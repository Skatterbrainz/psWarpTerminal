function Get-WarpAgentContext {
    <#
    .SYNOPSIS
    Returns the stored context from the last Invoke-WarpAgent call.

    .DESCRIPTION
    This function returns the module-scoped result object from the most recent Invoke-WarpAgent invocation. The stored context is used for automatic conversation continuation on follow-on prompts. By default the raw stored value is returned. Use -AsObject to force conversion from JSON string to a PSCustomObject.

    .PARAMETER AsObject
    Convert the stored context from a JSON string to a PSCustomObject. Useful when the stored result is a JSON-formatted string with escaped characters.

    .EXAMPLE
    Get-WarpAgentContext

    .EXAMPLE
    Get-WarpAgentContext -AsObject

    .EXAMPLE
    (Get-WarpAgentContext -AsObject).conversation_id
    #>
    [CmdletBinding()]
    param(
        [switch]$AsObject
    )

    if (-not $script:LastAgentResult) {
        Write-Verbose 'No agent context stored. Run Invoke-WarpAgent first.'
        return
    }

    if ($AsObject -and $script:LastAgentResult -is [string]) {
        $text = $script:LastAgentResult -replace '(?m)^```json\s*' -replace '(?m)^```\s*'

        # Parse NDJSON lines into raw events
        $events = $null
        try {
            $events = @($text -split "`n" | Where-Object { $_.Trim() -ne '' } | ForEach-Object {
                $_ | ConvertFrom-Json
            })
        } catch {
            Write-Error "Unable to convert stored context to object: $_"
            $script:LastAgentResult
            return
        }

        # Normalize all events to uniform columns
        foreach ($ev in $events) {
            $filePaths = if ($ev.file_paths) { $ev.file_paths -join '; ' }
                         elseif ($ev.files) { ($ev.files | ForEach-Object { $_.path }) -join '; ' }
                         else { $null }
            [PSCustomObject]@{
                type            = $ev.type
                event_type      = $ev.event_type
                conversation_id = $ev.conversation_id
                text            = $ev.text
                tool            = $ev.tool
                path            = $filePaths
            }
        }
    } else {
        $script:LastAgentResult
    }
}
