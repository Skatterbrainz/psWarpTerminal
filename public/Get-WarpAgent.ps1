function Get-WarpAgent {
    <#
    .SYNOPSIS
    Retrieves a list of Warp agents.

    .DESCRIPTION
    This function invokes the Warp CLI to list all available agents.
    Optionally filters by a specific GitHub repository.

    .PARAMETER Repo
    Optional. List skills from a specific GitHub repository (e.g. "owner/repo").

    .EXAMPLE
    Get-WarpAgent

    .EXAMPLE
    Get-WarpAgent -Repo "myorg/backend"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Repo
    )
    $a = [System.Collections.Generic.List[string]]@('agent', 'list')
    if ($Repo) { $a.Add('--repo'); $a.Add($Repo) }
    Invoke-WarpCli -Arguments $a
}
