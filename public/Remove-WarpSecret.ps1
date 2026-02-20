function Remove-WarpSecret {
    <#
    .SYNOPSIS
    Deletes a Warp secret.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a secret. Supports -WhatIf and -Confirm.

    .PARAMETER Id
    Required. The ID of the secret to delete. May be piped from another command.

    .EXAMPLE
    Remove-WarpSecret -Id "secret-abc123"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Delete secret')) {
            Invoke-WarpCli -Arguments @('secret', 'delete', $Id)
        }
    }
}
