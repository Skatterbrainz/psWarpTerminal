function Get-WarpMemoryStore {
    <#
    .SYNOPSIS
    Lists memory stores, gets a memory store, or lists agents attached to a store.

    .DESCRIPTION
    This function invokes the Warp CLI memory-store commands.

    .PARAMETER StoreId
    Optional. Memory store UID. If omitted, lists all stores.

    .PARAMETER StoreAgents
    When set with -StoreId, lists agents attached to that memory store.

    .EXAMPLE
    Get-WarpMemoryStore

    .EXAMPLE
    Get-WarpMemoryStore -StoreId "store_abc123"

    .EXAMPLE
    Get-WarpMemoryStore -StoreId "store_abc123" -StoreAgents
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(ParameterSetName = 'Get', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName = 'Agents', Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('StoreUid', 'Id')]
        [string]$StoreId,

        [Parameter(ParameterSetName = 'Agents', Mandatory)]
        [switch]$StoreAgents
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            'Get' { Invoke-WarpCli -Arguments @('memory-store', 'get', $StoreId) }
            'Agents' { Invoke-WarpCli -Arguments @('memory-store', 'list-store-agents', $StoreId) }
            default { Invoke-WarpCli -Arguments @('memory-store', 'list') }
        }
    }
}
