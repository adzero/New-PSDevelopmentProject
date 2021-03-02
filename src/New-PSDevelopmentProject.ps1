<#PSScriptInfo

.VERSION 1.1.0

.GUID 32d9b358-2002-4dbb-9393-d068333a60e6

.AUTHOR AdZero (adzero.git@gmail.com)

.COMPANYNAME 

.COPYRIGHT Copyright 2018-2021 AdZero

.TAGS PowerShell GIT

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
	[Parameter(HelpMessage='The root path where to create new project directory')]
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
# MIILqgYJKoZIhvcNAQcCoIILmzCCC5cCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUqJ2tB29avcTnTIkZSaAmZPNB
# BkOgggggMIIIHDCCBgSgAwIBAgITLQAB8DuytSqV58vDWwABAAHwOzANBgkqhkiG
# 9w0BAQ0FADA8MRIwEAYKCZImiZPyLGQBGRYCZnIxFDASBgoJkiaJk/IsZAEZFgRj
# ZzY3MRAwDgYDVQQDEwdDRzY3IENBMB4XDTE0MDcyNDA3NDQxN1oXDTI0MDcyMTA3
# NDQxN1owXDESMBAGCgmSJomT8ixkARkWAmZyMRQwEgYKCZImiZPyLGQBGRYEY2c2
# NzEaMBgGA1UECxMRU2VydmljZXMgQWNjb3VudHMxFDASBgNVBAMTC1NlcnZpY2VD
# ZXJ0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwfnpyM9UcNFHTIjg
# JuIlrIB440usbjELOXuUglFHc8UTNbAx4T4JLWIBEDkyWWb0okrFFLpj78FU2Scc
# xY1lSsTvSJpN5u6kGSASJWxV7eK+N8i4fSupV62LzTGAekxb2i5qXIDu6Yycio24
# 7tgb97RF/vPeC5j7KmIUW9wggedx29nIxGuq2r87ItXy9Rda+wUtFrl4wBLJo/+r
# zjoNOoEkXKA+DW/q8H6FaaBRMi/0it/w8xMYuPaltgPhi9OVbviDZPcJOrCTzaWS
# ZfyxEjDW9sVwi6qT0q+RGEC8MKoDeHIklKvU5vgCi1zrDk7W3F6J6FbVFUo7BpNp
# 2I+B/U0gr17BjFKcjhp9UVxWki5VcJoGzXfZB4sttovh5uo8X4hIIi0b4m3SHVNC
# TTDfn1Ss66Vy8GPK+gkQDp4uzFTnj3mR2V+r8iTAjj0GZT8dIMC2dmHddtoTZF1q
# TieZexqlarLXOX6N23rUc059jl5I25avU9a7Z04J3e3RhlAq/KNvgDc92g5CbqJx
# XGdpShzrRgdPOl4S3em7MNMSsQmsSvVz84euCdqWNEEsDb5Y2uG62qlH94t8pboe
# EgH/s8CU4eWv+OkRhkWtbXTC9txuoo+Y6WgZi25xpNVcqFK9YAlhhxD3ATYq5w7+
# GVVFLLrLAr4Fqrb5Y26QPebKnE0CAwEAAaOCAvUwggLxMD4GCSsGAQQBgjcVBwQx
# MC8GJysGAQQBgjcVCIKKtR+B0u5sg82RD4Ta41CFl+l7gUaB5PBXh/ilAAIBZAIB
# CDATBgNVHSUEDDAKBggrBgEFBQcDAzALBgNVHQ8EBAMCB4AwDAYDVR0TAQH/BAIw
# ADAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBSV1UGzJTwK
# 1N32vu0VNQtMF+CTGjAfBgNVHSMEGDAWgBSqHlPNsEpk6WPFatxhTUD5SBi82DCB
# 8AYDVR0fBIHoMIHlMIHioIHfoIHchoGqbGRhcDovLy9DTj1DRzY3JTIwQ0EoMSks
# Q049Q0EsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZp
# Y2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2c2NyxEQz1mcj9jZXJ0aWZpY2F0ZVJl
# dm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9p
# bnSGLWh0dHA6Ly9DQS5jZzY3LmZyL0NlcnRFbnJvbGwvQ0c2NyUyMENBKDEpLmNy
# bDCB/QYIKwYBBQUHAQEEgfAwge0wgaQGCCsGAQUFBzAChoGXbGRhcDovLy9DTj1D
# RzY3JTIwQ0EsQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNl
# cnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9Y2c2NyxEQz1mcj9jQUNlcnRpZmlj
# YXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTBEBggr
# BgEFBQcwAoY4aHR0cDovL0NBLmNnNjcuZnIvQ2VydEVucm9sbC9DQS5jZzY3LmZy
# X0NHNjclMjBDQSgxKS5jcnQwLwYDVR0RBCgwJqAkBgorBgEEAYI3FAIDoBYMFHNl
# cnZpY2UuY2VydEBjZzY3LmZyMA0GCSqGSIb3DQEBDQUAA4ICAQBfxPOXbOtpvRDN
# dzhEfhHJGmgirn2w1U4ASSdFggk1jB7GCACVoscHrxIUEt/kC3n0JAOVFEXzS2OY
# fiqR7VjlElIYkj5A/Np4EYoqYaiVm5fTcCpvqhnYylCAT4B929fR2pZMdERmkW3F
# tSQSxg++lUQhy1fJ00A99f/j1Uz7gCxp+NdbubyHyYEQkpFv0xtF4N+8zCre7Gp0
# lJnxa/SiXwk+lLf+/rXXKeHD3njZRxDBz87NW7E3khPfHiRvApCCvbzMQwICbDq6
# eYW/jPmAp0WCTHk/bDMhNPmQOYmGfAJzkoF/thDxywW16nZ4Db0yMyeKCWT2GFc/
# SZD7QrSFR7utEbD2THfRZZb+ZmyJFE7UoWY7ziwVg3v3YqwmWMiIfhS6ZdTZoJuj
# z6oIrE7Ztcnlr+vhhWRu05pU6qQZBkrDtNNhWg/vqOBP3kSIrewQGlM1U9JkrcxR
# IH4RDsEvmwsfHeyylZJZnbbDWERkWJIgvz2VZbMZD3hjqh2pVbXFjBADsNGhzPat
# h+oJlzVMawoNyOqt9n8unpQCR9fzQXjEflkN4dMjktL7lHO+IZDEVGx6DrsgZW4v
# Q6XoR9FmrSGgs0T7jjj69BtIIty7wiiKz4FWQf8Uw4irBcm0cXZoMN1OXqMiEk2R
# RcFScqXqOjTjCwLpQVjqTABYZHCe1zGCAvQwggLwAgEBMFMwPDESMBAGCgmSJomT
# 8ixkARkWAmZyMRQwEgYKCZImiZPyLGQBGRYEY2c2NzEQMA4GA1UEAxMHQ0c2NyBD
# QQITLQAB8DuytSqV58vDWwABAAHwOzAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIB
# DDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUKgYG10AcIQED
# iPY90Fko7o7kWAEwDQYJKoZIhvcNAQEBBQAEggIAMBaurWPYx4RWMj6OGbmafTBJ
# 9aKSjBLxL92re29fSbtYIxM/+08KxD030DIfdOcIYpXX+BnfJ3lThweJTWV0g1KZ
# 7rENEqbTkqaiHGJuOjHoFb1GaTlmhnp3APHS1Ytmx50GT5mZvqnluT8d5wSuBHzp
# Mc6ddvpYMkQ1BT8B0kLh3onMse14/KfzKVeR4k6BHbrDVPOZHx07ktglCRhFMPrP
# r7H4urC4vxUFYEXCiXh6xVHvSMamc30HqA2Yrd7mEnWJGUo+qhGM4MaPl9dUnVB5
# hsl+RtZGnxXPfYv6V5UIVIRp/5e4XFOhFqt1eJP7LSR4Rqe27pMFSwBNiebs3sdm
# IPW8m8HN3OMoHP02TtJdhU7dPoJUqrFzsrJhmUqrRPEBnFqeymxLRaWPI0pGbfkv
# X4qLcuh+oCtaMkgqkFRDTN4BjxMpmAtois61ZXtAxtL9BJX02U68ZCZifw/XNE/p
# i6k6twVCi5R7gzDGZpf9nUoE0960PCy3JSHxNN6cTwP7inCtmZKN2+fLqyvNS72b
# DIMN+DR+DCfsksVmqZhsZbCV7Rvv+2mluUVNOh7nH41i1xOri2HrfqAHfnCgGMMB
# G5fKkho00HiJXX6iZEbLqXeA9DK4YCc54UGp1HUJ1M91I26zOBNdJO6fV/DKp6qJ
# MzGu2rOtuYeVdR8Vk4U=
# SIG # End signature block
