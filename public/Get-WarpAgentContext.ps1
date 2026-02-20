function Get-WarpAgentContext {
    <#
    .SYNOPSIS
    Returns the stored context from the last Invoke-WarpAgent call.

    .DESCRIPTION
    This function returns the module-scoped result object from the most recent Invoke-WarpAgent invocation. The stored context is used for automatic conversation continuation on follow-on prompts.

    .EXAMPLE
    Get-WarpAgentContext

    .EXAMPLE
    (Get-WarpAgentContext).conversation_id
    #>
    [CmdletBinding()]
    param()

    if ($script:LastAgentResult) {
        $script:LastAgentResult
    } else {
        Write-Verbose 'No agent context stored. Run Invoke-WarpAgent first.'
    }
}
