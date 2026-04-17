function Save-WarpArtifact {
    <#
    .SYNOPSIS
    Downloads a Warp artifact file to the local filesystem.

    .DESCRIPTION
    This function invokes the Warp CLI to download an artifact file by UID. If -Path is provided, the file is written to that location; otherwise the CLI chooses a default filename in the current directory.

    .PARAMETER Uid
    Required. The UID of the artifact to download. May be piped from another command that outputs an object with a 'Uid' property.

    .PARAMETER Path
    Optional. Destination file path. Maps to the CLI's `-o / --out` option.

    .EXAMPLE
    Save-WarpArtifact -Uid "art-abc123" -Path ./report.pdf

    .EXAMPLE
    Get-WarpRun -TaskId "task-xyz" | Select-Object -ExpandProperty artifacts | Save-WarpArtifact
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('ArtifactUid','Id')]
        [string]$Uid,

        [Parameter(Position = 1)]
        [Alias('OutFile','Destination')]
        [string]$Path
    )

    process {
        $a = [System.Collections.Generic.List[string]]@('artifact', 'download', $Uid)
        if ($Path) { $a.Add('-o'); $a.Add($Path) }

        $target = if ($Path) { $Path } else { '(default CLI location)' }
        if ($PSCmdlet.ShouldProcess($target, "Download artifact $Uid")) {
            Invoke-WarpCli -Arguments $a -RawOutput
        }
    }
}
