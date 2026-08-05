---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpRun
---

# Get-WarpRun

## SYNOPSIS

Retrieves Warp runs.

## SYNTAX

### List (Default)

```powershell
Get-WarpRun [-Limit <int>] [-State <string[]>] [-Source <string>] [-ExecutionLocation <string>]
 [-Creator <string>] [-Environment <string>] [-Skill <string>] [-Schedule <string>] [-AncestorRun <string>]
 [-Name <string>] [-Model <string>] [-ArtifactType <string>] [-CreatedAfter <string>] [-CreatedBefore <string>]
 [-UpdatedAfter <string>] [-Query <string>] [-SortBy <string>] [-SortOrder <string>] [-Cursor <string>]
 [<CommonParameters>]
```

### ById

```powershell
Get-WarpRun -TaskId <string> [-Conversation] [<CommonParameters>]
```

## DESCRIPTION

Lists runs with filters or gets a specific run. Use `-Conversation` in by-id mode to request transcript output from the CLI.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-WarpRun -TaskId "run_abc123" -Conversation
```
