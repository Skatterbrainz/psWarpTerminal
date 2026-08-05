function ConvertTo-WarpAgentEvents {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $InputObject
    )

    $events = [System.Collections.Generic.List[object]]::new()

    function Add-EventObject {
        param($Object)

        if ($null -eq $Object) { return }

        if ($Object -is [string]) {
            $text = $Object -replace '(?m)^```json\s*' -replace '(?m)^```\s*'
            if ([string]::IsNullOrWhiteSpace($text)) { return }

            try {
                $parsed = $text | ConvertFrom-Json -Depth 100
                Add-EventObject -Object $parsed
                return
            } catch {
                foreach ($line in ($text -split "`r?`n")) {
                    $trimmed = $line.Trim()
                    if (-not $trimmed) { continue }
                    try {
                        [void]$events.Add(($trimmed | ConvertFrom-Json -Depth 100))
                    } catch {
                    }
                }
                return
            }
        }

        if ($Object -is [array] -or $Object -is [System.Collections.IList]) {
            foreach ($item in $Object) {
                Add-EventObject -Object $item
            }
            return
        }

        $props = @($Object.PSObject.Properties.Name)

        if ($props -contains 'events' -and $Object.events) {
            Add-EventObject -Object $Object.events
            return
        }

        if ($props -contains 'messages' -and $Object.messages) {
            Add-EventObject -Object $Object.messages
            return
        }

        if ($props -contains 'item' -and $Object.item) {
            Add-EventObject -Object $Object.item
            return
        }

        if ($props -contains 'items' -and $Object.items) {
            Add-EventObject -Object $Object.items
            return
        }

        [void]$events.Add($Object)
    }

    Add-EventObject -Object $InputObject
    return @($events)
}
