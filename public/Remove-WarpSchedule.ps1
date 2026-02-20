function Remove-WarpSchedule {
    <#
    .SYNOPSIS
    Deletes a Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a scheduled agent. Supports -WhatIf and -Confirm.

    .PARAMETER Id
    Required. The ID of the schedule to delete. May be piped from another command.

    .EXAMPLE
    Remove-WarpSchedule -Id "sched-abc123"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ShouldProcess($Id, 'Delete scheduled agent')) {
            Invoke-WarpCli -Arguments @('schedule', 'delete', $Id)
        }
    }
}
