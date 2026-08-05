---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: New-WarpSecret
---

# New-WarpSecret

## SYNOPSIS

Creates a new Warp secret.

## SYNTAX

### Raw (Default)

```powershell
New-WarpSecret -Name <string> [-Type <string>] [-ValueFile <string>] [-Description <string>] [-Team] [-Personal] [<CommonParameters>]
```

### ClaudeApiKey

```powershell
New-WarpSecret -Name <string> -ClaudeApiKey [-ValueFile <string>] [-Description <string>] [-Team] [-Personal] [<CommonParameters>]
```

### CodexApiKey

```powershell
New-WarpSecret -Name <string> -CodexApiKey [-ValueFile <string>] [-Description <string>] [-BaseUrl <string>] [-Team] [-Personal] [<CommonParameters>]
```

## DESCRIPTION

Supports generic secrets and provider auth secret creation for Claude and Codex harnesses.

## EXAMPLES

### EXAMPLE 1

```powershell
New-WarpSecret -Name "OPENAI_KEY" -CodexApiKey -ValueFile ./openai.txt
```
