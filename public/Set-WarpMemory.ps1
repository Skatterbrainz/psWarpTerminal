function Set-WarpMemory {
    <#
    .SYNOPSIS
    Updates a memory by creating a new version.

    .DESCRIPTION
    This function invokes the Warp CLI to update a memory's content and reason.

    .PARAMETER MemoryId
    Required. UID of the memory to update.

    .PARAMETER StoreId
    Required. UID of the containing memory store.

    .PARAMETER Content
    Required. Updated memory content.

    .PARAMETER Reason
    Required. Reason for updating the memory.

    .PARAMETER Version
    Optional. Version label.

    .EXAMPLE
    Set-WarpMemory -MemoryId "mem_abc123" -StoreId "store_abc123" -Content "New content" -Reason "Correction"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('MemoryUid', 'Id')]
        [string]$MemoryId,

        [Parameter(Mandatory)]
        [Alias('StoreUid')]
        [string]$StoreId,

        [Parameter(Mandatory)]
        [string]$Content,

        [Parameter(Mandatory)]
        [string]$Reason,

        [string]$Version
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('memory', 'update', '--store', $StoreId, '--content', $Content, '--reason', $Reason, $MemoryId)
        if ($Version) {
            $a.Add('--version')
            $a.Add($Version)
        }

        Invoke-WarpCli -Arguments $a
    }
}
