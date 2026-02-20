function Get-WarpIntegration {
    <#
    .SYNOPSIS
    Retrieves a list of Warp integrations.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available integrations.

    .EXAMPLE
    Get-WarpIntegration
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('integration', 'list')
}
