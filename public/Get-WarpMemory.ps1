function Get-WarpMemory {
    <#
    .SYNOPSIS
    Lists memories in a store, or lists versions for a memory.

    .DESCRIPTION
    This function invokes the Warp CLI to list memories by store, or inspect version history
    for a specific memory.

    .PARAMETER StoreId
    Required. UID of the memory store.

    .PARAMETER MemoryId
    Required with -Versions. UID of the memory.

    .PARAMETER Versions
    Return version history for a specific memory.

    .EXAMPLE
    Get-WarpMemory -StoreId "store_abc123"

    .EXAMPLE
    Get-WarpMemory -StoreId "store_abc123" -MemoryId "mem_abc123" -Versions
    #>
    [CmdletBinding(DefaultParameterSetName = 'List')]
    param(
        [Parameter(Mandatory)]
        [Alias('StoreUid')]
        [string]$StoreId,

        [Parameter(ParameterSetName = 'Versions', Mandatory)]
        [Alias('MemoryUid', 'Id')]
        [string]$MemoryId,

        [Parameter(ParameterSetName = 'Versions', Mandatory)]
        [switch]$Versions
    )

    if ($PSCmdlet.ParameterSetName -eq 'Versions') {
        Invoke-WarpCli -Arguments @('memory', 'versions', '--store', $StoreId, $MemoryId)
    } else {
        Invoke-WarpCli -Arguments @('memory', 'list', $StoreId)
    }
}
