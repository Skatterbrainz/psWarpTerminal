function Clear-WarpAgentContext {
    <#
    .SYNOPSIS
    Clears the stored agent conversation context.

    .DESCRIPTION
    Resets the module-scoped agent result so the next Invoke-WarpAgent call starts a fresh conversation instead of auto-continuing the previous one.

    .EXAMPLE
    Clear-WarpAgentContext
    #>
    [CmdletBinding()]
    param()

    $script:LastAgentResult = $null
    Write-Verbose 'Agent context cleared.'
}
