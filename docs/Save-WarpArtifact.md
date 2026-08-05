---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 04/17/2026
PlatyPS schema version: 2024-05-01
title: Save-WarpArtifact
---

# Save-WarpArtifact

## SYNOPSIS

Downloads a Warp artifact file to the local filesystem.

## SYNTAX

### Default

```
Save-WarpArtifact [-Uid] <string> [[-Path] <string>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to download an artifact file by UID. If -Path is provided, the file is written to that location; otherwise the CLI chooses a default filename in the current directory.

## EXAMPLES

### EXAMPLE 1

Save-WarpArtifact -Uid "art-abc123" -Path ./report.pdf

### EXAMPLE 2

Get-WarpRun -TaskId "task-xyz" | Select-Object -ExpandProperty artifacts | Save-WarpArtifact

## PARAMETERS

### -Uid

Required.
The UID of the artifact to download.
May be piped from another command that outputs an object with a 'Uid' property.


### -Path

Optional.
Destination file path. Maps to the CLI's `-o / --out` option.

