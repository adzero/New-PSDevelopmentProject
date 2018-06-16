# New-PSDevelopmentProject

## About

New-PSDevelopmentProject.ps1 is a PowerShell script that creates a new file structure for the developement of a PowerShell script or module with an optional Git repository.
The project contains :

- License file (MIT License by default)
- Markdown Readme file
- Tests folder with empty test script
- Source code folder with following files :

1. bin folder for any binaries required
2. lib folder for any libraries required
3. en-US localized folder with PowerShell topic about_ help file (only for modules)
4. Public/Private folders for modules functions files (only for modules)
5. Script or Root module script with its manifest file
6. Optional custom types definition file

Thanks to **[Warren Frame](https://github.com/RamblingCookieMonster)** and his blog post **[Building a PowerShell Module](http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module)** from which the module file structure and code was taken.

## Prerequisites

- PowerShell (V5, previous versions untested)
- PowerShellGet module (required for script info initialization)
- Git (optional)

## Parameters

### Name

The name of the new PowerShell script/module. (Mandatory)

### Author

The author of the new PowerShell script/module. (Mandatory)

### Description

Short description of the new PowerShell script/module.  (Mandatory)

### RootPath

The root path where to create new project directory :

- Script projects will be located under a _Scripts_ directory.
- Module projects will be located under a _Modules_ directory.

If not specified, default value is "$($env:HOMEDRIVE)$($env:HOMEPATH)\Documents\WindowsPowerShell\".

### ScriptProject

Switch option to use for a script project creation. (Mandatory)

### ModuleProject

Switch option to use for a module project creation. (Mandatory)

### GitRepository

Switch option to initialize a new git repository in the project root directory.
First commit of the master branch only contains blank gitignore file.
All files created, tracked and uncommited in a new dev branch.

## Examples

### New script project

```powershell
C:\Users\adzero\Documents\WindowsPowerShell\Scripts> .\New-PSDevelopmentProject.ps1 -Name HelloWorldScript -Author  AdZero -Description "A little script to say Hello !" -RootPath "C:\Users\AdZero\Documents\WindowsPowerShell\dev" -ScriptProject
```

### New Module project with Git repository

```powershell
C:\Users\adzero\Documents\WindowsPowerShell\Scripts> .\New-PSDevelopmentProject.ps1 -Name DemoModule -Author  AdZero -Description "A new PS module" -RootPath "C:\Users\AdZero\Documents\WindowsPowerShell\dev" -ModuleProject -GitRepository
```