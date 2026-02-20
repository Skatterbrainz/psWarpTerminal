function Get-WarpAgent {
    <#
    .SYNOPSIS
    Retrieves a list of Warp agents.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available agents.

    .EXAMPLE
    Get-WarpAgent
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('agent', 'list')
}
