<#PSScriptInfo

.VERSION 2.0.0

.GUID 32d9b358-2002-4dbb-9393-d068333a60e6

.AUTHOR AdZero

.COMPANYNAME AdZero

.COPYRIGHT Copyright 2018-2024 AdZero

.TAGS PowerShell GIT

.LICENSEURI https://raw.githubusercontent.com/adzero/New-PSDevelopmentProject/master/LICENSE

.PROJECTURI https://github.com/adzero/New-PSDevelopmentProject

.ICONURI https://raw.githubusercontent.comm/adzero/New-PSDevelopmentProject/master/images/adzero-avatar.png

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES

#>

<#
.SYNOPSIS
Creates a new file structure for the development of a PowerShell script or module. 

.DESCRIPTION 
Creates a new file structure for the development of a PowerShell script or module. 

.EXAMPLE
PS> New-PSDevelopmentProject.ps1 -Name NewScriptProject -RootPath C:\Users\adzero\Documents\WindowsPowerShell\Sources -ScriptProject -Author Adzero -Description "My awesome new PowerShell script project !"

 

    Directory: C:\Users\adzero\Documents\WindowsPowerShell\Sources\Scripts\NewScriptProject


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        02/03/2021     19:19             85 README.md
-a----        02/03/2021     19:19           1071 LICENSE


    Directory: C:\Users\adzero\Documents\WindowsPowerShell\Sources\Scripts\NewScriptProject\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        02/03/2021     19:19                lib
d-----        02/03/2021     19:19                bin

.EXAMPLE
PS> New-PSDevelopmentProject.ps1 -Name NewModuleProject -RootPath C:\Users\adzero\Documents\WindowsPowerShell\Sources -ModuleProject -Author Adzero -Description "My awesome new PowerShell module project !"


    Directory: D:\Temp\Modules\NewModuleProject


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        02/03/2021     19:23             85 README.md
-a----        02/03/2021     19:23           1071 LICENSE


    Directory: D:\Temp\Modules\NewModuleProject\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        02/03/2021     19:23                lib
d-----        02/03/2021     19:23                bin
-a----        02/03/2021     19:23            574 NewModuleProject.psm1
d-----        02/03/2021     19:23                Enums
d-----        02/03/2021     19:23                Classes
d-----        02/03/2021     19:23                Private
d-----        02/03/2021     19:23                Public


    Directory: D:\Temp\Modules\NewModuleProject\src\en-US


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        02/03/2021     19:23              0 about_NewModuleProject.help.txt

.EXAMPLE
PS> New-PSDevelopmentProject.ps1 -Name NewModuleGitProject -RootPath C:\Users\adzero\Documents\WindowsPowerShell\Sources -ModuleProject -Author Adzero -Description "My awesome new PowerShell module project with a git repository !" -GitRepository


    Directory: C:\Users\adzero\Documents\WindowsPowerShell\Sources\Modules\NewModuleGitProject


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        02/03/2021     19:28              0 .gitignore
Initialized empty Git repository in C:/Users/adzero/Documents/WindowsPowerShell/Sources/Modules/NewModuleGitProject/.git/
[master (root-commit) a1989f2] Repository creation
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
-a----        02/03/2021     19:28            110 README.md
-a----        02/03/2021     19:28           1071 LICENSE


    Directory: C:\Users\adzero\Documents\WindowsPowerShell\Sources\Modules\NewModuleGitProject\src


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        02/03/2021     19:28                lib
d-----        02/03/2021     19:28                bin
-a----        02/03/2021     19:28            574 NewModuleGitProject.psm1
d-----        02/03/2021     19:23                Enums
d-----        02/03/2021     19:23                Classes
d-----        02/03/2021     19:28                Private
d-----        02/03/2021     19:28                Public


    Directory: C:\Users\adzero\Documents\WindowsPowerShell\Sources\Modules\NewModuleGitProject\src\en-US


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        02/03/2021     19:28              0 about_NewModuleGitProject.help.txt

.PARAMETER ScriptProject
Use this option to create a project structure for a script.

.PARAMETER ModuleProject
Use this option to create a project structure for a module.

.PARAMETER RootPath
The root path where to create new project directory.

.PARAMETER Name
Specifies the name of the script/module. Name should not contain spaces or invalid filename characters.

.PARAMETER Version
Specifies the version of the script/module. Version should adhere to semantic versioning format. 

.PARAMETER Author
Specifies the script/module author.

.PARAMETER Description
Specifies a description for the script/module.

.PARAMETER Guid
Specifies a unique ID for the script/module.

.PARAMETER CompanyName
Specifies the company or vendor who created the script/module.

.PARAMETER Copyright
Specifies a copyright statement for the script/module.

.PARAMETER Tags
Specifies an array of tags.

.PARAMETER ProjectUri
Specifies the URL of a web page about this project.

.PARAMETER LicenseUri
Specifies the URL of licensing terms.

.PARAMETER IconUri
Specifies the URL of an icon for the script/module. The specified icon is displayed on the gallery web page for the script/module.

.PARAMETER ReleaseNotes
Specifies release notes.

.PARAMETER RequiredModules
Specifies modules that must be in the global session state. If the required modules aren't in the global session state, PowerShell imports them. If the required modules aren't available, the Import-Module command fails.

Enter each module name as a string or as a hash table with ModuleName and ModuleVersion/RequiredVersion keys. The hash table can also have an optional GUID key. You can combine strings and hash tables in the parameter value.

.PARAMETER ExternalModuleDependencies
A list of external modules that this module is depends on.

.PARAMETER RequiredAssemblies
Specifies the assembly (.dll) files that the module requires. Enter the assembly file names. PowerShell loads the specified assemblies before updating types or formats, importing nested modules, or importing the module file that is specified in the value of the RootModule key.

Use this parameter to list all the assemblies that the module requires, including assemblies that must be loaded to update any formatting or type files that are listed in the FormatsToProcess or TypesToProcess keys, even if those assemblies are also listed as binary modules in the NestedModules key.

.PARAMETER FunctionsToExport
Specifies the functions that the module exports. Wildcards are permitted.

You can use this parameter to restrict the functions that are exported by the module. It can remove functions from the list of exported aliases, but it can't add functions to the list.

If you omit this parameter, module manifest is created with FunctionsToExport key with a value of * (all), meaning that all functions defined in the module are exported by the manifest.

.PARAMETER AliasesToExport
Specifies the aliases that the module exports. Wildcards are permitted.

You can use this parameter to restrict the aliases that are exported by the module. It can remove aliases from the list of exported aliases, but it can't add aliases to the list.

If you omit this parameter, module manifest is created with AliasesToExport key with a value of * (all), meaning that all aliases defined in the module are exported by the manifest.

.PARAMETER VariablesToExport
Specifies the variables that the module exports. Wildcards are permitted.

You can use this parameter to restrict the variables that are exported by the module. It can remove variables from the list of exported variables, but it can't add variables to the list.

If you omit this parameter, module manifest is created with VariablesToExport key with a value of * (all), meaning that all variables defined in the module are exported by the manifest.

.PARAMETER CmdletsToExport
Specifies the cmdlets that the module exports. Wildcards are permitted.

You can use this parameter to restrict the cmdlets that are exported by the module. It can remove cmdlets from the list of exported cmdlets, but it can't add cmdlets to the list.

If you omit this parameter, module manifest is created with CmdletsToExport key with a value of * (all), meaning that all cmdlets defined in the module are exported by the manifest.

.PARAMETER DscResourcesToExport
Specifies the Desired State Configuration (DSC) resources that the module exports. Wildcards are permitted.

.PARAMETER CompatiblePSEditions
Specifies the module's compatible PSEditions. For information about PSEdition, see Modules with compatible PowerShell Editions.

.PARAMETER PrivateData
Specifies data that is passed to the script/module.

.PARAMETER DefaultCommandPrefix
Specifies a prefix that is prepended to the nouns of all commands in the module when they're imported into a session. Enter a prefix string. Prefixes prevent command name conflicts in a user's session.

Module users can override this prefix by specifying the Prefix parameter of the Import-Module cmdlet.

.PARAMETER FileList
Specifies all items that are included in the module.

This key is designed to act as a module inventory. The files listed in the key are included when the module is published, but any functions aren't automatically exported.

.PARAMETER ModuleList
Lists all modules that are included in this module.

Enter each module name as a string or as a hash table with ModuleName and ModuleVersion keys. The hash table can also have an optional GUID key. You can combine strings and hash tables in the parameter value.

This key is designed to act as a module inventory. The modules that are listed in the value of this key aren't automatically processed.

.PARAMETER ProcessorArchitecture
Specifies the processor architecture that the module requires. Valid values are x86, AMD64, IA64, MSIL, and None (unknown or unspecified).

.PARAMETER PowerShellVersion
Specifies the minimum version of PowerShell that works with this module. For example, you can enter 1.0, 2.0, or 3.0 as the parameter's value. It must be in an X.X format. For example, if you submit 5, PowerShell will throw an error.

.PARAMETER PowerShellHostName 
Specifies the name of the PowerShell host program that the module requires. Enter the name of the host program, such as Windows PowerShell ISE Host or ConsoleHost. Wildcards aren't permitted.

To find the name of a host program, in the program, type $Host.Name.

.PARAMETER PowerShellHostVersion
Specifies the minimum version of the PowerShell host program that works with the module. Enter a version number, such as 1.1.

.PARAMETER RequireLicenseAcceptance
Flag to indicate whether the module requires explicit user acceptance for install, update, or save.

.PARAMETER Prerelease
Prerelease string of this module. Adding a Prerelease string identifies the module as a prerelease version.

.PARAMETER HelpInfoUri
Specifies the internet address of the HelpInfo XML file for the module. Enter a Uniform Resource Identifier (URI) that begins with http or https.

The HelpInfo XML file supports the Updatable Help feature that was introduced in PowerShell 3.0. It contains information about the location of downloadable help files for the module and the version numbers of the newest help files for each supported locale.

For information about Updatable Help, see [about_Updatable_Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_updatable_help?view=powershell-7.4). For information about the HelpInfo XML file, see [Supporting Updatable Help](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/supporting-updatable-help).

.PARAMETER FormatFile
Use this option to add an object display format definition file.

.PARAMETER TypeFile
Use this option to add an extended type data definition file.

.PARAMETER PesterTests
Use this option to add a test folder with a default Pester script.

.PARAMETER GitRepository
Use this option to include a git repository for the project.

.PARAMETER DisableProjectCategoryFolder
 Use this option to not include Modules or Scripts folder in the project root path.

.PARAMETER Passthru
Use this option to return the object representing the project directory.

.INPUTS
None

.OUTPUTS
System.IO.FileInfo
System.IO.DirectoryInfo

.LINK
https://semver.org/spec/v2.0.0.html

.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-modulemanifest

.LINK
https://learn.microsoft.com/en-us/powershell/module/powershellget/new-scriptfileinfo

.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_types.ps1xml

.LINK
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_format.ps1xml

#>

#Requires -Modules @{ModuleName = "PowerShellGet"; ModuleVersion = "2.2.5"; GUID = "1d73a601-4a6c-43c5-ba3f-619b18bbb404" })

[CmdletBinding(DefaultParameterSetName = "Script", SupportsShouldProcess, ConfirmImpact="Low")]
Param(
	[Parameter(ParameterSetName = "Script", Mandatory = $true, HelpMessage = "Use this option to create a project structure for a script.")]
	[switch]
	$ScriptProject,
	[Parameter(ParameterSetName = "Module", Mandatory = $true, HelpMessage = "Use this option to create a project structure for a module.")]
	[switch]
	$ModuleProject,
	[Parameter(Mandatory = $true, HelpMessage = "Specifies the name of the script/module. Name should not contain spaces or invalid filename characters.")]
	[ValidateScript({$_ -inotmatch ([RegEx]::Escape([System.IO.Path]::GetInvalidFileNameChars()))})]
	[string]
	$Name,
	[Parameter(Mandatory = $true, HelpMessage = "Specifies a description for the script/module.")]
	[string]
	$Description,
	[Parameter(HelpMessage = "Specifies the version of the script/module.")]
	[ValidateScript({ $_ -imatch "^\d+\.\d+\.\d+(-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?$" })]
	[string]
	$Version = "1.0.0",
	[Parameter(HelpMessage = "Specifies the script/module author")]
	[string]
	$Author,
	[Parameter(HelpMessage = "Specifies a unique ID for the script/module.")]
	[guid]
	$Guid,
	[Parameter(HelpMessage = "Specifies the company or vendor who created the script/module.")]
	[string]
	$CompanyName,
	[Parameter(HelpMessage = "Specifies a copyright statement for the script/module.")]
	[string]
	$Copyright,
	[Parameter(HelpMessage = "Specifies an array of tags.")]
	[string[]]
	$Tags,
	[Parameter(HelpMessage = "Specifies the URL of a web page about this project.")]
	[Uri]
	$ProjectUri,
	[Parameter(HelpMessage = "Specifies the URL of licensing terms.")]
	[Uri]
	$LicenseUri,
	[Parameter(HelpMessage = "Specifies the URL of an icon for the script/module. The specified icon is displayed on the gallery web page for the script/module.")]
	[Uri]
	$IconUri,
	[Parameter(HelpMessage = "Specifies release notes.")]
	[string]
	$ReleaseNotes,
	[Parameter(HelpMessage = "Specifies modules that must be in the global session state. If the required modules aren't in the global session state, PowerShell imports them. If the required modules aren't available, the Import-Module command fails.`n`nEnter each module name as a string or as a hash table with ModuleName and ModuleVersion/RequiredVersion keys. The hash table can also have an optional GUID key. You can combine strings and hash tables in the parameter value.")]
	[ValidateScript({
			$input = $_
			$result = ($input -is [array]) -or ($input -is [string]) -or ($input -is [hashtable])

			if ($result)
			{
				foreach ($module in ($input | Select-Object))
				{
			
					if ($module -is [hashtable])
					{
						$module.Keys | Foreach-Object { $result = $result -and ($_ -imatch "^(ModuleName|ModuleVersion|RequiredVersion|Guid)$") }

						$result = $result -and $module.ContainsKey("ModuleName") -and ($module.ContainsKey("ModuleVersion") -or $module.ContainsKey("RequiredVersion"))
					}
					elseif ($module -is [string])
					{
						$result
					}
					else
					{
						$result = $false
					}

					if (-not $result)
					{
						break
					}
				}	
			}

			return $result
		})]
	[object[]]
	$RequiredModules,
	[Parameter(HelpMessage = "A list of external modules that this module is depends on.")]
	[string[]]
	$ExternalModuleDependencies,
	[Parameter(HelpMessage = "Specifies data that is passed to the script/module.")]
	[hashtable]
	$PrivateData,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the assembly (.dll) files that the module requires. Enter the assembly file names. PowerShell loads the specified assemblies before updating types or formats, importing nested modules, or importing the module file that is specified in the value of the RootModule key.`nUse this parameter to list all the assemblies that the module requires, including assemblies that must be loaded to update any formatting or type files that are listed in the FormatsToProcess or TypesToProcess keys, even if those assemblies are also listed as binary modules in the NestedModules key.")]
	[string[]]
	$RequiredAssemblies,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies all items that are included in the module.`nThis key is designed to act as a module inventory. The files listed in the key are included when the module is published, but any functions aren't automatically exported.")]
	[string[]]
	$FileList,
	[Parameter(HelpMessage = "Lists all modules that are included in this module.`nEnter each module name as a string or as a hash table with ModuleName and ModuleVersion keys. The hash table can also have an optional GUID key. You can combine strings and hash tables in the parameter value.`nThis key is designed to act as a module inventory. The modules that are listed in the value of this key aren't automatically processed.")]
	[ValidateScript({
			$input = $_
			$result = ($input -is [array]) -or ($input -is [string]) -or ($input -is [hashtable])

			if ($result)
			{
				foreach ($module in ($input | Select-Object))
				{
			
					if ($module -is [hashtable])
					{
						$module.Keys | Foreach-Object { $result = $result -and ($_ -imatch "^(ModuleName|ModuleVersion|RequiredVersion|Guid)$") }

						$result = $result -and $module.ContainsKey("ModuleName") -and ($module.ContainsKey("ModuleVersion") -or $module.ContainsKey("RequiredVersion"))
					}
					elseif ($module -is [string])
					{
						$result
					}
					else
					{
						$result = $false
					}

					if (-not $result)
					{
						break
					}
				}	
			}

			return $result
		})]
	[object[]]
	$ModuleList,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the functions that the module exports. Wildcards are permitted.`n`nYou can use this parameter to restrict the functions that are exported by the module. It can remove functions from the list of exported aliases, but it can't add functions to the list.`n`nIf you omit this parameter, module manifest is created with FunctionsToExport key with a value of * (all), meaning that all functions defined in the module are exported by the manifest.")]
	[string[]]
	$FunctionsToExport,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the aliases that the module exports. Wildcards are permitted.`n`nYou can use this parameter to restrict the aliases that are exported by the module. It can remove aliases from the list of exported aliases, but it can't add aliases to the list.`n`nIf you omit this parameter, module manifest is created with AliasesToExport key with a value of * (all), meaning that all aliases defined in the module are exported by the manifest.")]
	[string[]]
	$AliasesToExport,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the variables that the module exports. Wildcards are permitted.`n`nYou can use this parameter to restrict the variables that are exported by the module. It can remove variables from the list of exported variables, but it can't add variables to the list.`n`nIf you omit this parameter, module manifest is created with VariablesToExport key with a value of * (all), meaning that all variables defined in the module are exported by the manifest.")]
	[string[]]
	$VariablesToExport,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the cmdlets that the module exports. Wildcards are permitted.`n`nYou can use this parameter to restrict the cmdlets that are exported by the module. It can remove cmdlets from the list of exported cmdlets, but it can't add cmdlets to the list.`n`nIf you omit this parameter, module manifest is created with CmdletsToExport key with a value of * (all), meaning that all cmdlets defined in the module are exported by the manifest.")]
	[string[]]
	$CmdletsToExport,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the Desired State Configuration (DSC) resources that the module exports. Wildcards are permitted.")]
	[string[]]
	$DscResourcesToExport,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the module's compatible PSEditions. For information about PSEdition, see Modules with compatible PowerShell Editions.")]
	[string[]]
	$CompatiblePSEditions,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies a prefix that is prepended to the nouns of all commands in the module when they're imported into a session. Enter a prefix string. Prefixes prevent command name conflicts in a user's session.`n`nModule users can override this prefix by specifying the Prefix parameter of the Import-Module cmdlet.")]
	[string]
	$DefaultCommandPrefix,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Flag to indicate whether the module requires explicit user acceptance for install, update, or save.")]
	[switch]
	$RequireLicenseAcceptance,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Prerelease string of this module. Adding a Prerelease string identifies the module as a prerelease version.")]
	[string]
	$Prerelease,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the internet address of the HelpInfo XML file for the module. Enter a Uniform Resource Identifier (URI) that begins with http or https.`n`nThe HelpInfo XML file supports the Updatable Help feature that was introduced in PowerShell 3.0. It contains information about the location of downloadable help files for the module and the version numbers of the newest help files for each supported locale.`n`nFor information about Updatable Help, see [about_Updatable_Help](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_updatable_help?view=powershell-7.4). For information about the HelpInfo XML file, see [Supporting Updatable Help](https://learn.microsoft.com/en-us/powershell/scripting/developer/module/supporting-updatable-help).")]
	[ValidateScript({ $_ -imatch "^https?://" })]
	[string]
	$HelpInfoUri,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the processor architecture that the module requires. Valid values are x86, AMD64, IA64, MSIL, and None (unknown or unspecified).")]
	[System.Reflection.ProcessorArchitecture]
	$ProcessorArchitecture,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the minimum version of PowerShell that works with this module. For example, you can enter 1.0, 2.0, or 3.0 as the parameter's value. It must be in an X.X format. For example, if you submit 5, PowerShell will throw an error.")]
	[ValidateScript({ $_ -imatch "^[1-9]\d*\.\d+(.\d+(\.\d+)?)?$" })]
	[string]
	$PowerShellVersion = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)",
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the name of the PowerShell host program that the module requires. Enter the name of the host program, such as Windows PowerShell ISE Host or ConsoleHost. Wildcards aren't permitted.`nTo find the name of a host program, in the program, type `$Host.Name.")]
	[string]
	$PowerShellHostName,
	[Parameter(ParameterSetName = "Module", HelpMessage = "Specifies the minimum version of the PowerShell host program that works with the module. Enter a version number, such as 1.1.")]
	[ValidateScript({ $_ -imatch "^[1-9]\d*\.\d+(.\d+(\.\d+)?)?$" })]
	[string]
	$PowerShellHostVersion,
	[Parameter(HelpMessage = "Use this option to add an object display format definition file.")]
	[switch]
	$FormatFile,
	[Parameter(HelpMessage = "Use this option to add an extended type data definition file.")]
	[switch]
	$TypeFile,
	[Parameter(HelpMessage = "Use this option to add a test folder with a default Pester script.")]
	[switch]
	$PesterTests,
	[Parameter(HelpMessage = "Use this option to include a git repository for the project.")]
	[switch]
	$GitRepository,
	[Parameter(HelpMessage = "Use this option to not include Modules or Scripts folder in the project root path.")]
	[switch]
	$DisableProjectCategoryFolder,
	[Parameter(HelpMessage = "The root path where to create new project directory.")]
	[ValidateScript({ 

			if ($_ -is [System.IO.FileSystemInfo])
			{
				$value = $_.FullName
			}
			elseif ([System.IO.Path]::IsPathRooted($_))
			{
				$value = [string]$_
			}
			else
			{
				$value = (Join-Path -Path $PSScriptRoot -ChildPath [string]$_)
			}

			if (!(Test-Path -LiteralPath $value -PathType Container))
			{
				throw "Provided path is not a valid directory path: '$value'" 
			}
	
			return $true
		})]
	$RootPath = "$([Environment]::GetFolderPath('MyDocuments'))\WindowsPowerShell\",	
	[Parameter(HelpMessage = "Use this option to return the object representing the project directory.")]
	[switch]
	$Passthru)

#region Constants and global variables

$Script:ROOT_MODULE_CONTENT = '#Get public and private function definition files.
$Enums  = @( Get-ChildItem -Path $PSScriptRoot\Enums\*.ps1 -ErrorAction SilentlyContinue )
$Classes  = @( Get-ChildItem -Path $PSScriptRoot\Classes\*.ps1 -ErrorAction SilentlyContinue )
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Enums + $Classes + $Public + $Private))
{
	Try
	{
		. $import.fullname
	}
	Catch
	{
		Write-Error -Message "Failed to import function $($import.fullname): $_"
	}
}

Export-ModuleMember -Function $Public.Basename

if($ExportPrivate)
{
	Export-ModuleMember -Function $Private.Basename
}'

$Script:TYPE_PS1XML_DEFAULT_CONTENT = '<?xml version="1.0" encoding="utf-8"?>
<Types>
</Types>'

$Script:FORMAT_PS1XML_DEFAULT_CONTENT = '<?xml version="1.0" encoding="utf-8"?>
<Configuration>
  <ViewDefinitions>
  </ViewDefinitions>
</Configuration>'

$Script:README = "# $Name

---
#### $Description
---"

$Script:LICENSE = "MIT License

Copyright $(Get-Date | Select-Object -ExpandProperty Year) $Author

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ""Software""), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ""AS IS"", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."

#endregion

#region Functions

<#
.SYNOPSIS
Creates a new project item

.DESCRIPTION
This function creates a new file or directory under the specified path.

.PARAMETER Path
Location of the directory containing the new item. 

.PARAMETER Name
Item name.

.INPUTS
System.IO.FileInfo
System.String

.OUTPUTS
System.IO.FileInfo
#>
function New-ProjectItem
{
	[CmdletBinding(DefaultParameterSetName = "File")]
	Param(
		[Parameter(Position = 0, Mandatory = $true, HelpMessage = "Location of the item")]
		[ValidateScript({ 
		
				if ($_ -is [System.IO.FileSystemInfo])
				{
					$value = $_.FullName
				}
				elseif ([System.IO.Path]::IsPathRooted($_))
				{
					$value = [string]$_
				}
				else
				{
					$value = (Join-Path -Path $PSScriptRoot -ChildPath [string]$_)
				}

				if (!(Test-Path -LiteralPath $value -PathType Container))
				{
					throw "Provided path is not a valid directory path: '$value'" 
				}
			
				return $true
			})]
		[string]$Path,
		[Parameter(ParameterSetName = "File", Position = 1, Mandatory = $true, HelpMessage = "File name")]
		[Parameter(ParameterSetName = "Directory", Position = 1, Mandatory = $true, HelpMessage = "Directory name")]
		[string]$Name, 
		[Parameter(ParameterSetName = "File", Mandatory = $true, HelpMessage = "Creates a new file")]
		[switch]$File,
		[Parameter(ParameterSetName = "File", Position = 2, HelpMessage = "Content of the new file")]
		[string]$Content,
		[Parameter(ParameterSetName = "Directory", Mandatory = $true, HelpMessage = "Creates a new directory")]
		[switch]$Directory
	)

	
	$newItemType = @{$true = "File"; $false = "Container" }[$PSCmdlet.ParameterSetName -eq "File"]
	$newItemPath = Join-Path -Path $Path -ChildPath $Name
	$result = New-Item -Path $newItemPath -ItemType $newItemType -ErrorAction SilentlyContinue -WhatIf:$false -Confirm:$false

	if ($result -and $PSCmdlet.ParameterSetName -eq "File" -and ![string]::IsNullOrWhiteSpace($Content))
	{
		$Content | Out-File -FilePath $newItemPath -Encoding UTF8 -WhatIf:$false -Confirm:$false
	}
	
	if ($result)
	{
		return $result
	}
	elseif (Test-Path -Path $path -PathType $newItemType)
	{
		throw "Item '$newItemPath' already exists. Rename or remove it and retry."
	}
	else
	{
		throw "Can't create item '$newItemPath'."
	}
}

#endregion

# Add ToString method to Hashtables
Update-TypeData -TypeName System.Collections.HashTable `
	-MemberType ScriptMethod `
	-MemberName ToString `
	-Value {
	$result = "@{"; 
	$keys = $this.Keys; 
	$count = 0
	foreach ($currentKey in $keys)
	{
		$currentValue = $this[$currentKey]; 
		if ($currentKey -match "\s") 
		{ 
			$result += "`"$($currentKey)`"=`"$($currentValue)`"" 
		}
		else 
		{ 
			$result += "$($currentKey)=`"$currentValue`"" 
		}

		$count++

		if ($count -lt $this.Keys.Count)
		{
			$result += ";"
		}
	} 
	$result += "}"

	return $result 
} -Force -WhatIf:$false -Confirm:$false

#region Creating directory structure

if($WhatIfPreference -or $ConfirmPreference -ne [System.Management.Automation.ConfirmImpact]::None)
{
	$path = Join-Path -Path $RootPath -ChildPath (@{$true = "Modules"; $false = [string]::Empty }[-not $DisableProjectCategoryFolder.IsPresent -and $ModuleProject.IsPresent]) | Join-Path -ChildPath (@{$true = "Scripts"; $false = [string]::Empty }[-not $DisableProjectCategoryFolder.IsPresent -and $ScriptProject.IsPresent]) | Join-Path -ChildPath $Name
}

if ($PSCmdlet.ShouldProcess("Create a new PowerShell $(@{$true="module";$false="script"}[$ModuleProject.IsPresent]) project under '$path'.",
		"Create a new PowerShell $(@{$true="module";$false="script"}[$ModuleProject.IsPresent]) project under '$path' ?",
		$MyInvocation.MyCommand.Name))
{
	#Creating project root path
	if (-not $DisableProjectCategoryFolder.IsPresent)
	{
		$path = (New-Item -Path $RootPath -Name (@{$true = "Modules"; $false = "Scripts" }[$ModuleProject.IsPresent]) -ItemType Directory -Force).FullName
	}
	else
	{
		$path = $RootPath
	}

	#Root directory
	$rootDirectory = New-ProjectItem -Directory -Path $path -Name $Name

	if ($rootDirectory)
	{
		$path = Join-Path -Path $path -ChildPath $Name

		#Initialising Git repository if enabled
		if ($GitRepository)
		{
			if (Get-Command "git" -ErrorAction SilentlyContinue)
			{
				#Empty gitignore file
				New-ProjectItem -File -Path $path -Name ".gitignore" | Out-Null
			
				#Create repository
				$env:GIT_DIR = Join-Path -Path $path -ChildPath ".git"
				$env:GIT_WORK_TREE = $path
				&git init *> $null

				#First commit and dev branch creation
				$temp = Get-Location
				Set-Location $path -PassThru *> $null
				&git branch -m master main *> $null
				&git add . *> $null
				&git commit -m "Repository creation" *> $null
				&git branch "develop"
				&git checkout "develop" *> $null
				Set-Location $temp -PassThru | Out-Null
			}
			else
			{
				Write-Warning -Message "Git executable not found. Check its existence and add it to your PATH environment variable."
			}
		}

		#README, License,...
		New-ProjectItem -File -Path $path -Name "README.md" -Content $Script:README | Out-Null
		New-ProjectItem -File -Path $path -Name "LICENSE" -Content $Script:LICENSE | Out-Null

		#Script/Module code directory tree
		$codeFolder = New-ProjectItem -Directory -Path $path -Name "src"

		#Bin and libraries folders
		New-ProjectItem -Directory -Path $codeFolder -Name "lib" | Out-Null
		New-ProjectItem -Directory -Path $codeFolder -Name "bin" | Out-Null

		#Type definition file if option enabled
		if ($TypeFile.IsPresent)
		{
			New-ProjectItem -File -Path $codeFolder -Name "$Name.Types.ps1xml" -Content $Script:TYPE_PS1XML_DEFAULT_CONTENT | Out-Null
		}

		#Format definition file if option enabled
		if ($FormatFile.IsPresent)
		{
			New-ProjectItem -File -Path $codeFolder -Name "$Name.Format.ps1xml" -Content $Script:FORMAT_PS1XML_DEFAULT_CONTENT | Out-Null
		}

		#Pester Tests
		if ($PesterTests.IsPresent)
		{
			#Tests directory
			$childDirectory = New-ProjectItem -Directory -Path $path -Name "tests"

			$commandParameters = @{
				"Path"        = (Join-Path -Path $childDirectory -ChildPath "$Name.Tests.ps1");
				"Version"     = "1.0.0";
				"Description" = "Tests for $Name project"
			}

			if ($PSBoundParameters.ContainsKey("Author"))
			{
				$commandParameters.Add("Author", $Author)
			}
	
			New-ScriptFileInfo @commandParameters
		}

		#Module project additional content
		if ($PSCmdlet.ParameterSetName -eq "Module")
		{
			#Directories for module's functions, classes and enumerations.
			New-ProjectItem -Directory -Path $codeFolder -Name "Enums" | Out-Null
			New-ProjectItem -Directory -Path $codeFolder -Name "Classes" | Out-Null
			New-ProjectItem -Directory -Path $codeFolder -Name "Private" | Out-Null
			New-ProjectItem -Directory -Path $codeFolder -Name "Public" | Out-Null
						
			##Help file(s)
			$childDirectory = New-ProjectItem -Directory -Path $codeFolder -Name "en-US"
			New-ProjectItem -File -Path $childDirectory -Name "about_$Name.help.txt" | Out-Null		
		
			#Root module file
			New-ProjectItem -File -Path $codeFolder -Name "$Name.psm1" -Content $Script:ROOT_MODULE_CONTENT | Out-Null
		}
	
		#region Module manifest/script file creation

		#Setting parameters for dedicated provisionning command.
		$commandParameters = @{
			"Path" = $null
		}

		#Author
		if ($PSBoundParameters.ContainsKey("Author") -and -not [string]::IsNullOrWhiteSpace($Author))
		{
			$commandParameters.Add("Author", $Author.Trim())
		}
		#Description
		if ($PSBoundParameters.ContainsKey("Description") -and -not [string]::IsNullOrWhiteSpace($Description))
		{
			$commandParameters.Add("Description", $Description.Trim())
		}
		#CompanyName
		if ($PSBoundParameters.ContainsKey("CompanyName") -and -not [string]::IsNullOrWhiteSpace($CompanyName))
		{
			$commandParameters.Add("CompanyName", $CompanyName.Trim())
		}
		#Copyright
		if ($PSBoundParameters.ContainsKey("Copyright") -and -not [string]::IsNullOrWhiteSpace($Copyright))
		{
			$commandParameters.Add("Copyright", $Copyright.Trim())
		}
		elseif ($commandParameters.ContainsKey("CompanyName"))
		{
			$commandParameters.Add("Copyright", "Copyright $(Get-Date | Select-Object -ExpandProperty Year) $($commandParameters["CompanyName"])")
		}
		elseif ($commandParameters.ContainsKey("Author"))
		{
			$commandParameters.Add("Copyright", "Copyright $(Get-Date | Select-Object -ExpandProperty Year) $($commandParameters["Author"])")
		}
		#Tags
		if ($PSBoundParameters.ContainsKey("Tags"))
		{
			$commandParameters.Add("Tags", $Tags)
		}
		#ProjectUri
		if ($PSBoundParameters.ContainsKey("ProjectUri"))
		{
			$commandParameters.Add("ProjectUri", $ProjectUri)
		}
		#LicenseUri
		if ($PSBoundParameters.ContainsKey("LicenseUri"))
		{
			$commandParameters.Add("LicenseUri", $LicenseUri)
		}
		#IconUri
		if ($PSBoundParameters.ContainsKey("IconUri"))
		{
			$commandParameters.Add("IconUri", $IconUri)
		}
		#ReleaseNotes
		if ($PSBoundParameters.ContainsKey("ReleaseNotes"))
		{
			$commandParameters.Add("ReleaseNotes", $ReleaseNotes)
		}
		#RequiredModules
		if ($PSBoundParameters.ContainsKey("RequiredModules"))
		{
			$commandParameters.Add("RequiredModules", $RequiredModules)
		}
		#ExternalModuleDependencies
		if ($PSBoundParameters.ContainsKey("ExternalModuleDependencies"))
		{
			$commandParameters.Add("ExternalModuleDependencies", $ExternalModuleDependencies)
		}
		#PrivateData
		if ($PSBoundParameters.ContainsKey("PrivateData"))
		{
			if ($ScriptProject.IsPresent)
			{
				$commandParameters.Add("PrivateData", $PrivateData.ToString())
			}
			else
			{
				$commandParameters.Add("PrivateData", $PrivateData)
			}
		}

		#Handling specific parameters for Script or Module.
		if ($PSCmdlet.ParameterSetName -eq "Module")
		{
			$commandParameters["Path"] = Join-Path -Path $codeFolder -ChildPath "$Name.psd1"

			#RootModule
			$commandParameters.Add("RootModule", "$Name.psm1")

			#ModuleVersion
			if ($PSBoundParameters.ContainsKey("Version") -and -not [string]::IsNullOrWhiteSpace($Version))
			{
				$commandParameters.Add("ModuleVersion", $Version.Trim())
			}
			#ProcessorArchitecture
			if ($PSBoundParameters.ContainsKey("ProcessorArchitecture"))
			{
				$commandParameters.Add("ProcessorArchitecture", $ProcessorArchitecture)
			}
			#PowerShellVersion
			if ($PSBoundParameters.ContainsKey("PowerShellVersion"))
			{
				$commandParameters.Add("PowerShellVersion", $PowerShellVersion)
			}
			#PowerShellHostName
			if ($PSBoundParameters.ContainsKey("PowerShellHostName"))
			{
				$commandParameters.Add("PowerShellHostName", $PowerShellHostName)
			}
			#PowerShellHostVersion
			if ($PSBoundParameters.ContainsKey("PowerShellHostVersion"))
			{
				$commandParameters.Add("PowerShellHostVersion", $PowerShellHostVersion)
			}
			#RequiredAssemblies
			if ($PSBoundParameters.ContainsKey("RequiredAssemblies"))
			{
				$commandParameters.Add("RequiredAssemblies", $RequiredAssemblies)
			}
			#FileList
			if ($PSBoundParameters.ContainsKey("FileList"))
			{
				$commandParameters.Add("FileList", $FileList)
			}
			#ModuleList
			if ($PSBoundParameters.ContainsKey("ModuleList"))
			{
				$commandParameters.Add("ModuleList", $ModuleList)
			}
			#FunctionsToExport
			if ($PSBoundParameters.ContainsKey("FunctionsToExport"))
			{
				$commandParameters.Add("FunctionsToExport", $FunctionsToExport)
			}
			#AliasesToExport
			if ($PSBoundParameters.ContainsKey("AliasesToExport"))
			{
				$commandParameters.Add("AliasesToExport", $AliasesToExport)
			}
			#VariablesToExport
			if ($PSBoundParameters.ContainsKey("VariablesToExport"))
			{
				$commandParameters.Add("VariablesToExport", $VariablesToExport)
			}
			#CmdletsToExport
			if ($PSBoundParameters.ContainsKey("CmdletsToExport"))
			{
				$commandParameters.Add("CmdletsToExport", $CmdletsToExport)
			}
			#DscResourcesToExport
			if ($PSBoundParameters.ContainsKey("DscResourcesToExport"))
			{
				$commandParameters.Add("DscResourcesToExport", $DscResourcesToExport)
			}
			#DefaultCommandPrefix
			if ($PSBoundParameters.ContainsKey("DefaultCommandPrefix"))
			{
				$commandParameters.Add("DefaultCommandPrefix", $DefaultCommandPrefix)
			}
			#RequireLicenseAcceptance
			if ($PSBoundParameters.ContainsKey("RequireLicenseAcceptance"))
			{
				$commandParameters.Add("RequireLicenseAcceptance", $RequireLicenseAcceptance)
			}
			#Prerelease
			if ($PSBoundParameters.ContainsKey("Prerelease") -and -not [string]::IsNullOrWhiteSpace($Prerelease))
			{
				$commandParameters.Add("Prerelease", $Prerelease.trim())
			}
			#HelpInfoUri
			if ($PSBoundParameters.ContainsKey("HelpInfoUri"))
			{
				$commandParameters.Add("HelpInfoUri", $HelpInfoUri)
			}
			#FormatsToProcess
			if ($FormatFile.IsPresent)
			{
				$commandParameters.Add("FormatsToProcess", "$Name.Format.ps1xml")
			}
			#TypesToProcess
			if ($TypeFile.IsPresent)
			{
				$commandParameters.Add("TypesToProcess", "$Name.Types.ps1xml")
			}

			#Removing unsupported parameters if PowerShell version is below 7
			if ($PSVersionTable.PSVersion.Major -lt 7)
			{
				"Prerelease", "RequireLicenseAcceptance", "ExternalModuleDependencies" | Foreach-Object {
					if ($commandParameters.ContainsKey($_))
					{
						$commandParameters.Remove($_)
					}
				}
			}

			New-ModuleManifest @commandParameters		
		}
		else
		{
			$commandParameters["Path"] = Join-Path -Path $codeFolder -ChildPath "$Name.ps1"

			#Version
			if ($PSBoundParameters.ContainsKey("Version") -and -not [string]::IsNullOrWhiteSpace($Version))
			{
				$commandParameters.Add("Version", $Version.Trim())
			}
			#ReleaseNotes
			if ($PSBoundParameters.ContainsKey("ReleaseNotes"))
			{
				#Splitting ReleaseNotes string as string array is expected by New-ScriptFileInfo
				$commandParameters["ReleaseNotes"] = $ReleaseNotes -split "`n"
			}
	
			New-ScriptFileInfo @commandParameters
		}

		#endregion

		#Add created directories and files to Git repository if enabled
		if ($GitRepository.IsPresent)
		{
			if (Get-Command "git" -ErrorAction SilentlyContinue)
			{
				$temp = Get-Location
				$null = Set-Location $path -PassThru | Out-Null
				&git add . *> $null
				$null = Set-Location $temp -PassThru | Out-Null
			}
			else
			{
				Write-Warning -Message "Git executable not found. Check its existence and add it to your PATH environment variable."
			}
		}

		if ($Passthru.IsPresent)
		{
			$rootDirectory
		}
	}
	elseif (Test-Path -Path $path -PathType Container)
	{
		Write-Host "Directory '$path' already exists. Rename or remove it and retry." -ForegroundColor Red
	}
	else
	{
		Write-Host "Can't create directory '$path'." -ForegroundColor Red
	}
}
#endregion