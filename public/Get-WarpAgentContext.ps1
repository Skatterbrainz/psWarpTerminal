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
        # Try single JSON document first
        try {
            $text | ConvertFrom-Json
            return
        } catch {}
        # Try wrapping as a JSON array (handles NDJSON / multiple objects per line)
        try {
            $lines = $text -split "`n" | Where-Object { $_.Trim() -ne '' }
            $wrapped = '[' + ($lines -join ',') + ']'
            $wrapped | ConvertFrom-Json
            return
        } catch {}
        # Try parsing each non-empty line individually
        try {
            $text -split "`n" | Where-Object { $_.Trim() -ne '' } | ForEach-Object {
                $_ | ConvertFrom-Json
            }
            return
        } catch {
            Write-Error "Unable to convert stored context to object: $_"
            $script:LastAgentResult
        }
    } else {
        $script:LastAgentResult
    }
}
