function ConvertFrom-Toml {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[string]$Content
	)

	function GetBracketBalance([string]$str) {
		$balance = 0
		$inS = $false; $inD = $false
		for ($j = 0; $j -lt $str.Length; $j++) {
			$ch = $str[$j]
			if ($inS) { if ($ch -eq "'") { $inS = $false }; continue }
			if ($inD) {
				if ($ch -eq '\' -and ($j + 1) -lt $str.Length) { $j++; continue }
				if ($ch -eq '"') { $inD = $false }; continue
			}
			if ($ch -eq "'") { $inS = $true; continue }
			if ($ch -eq '"') { $inD = $true; continue }
			if ($ch -eq '[' -or $ch -eq '{') { $balance++ }
			if ($ch -eq ']' -or $ch -eq '}') { $balance-- }
		}
		return $balance
	}

	function SplitRespectingNesting([string]$str, [char]$delimiter) {
		$result = [System.Collections.Generic.List[string]]::new()
		$current = [System.Text.StringBuilder]::new()
		$depth = 0
		$inSingle = $false
		$inDouble = $false
		for ($j = 0; $j -lt $str.Length; $j++) {
			$ch = $str[$j]
			if ($inSingle) {
				[void]$current.Append($ch)
				if ($ch -eq "'") { $inSingle = $false }
				continue
			}
			if ($inDouble) {
				if ($ch -eq '\' -and ($j + 1) -lt $str.Length) {
					[void]$current.Append($ch)
					$j++
					[void]$current.Append($str[$j])
					continue
				}
				[void]$current.Append($ch)
				if ($ch -eq '"') { $inDouble = $false }
				continue
			}
			if ($ch -eq "'") { $inSingle = $true; [void]$current.Append($ch); continue }
			if ($ch -eq '"') { $inDouble = $true; [void]$current.Append($ch); continue }
			if ($ch -eq '[' -or $ch -eq '{') { $depth++; [void]$current.Append($ch); continue }
			if ($ch -eq ']' -or $ch -eq '}') { $depth--; [void]$current.Append($ch); continue }
			if ($ch -eq $delimiter -and $depth -eq 0) {
				$result.Add($current.ToString())
				[void]$current.Clear()
				continue
			}
			[void]$current.Append($ch)
		}
		$trailing = $current.ToString().Trim()
		if ($trailing -ne '') { $result.Add($current.ToString()) }
		return $result
	}

	function ParseTomlValue([string]$val) {
		$val = $val.Trim()
		if ($val -eq 'true') { return $true }
		if ($val -eq 'false') { return $false }
		if ($val -match "^'(.*)'$") { return $matches[1] }
		if ($val -match '^"(.*)"$') {
			$s = $matches[1] -replace '\\\\', "`0"
			$s = $s -replace '\\n', "`n" -replace '\\t', "`t" -replace '\\"', '"'
			return ($s -replace "`0", '\')
		}
		if ($val -match '^-?\d+\.\d+$') { return [double]$val }
		if ($val -match '^-?\d+$') { return [long]$val }
		if ($val.StartsWith('[')) { return ParseTomlArray $val }
		if ($val.StartsWith('{')) { return ParseTomlInlineTable $val }
		return $val
	}

	function ParseTomlArray([string]$val) {
		$inner = $val.Substring(1, $val.Length - 2).Trim()
		if ($inner -eq '') { return @() }
		$elements = SplitRespectingNesting $inner ','
		$result = [System.Collections.Generic.List[object]]::new()
		foreach ($elem in $elements) {
			$trimmed = $elem.Trim()
			if ($trimmed -ne '') { $result.Add((ParseTomlValue $trimmed)) }
		}
		return ,$result.ToArray()
	}

	function ParseTomlInlineTable([string]$val) {
		$inner = $val.Substring(1, $val.Length - 2).Trim()
		$table = [ordered]@{}
		if ($inner -eq '') { return $table }
		$pairs = SplitRespectingNesting $inner ','
		foreach ($pair in $pairs) {
			$trimmed = $pair.Trim()
			if ($trimmed -match '^([A-Za-z0-9_-]+)\s*=\s*(.+)$') {
				$table[$matches[1]] = ParseTomlValue $matches[2]
			}
		}
		return $table
	}

	function ConvertToObject($obj) {
		if ($obj -is [System.Collections.Specialized.OrderedDictionary]) {
			$props = [ordered]@{}
			foreach ($key in $obj.Keys) {
				$props[$key] = ConvertToObject $obj[$key]
			}
			return [PSCustomObject]$props
		}
		if ($obj -is [array]) {
			return ,@($obj | ForEach-Object { ConvertToObject $_ })
		}
		return $obj
	}

	$root = [ordered]@{}
	$currentTable = $root
	$lines = $Content -split '\r?\n'
	$i = 0

	while ($i -lt $lines.Count) {
		$line = $lines[$i]
		$stripped = [System.Text.StringBuilder]::new()
		$qs = $false; $qd = $false
		for ($j = 0; $j -lt $line.Length; $j++) {
			$ch = $line[$j]
			if ($qs) { [void]$stripped.Append($ch); if ($ch -eq "'") { $qs = $false }; continue }
			if ($qd) {
				if ($ch -eq '\' -and ($j + 1) -lt $line.Length) { [void]$stripped.Append($ch); $j++; [void]$stripped.Append($line[$j]); continue }
				[void]$stripped.Append($ch); if ($ch -eq '"') { $qd = $false }; continue
			}
			if ($ch -eq '#') { break }
			if ($ch -eq "'") { $qs = $true }
			if ($ch -eq '"') { $qd = $true }
			[void]$stripped.Append($ch)
		}
		$sLine = $stripped.ToString().Trim()
		if ($sLine -eq '') { $i++; continue }

		if ($sLine -match '^\[([^\[\]]+)\]\s*$') {
			$segments = $matches[1].Trim() -split '\.'
			$currentTable = $root
			foreach ($seg in $segments) {
				$seg = $seg.Trim()
				if (-not $currentTable.Contains($seg)) {
					$currentTable[$seg] = [ordered]@{}
				}
				$currentTable = $currentTable[$seg]
			}
			$i++
			continue
		}

		if ($sLine -match '^([A-Za-z0-9_-]+)\s*=\s*(.*)$') {
			$key = $matches[1]
			$rawValue = $matches[2].Trim()
			$accumulated = $rawValue
			$balance = GetBracketBalance $accumulated
			while ($balance -gt 0 -and ($i + 1) -lt $lines.Count) {
				$i++
				$accumulated += "`n" + $lines[$i]
				$balance = GetBracketBalance $accumulated
			}
			$currentTable[$key] = ParseTomlValue $accumulated
			$i++
			continue
		}

		$i++
	}

	ConvertToObject $root
}
