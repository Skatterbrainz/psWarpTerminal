---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 04/17/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpArtifact
---

# Get-WarpArtifact

## SYNOPSIS

Retrieves metadata for a Warp artifact by UID.

## SYNTAX

### Default

```
Get-WarpArtifact [-Uid] <string> [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to fetch metadata for a single artifact produced by an agent run.

## EXAMPLES

### EXAMPLE 1

Get-WarpArtifact -Uid "art-abc123"

### EXAMPLE 2

Get-WarpRun -TaskId "task-xyz" | Select-Object -ExpandProperty artifacts | Get-WarpArtifact

## PARAMETERS

### -Uid

Required.
The UID of the artifact to retrieve.
May be piped from another command that outputs an object with a 'Uid' property.

