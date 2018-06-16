<#PSScriptInfo

.VERSION 1.0.0

.GUID 32d9b358-2002-4dbb-9393-d068333a60e6

.AUTHOR AdZero (adzero.git@gmail.com)

.COMPANYNAME 

.COPYRIGHT Copyright 2018 AdZero

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES PowerShellGet

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES

.DESCRIPTION 
 Creates a new file structure for the developement of a PowerShell script or module. 

#>
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
	[switch]$GitRepository
)

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

Export-ModuleMember -Function $Public.Basename'

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
		[switch]$GitRepository
	)

	#Creating project root path
	$path = (New-Item -Path $RootPath -Name (@{$true="Modules";$false="Scripts"}[$PSCmdlet.ParameterSetName -eq "Module"]) -ItemType Directory -Force).FullName

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
				&git branch "dev" 2>$null
				&git checkout "dev" 2>$null
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
		$codeFolder = New-ProjectItem -Directory -Path $path -Name $Name

		##Types definition file
		New-ProjectItem -File -Path $codeFolder -Name "$Name.Format.ps1xml"

		##Bin and libraries folders
		New-ProjectItem -Directory -Path $codeFolder -Name "lib"
		New-ProjectItem -Directory -Path $codeFolder -Name "bin"

		##Script/Module files
		if($PSCmdlet.ParameterSetName -eq "Module")
		{
			#Root module file
			New-ProjectItem -File -Path $codeFolder -Name "$Name.psm1" -Content $ROOT_MODULE_CONTENT
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
		$childDirectory = New-ProjectItem -Directory -Path $path -Name "Tests"
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
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUZSbqeAKUTljBHxlV0B2xybAq
# bWagggUwMIIFLDCCAxSgAwIBAgIQNC2Wu6czaZhGPNSKX+8pbjANBgkqhkiG9w0B
# AQ0FADAuMSwwKgYDVQQDDCNBZFplcm8gUG93ZXJTaGVsbCBMb2NhbCBDZXJ0aWZp
# Y2F0ZTAeFw0xNzEwMTQyMjAwMDBaFw0xODEyMzAyMjAwMDBaMC4xLDAqBgNVBAMM
# I0FkWmVybyBQb3dlclNoZWxsIExvY2FsIENlcnRpZmljYXRlMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAseRnSUGLrhXeaxyhOFY40MKRLH7fS+HTPeEd
# QijAvV7fMDRIVK/SovoUbHCz7pkf2lmgSStfVlTH44akTDwtzONVS2puwoLSYQBD
# YcA5OAjEJTFwsUdMuZ8290vF3pnaeuOuiGvHbb5iMLSJ2OAxbiEAPHQONJdIhphF
# vB00k+P7rnXdlQf6HbqcYWygUBF7qw/pTqn1o/u2uJdypw+NWUy/ybUP6i2dh/jb
# 7uKHxhkHqmz2zHLfPYilQkHPj/uhswflgtrvwofrQTIP+43xwMueko3LNzKAM6Gu
# 8Gh5Ojmv125nNCg8ghHJ5PcQ5taaYSodJ1UqZOs0TDPSoPg0ucXypV4zxTMFUVVZ
# WoMG9ZRlVbbF1YQyqTonAiWpbe6FOYEYx78ozGW3BQp4QPzeDFsj+cXDRExnyeVJ
# EsF10dTek94EeNvpdrWEFwgt7yTCKZRX791Kt9Yu1nnDgvb4CkyuKoXyYfC+Ne07
# 3/QAg5gc1sMo62/50lBrZ4Mj1WABRza1zIlrKuzmEt9oE7XntGNn9MSfa57dc+mV
# 7D5W5n/5i15S5sZTBu9/IjKrxkdeISUuIISJX/gF4dAdQp8G3OmCqRMsBfmau4xR
# esqaTd+danE1qzHyMDteSc+eHtCGK6WKvKSKTB0K3bXso0Cp3zSUannkkWiXjwQZ
# ZA+zQOECAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB0GA1UdDgQWBBT0Bf0PiCAkgYgmQ5hb7HM7Sx4nsjANBgkqhkiG9w0BAQ0F
# AAOCAgEANQEi1mKrKsvhigzK/sIiy+12yVc4sS/GYU5Xyq9/qLYqYNYOihn7bJVW
# cGHy+vdnoX8/cFdrTTyCFP2jUY2LckTnEwPbCWHnMEsuyVf3rftCV2zPw6tHpD3P
# YFer5ipBdQxKs7/NOHYp8YEUghViKB0chDBhGvGZxqHDMARzPDQDzAR1hqp1tMzl
# Hc6Mlk4IfvkmJE2qZh1K6Qg1x3NSJ4UnhmnkDWZmNJqbDsjV4WoNhaIQFoHaPbOT
# 9YhESDW4T4WOogh4mxFDpueomroEimi31OlVRByYh5GkzKoaC3A6NXMdZ5R+YHeM
# 7BQGZbzoFw4JP+6zA0o7BHlUV9a3whZt/r/a+zzu+Rq/1jVG8i8WhF0poSebB7/C
# bxq1zJocAVJzLUY6QknhHIVgcM0wxz3g3afy5slGQxKKrvlQCBx0F6LdPsydxIl7
# TH1W/iG1knjuH88CBvV9FyptvN15uzEzuhkbSUt6k5RVUfL7tsE0hprheFZJ5wwx
# kSgvACunnmN8gudA0s0rbq65SsKpNMJjz8uAoxqyugoBbnbRV6sxt52qS10wX+5/
# JS704Pqewi6qkescuWfW1QxrJOGzRD+UXNH+yplUlFlDQOcb7a5lwXrg+gQrSoQy
# 0ZQiu6WZsYHX0L0BKEC+wT56x43RhmduEU63d6pzCz0wNcHOJaIxggLjMIIC3wIB
# ATBCMC4xLDAqBgNVBAMMI0FkWmVybyBQb3dlclNoZWxsIExvY2FsIENlcnRpZmlj
# YXRlAhA0LZa7pzNpmEY81Ipf7yluMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEM
# MQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQB
# gjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBSfzJa4KXMuZEXV
# Hxi76Dw16bxNKzANBgkqhkiG9w0BAQEFAASCAgA3lW+opxO5VWS2IrSntCUU4yYg
# L4ebe+DwzCQ5NP0dUG5MyZh+zgTfgFq8kts1OvU8h2fQg1rMbu4QppWG9ISqi+M+
# tac3hOYtSnKtvL+XmLrKxcjhetNgy5HDkBCQKwlQPqFmkt8r5ng7lsHcnuJP3vez
# X0wegmZYAuOzHF7ven2h8D0z6hA7nNWh85KYzF5W6X/KC6+RHRf5pUXJUmHZIyuN
# JHWTb2CLLJwJSBZFVn+nBq+2jfY8hFeBCSEB/bm7M6feDh17pmtUiCbrgIu1BQx7
# rQhu+IfiwLYn9WY5GKDew4kLK/NICprsspoUYVWQE8F9uB14CBaO9k30SLUeMtuS
# Th0+KvfwuyZAg1PnwFv93It81atNOj28VAWUAXcGngJg9p0gWk4LZjlrNBiltQLl
# VNCs9x6ff2KTaW4eNOJIFaCY3rwFfI5lbTTXQRqYdPt1UWJ+fAZDhRb1Y0GcoxAN
# a48jmIN7TyjBS1Aa6Gq+LOlMaLNKrWgmWwBC8L/ysjCs+bk2V7qubNEbXxkoj+by
# QMPp+AEXsnrg4f9+q5Z16Gst6kYwZ2HMi8tvCJE+LpIy3Ai9Yt+InKeqiThNx1Lw
# 80jsCaRZTrUSonnZPZ8LCt+N9SKxUuA5YwvEk1LVQS+JhkUta9GhzAGTznJUiKt9
# 66YtACJDwgofUVkvIQ==
# SIG # End signature block
