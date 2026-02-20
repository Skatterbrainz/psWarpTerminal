function Get-WarpEnvironmentImage {
    <#
    .SYNOPSIS
    Retrieves a list of Warp environment images.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available environment images.

    .EXAMPLE
    Get-WarpEnvironmentImage
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('environment', 'image', 'list')
}
