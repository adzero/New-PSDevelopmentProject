<#PSScriptInfo

.VERSION 1.1.0

.GUID 00fe9040-1bc7-4862-9e45-e0a59c005d65

.AUTHOR AdZero

.COMPANYNAME AdZero

.COPYRIGHT Copyright 2018-2021 AdZero

.TAGS New-PSDevelopmentProject Test Pester

.LICENSEURI https://raw.githubusercontent.com/adzero/New-PSDevelopmentProject/master/LICENSE

.PROJECTURI https://github.com/adzero/New-PSDevelopmentProject

.ICONURI https://raw.githubusercontent.comm/adzero/New-PSDevelopmentProject/master/images/adzero-avatar.png

.EXTERNALMODULEDEPENDENCIES 
 Pester

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES

#>

#Requires -Module Pester

<# 

.DESCRIPTION 
 Tests for New-PSDevelopmentProject project 

#> 
$here = (Get-Item (Split-Path -Parent $MyInvocation.MyCommand.Path)).Parent.FullName
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$name = (Get-Item (Split-Path -Parent $MyInvocation.MyCommand.Path)).Parent.Name

$Script:scriptPath = "$here\src\$sut"
$Script:testPath = Join-Path -Path $env:TEMP -ChildPath ([Guid]::NewGuid().ToString())

Describe "New-PSDevelopmentProject | Test script project creation" {

	Context "Without GIT repository" {

		It "Check script projects root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts") -PathType Container| Should -Be $true
		}

		It "Check test script project root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject") -PathType Container| Should -Be $true
		}

		It "Check test script project License file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\LICENSE") -PathType Leaf| Should -Be $true
		}
		
		It "Check test script project Markdown README file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\README.md") -PathType Leaf| Should -Be $true
		}
		
		It "Check test script project code directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src") -PathType Container| Should -Be $true
		}

		It "Check test script project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.ps1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\bin") -PathType Container | Should -Be $true
		}

		It "Check test script project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\tests") -PathType Container| Should -Be $true
		}

		It "Check test script project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\tests\TestScriptProject.Tests.ps1") -PathType Leaf | Should -Be $true
		}
		
		BeforeAll {

			New-Item -Path $Script:testPath -ItemType Directory
			&"$($Script:scriptPath)" -Name TestScriptProject -Author Pester -Description "PowerShell test script" -RootPath $testPath -ScriptProject
		}
		
		AfterAll {
			
			Remove-Item -Path $Script:testPath -Recurse -Force -ErrorAction SilentlyContinue
		
		}
	}
	
	Context "With GIT repository" {

		It "Check script projects root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts") -PathType Container| Should -Be $true
		}

		It "Check test script project root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject") -PathType Container| Should -Be $true
		}

		It "Check test script project License file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\LICENSE") -PathType Leaf| Should -Be $true
		}
		
		It "Check test script project Markdown README file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\README.md") -PathType Leaf| Should -Be $true
		}
		
		It "Check test script project code directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src") -PathType Container| Should -Be $true
		}

		It "Check test script project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.ps1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\bin") -PathType Container | Should -Be $true
		}

		It "Check test script project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\tests") -PathType Container| Should -Be $true
		}

		It "Check test script project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\tests\TestScriptProject.Tests.ps1") -PathType Leaf | Should -Be $true
		}
		
		It "Check test script project git repository directory" {
			#Better tests needed...
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\.git") -PathType Container| Should -Be $true
		}
		
		BeforeAll {

			New-Item -Path $Script:testPath -ItemType Directory
			&"$($Script:scriptPath)" -Name TestScriptProject -Author Pester -Description "PowerShell test script" -RootPath $testPath -ScriptProject -GitRepository
		}
		
		AfterAll {
			
			Remove-Item -Path $Script:testPath -Recurse -Force -ErrorAction SilentlyContinue
		
		}
	}
}

Describe "New-PSDevelopmentProject | Test module project creation" {

	Context "Without GIT repository" {

		It "Check module projects root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules") -PathType Container| Should -Be $true
		}

		It "Check test module project root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject") -PathType Container| Should -Be $true
		}

		It "Check test module project License file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\LICENSE") -PathType Leaf| Should -Be $true
		}
		
		It "Check test module project Markdown README file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\README.md") -PathType Leaf| Should -Be $true
		}
		
		It "Check test module project code directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src") -PathType Container| Should -Be $true
		}

		It "Check test module project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.psm1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.psd1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Public") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Private") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\bin") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\en-US") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\en-US\about_TestModuleProject.help.txt") -PathType Leaf | Should -Be $true
		}

		It "Check test module project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\tests") -PathType Container| Should -Be $true
		}

		It "Check test module project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\tests\TestModuleProject.Tests.ps1") -PathType Leaf | Should -Be $true
		}
		
		BeforeAll {

			New-Item -Path $Script:testPath -ItemType Directory
			&"$($Script:scriptPath)" -Name TestModuleProject -Author Pester -Description "PowerShell test module" -RootPath $testPath -ModuleProject
		}
		
		AfterAll {
			
			Remove-Item -Path $Script:testPath -Recurse -Force -ErrorAction SilentlyContinue
		
		}
	}
	
	Context "With GIT repository" {

		It "Check module projects root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules") -PathType Container| Should -Be $true
		}

		It "Check test module project root directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject") -PathType Container| Should -Be $true
		}

		It "Check test module project License file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\LICENSE") -PathType Leaf| Should -Be $true
		}
		
		It "Check test module project Markdown README file" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\README.md") -PathType Leaf| Should -Be $true
		}
		
		It "Check test module project code directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src") -PathType Container| Should -Be $true
		}

		It "Check test module project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.psm1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.psd1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Public") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Private") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\bin") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\en-US") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\en-US\about_TestModuleProject.help.txt") -PathType Leaf | Should -Be $true
		}

		It "Check test module project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\tests") -PathType Container| Should -Be $true
		}

		It "Check test module project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\tests\TestModuleProject.Tests.ps1") -PathType Leaf | Should -Be $true
		}
		
		It "Check test module project git repository directory" {
			#Better tests needed...
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\.git") -PathType Container | Should -Be $true
		}

		BeforeAll {

			New-Item -Path $Script:testPath -ItemType Directory
			&"$($Script:scriptPath)" -Name TestModuleProject -Author Pester -Description "PowerShell test module" -RootPath $testPath -ModuleProject -GitRepository
		}
		
		AfterAll {
			
			Remove-Item -Path $Script:testPath -Recurse -Force -ErrorAction SilentlyContinue
		
		}
	}
}

# SIG # Begin signature block
# MIIIqQYJKoZIhvcNAQcCoIIImjCCCJYCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUSyedCtgPu16a/grwg34ezcCM
# rpigggUwMIIFLDCCAxSgAwIBAgIQW63XJ86VXrBOrf64HYKdVjANBgkqhkiG9w0B
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
# gjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBQ3/60AY3G46KjZ
# vvJpes31yEkgODANBgkqhkiG9w0BAQEFAASCAgATwiP4f5ep9WgpzH+rlfCmgZrQ
# AAXO4CFu8RUqr+SK/UXlSOf3djynr4TkozOZ51TaJFJguOC1WzrdNjCvmO9o1nmi
# uBTmXOIimbCUkpXhZoK6/hffGSAcH3Pqobb54DAtzQHtsnw2OhkYWqrGvab9vcay
# kLi+TIqFyH4Zsmf2Q3uVNQqC4ZFUBDRDfuvVTeAkvqDszeB94oWThTC3w89x7gJh
# QkqXR7iKkKT/VGRSsiGtuSzE1wMEgmKq4fEZ1zAw50dOLSrIwj3vJ/G6hCtkotwm
# Rl8kPrTzBPB2B3/CQa+iO4QP/+dlf/kThmQw9YCoVSztvK1Ag4itHosQKQfZUS0S
# LT5ITNzSiEi5ZJSRlVKSF8nJ15PVqKeGBj6nlNUxAHRaMKSkLIJv5vrUlcHiLUkx
# pneqz2XwL5fsAWf2G6zV5+uBX7ik+zb5E0Mt2e7IrL1aLodnowLxn/LDJ0NBlEhf
# RiDsHmw6BxuhEERocbi1BhkCJ23sflIkIt3OkB3fWupXbMTkJIA13xshkPzlFhJP
# 9bmLq/7KI9bDrAHUIjWlCbN8HsHNlB4alDSLTWd45+/aG6QsabbNUEhCCWJhXEJ3
# initOSFHzAltWCXQkALCVQ5UbyaX5rF1gnpf8H/UoRvqwZEKKSEcCB4q7YVSrkkL
# KN8QJLIv0DDaxHfNAA==
# SIG # End signature block
