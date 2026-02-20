function Get-WarpAgentProfile {
    <#
    .SYNOPSIS
    Retrieves a list of Warp agent profiles.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available agent profiles.

    .EXAMPLE
    Get-WarpAgentProfile
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('agent', 'profile', 'list')
}
