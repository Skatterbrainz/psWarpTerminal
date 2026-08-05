---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpRunner
---

# Set-WarpRunner

## SYNOPSIS

Updates an existing cloud runner.

## SYNTAX

```powershell
Set-WarpRunner [[-Id] <string>] [-Name <string>] [-Description <string>] [-SetupCommand <string[]>]
 [-Os <string>] [-Arch <string>] [-DockerImage <string>] [-MacosVersion <string>]
 [-Vcpus <int>] [-MemoryGb <int>] [<CommonParameters>]
```

## DESCRIPTION

Updates a runner by UID or name using `runner update`.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-WarpRunner -Id "runner_abc123" -Description "updated"
```
