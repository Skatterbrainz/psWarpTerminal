function Get-WarpRunner {
    <#
    .SYNOPSIS
    Lists cloud runners.

    .DESCRIPTION
    This function invokes the Warp CLI to list runners, with optional sorting.

    .PARAMETER SortBy
    Optional. Sort field.

    .EXAMPLE
    Get-WarpRunner
    #>
    [CmdletBinding()]
    param(
        [ValidateSet('name', 'last-updated')]
        [string]$SortBy
    )

    $a = [System.Collections.Generic.List[string]]@('runner', 'list')
    if ($SortBy) {
        $a.Add('--sort-by')
        $a.Add($SortBy)
    }

    Invoke-WarpCli -Arguments $a
}
