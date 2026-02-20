function Connect-Warp {
    <#
    .SYNOPSIS
    Connects to the Warp CLI.

    .DESCRIPTION
    This function invokes the Warp CLI login command.

    .EXAMPLE
    Connect-Warp
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('login') -RawOutput
}
