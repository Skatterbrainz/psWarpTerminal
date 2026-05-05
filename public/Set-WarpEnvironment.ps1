function Set-WarpEnvironment {
    <#
    .SYNOPSIS
    Updates an existing Warp cloud environment.

    .DESCRIPTION
    This function invokes the Warp CLI to update a cloud environment's configuration.

    .PARAMETER Id
    Required. The ID of the environment to update. May be piped from another command.

    .PARAMETER Name
    Optional. Update the environment name.

    .PARAMETER Description
    Optional. Update the description (max 240 characters).

    .PARAMETER RemoveDescription
    Remove the description from the environment.

    .PARAMETER DockerImage
    Optional. Update the Docker image.

    .PARAMETER Repo
    Optional. One or more Git repos in "owner/repo" format to add.

    .PARAMETER RemoveRepo
    Optional. One or more Git repos in "owner/repo" format to remove.

    .PARAMETER SetupCommand
    Optional. One or more setup commands to add.

    .PARAMETER RemoveSetupCommand
    Optional. One or more setup commands to remove.

    .PARAMETER Force
    Force update without checking for integration usage.

    .EXAMPLE
    Set-WarpEnvironment -Id "env-abc123" -Name "new-name"

    .EXAMPLE
    Set-WarpEnvironment -Id "env-abc123" -Repo "org/new-repo" -RemoveRepo "org/old-repo"

    .EXAMPLE
    Get-WarpEnvironment -Id "env-abc123" | Set-WarpEnvironment -DockerImage "ubuntu:24.04" -Force
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [string]$Id,

        [string]$Name,
        [string]$Description,
        [switch]$RemoveDescription,
        [string]$DockerImage,
        [string[]]$Repo,
        [string[]]$RemoveRepo,
        [string[]]$SetupCommand,
        [string[]]$RemoveSetupCommand,
        [switch]$Force
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('environment', 'update', $Id)

        if ($Name)        { $a.Add('--name');        $a.Add($Name) }
        if ($Description) { $a.Add('--description'); $a.Add($Description) }
        if ($RemoveDescription.IsPresent) { $a.Add('--remove-description') }
        if ($DockerImage)  { $a.Add('-d');           $a.Add($DockerImage) }
        foreach ($r in $Repo)              { $a.Add('-r');                     $a.Add($r) }
        foreach ($r in $RemoveRepo)        { $a.Add('--remove-repo');          $a.Add($r) }
        foreach ($c in $SetupCommand)      { $a.Add('-c');                     $a.Add($c) }
        foreach ($c in $RemoveSetupCommand){ $a.Add('--remove-setup-command');  $a.Add($c) }
        if ($Force.IsPresent) { $a.Add('--force') }

        Invoke-WarpCli -Arguments $a
    }
}
