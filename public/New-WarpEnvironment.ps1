function New-WarpEnvironment {
    <#
    .SYNOPSIS
    Creates a new Warp cloud environment.

    .DESCRIPTION
    This function invokes the Warp CLI to create a new cloud environment with the specified configuration.

    .PARAMETER Name
    Required. Name of the environment.

    .PARAMETER Description
    Optional. Description of the environment (max 240 characters).

    .PARAMETER DockerImage
    Optional. Docker image to use. Use Get-WarpEnvironmentImage to list available images.

    .PARAMETER Repo
    Optional. One or more Git repos in "owner/repo" format.

    .PARAMETER SetupCommand
    Optional. One or more setup commands to run after cloning.

    .PARAMETER Team
    Create at the team level.

    .PARAMETER Personal
    Create as private to your account.

    .EXAMPLE
    New-WarpEnvironment -Name "my-env" -DockerImage "ubuntu:22.04" -Repo "org/repo"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Name,

        [string]$Description,
        [string]$DockerImage,
        [string[]]$Repo,
        [string[]]$SetupCommand,
        [switch]$Team,
        [switch]$Personal
    )

    $a = [System.Collections.Generic.List[string]]@('environment', 'create', '--name', $Name)

    if ($Description) { $a.Add('--description'); $a.Add($Description) }
    if ($DockerImage)  { $a.Add('-d');            $a.Add($DockerImage) }
    foreach ($r in $Repo)         { $a.Add('-r'); $a.Add($r) }
    foreach ($c in $SetupCommand) { $a.Add('-c'); $a.Add($c) }
    if ($Team)     { $a.Add('--team') }
    if ($Personal) { $a.Add('--personal') }

    Invoke-WarpCli -Arguments $a
}
