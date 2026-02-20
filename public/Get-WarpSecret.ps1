function Get-WarpSecret {
    <#
    .SYNOPSIS
    Retrieves a list of Warp secrets.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available secrets.

    .EXAMPLE
    Get-WarpSecret
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('secret', 'list')
}
