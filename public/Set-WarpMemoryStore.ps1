function Set-WarpMemoryStore {
    <#
    .SYNOPSIS
    Updates a memory store description.

    .DESCRIPTION
    This function invokes the Warp CLI to update the memory store description.

    .PARAMETER StoreId
    Required. UID of the memory store to update.

    .PARAMETER Description
    Required. Updated description. Pass an empty string to clear.

    .EXAMPLE
    Set-WarpMemoryStore -StoreId "store_abc123" -Description "Shared coding guidance"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('StoreUid', 'Id')]
        [string]$StoreId,

        [Parameter(Mandatory)]
        [string]$Description
    )

    process {
        Invoke-WarpCli -Arguments @('memory-store', 'update', $StoreId, '-d', $Description)
    }
}
