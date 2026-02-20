function Disconnect-Warp {
    <#
    .SYNOPSIS
    Disconnects from the Warp CLI.

    .DESCRIPTION
    This function invokes the Warp CLI logout command.

    .EXAMPLE
    Disconnect-Warp
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param()

    if ($PSCmdlet.ShouldProcess('Warp session', 'Log out')) {
        Invoke-WarpCli -Arguments @('logout') -RawOutput
    }
}
