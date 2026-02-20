function Get-WarpSchedule {
    <#
    .SYNOPSIS
    Retrieves a list of Warp scheduled agents.

    .DESCRIPTION
    This function invokes the Warp CLI to list all scheduled agents or get a specific schedule by ID.

    .PARAMETER Id
    Optional. The ID of a specific schedule to retrieve. If not provided, all schedules will be listed. May be piped from another command that outputs an object with an 'Id' property.

    .EXAMPLE
    Get-WarpSchedule

    .EXAMPLE
    Get-WarpSchedule -Id "sched-abc123"
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            Invoke-WarpCli -Arguments @('schedule', 'get', $Id)
        } else {
            Invoke-WarpCli -Arguments @('schedule', 'list')
        }
    }
}
