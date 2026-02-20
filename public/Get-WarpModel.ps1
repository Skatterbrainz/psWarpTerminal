function Get-WarpModel {
    <#
    .SYNOPSIS
    Retrieves a list of Warp models.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available models.

    .EXAMPLE
    Get-WarpModel
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('model', 'list')
}
