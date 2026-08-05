function Invoke-WarpCli {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string[]]$Arguments,
        [switch]$RawOutput,
        [ValidateSet('json', 'ndjson', 'pretty', 'text')]
        [string]$OutputFormat,
        [switch]$StreamOutput,
        [switch]$MeasureTiming
    )

    if ($StreamOutput.IsPresent -and -not $RawOutput.IsPresent) {
        throw '-StreamOutput requires -RawOutput.'
    }

    $cmd = Get-Command 'oz' -ErrorAction SilentlyContinue
    if (-not $cmd) {
        $cmd = Get-Command 'oz-preview' -ErrorAction SilentlyContinue
    }
    if (-not $cmd) {
        $cmd = Get-Command 'warp-terminal' -ErrorAction SilentlyContinue
    }
    if (-not $cmd) { throw 'Neither oz, oz-preview, nor warp-terminal found in PATH.' }

    $args_ = [System.Collections.Generic.List[string]]::new()
    $args_.AddRange($Arguments)

    if ($OutputFormat) {
        $args_.Add('--output-format')
        $args_.Add($OutputFormat)
    } elseif (-not $RawOutput) {
        $args_.Add('--output-format')
        $args_.Add('json')
    }

    if ($env:WARP_API_KEY) {
        $args_.Add('--api-key')
        $args_.Add($env:WARP_API_KEY)
    }

    Write-Verbose "$($cmd.Name) $($args_ -join ' ')"

    if ($MeasureTiming.IsPresent -and $StreamOutput.IsPresent) {
        # Keep native streaming behavior (TTY + host output) and only measure wall time.
        $runWatch = [System.Diagnostics.Stopwatch]::StartNew()
        & $cmd.Name @args_
        $runWatch.Stop()

        $exitCode = $LASTEXITCODE
        if ($exitCode -ne 0) {
            Write-Error "$($cmd.Name) exited $exitCode"
            return
        }

        return [PSCustomObject]@{
            Output = $null
            Timing = [PSCustomObject]@{
                CliStartupMs = $null
                FirstOutputMs = $null
                CliTotalMs   = [int][Math]::Round($runWatch.Elapsed.TotalMilliseconds)
            }
        }
    }

    if ($MeasureTiming.IsPresent) {
        $exePath = if ($cmd.Path) { $cmd.Path } else { $cmd.Name }
        $psi = [System.Diagnostics.ProcessStartInfo]::new()
        $psi.FileName = $exePath
        foreach ($arg in $args_) {
            [void]$psi.ArgumentList.Add($arg)
        }
        $psi.RedirectStandardOutput = $true
        $psi.RedirectStandardError = $true
        $psi.UseShellExecute = $false
        $psi.CreateNoWindow = $true

        $proc = [System.Diagnostics.Process]::new()
        $proc.StartInfo = $psi

        $startupWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $null = $proc.Start()
        $startupWatch.Stop()

        $runWatch = [System.Diagnostics.Stopwatch]::StartNew()
        $stdoutBuilder = [System.Text.StringBuilder]::new()
        $stderrBuilder = [System.Text.StringBuilder]::new()
        $firstOutputMs = $null

        while (-not $proc.HasExited) {
            while ($proc.StandardOutput.Peek() -ge 0) {
                $charCode = $proc.StandardOutput.Read()
                if ($charCode -lt 0) { break }

                if ($null -eq $firstOutputMs) {
                    $firstOutputMs = $runWatch.ElapsedMilliseconds
                }

                $char = [char]$charCode
                [void]$stdoutBuilder.Append($char)
                if ($StreamOutput.IsPresent) {
                    [Console]::Out.Write($char)
                }
            }

            while ($proc.StandardError.Peek() -ge 0) {
                $errCharCode = $proc.StandardError.Read()
                if ($errCharCode -lt 0) { break }

                $errChar = [char]$errCharCode
                [void]$stderrBuilder.Append($errChar)
            }

            [void]$proc.WaitForExit(25)
        }

        while ($proc.StandardOutput.Peek() -ge 0) {
            $charCode = $proc.StandardOutput.Read()
            if ($charCode -lt 0) { break }

            if ($null -eq $firstOutputMs) {
                $firstOutputMs = $runWatch.ElapsedMilliseconds
            }

            $char = [char]$charCode
            [void]$stdoutBuilder.Append($char)
            if ($StreamOutput.IsPresent) {
                [Console]::Out.Write($char)
            }
        }

        while ($proc.StandardError.Peek() -ge 0) {
            $errCharCode = $proc.StandardError.Read()
            if ($errCharCode -lt 0) { break }

            $errChar = [char]$errCharCode
            [void]$stderrBuilder.Append($errChar)
        }

        $stderr = $stderrBuilder.ToString().TrimEnd("`r", "`n")
        $proc.WaitForExit()
        $runWatch.Stop()

        $stdout = $stdoutBuilder.ToString().TrimEnd("`r", "`n")
        $exitCode = $proc.ExitCode

        if ($exitCode -ne 0) {
            $msg = if ($stderr) { $stderr } else { $stdout }
            Write-Error "$($cmd.Name) exited $exitCode`: $msg"
            return
        }

        $payload = $null
        if ($RawOutput.IsPresent) {
            $payload = $stdout
        } elseif (-not [string]::IsNullOrWhiteSpace($stdout)) {
            try { $payload = $stdout | ConvertFrom-Json } catch { $payload = $stdout }
        }

        return [PSCustomObject]@{
            Output = $payload
            Timing = [PSCustomObject]@{
                CliStartupMs = [int][Math]::Round($startupWatch.Elapsed.TotalMilliseconds)
                FirstOutputMs = if ($null -ne $firstOutputMs) { [int]$firstOutputMs } else { $null }
                CliTotalMs   = [int][Math]::Round($runWatch.Elapsed.TotalMilliseconds)
            }
        }
    }

    if ($StreamOutput.IsPresent) {
        # Stream stdout directly to caller to reduce perceived latency.
        & $cmd.Name @args_
        $exitCode = $LASTEXITCODE
        if ($exitCode -ne 0) {
            Write-Error "$($cmd.Name) exited $exitCode"
            return
        }
        return
    }

    $raw = & $cmd.Name @args_ 2>&1

    $exitCode = $LASTEXITCODE
    $stderr = ($raw | Where-Object { $_ -is [System.Management.Automation.ErrorRecord] }) -join "`n"
    $stdout = ($raw | Where-Object { $_ -isnot [System.Management.Automation.ErrorRecord] }) -join "`n"

    if ($exitCode -ne 0) {
        $msg = if ($stderr) { $stderr } else { $stdout }
        Write-Error "$($cmd.Name) exited $exitCode`: $msg"
        return
    }

    if ($RawOutput) { return $stdout }

    if ([string]::IsNullOrWhiteSpace($stdout)) { return }

    try { $stdout | ConvertFrom-Json } catch { Write-Output $stdout }
}
