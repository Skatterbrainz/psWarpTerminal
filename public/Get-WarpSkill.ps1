function Get-WarpSkill {
    <#
    .SYNOPSIS
    Lists available Warp agent skills.

    .DESCRIPTION
    This function invokes the Warp CLI to list available skills discovered from
    your environments, or from a specific GitHub repository.

    .PARAMETER Repo
    Optional. List skills from a specific GitHub repository.
    Format: "owner/repo" or "https://github.com/owner/repo".

    .EXAMPLE
    Get-WarpSkill

    .EXAMPLE
    Get-WarpSkill -Repo "myorg/backend"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]$Repo
    )

    $a = [System.Collections.Generic.List[string]]@('agent', 'skills')
    if ($Repo) { $a.Add('--repo'); $a.Add($Repo) }

    Invoke-WarpCli -Arguments $a
}
