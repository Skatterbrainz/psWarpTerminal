---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Invoke-WarpAgent
---

# Invoke-WarpAgent

## SYNOPSIS

Runs a Warp Oz agent locally or in the cloud.

## SYNTAX

### Local (Default)

```powershell
Invoke-WarpAgent [[-Prompt] <string>] [-Name <string>] [-Model <string>] [-Environment <string>]
 [-Skill <string>] [-SavedPrompt <string>] [-TaskId <string>] [-Conversation <string>] [-Mcp <string[]>]
 [-ConfigFile <string>] [-Cwd <string>] [-Share <string>] [-Profile <string>] [-StrictMcpStartup]
 [-McpStartupTimeout <string>] [-NoSnapshot] [-SnapshotUploadTimeout <string>]
 [-SnapshotScriptTimeout <string>] [-OneShot] [-Fast] [-MeasureTiming] [-FastOutputFormat <string>]
 [<CommonParameters>]
```

### Cloud

```powershell
Invoke-WarpAgent [[-Prompt] <string>] -Cloud [-Name <string>] [-Model <string>] [-Environment <string>]
 [-Skill <string>] [-SavedPrompt <string>] [-Conversation <string>] [-Mcp <string[]>] [-ConfigFile <string>]
 [-Open] [-Team] [-Personal] [-NoEnvironment] [-WorkerID <string>] [-Runner <string>] [-Agent <string>]
 [-Attach <string[]>] [-ComputerUse] [-NoComputerUse] [-Harness <string>] [-ClaudeAuthSecret <string>]
 [-CodexAuthSecret <string>] [-NoSnapshot] [-SnapshotUploadTimeout <string>] [-SnapshotScriptTimeout <string>]
 [-OneShot] [-Fast] [-MeasureTiming] [-FastOutputFormat <string>] [<CommonParameters>]
```

## DESCRIPTION

Invokes `agent run` or `agent run-cloud` and returns normalized result fields for conversation, text, files, and events.
Use `-Fast` for low-latency requests. In fast mode, the command skips automatic conversation continuation,
streams output, bypasses event normalization, and disables snapshot upload by default.

Use `-FastOutputFormat` to control fast-mode streaming format. The default is `ndjson`, which shows
event records as they arrive.

Use `-MeasureTiming` to return timing diagnostics including argument-build, CLI startup,
first output token, and total duration.

When combined with `-Fast`, timing uses native streaming execution and may report
`CliStartupMs` / `FirstOutputMs` as null while still reporting total duration.

## EXAMPLES

### EXAMPLE 1

```powershell
Invoke-WarpAgent -Prompt "Build a REST API"
```

### EXAMPLE 2

```powershell
Invoke-WarpAgent -Cloud -Harness claude -ClaudeAuthSecret "ANTHROPIC_API_KEY" -Prompt "Review latest PR"
```

### EXAMPLE 3

```powershell
Invoke-WarpAgent -Prompt "what is the capital of Missouri?" -Fast -OneShot -NoSnapshot
```

### EXAMPLE 4

```powershell
# Fast mode already implies one-shot semantics and disables snapshot upload
Invoke-WarpAgent -Prompt "what is the capital of Missouri?" -Fast
```

### EXAMPLE 5

```powershell
Invoke-WarpAgent -Prompt "what is the capital of Missouri?" -Fast -FastOutputFormat pretty
```

### EXAMPLE 6

```powershell
Invoke-WarpAgent -Prompt "what is the capital of Missouri?" -Fast -MeasureTiming
```
