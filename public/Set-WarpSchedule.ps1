function Set-WarpSchedule {
    <#
    .SYNOPSIS
    Updates an existing Warp scheduled agent.

    .DESCRIPTION
    This function invokes the Warp CLI to update a scheduled agent. Additional arguments are passed through to the CLI.

    .PARAMETER Id
    Required. The ID of the schedule to update. May be piped from another command.

    .PARAMETER PassThru
    Optional. Additional arguments forwarded to the Warp CLI update command.

    .EXAMPLE
    Set-WarpSchedule -Id "sched-abc123" --cron "0 10 * * *"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id,

        [Parameter(ValueFromRemainingArguments)]
        [string[]]$PassThru
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('schedule', 'update', $Id)
        if ($PassThru) { $a.AddRange([string[]]$PassThru) }
        Invoke-WarpCli -Arguments $a
    }
}
