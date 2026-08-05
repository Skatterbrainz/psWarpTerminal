---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 05/05/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpIntegration
---

# Set-WarpIntegration

## SYNOPSIS

Updates an existing Warp integration.

## SYNTAX

### Default

```
Set-WarpIntegration [-Provider] <string> [-Prompt <string>] [-Model <string>]
 [-Environment <string>] [-RemoveEnvironment] [-Mcp <string[]>] [-RemoveMcp <string[]>]
 [-ConfigFile <string>] [-WorkerID <string>] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to update an integration for a supported provider.

## EXAMPLES

### EXAMPLE 1

Set-WarpIntegration -Provider slack -Prompt "Updated instructions"

### EXAMPLE 2

Set-WarpIntegration -Provider linear -RemoveMcp "old-server"

## PARAMETERS

### -Provider

Required. The provider to update (linear or slack).


### -Prompt

Optional. Custom instructions for the integration.


### -Model

Optional. Override the base model.


### -Environment

Optional. Cloud environment ID to run in.


### -RemoveEnvironment

Remove the environment from this integration.


### -Mcp

Optional. One or more MCP server specs to add.


### -RemoveMcp

Optional. One or more MCP server names to remove.


### -ConfigFile

Optional. Path to a YAML or JSON configuration file.


### -WorkerID

Optional. Worker host ID for self-hosted workers.

