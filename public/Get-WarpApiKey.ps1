function Get-WarpApiKey {
    <#
    .SYNOPSIS
    Lists active Oz API keys.

    .DESCRIPTION
    This function invokes the Warp CLI to list active API keys.

    .PARAMETER SortBy
    Optional. Sort field.

    .PARAMETER SortOrder
    Optional. Sort direction.

    .EXAMPLE
    Get-WarpApiKey

    .EXAMPLE
    Get-WarpApiKey -SortBy created-at -SortOrder desc
    #>
    [CmdletBinding()]
    param(
        [ValidateSet('name', 'created-at', 'last-used-at', 'expires-at', 'scope')]
        [string]$SortBy,

        [ValidateSet('asc', 'desc')]
        [string]$SortOrder
    )

    $a = [System.Collections.Generic.List[string]]@('api-key', 'list')

    if ($SortBy)    { $a.Add('--sort-by'); $a.Add($SortBy) }
    if ($SortOrder) { $a.Add('--sort-order'); $a.Add($SortOrder) }

    Invoke-WarpCli -Arguments $a
}
