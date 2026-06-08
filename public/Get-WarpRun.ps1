function Get-WarpRun {
    <#
    .SYNOPSIS
    Retrieves Warp runs.

    .DESCRIPTION
    This function invokes the Warp CLI to list runs with optional filters, or
    get a specific run by ID.

    .PARAMETER TaskId
    Required. The ID of a specific run to retrieve. If not provided, all runs will be listed. May be piped from another command that outputs an object with an 'Id' property.

    .PARAMETER Limit
    Optional. The maximum number of runs to retrieve. Defaults to 10.

    .PARAMETER State
    Optional. One or more run states to include.

    .PARAMETER Source
    Optional. Filter by run source.

    .PARAMETER ExecutionLocation
    Optional. Filter by where the run executed.

    .PARAMETER Creator
    Optional. Filter by creator ID.

    .PARAMETER Environment
    Optional. Filter by environment ID.

    .PARAMETER Skill
    Optional. Filter by skill spec.

    .PARAMETER Schedule
    Optional. Filter to runs created by a specific schedule ID.

    .PARAMETER AncestorRun
    Optional. Filter to descendants of a specific run ID.

    .PARAMETER Name
    Optional. Filter by run name.

    .PARAMETER Model
    Optional. Filter by model ID.

    .PARAMETER ArtifactType
    Optional. Filter by produced artifact type.

    .PARAMETER CreatedAfter
    Optional. Include runs created after an RFC3339 timestamp.

    .PARAMETER CreatedBefore
    Optional. Include runs created before an RFC3339 timestamp.

    .PARAMETER UpdatedAfter
    Optional. Include runs updated after an RFC3339 timestamp.

    .PARAMETER Query
    Optional. Fuzzy search text.

    .PARAMETER SortBy
    Optional. Sort field.

    .PARAMETER SortOrder
    Optional. Sort direction.

    .PARAMETER Cursor
    Optional. Pagination cursor.

    .EXAMPLE
    Get-WarpRun
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [string]$TaskId,

        [Parameter(ParameterSetName = 'List')]
        [int]$Limit = 10,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('queued', 'pending', 'claimed', 'in-progress', 'succeeded', 'failed', 'error', 'blocked', 'cancelled')]
        [string[]]$State,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('api', 'cli', 'slack', 'linear', 'scheduled-agent', 'web-app', 'cloud-mode', 'github-action', 'interactive')]
        [string]$Source,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('local', 'remote')]
        [string]$ExecutionLocation,

        [Parameter(ParameterSetName = 'List')]
        [string]$Creator,

        [Parameter(ParameterSetName = 'List')]
        [string]$Environment,

        [Parameter(ParameterSetName = 'List')]
        [string]$Skill,

        [Parameter(ParameterSetName = 'List')]
        [string]$Schedule,

        [Parameter(ParameterSetName = 'List')]
        [string]$AncestorRun,

        [Parameter(ParameterSetName = 'List')]
        [string]$Name,

        [Parameter(ParameterSetName = 'List')]
        [string]$Model,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('plan', 'pull-request', 'screenshot', 'file')]
        [string]$ArtifactType,

        [Parameter(ParameterSetName = 'List')]
        [string]$CreatedAfter,

        [Parameter(ParameterSetName = 'List')]
        [string]$CreatedBefore,

        [Parameter(ParameterSetName = 'List')]
        [string]$UpdatedAfter,

        [Parameter(ParameterSetName = 'List')]
        [string]$Query,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('updated-at', 'created-at', 'title', 'agent')]
        [string]$SortBy,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('asc', 'desc')]
        [string]$SortOrder,

        [Parameter(ParameterSetName = 'List')]
        [string]$Cursor
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            Invoke-WarpCli -Arguments @('run', 'get', $TaskId)
        } else {
            $a = [System.Collections.Generic.List[string]]@('run', 'list', '-L', $Limit)

            foreach ($s in $State) { $a.Add('--state'); $a.Add($s) }
            if ($Source)            { $a.Add('--source'); $a.Add($Source) }
            if ($ExecutionLocation) { $a.Add('--execution-location'); $a.Add($ExecutionLocation) }
            if ($Creator)           { $a.Add('--creator'); $a.Add($Creator) }
            if ($Environment)       { $a.Add('--environment'); $a.Add($Environment) }
            if ($Skill)             { $a.Add('--skill'); $a.Add($Skill) }
            if ($Schedule)          { $a.Add('--schedule'); $a.Add($Schedule) }
            if ($AncestorRun)       { $a.Add('--ancestor-run'); $a.Add($AncestorRun) }
            if ($Name)              { $a.Add('--name'); $a.Add($Name) }
            if ($Model)             { $a.Add('--model'); $a.Add($Model) }
            if ($ArtifactType)      { $a.Add('--artifact-type'); $a.Add($ArtifactType) }
            if ($CreatedAfter)      { $a.Add('--created-after'); $a.Add($CreatedAfter) }
            if ($CreatedBefore)     { $a.Add('--created-before'); $a.Add($CreatedBefore) }
            if ($UpdatedAfter)      { $a.Add('--updated-after'); $a.Add($UpdatedAfter) }
            if ($Query)             { $a.Add('-q'); $a.Add($Query) }
            if ($SortBy)            { $a.Add('--sort-by'); $a.Add($SortBy) }
            if ($SortOrder)         { $a.Add('--sort-order'); $a.Add($SortOrder) }
            if ($Cursor)            { $a.Add('--cursor'); $a.Add($Cursor) }

            Invoke-WarpCli -Arguments $a
        }
    }
}
