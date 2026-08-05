---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpAgent
---

# Set-WarpAgent

## SYNOPSIS

Updates an existing reusable Warp agent.

## SYNTAX

```powershell
Set-WarpAgent -Id <string> [-Name <string>] [-Description <string>] [-RemoveDescription]
 [-Prompt <string>] [-RemovePrompt] [-AddSecret <string[]>] [-RemoveSecret <string[]>] [-RemoveAllSecrets]
 [-AddSkill <string[]>] [-RemoveSkill <string[]>] [-RemoveAllSkills] [-BaseModel <string>] [-RemoveBaseModel]
 [-Environment <string>] [-RemoveEnvironment] [<CommonParameters>]
```

## DESCRIPTION

Wraps `agent update`.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-WarpAgent -Id "ag_abc123" -Prompt "New base behavior" -RemoveSkill "old/repo:legacy"
```
