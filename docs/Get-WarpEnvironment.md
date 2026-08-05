---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: Get-WarpEnvironment
---

# Get-WarpEnvironment

## SYNOPSIS

Retrieves a list of Warp environments.

## SYNTAX

### List (Default)

```
Get-WarpEnvironment [<CommonParameters>]
```

### ById

```
Get-WarpEnvironment [-Id] <string> [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to list all available environments or get a specific environment by ID.

## EXAMPLES

### EXAMPLE 1

Get-WarpEnvironment

## PARAMETERS

### -Id

Optional.
The ID of a specific environment to retrieve.
If not provided, all environments will
be listed.
May be piped from another command that outputs an object with an 'Id' property.

