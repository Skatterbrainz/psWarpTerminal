---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 05/05/2026
PlatyPS schema version: 2024-05-01
title: New-WarpIntegration
---

# New-WarpIntegration

## SYNOPSIS

Creates a new Warp integration.

## SYNTAX

### Default

```
New-WarpIntegration [-Provider] <string> [-Prompt <string>] [-Model <string>]
 [-Environment <string>] [-NoEnvironment] [-Mcp <string[]>] [-ConfigFile <string>]
 [-WorkerID <string>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to create a new integration for a supported provider.

## EXAMPLES

### EXAMPLE 1

New-WarpIntegration -Provider linear -Environment "env-id"

### EXAMPLE 2

New-WarpIntegration -Provider slack -Prompt "Respond helpfully to questions in #dev"

## PARAMETERS

### -Provider

Required. The provider to integrate (linear or slack).


### -Prompt

Optional. Custom instructions for the integration.


### -Model

Optional. Override the base model.


### -Environment

Optional. Cloud environment ID to run in.


### -NoEnvironment

Do not run the agent in an environment.


### -Mcp

Optional. One or more MCP server specs.


### -ConfigFile

Optional. Path to a YAML or JSON configuration file.


### -WorkerID

Optional. Worker host ID for self-hosted workers.

