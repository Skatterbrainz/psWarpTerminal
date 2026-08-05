function Remove-WarpSecret {
    <#
    .SYNOPSIS
    Deletes a Warp secret.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a secret. Supports -WhatIf and -Confirm.

    .PARAMETER Id
    Required. The name or UID of the secret to delete. May be piped from another command.

    .PARAMETER Force
    Delete without CLI confirmation.

    .PARAMETER Team
    Delete at the team scope.

    .PARAMETER Personal
    Delete at the personal scope.

    .EXAMPLE
    Remove-WarpSecret -Id "secret-abc123"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Name', 'Uid')]
        [string]$Id,

        [switch]$Force,
        [switch]$Team,
        [switch]$Personal
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Delete secret')) {
            $a = [System.Collections.Generic.List[string]]@('secret', 'delete', $Id)
            if ($Force.IsPresent) { $a.Add('--force') }
            if ($Team.IsPresent) { $a.Add('--team') }
            if ($Personal.IsPresent) { $a.Add('--personal') }
            Invoke-WarpCli -Arguments $a
        }
    }
}
