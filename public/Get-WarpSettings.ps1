function Get-WarpSettings {
	<#
	.SYNOPSIS
	Returns Warp Terminal settings as a PowerShell object.

	.DESCRIPTION
	Reads and parses the Warp Terminal settings.toml file, returning it as a PSCustomObject.
	Automatically detects the settings file location based on the operating system.

	.PARAMETER Path
	Optional. Path to the settings.toml file. If not specified, the default platform-specific location is used.

	.EXAMPLE
	Get-WarpSettings

	.EXAMPLE
	Get-WarpSettings -Path ~/.config/warp-terminal/settings.toml

	.EXAMPLE
	(Get-WarpSettings).appearance.themes.theme
	#>
	[CmdletBinding()]
	param(
		[Parameter(Position = 0)]
		[string]$Path
	)

	if (-not $Path) {
		$candidates = @()
		if ($IsLinux) {
			$candidates += Join-Path $HOME '.config/warp-terminal/settings.toml'
		} elseif ($IsMacOS) {
			$candidates += Join-Path $HOME 'Library/Preferences/dev.warp.Warp-Stable/settings.toml'
			$candidates += Join-Path $HOME '.warp/settings.toml'
		} else {
			if ($env:LOCALAPPDATA) {
				$candidates += Join-Path $env:LOCALAPPDATA 'warp-terminal\settings.toml'
			}
			$candidates += Join-Path $HOME '.config\warp-terminal\settings.toml'
		}
		$Path = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
		if (-not $Path) {
			Write-Error "Warp settings.toml not found. Searched: $($candidates -join ', '). Use -Path to specify the location."
			return
		}
	}

	if (-not (Test-Path $Path)) {
		Write-Error "Settings file not found: $Path"
		return
	}

	$content = Get-Content -Path $Path -Raw
	ConvertFrom-Toml -Content $content
}
