function Set-WarpRunner {
    <#
    .SYNOPSIS
    Updates an existing cloud runner.

    .DESCRIPTION
    This function invokes the Warp CLI to update a runner by UID, or by name if UID is omitted.

    .PARAMETER Id
    Optional. UID of the runner to update.

    .PARAMETER Name
    Required when Id is omitted. If Id is provided, updates runner name.

    .PARAMETER Description
    Optional. New description.

    .PARAMETER SetupCommand
    Optional. Setup commands to set (replaces existing).

    .PARAMETER Os
    Optional. Target operating system.

    .PARAMETER Arch
    Optional. Target CPU architecture.

    .PARAMETER DockerImage
    Optional. Docker image reference.

    .PARAMETER MacosVersion
    Optional. macOS version.

    .PARAMETER Vcpus
    Optional. vCPU count.

    .PARAMETER MemoryGb
    Optional. memory in GB.

    .EXAMPLE
    Set-WarpRunner -Id "runner_abc123" -Description "updated"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('Uid')]
        [string]$Id,

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
        [int]$MemoryGb
    )

    process {
        if (-not $Id -and -not $Name) {
            throw 'Set-WarpRunner requires -Id or -Name.'
        }

        $a = [System.Collections.Generic.List[string]]@('runner', 'update')
        if ($Id) { $a.Add($Id) }

        if ($Name) { $a.Add('-n'); $a.Add($Name) }
        if ($Description) { $a.Add('-d'); $a.Add($Description) }
        foreach ($cmd in $SetupCommand) { $a.Add('-c'); $a.Add($cmd) }
        if ($Os) { $a.Add('--os'); $a.Add($Os) }
        if ($Arch) { $a.Add('--arch'); $a.Add($Arch) }
        if ($DockerImage) { $a.Add('--docker-image'); $a.Add($DockerImage) }
        if ($MacosVersion) { $a.Add('--macos-version'); $a.Add($MacosVersion) }
        if ($Vcpus -gt 0) { $a.Add('--vcpus'); $a.Add([string]$Vcpus) }
        if ($MemoryGb -gt 0) { $a.Add('--memory-gb'); $a.Add([string]$MemoryGb) }

        Invoke-WarpCli -Arguments $a
    }
}
