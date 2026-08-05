function New-WarpMemory {
    <#
    .SYNOPSIS
    Creates a manual memory in a memory store.

    .DESCRIPTION
    This function invokes the Warp CLI to create a new memory entry.

    .PARAMETER StoreId
    Required. UID of the memory store.

    .PARAMETER Content
    Required. Memory content.

    .PARAMETER Reason
    Required. Reason for creating this memory.

    .PARAMETER Version
    Optional. Version label.

    .EXAMPLE
    New-WarpMemory -StoreId "store_abc123" -Content "Use feature flag" -Reason "Postmortem action"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [Alias('StoreUid')]
        [string]$StoreId,

        [Parameter(Mandatory)]
        [string]$Content,

        [Parameter(Mandatory)]
        [string]$Reason,

        [string]$Version
    )

    $a = [System.Collections.Generic.List[string]]@('memory', 'create', '--content', $Content, '--reason', $Reason, $StoreId)
    if ($Version) {
        $a.Add('--version')
        $a.Add($Version)
    }

    Invoke-WarpCli -Arguments $a
}
