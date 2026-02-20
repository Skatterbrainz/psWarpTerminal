function Remove-WarpEnvironment {
    <#
    .SYNOPSIS
    Deletes a Warp cloud environment.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a cloud environment. Supports -WhatIf and -Confirm.

    .PARAMETER Id
    Required. The ID of the environment to delete. May be piped from another command.

    .EXAMPLE
    Remove-WarpEnvironment -Id "env-abc123"

    .EXAMPLE
    Get-WarpEnvironment | Where-Object name -eq "old-env" | Remove-WarpEnvironment
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Delete cloud environment')) {
            Invoke-WarpCli -Arguments @('environment', 'delete', $Id)
        }
    }
}
