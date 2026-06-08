function Get-WarpAgent {
    <#
    .SYNOPSIS
    Retrieves Warp reusable agents.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available reusable agents,
    or retrieve a single agent by ID.

    .PARAMETER Id
    Optional. The ID (UID) of a specific agent to retrieve.

    .EXAMPLE
    Get-WarpAgent

    .EXAMPLE
    Get-WarpAgent -Id "ag_abc123"
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'ById', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Uid')]
        [string]$Id
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq 'ById') {
            Invoke-WarpCli -Arguments @('agent', 'get', $Id)
        } else {
            Invoke-WarpCli -Arguments @('agent', 'list')
        }
    }
}
