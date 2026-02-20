function Suspend-WarpSchedule {
    <#
    .SYNOPSIS
    Pauses a Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to pause a scheduled agent so it stops running on its cron schedule.

    .PARAMETER Id
    Required. The ID of the schedule to pause. May be piped from another command.

    .EXAMPLE
    Suspend-WarpSchedule -Id "sched-abc123"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        Invoke-WarpCli -Arguments @('schedule', 'pause', $Id)
    }
}
