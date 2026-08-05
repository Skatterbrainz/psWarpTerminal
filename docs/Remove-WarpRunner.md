---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 08/04/2026
PlatyPS schema version: 2024-05-01
title: Remove-WarpRunner
---

# Remove-WarpRunner

## SYNOPSIS

Deletes a cloud runner.

## SYNTAX

```powershell
Remove-WarpRunner [-Id] <string> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Deletes a runner using `runner delete`.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-WarpRunner -Id "runner_abc123" -Force
```
