function Resume-WarpSchedule {
    <#
    .SYNOPSIS
    Resumes a paused Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to unpause a scheduled agent so it resumes running on its cron schedule.

    .PARAMETER Id
    Required. The ID of the schedule to resume. May be piped from another command.

    .EXAMPLE
    Resume-WarpSchedule -Id "sched-abc123"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        Invoke-WarpCli -Arguments @('schedule', 'unpause', $Id)
    }
}
