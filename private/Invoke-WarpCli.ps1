function Invoke-WarpCli {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]]$Arguments,
        [switch]$RawOutput
    )

    $cmd = Get-Command 'warp-terminal' -ErrorAction SilentlyContinue
    if (-not $cmd) { throw 'warp-terminal not found in PATH.' }

    $args_ = [System.Collections.Generic.List[string]]::new()
    $args_.AddRange($Arguments)

    if (-not $RawOutput) {
        $args_.Add('--output-format')
        $args_.Add('json')
    }

    if ($env:WARP_API_KEY) {
        $args_.Add('--api-key')
        $args_.Add($env:WARP_API_KEY)
    }

    Write-Verbose "warp-terminal $($args_ -join ' ')"
    $raw = & warp-terminal @args_ 2>&1

    $exitCode = $LASTEXITCODE
    $stderr = ($raw | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] }) -join "`n"
    $stdout = ($raw | Where-Object { $_ -isnot [System.Management.Automation.ErrorRecord] }) -join "`n"

    if ($exitCode -ne 0) {
        $msg = if ($stderr) { $stderr } else { $stdout }
        Write-Error "warp-terminal exited $exitCode`: $msg"
        return
    }

    if ($RawOutput) { return $stdout }

    if ([string]::IsNullOrWhiteSpace($stdout)) { return }

    try { $stdout | ConvertFrom-Json } catch { Write-Output $stdout }
}
