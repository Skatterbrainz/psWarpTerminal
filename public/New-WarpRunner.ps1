function New-WarpRunner {
    <#
    .SYNOPSIS
    Creates a new cloud runner.

    .DESCRIPTION
    This function invokes the Warp CLI to create a runner.

    .PARAMETER Name
    Required. Runner name.

    .PARAMETER Description
    Optional. Runner description.

    .PARAMETER SetupCommand
    Optional. One or more setup commands.

    .PARAMETER Os
    Optional. Target operating system.

    .PARAMETER Arch
    Optional. Target CPU architecture.

    .PARAMETER DockerImage
    Optional. Docker image reference (Linux only).

    .PARAMETER MacosVersion
    Optional. macOS version (macOS only).

    .PARAMETER Vcpus
    Optional. Instance vCPU count.

    .PARAMETER MemoryGb
    Optional. Instance memory in GB.

    .PARAMETER Team
    Create at team scope.

    .PARAMETER Personal
    Create at personal scope.

    .EXAMPLE
    New-WarpRunner -Name "linux-large" -Os linux -DockerImage "ghcr.io/org/dev:latest" -Vcpus 4 -MemoryGb 16
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [string]$Description,
        [string[]]$SetupCommand,

        [ValidateSet('linux', 'macos')]
        [string]$Os,

        [ValidateSet('auto', 'x86-64', 'aarch64')]
        [string]$Arch,

        [string]$DockerImage,
        [ValidateSet('14', '15', '26', '27')]
        [string]$MacosVersion,
        [int]$Vcpus,
        [int]$MemoryGb,
        [switch]$Team,
        [switch]$Personal
    )

    $a = [System.Collections.Generic.List[string]]@('runner', 'create', '--name', $Name)

    if ($Description) { $a.Add('-d'); $a.Add($Description) }
    foreach ($cmd in $SetupCommand) { $a.Add('-c'); $a.Add($cmd) }
    if ($Os) { $a.Add('--os'); $a.Add($Os) }
    if ($Arch) { $a.Add('--arch'); $a.Add($Arch) }
    if ($DockerImage) { $a.Add('--docker-image'); $a.Add($DockerImage) }
    if ($MacosVersion) { $a.Add('--macos-version'); $a.Add($MacosVersion) }
    if ($Vcpus -gt 0) { $a.Add('--vcpus'); $a.Add([string]$Vcpus) }
    if ($MemoryGb -gt 0) { $a.Add('--memory-gb'); $a.Add([string]$MemoryGb) }
    if ($Team.IsPresent) { $a.Add('--team') }
    if ($Personal.IsPresent) { $a.Add('--personal') }

    Invoke-WarpCli -Arguments $a
}
