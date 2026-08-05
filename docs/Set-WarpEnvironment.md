---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 05/05/2026
PlatyPS schema version: 2024-05-01
title: Set-WarpEnvironment
---

# Set-WarpEnvironment

## SYNOPSIS

Updates an existing Warp cloud environment.

## SYNTAX

### Default

```
Set-WarpEnvironment [-Id] <string> [-Name <string>] [-Description <string>] [-RemoveDescription]
 [-DockerImage <string>] [-Repo <string[]>] [-RemoveRepo <string[]>] [-SetupCommand <string[]>]
 [-RemoveSetupCommand <string[]>] [-Force] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to update a cloud environment's configuration.

## EXAMPLES

### EXAMPLE 1

Set-WarpEnvironment -Id "env-abc123" -Name "new-name"

### EXAMPLE 2

Set-WarpEnvironment -Id "env-abc123" -Repo "org/new-repo" -RemoveRepo "org/old-repo"

### EXAMPLE 3

Get-WarpEnvironment -Id "env-abc123" | Set-WarpEnvironment -DockerImage "ubuntu:24.04" -Force

## PARAMETERS

### -Id

Required. The ID of the environment to update. May be piped from another command.


### -Name

Optional. Update the environment name.


### -Description

Optional. Update the description (max 240 characters).


### -RemoveDescription

Remove the description from the environment.


### -DockerImage

Optional. Update the Docker image.


### -Repo

Optional. One or more Git repos in "owner/repo" format to add.


### -RemoveRepo

Optional. One or more Git repos in "owner/repo" format to remove.


### -SetupCommand

Optional. One or more setup commands to add.


### -RemoveSetupCommand

Optional. One or more setup commands to remove.


### -Force

Force update without checking for integration usage.

