<#PSScriptInfo

.VERSION 1.1.0

.GUID 32d9b358-2002-4dbb-9393-d068333a60e6

.AUTHOR AdZero (adzero.git@gmail.com)

.COMPANYNAME AdZero

.COPYRIGHT Copyright 2018-2021 AdZero

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
Creates a new file structure for the developement of a PowerShell script or module. 

.DESCRIPTION 
Creates a new file structure for the developement of a PowerShell script or module. 

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
-a----        02/03/2021     19:19             63 NewScriptProject.Format.ps1xml
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
-a----        02/03/2021     19:23             63 NewModuleProject.Format.ps1xml
d-----        02/03/2021     19:23                lib
d-----        02/03/2021     19:23                bin
-a----        02/03/2021     19:23            574 NewModuleProject.psm1
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
-a----        02/03/2021     19:28             63 NewModuleGitProject.Format.ps1xml
d-----        02/03/2021     19:28                lib
d-----        02/03/2021     19:28                bin
-a----        02/03/2021     19:28            574 NewModuleGitProject.psm1
d-----        02/03/2021     19:28                Private
d-----        02/03/2021     19:28                Public


    Directory: C:\Users\adzero\Documents\WindowsPowerShell\Sources\Modules\NewModuleGitProject\src\en-US


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        02/03/2021     19:28              0 about_NewModuleGitProject.help.txt

.PARAMETER Name
New project name.

.PARAMETER Author
New project author.

.PARAMETER Description
New project description.

.PARAMETER RootPath
The root path where to create new project directory.

.PARAMETER ScriptProject
Use this option to create a project structure for a script.

.PARAMETER ModuleProject
Use this option to create a project structure for a module.

.PARAMETER GitRepository
Use this option to include a git repository for the project.

.PARAMETER DisableProjectCategoryFolder
 Use this option to not include Modules or Scripts folder in the project root path.

.INPUTS
None

.OUTPUTS
System.IO.FileInfo
System.IO.DirectoryInfo

#>
[CmdletBinding(DefaultParameterSetName="Script")]
Param(
[Parameter(ParameterSetName="Script", Position=0, Mandatory=$true, HelpMessage='New project name.')]
[Parameter(ParameterSetName="Module", Position=0, Mandatory=$true, HelpMessage='New project name.')]
[string]$Name,
[Parameter(ParameterSetName="Script", Position=1, Mandatory=$true, HelpMessage='New project author.')]
[Parameter(ParameterSetName="Module", Position=1, Mandatory=$true, HelpMessage='New project author.')]
[string]$Author,
[Parameter(ParameterSetName="Script", Position=2, Mandatory=$true, HelpMessage='New project description.')]
[Parameter(ParameterSetName="Module", Position=2, Mandatory=$true, HelpMessage='New project description.')]
[string]$Description,
[Parameter(HelpMessage='The root path where to create new project directory.')]
[ValidateScript({ 

	if($_ -is [System.IO.FileSystemInfo])
	{
		$value = $_.FullName
	}
	elseif([System.IO.Path]::IsPathRooted($_))
	{
		$value = [string]$_
	}
	else
	{
		$value = (Join-Path -Path $PSScriptRoot -ChildPath [string]$_)
	}

	if(!(Test-Path -LiteralPath $value -PathType Container))
	{
		throw "Provided path is not a valid directory path: '$value'" 
	}
	
	return $true
})]
$RootPath = "$([Environment]::GetFolderPath('MyDocuments'))\WindowsPowerShell\",	
[Parameter(ParameterSetName="Script", Mandatory=$true, HelpMessage='Use this option to create a project structure for a script.')]
[switch]$ScriptProject,
[Parameter(ParameterSetName="Module", Mandatory=$true, HelpMessage='Use this option to create a project structure for a module.')]
[switch]$ModuleProject,
[Parameter(HelpMessage='Use this option to include a git repository for the project.')]
[switch]$GitRepository,
[Parameter(HelpMessage='Use this option to not include Modules or Scripts folder in the project root path.')]
[switch]$DisableProjectCategoryFolder)

##################################
# Constants and global variables #
##################################

$Script:ROOT_MODULE_CONTENT = '#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public + $Private))
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

$Script:PS1XML_DEFAULT_CONTENT = '<?xml version="1.0" encoding="utf-8" ?>
<Types>
</Types>'

$Script:README = "# $Name

---
#### $Description.
---"

$Script:LICENSE = "MIT License

Copyright $((Get-Date).Year) $Author

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ""Software""), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ""AS IS"", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."

#############
# Functions #
#############

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
	[CmdletBinding(DefaultParameterSetName="File")]
	Param(
		[Parameter(Position=0, Mandatory=$true, HelpMessage='Location of the item')]
		[ValidateScript({ 
		
			if($_ -is [System.IO.FileSystemInfo])
			{
				$value = $_.FullName
			}
			elseif([System.IO.Path]::IsPathRooted($_))
			{
				$value = [string]$_
			}
			else
			{
				$value = (Join-Path -Path $PSScriptRoot -ChildPath [string]$_)
			}

			if(!(Test-Path -LiteralPath $value -PathType Container))
			{
				throw "Provided path is not a valid directory path: '$value'" 
			}
			
			return $true
		})]
		[string]$Path,
		[Parameter(ParameterSetName="File", Position=1, Mandatory=$true, HelpMessage='File name')]
		[Parameter(ParameterSetName="Directory", Position=1, Mandatory=$true, HelpMessage='Directory name')]
		[string]$Name, 
		[Parameter(ParameterSetName="File", Mandatory=$true, HelpMessage='Creates a new file')]
		[switch]$File,
		[Parameter(ParameterSetName="File", Position=2, HelpMessage='Content of the new file')]
		[string]$Content,
		[Parameter(ParameterSetName="Directory", Mandatory=$true, HelpMessage='Creates a new directory')]
		[switch]$Directory
	)

	
	$newItemType = @{$true="File";$false="Container"}[$PSCmdlet.ParameterSetName -eq "File"]
	$newItemPath = Join-Path -Path $Path -ChildPath $Name
	$result = New-Item -Path $newItemPath -ItemType $newItemType -ErrorAction SilentlyContinue

	if($result -and $PSCmdlet.ParameterSetName -eq "File" -and ![string]::IsNullOrWhiteSpace($Content))
	{
		$Content | Out-File -FilePath $newItemPath -Encoding UTF8
	}
	
	if($result)
	{
		return $result
	}
	elseif(Test-Path -Path $path -PathType $newItemType)
	{
		throw "Item '$newItemPath' already exists. Rename or remove it and retry."
	}
	else
	{
		throw "Can't create item '$newItemPath'."
	}
}

########################
# Script main function #
########################

function New-PSDevelopmentProject
{
	[CmdletBinding(DefaultParameterSetName="Script")]
	Param(
		[Parameter(ParameterSetName="Script", Position=0, Mandatory=$true, HelpMessage='New script name')]
		[Parameter(ParameterSetName="Module", Position=0, Mandatory=$true, HelpMessage='New module name')]
		[string]$Name,
		[Parameter(ParameterSetName="Script", Position=1, Mandatory=$true, HelpMessage='New script author')]
		[Parameter(ParameterSetName="Module", Position=1, Mandatory=$true, HelpMessage='New module author')]
		[string]$Author,
		[Parameter(ParameterSetName="Script", Position=2, Mandatory=$true, HelpMessage='New script description')]
		[Parameter(ParameterSetName="Module", Position=2, Mandatory=$true, HelpMessage='New module description')]
		[string]$Description,
		[Parameter(Position=3, HelpMessage='The root path where to create new project directory')]
		[ValidateScript({ 
		
			if($_ -is [System.IO.FileSystemInfo])
			{
				$value = $_.FullName
			}
			elseif([System.IO.Path]::IsPathRooted($_))
			{
				$value = [string]$_
			}
			else
			{
				$value = (Join-Path -Path $PSScriptRoot -ChildPath [string]$_)
			}

			if(!(Test-Path -LiteralPath $value -PathType Container))
			{
				throw "Provided path is not a valid directory path: '$value'" 
			}
			
			return $true
		})]
		$RootPath = "$([Environment]::GetFolderPath('MyDocuments'))\WindowsPowerShell\",	
		[Parameter(ParameterSetName="Script", Mandatory=$true, HelpMessage='Use this option to create a project structure for a script')]
		[switch]$ScriptProject,
		[Parameter(ParameterSetName="Module", Mandatory=$true, HelpMessage='Use this option to create a project structure for a module')]
		[switch]$ModuleProject,
		[Parameter(HelpMessage='Use this option to create a new git repository for the project')]
		[switch]$GitRepository,
		[Parameter(HelpMessage='Use this option to not include Modules or Scripts folder in the project root path')]
		[switch]$DisableProjectCategoryFolder)

	#Creating project root path
	if(-not $DisableProjectCategoryFolder.IsPresent)
	{
		$path = (New-Item -Path $RootPath -Name (@{$true="Modules";$false="Scripts"}[$PSCmdlet.ParameterSetName -eq "Module"]) -ItemType Directory -Force).FullName
	}
	else
	{
		$path = $RootPath
	}

	#Creating directory structure
	#Root directory
	if(New-ProjectItem -Directory -Path $path -Name $Name)
	{
		$path = Join-Path -Path $path -ChildPath $Name

		#Git repository if enabled
		if($GitRepository)
		{
			if(Get-Command "git" -ErrorAction SilentlyContinue)
			{
				#Empty gitignore file
				New-ProjectItem -File -Path $path -Name ".gitignore"
				
				#Create repository
				$env:GIT_DIR = Join-Path -Path $path -ChildPath ".git"
				$env:GIT_WORK_TREE = $path
				&git init 2>$null

				#First commit and dev branch creation
				$temp = Get-Location
				$null = Set-Location $path -PassThru 2>$null
				&git add . 2>$null
				&git commit -m "Repository creation" 2>$null
				&git branch "develop" 2>$null
				&git checkout "develop" 2>$null
				$null = Set-Location $temp -PassThru | Out-Null
			}
			else
			{
				Write-Warning -Message "Git executable not found. Check its existence and add it to your PATH environment variable."
			}
		}

		#README, License,...
		New-ProjectItem -File -Path $path -Name "README.md" -Content $Script:README
		New-ProjectItem -File -Path $path -Name "LICENSE" -Content $Script:LICENSE

		#Script/Module code directory tree
		$codeFolder = New-ProjectItem -Directory -Path $path -Name "src"

		##Types definition file
		New-ProjectItem -File -Path $codeFolder -Name "$Name.Format.ps1xml" -Content $Script:PS1XML_DEFAULT_CONTENT

		##Bin and libraries folders
		New-ProjectItem -Directory -Path $codeFolder -Name "lib"
		New-ProjectItem -Directory -Path $codeFolder -Name "bin"

		##Script/Module files
		if($PSCmdlet.ParameterSetName -eq "Module")
		{
			#Root module file
			New-ProjectItem -File -Path $codeFolder -Name "$Name.psm1" -Content $Script:ROOT_MODULE_CONTENT
			#Getting current PowerShell Version
			$version = $PSVersionTable.PSVersion | select -ExpandProperty Major

			New-ModuleManifest -Path (Join-Path -Path $codeFolder -ChildPath "$Name.psd1") `
							   -RootModule "$Name.psm1" `
							   -Description $Description `
							   -PowerShellVersion $PSVersionTable.PSVersion `
							   -Author $Author `
							   -Copyright "Copyright $((Get-Date).Year) $Author" `
							   -FormatsToProcess "$Name.Format.ps1xml"
			
			#Directories for module's functions
			New-ProjectItem -Directory -Path $codeFolder -Name "Private"
			New-ProjectItem -Directory -Path $codeFolder -Name "Public"
			
			##Help file(s)
			$childDirectory = New-ProjectItem -Directory -Path $codeFolder -Name "en-US"
			New-ProjectItem -File -Path $childDirectory -Name "about_$Name.help.txt"
		}
		else
		{
			New-ScriptFileInfo -Path (Join-Path -Path $codeFolder -ChildPath "$Name.ps1") -Version "1.0.0" -Author $Author -Description $Description -Copyright "Copyright $((Get-Date).Year) $Author"
		}

		#Tests directory
		$childDirectory = New-ProjectItem -Directory -Path $path -Name "tests"
		New-ScriptFileInfo -Path (Join-Path -Path $childDirectory -ChildPath "$Name.Tests.ps1") -Version "1.0.0" -Author $Author -Description "Tests for $Name project"

		#Add created directories and files to Git repository if enabled
		if($GitRepository)
		{
			if(Get-Command "git" -ErrorAction SilentlyContinue)
			{
				$temp = Get-Location
				$null = Set-Location $path -PassThru | Out-Null
				&git add . 2>$null
				$null = Set-Location $temp -PassThru | Out-Null
			}
			else
			{
				Write-Warning -Message "Git executable not found. Check its existence and add it to your PATH environment variable."
			}
		}
	}
	elseif(Test-Path -Path $path -PathType Container)
	{
		Write-Host "Directory '$path' already exists. Rename or remove it and retry." -ForegroundColor Red
	}
	else
	{
		Write-Host "Can't create directory '$path'." -ForegroundColor Red
	}
}

New-PSDevelopmentProject @PsBoundParameters

# SIG # Begin signature block
# MIIIqQYJKoZIhvcNAQcCoIIImjCCCJYCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUFiLmjJCW71tLIZVlZBOKfYPt
# csOgggUwMIIFLDCCAxSgAwIBAgIQW63XJ86VXrBOrf64HYKdVjANBgkqhkiG9w0B
# AQ0FADAuMSwwKgYDVQQDDCNBZFplcm8gUG93ZXJTaGVsbCBMb2NhbCBDZXJ0aWZp
# Y2F0ZTAeFw0yMDAxMDYyMzAwMDBaFw0yNTEyMzAyMzAwMDBaMC4xLDAqBgNVBAMM
# I0FkWmVybyBQb3dlclNoZWxsIExvY2FsIENlcnRpZmljYXRlMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAsKSGndXWnvczniCJM5x2ErFwKWPufBqG2hQT
# NU/hxjQjOEfv7EewowFCf8hm0OQjNbn4Bv8LtwQCsN2r+iM+CScJ/mipyEpzvG9T
# q6Hf4jybgBSYH8G5mWUym3LsrlFUt1A5FvfuJbPNNWkoGY6sgG7NTqEICLS46/Zc
# n9GWNiYoIcMXdouMwWHsYLWnhKSfyE077brSmd4mJFym4OUy5tNiBjyiaEawZ6fE
# vINXJghk2PfUUYjqBs/10AH75N8AjaBieBiQaZj98LAHJYis618Os/QxR4moRjGG
# oMikBJMRWmC4ijrONFZsbchyxd/6gXLnUAcB1/F4g1VAXJZ3gPsRja1ItsxNuAcA
# NEXRt34RKK+ayDul4mHvYy7X4+J88qB//p7ENrA+d1l2GM9GJhzemmgZUVv9Sx39
# r45VF7zRRluCIRsmOREAKmiqRU6y6xdSp/Fmf0cWt2bBgvqJ5+j4cRHv4KI0veLP
# SBWRFplbr+emxrhbMHI9m+/RHiT2BI9jBX9awXnaxcYH8IQN87CA/L4y/AhRLsuU
# +zwaZ5YCyyi3VeAUfMCnJq/1Gfa+gUO2xfWcavVjcSgMatrktSNyCLURSD9OS/89
# 4kBS2EO5lzvOUKDrE3LfDHORsbhpk7MbP/+TOnSL6heBplT6RE1Voql1k0IoTqyW
# TtD1YA0CAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB0GA1UdDgQWBBRkZ706baqI0oKHJiJwnYJW+FT2rDANBgkqhkiG9w0BAQ0F
# AAOCAgEAGkzJAIBdoCtUDV9Hz4bqllZ5X4SEEFk3WvlwqLz7S5FyiRFGzaBRfIoJ
# XTwzczUXxr8UOhN90zBvkPoF+9pJccIEoXs3VuBK/jiv+WQJZtD2qpvmz5ZJMU3G
# f/mwlDAc/Vof3GJmCIJ/5A4gVRu4j07tH/XWOyfYJEMIBPFOUsBnJCYZzlbKGXoU
# hDQHLwsDB5Z/+4TwLZPSG3fkUewuTyaqLPotarh6EEWcf6Bxrtwr2SEIwpbshRb5
# 1T8e2JRDAPFMM49kVqv5IiHq3Zrws4LFDZsXCuYaDABw4B7nDx1GP8En7+hGlVvn
# Jhr1kr11yrwo4yr9RPvDLIQRNFrvkwwEcwBrGTXuydCNkd+P+knCDLR7T6B38i6o
# WSiqleN0GgUYddT5s7kSPYjPbQD5ChheHYSTAiJBNvip+UBkTYsj9sxYz7sajmP0
# vWhuXNqMgOj49KYJ3Q348Z93cMSBUZ4DYQoHToHtf9fXzHQGZtAOasDYayhUh08b
# 1pr/zikZKfzH4Afgj5ffHLifxmWTUsocsIrXmkgScKDizW+vONhiljmS8FxacZmm
# Xm+q+cDJ+2CrzlQSyPWN5f5r1DzyxC+7SA9uRfQi1meDSo0W9jrsKx+1IBE6D1DY
# l/km38aF2oeAPBhn/43itNPYg2yP+nvWt/Fodn/t7BBk8upTPFYxggLjMIIC3wIB
# ATBCMC4xLDAqBgNVBAMMI0FkWmVybyBQb3dlclNoZWxsIExvY2FsIENlcnRpZmlj
# YXRlAhBbrdcnzpVesE6t/rgdgp1WMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEM
# MQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQB
# gjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBSJDQjZk3NX/8Pn
# s9HgasEYmiaflTANBgkqhkiG9w0BAQEFAASCAgAQ2HbhRHBoTXZ1Rh1Ks4fAqtu8
# eG32iUBgZRHz2LvxQ9bKbvBfI52fCJxNGx3289nhzYnyAGfZ3U7lGFGSiCCydvvp
# vXsVrMq7Ldhv2Cybim7pkLgz2cxUZd/aMDHiZAHVfw/0HHwkhzgMIlqOV7kx+Uje
# MKIS4g98c2j2fwczrpgxJWLBl/ICiilvFTgDZTTP8GeJFg9sve35kFosB/m7ry/8
# SHphl7b0HHzb73wRiOlBcg0Ru5gCXOptv0XBwzi9c4TPxbZ2x+672YFmz39BHnU6
# eCW8H9gBim+PJENGO1GKB+BU6PvAgSPs/zqWBWNtDxS7QIZuJTTH9+sxhcOkP+lV
# 1mclQ4awium6ZonKEPzkON0RjZFdRd+Bv2vrXfCYwOJVz8UvwrkX+PgRcNI7SbPg
# /cknnvOx9/W9mkshPTf5v0mRIsgiyu4eeVyhkykvluB+NJ4BrT8LehD6/8kmDV84
# q0beh8Cy/+bsbzDY9bwgUzKPoxmyfOZQiTjZ47zqSuROhkN8B5PyM/G9/7vF+xlL
# zLJpfdMCqd1d4mMKJviDM6ekd3vSM0CcPN930lo2VToNEI2Ff5pUScMroFQbq5IT
# J3CaFIlH5PMrzESpZ7MrCW4J+BPgl9XAF94llFOAX6Tzrj7VN6aZWvH3FdHOXlXz
# tPgNDu42jVtsIcqECA==
# SIG # End signature block
