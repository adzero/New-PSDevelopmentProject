<#PSScriptInfo

.VERSION 1.1.0

.GUID 00fe9040-1bc7-4862-9e45-e0a59c005d65

.AUTHOR AdZero

.COMPANYNAME 

.COPYRIGHT Copyright 2018-2021 AdZero

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

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
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU5OeMkdrsrfQFlTBlliQ0b3ro
# 0+KgggUwMIIFLDCCAxSgAwIBAgIQW63XJ86VXrBOrf64HYKdVjANBgkqhkiG9w0B
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
# gjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBQgklTLGRVjKj0h
# VJBAcLGku7fmTDANBgkqhkiG9w0BAQEFAASCAgCv/JBXiv5eCe/LCnodtv1X98y5
# oUpnw2wXdQ7vEQRy10bP4F5+6Ow3XSwN6aG9Z2gqmEUbZQwlwn08io7Sc1jIhvpU
# y5zQRQjf89O9kpmoem9hbpwfqYwK4RLpCuewgtUH0GL65ZgfkJXL12kzSNAEgBbI
# +TQqgjBbD2Ojooz2hWkKGmIXFyBTct/xWwSNpQJLl3uPBCxYBmky26mPBGOYq4CL
# 8nHfonvje3AnYYZLEbjJVywr9U5w7gPrJ9EimChjKiCwNL3BW1mlR1mrOcmUjz0q
# WJ7esNtC65nrV8C+jZdjDPz0/x3vD767kKD42aMdbu8yr/RcvucUu9kg04k30530
# +uiPsLrn4fldSEc/iviEJeXHb4T5WFfd4Ilj0TB8c3ufrZm2sfiM1Rzv1Vg/V1s5
# l4o3mhJb1n9KiJ+5J89+HMrvLCqZl9AiSVW8MdVTksntsDXCcYkDI6kLGveyavua
# UhCc3d4+F+Eg9XhUdfkZ69RED02G7THN2OWsg6jxvVD9hHylCtfl0tJnG96tzx6j
# rfd0DXfmcrxkRycmukgRghBLRijQN50HJ0c0mKKEZ8rTyc7v9QQlmgBaWrjiP1wO
# IaIS0z+go79rE3DTCxEEgK4ggQy1beJ32GKdVN+SakOOZ+m3UM8/WwAXXtOA4zFb
# 5Nd5STP2tJnxiYHP4w==
# SIG # End signature block
