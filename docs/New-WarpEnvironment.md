---
document type: cmdlet
external help file: psWarpTerminal-Help.xml
HelpUri: ''
Locale: en-US
Module Name: psWarpTerminal
ms.date: 02/26/2026
PlatyPS schema version: 2024-05-01
title: New-WarpEnvironment
---

# New-WarpEnvironment

## SYNOPSIS

Creates a new Warp cloud environment.

## SYNTAX

### Default

```
New-WarpEnvironment [-Name] <string> [-Description <string>] [-DockerImage <string>]
 [-Repo <string[]>] [-SetupCommand <string[]>] [-Team] [-Personal] [<CommonParameters>]
```

## DESCRIPTION

This function invokes the Warp CLI to create a new cloud environment with the specified configuration.

## EXAMPLES

### EXAMPLE 1

New-WarpEnvironment -Name "my-env" -DockerImage "ubuntu:22.04" -Repo "org/repo"

## PARAMETERS

### -Description

Optional.
Description of the environment (max 240 characters).


### -DockerImage

Optional.
Docker image to use.
Use Get-WarpEnvironmentImage to list available images.


### -Name

Required.
Name of the environment.


### -Personal

Create as private to your account.


### -Repo

Optional.
One or more Git repos in "owner/repo" format.


### -SetupCommand

Optional.
One or more setup commands to run after cloning.


### -Team

Create at the team level.

