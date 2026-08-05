function Get-WarpAgent {
    <#
    .SYNOPSIS
    Retrieves Warp reusable agents.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available reusable agents,
    or retrieve a single agent by ID.

    .PARAMETER Id
    Optional. The ID (UID) of a specific agent to retrieve.

    .PARAMETER SortBy
    Optional. Sort field when listing agents.

    .PARAMETER SortOrder
    Optional. Sort direction when listing agents.

    .EXAMPLE
    Get-WarpAgent

    .EXAMPLE
    Get-WarpAgent -Id "ag_abc123"
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Uid')]
        [string]$Id,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('name', 'created-at')]
        [string]$SortBy,

        [Parameter(ParameterSetName = 'List')]
        [ValidateSet('asc', 'desc')]
        [string]$SortOrder
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            Invoke-WarpCli -Arguments @('agent', 'get', $Id)
        } else {
            $a = [System.Collections.Generic.List[string]]@('agent', 'list')
            if ($SortBy) { $a.Add('--sort-by'); $a.Add($SortBy) }
            if ($SortOrder) { $a.Add('--sort-order'); $a.Add($SortOrder) }
            Invoke-WarpCli -Arguments $a
        }
    }
}
