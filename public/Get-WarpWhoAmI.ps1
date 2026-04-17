function Get-WarpWhoAmI {
    <#
    .SYNOPSIS
    Returns information about the currently logged-in Warp user.

    .DESCRIPTION
    This function invokes the Warp CLI `whoami` command and returns the parsed JSON response describing the authenticated user (email, team, etc.).

    .EXAMPLE
    Get-WarpWhoAmI

    .EXAMPLE
    (Get-WarpWhoAmI).email
    #>
    [CmdletBinding()]
    param()
    Invoke-WarpCli -Arguments @('whoami')
}
