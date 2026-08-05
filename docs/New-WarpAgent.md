---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: New-WarpAgent
---

# New-WarpAgent

## SYNOPSIS

Creates a new reusable Warp agent.

## SYNTAX

```powershell
New-WarpAgent -Name <string> [-Description <string>] [-Prompt <string>] [-Secret <string[]>]
 [-Skill <string[]>] [-BaseModel <string>] [-Environment <string>] [<CommonParameters>]
```

## DESCRIPTION

Wraps `agent create`.

## EXAMPLES

### EXAMPLE 1

```powershell
New-WarpAgent -Name "release-notes" -Prompt "Draft concise release notes" -Skill "myorg/repo:release-notes"
```
