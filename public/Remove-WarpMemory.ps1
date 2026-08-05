function Remove-WarpMemory {
    <#
    .SYNOPSIS
    Deletes a memory from a memory store.

    .DESCRIPTION
    This function invokes the Warp CLI to delete a memory.

    .PARAMETER MemoryId
    Required. UID of the memory to delete.

    .PARAMETER StoreId
    Required. UID of the containing memory store.

    .EXAMPLE
    Remove-WarpMemory -MemoryId "mem_abc123" -StoreId "store_abc123"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('MemoryUid', 'Id')]
        [string]$MemoryId,

        [Parameter(Mandatory)]
        [Alias('StoreUid')]
        [string]$StoreId
    )

    process {
        if ($PSCmdlet.ShouldProcess($MemoryId, 'Delete memory')) {
            Invoke-WarpCli -Arguments @('memory', 'delete', '--store', $StoreId, $MemoryId)
        }
    }
}
