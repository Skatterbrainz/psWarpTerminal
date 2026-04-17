function Get-WarpArtifact {
    <#
    .SYNOPSIS
    Retrieves metadata for a Warp artifact by UID.

    .DESCRIPTION
    This function invokes the Warp CLI to fetch metadata for a single artifact produced by an agent run.

    .PARAMETER Uid
    Required. The UID of the artifact to retrieve. May be piped from another command that outputs an object with a 'Uid' property.

    .EXAMPLE
    Get-WarpArtifact -Uid "art-abc123"

    .EXAMPLE
    Get-WarpRun -TaskId "task-xyz" | Select-Object -ExpandProperty artifacts | Get-WarpArtifact
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [Alias('ArtifactUid','Id')]
        [string]$Uid
    )

    process {
        Invoke-WarpCli -Arguments @('artifact', 'get', $Uid)
    }
}
