# New-PSDevelopmentProject

## About

New-PSDevelopmentProject.ps1 is a PowerShell script that creates a new file structure for the development of a PowerShell script or module with an optional Git repository.
The project contains :

- License file (MIT License by default)
- Markdown Readme file
- Tests folder with empty test script (with -PesterTests parameter)
- Source code folder with following files :

1. bin folder for any binaries required
2. lib folder for any libraries required
3. en-US localized folder with PowerShell topic about_ help file (only for modules)
4. Public/Private folders for modules functions files (only for modules)
5. Script or Root module script with its manifest file
6. Optional custom types definition file (with -TypeFile parameter)
7. Optional format file (with -FormatFile parameter)

Thanks to **[Warren Frame](https://github.com/RamblingCookieMonster)** and his blog post **[Building a PowerShell Module](http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module)** from which the module file structure and code was taken.

## Prerequisites

- PowerShell (V5, previous versions untested)
- PowerShellGet module (required for script info initialization)
- Git (optional)

## Parameters

### ScriptProject

Use this option to create a project structure for a script.

### ModuleProject

Use this option to create a project structure for a module.

### RootPath
The root path where to create new project directory :

- Script projects will be located under a _Scripts_ directory.
- Module projects will be located under a _Modules_ directory.

If not specified, default value is "$($env:HOMEDRIVE)$($env:HOMEPATH)\Documents\WindowsPowerShell\".

### DisableProjectCategoryFolder
Use this option to not include Modules or Scripts folder in the project root path.

### FormatFile
Use this option to add an object display format definition file.

### TypeFile
Use this option to add an extended type data definition file.

### PesterTests
Use this option to add a test folder with a default Pester script.

### GitRepository
Use this option to include a git repository for the project.

First commit of the main branch only contains blank gitignore file.
All files created, tracked and uncommited in a new dev branch.

### Name
Specifies the name of the script/module. Name should not contain spaces or invalid filename characters.

### Description
Specifies a description for the script/module. (Mandatory)

### Version
Specifies the version of the script/module. Version should adhere to semantic versioning format. 

### Author
Specifies the script/module author.

### Guid 
Specifies a unique ID for the script/module.

### CompanyName
Specifies the company or vendor who created the script/module.

### Copyright
Specifies a copyright statement for the script/module.

### Tags
Specifies an array of tags.

### ProjectUri
Specifies the URL of a web page about this project.

### LicenseUri
Specifies the URL of licensing terms.

### IconUri
Specifies the URL of an icon for the script/module. The specified icon is displayed on the gallery web page for the script/module.

### ReleaseNotes
Specifies release notes.

### RequiredModules
Specifies modules that must be in the global session state. If the required modules aren't in the global session state, PowerShell imports them. If the required modules aren't available, the Import-Module command fails.

Enter each module name as a string or as a hash table with ModuleName and ModuleVersion/RequiredVersion keys. The hash table can also have an optional GUID key. You can combine strings and hash tables in the parameter value.

### ExternalModuledependencies
A list of external modules that this module is depends on.

### RequiredAssemblies
Specifies the assembly (.dll) files that the module requires. Enter the assembly file names. PowerShell loads the specified assemblies before updating types or formats, importing nested modules, or importing the module file that is specified in the value of the RootModule key.

Use this parameter to list all the assemblies that the module requires, including assemblies that must be loaded to update any formatting or type files that are listed in the FormatsToProcess or TypesToProcess keys, even if those assemblies are also listed as binary modules in the NestedModules key.

### FileList
Specifies all items that are included in the module.

This key is designed to act as a module inventory. The files listed in the key are included when the module is published, but any functions aren't automatically exported.

### ModuleList
Lists all modules that are included in this module.

Enter each module name as a string or as a hash table with ModuleName and ModuleVersion keys. The hash table can also have an optional GUID key. You can combine strings and hash tables in the parameter value.

This key is designed to act as a module inventory. The modules that are listed in the value of this key aren't automatically processed.

### FunctionsToExport
Specifies the functions that the module exports. Wildcards are permitted.

You can use this parameter to restrict the functions that are exported by the module. It can remove functions from the list of exported aliases, but it can't add functions to the list.

If you omit this parameter, module manifest is created with FunctionsToExport key with a value of * (all), meaning that all functions defined in the module are exported by the manifest.

### AliasesToExport
Specifies the aliases that the module exports. Wildcards are permitted.

You can use this parameter to restrict the aliases that are exported by the module. It can remove aliases from the list of exported aliases, but it can't add aliases to the list.

If you omit this parameter, module manifest is created with AliasesToExport key with a value of * (all), meaning that all aliases defined in the module are exported by the manifest.

### VariablesToExport
Specifies the variables that the module exports. Wildcards are permitted.

You can use this parameter to restrict the variables that are exported by the module. It can remove variables from the list of exported variables, but it can't add variables to the list.

If you omit this parameter, module manifest is created with VariablesToExport key with a value of * (all), meaning that all variables defined in the module are exported by the manifest.

### CmdletsToExport
Specifies the cmdlets that the module exports. Wildcards are permitted.

You can use this parameter to restrict the cmdlets that are exported by the module. It can remove cmdlets from the list of exported cmdlets, but it can't add cmdlets to the list.

If you omit this parameter, module manifest is created with CmdletsToExport key with a value of * (all), meaning that all cmdlets defined in the module are exported by the manifest.

### DscResourcesToExport
Specifies the Desired State Configuration (DSC) resources that the module exports. Wildcards are permitted.

### CompatiblePSEditions
Specifies the module's compatible PSEditions. For information about PSEdition, see Modules with compatible PowerShell Editions.

### DefaultCommandPrefix
Specifies all items that are included in the module.

This key is designed to act as a module inventory. The files listed in the key are included when the module is published, but any functions aren't automatically exported.

### ProcessorArchitecture
Specifies the processor architecture that the module requires. Valid values are x86, AMD64, IA64, MSIL, and None (unknown or unspecified).

### PowerShellVersion
Specifies the minimum version of PowerShell that works with this module. For example, you can enter 1.0, 2.0, or 3.0 as the parameter's value. It must be in an X.X format. For example, if you submit 5, PowerShell will throw an error.

To find the name of a host program, in the program, type $Host.Name.

### PowerShellHostVersion
Specifies the minimum version of the PowerShell host program that works with the module. Enter a version number, such as 1.1.

### RequireLicenseAcceptance
Flag to indicate whether the module requires explicit user acceptance for install, update, or save.

### Prerelease
Prerelease string of this module. Adding a Prerelease string identifies the module as a prerelease version.

### HelpInfoUri
Specifies the internet address of the HelpInfo XML file for the module. Enter a Uniform Resource Identifier (URI) that begins with http or https.

The HelpInfo XML file supports the Updatable Help feature that was introduced in PowerShell 3.0. It contains information about the location of downloadable help files for the module and the version numbers of the newest help files for each supported locale.

For information about Updatable Help, see [about_Updatable_Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_updatable_help?view=powershell-7.4). For information about the HelpInfo XML file, see [Supporting Updatable Help](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/supporting-updatable-help).

### PrivateData
Specifies data that is passed to the script/module.

### PassThru
Use this option to return the object representing the project directory.

## Examples

### Example 1 - Creates a new script project for a given author.

```powershell
PS> New-PSDevelopmentProject.ps1 -ScriptProject -RootPath C:\Users\adzero\Documents\WindowsPowerShell\Sources -Name NewScriptProject -Description "My awesome new PowerShell script project !" -Author AdZero
```

### Example 2 - Creates a new module project for a given author. 

```powershell
PS> New-PSDevelopmentProject.ps1 -ModuleProject -RootPath C:\Users\adzero\Documents\WindowsPowerShell\Sources -Name NewModuleProject -Description "My awesome new PowerShell module project !" -Author Adzero
```

### Example 3 - Creates a new module project for a given author with a git repository. 

```powershell
PS> New-PSDevelopmentProject.ps1 -ModuleProject -RootPath C:\Users\adzero\Documents\WindowsPowerShell\Sources -Name NewModuleGitProject -Description "My awesome new PowerShell module project with a git repository !" -Author Adzero -GitRepository
```