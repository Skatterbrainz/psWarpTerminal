function Get-WarpRun {
    <#
    .SYNOPSIS
    Retrieves a list of Warp runs.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available runs or get a specific run by ID.

    .PARAMETER TaskId
    Required. The ID of a specific run to retrieve. If not provided, all runs will be listed. May be piped from another command that outputs an object with an 'Id' property.

    .PARAMETER Limit
    Optional. The maximum number of runs to retrieve. Defaults to 10.

    .EXAMPLE
    Get-WarpRun
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$TaskId,

        [Parameter(ParameterSetName = 'List')]
        [int]$Limit = 10
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            Invoke-WarpCli -Arguments @('run', 'get', $TaskId)
        } else {
            Invoke-WarpCli -Arguments @('run', 'list', '-L', $Limit)
        }
    }
}
