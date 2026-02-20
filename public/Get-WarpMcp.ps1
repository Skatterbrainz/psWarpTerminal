function Get-WarpMcp {
    <#
    .SYNOPSIS
    Retrieves a list of Warp MCPs.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available MCPs.

    .EXAMPLE
    Get-WarpMcp
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('mcp', 'list')
}
