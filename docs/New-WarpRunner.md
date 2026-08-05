---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: New-WarpRunner
---

# New-WarpRunner

## SYNOPSIS

Creates a new cloud runner.

## SYNTAX

```powershell
New-WarpRunner -Name <string> [-Description <string>] [-SetupCommand <string[]>]
 [-Os <string>] [-Arch <string>] [-DockerImage <string>] [-MacosVersion <string>]
 [-Vcpus <int>] [-MemoryGb <int>] [-Team] [-Personal] [<CommonParameters>]
```

## DESCRIPTION

Creates a runner using `runner create`.

## EXAMPLES

### EXAMPLE 1

```powershell
New-WarpRunner -Name "linux-large" -Os linux -DockerImage "ghcr.io/org/dev:latest" -Vcpus 4 -MemoryGb 16
```
