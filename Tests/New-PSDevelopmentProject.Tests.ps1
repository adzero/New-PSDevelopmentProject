
<#PSScriptInfo

.VERSION 1.0.0

.GUID 00fe9040-1bc7-4862-9e45-e0a59c005d65

.AUTHOR AdZero

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 

.DESCRIPTION 
 Tests for New-PSDevelopmentProject project 

#> 
$here = (Get-Item (Split-Path -Parent $MyInvocation.MyCommand.Path)).Parent.FullName
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
$name = (Get-Item (Split-Path -Parent $MyInvocation.MyCommand.Path)).Parent.Name

$Script:scriptPath = "$here\$name\$sut"
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject") -PathType Container| Should -Be $true
		}

		It "Check test script project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\TestScriptProject.ps1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\TestScriptProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\bin") -PathType Container | Should -Be $true
		}

		It "Check test script project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\Tests") -PathType Container| Should -Be $true
		}

		It "Check test script project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\Tests\TestScriptProject.Tests.ps1") -PathType Leaf | Should -Be $true
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject") -PathType Container| Should -Be $true
		}

		It "Check test script project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\TestScriptProject.ps1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\TestScriptProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\TestScriptProject\bin") -PathType Container | Should -Be $true
		}

		It "Check test script project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\Tests") -PathType Container| Should -Be $true
		}

		It "Check test script project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\Tests\TestScriptProject.Tests.ps1") -PathType Leaf | Should -Be $true
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject") -PathType Container| Should -Be $true
		}

		It "Check test module project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\TestModuleProject.psm1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\TestModuleProject.psd1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\TestModuleProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\Public") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\Private") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\bin") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\en-US") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\en-US\about_TestModuleProject.help.txt") -PathType Leaf | Should -Be $true
		}

		It "Check test module project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\Tests") -PathType Container| Should -Be $true
		}

		It "Check test module project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\Tests\TestModuleProject.Tests.ps1") -PathType Leaf | Should -Be $true
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject") -PathType Container| Should -Be $true
		}

		It "Check test module project code directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\TestModuleProject.psm1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\TestModuleProject.psd1") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\TestModuleProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\Public") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\Private") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\lib") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\bin") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\en-US") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\TestModuleProject\en-US\about_TestModuleProject.help.txt") -PathType Leaf | Should -Be $true
		}

		It "Check test module project Pester tests directory" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\Tests") -PathType Container| Should -Be $true
		}

		It "Check test module project Pester tests directory default content" {
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\Tests\TestModuleProject.Tests.ps1") -PathType Leaf | Should -Be $true
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
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU3GXqEyqOvlzUJqolFeUbdQu2
# zEqgggUwMIIFLDCCAxSgAwIBAgIQNC2Wu6czaZhGPNSKX+8pbjANBgkqhkiG9w0B
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
# gjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBQ4HCNnv7ymbozb
# jDJrYdC5s+tm4DANBgkqhkiG9w0BAQEFAASCAgArLXpeYFHPOIBxp6aNoS8NRmiN
# d2iMBK/3zNMEEQ7h8Onk6LdcjkAMBBF57IVSaEyp2LSEsAT32F/LoGP/HwVoIhUU
# EcyHsWaDZ8ZfSaofC/4YBEEaXiG4o5p8Pnff1yWaRQD0DL1gdAC/U7pA9H55yNzJ
# VXa3iZFsM8ulHI07gKsrCkNdorIFiBS75GuYggTRjc3ZoKnEX9cU61rHbqcwZobr
# XEQrQ1oP9lXFYta5OwMWek8SlJdVxqD1tA1MFKZMuRX9bJprakioPjtutgPsEk2f
# WLQdVKVSqJ0E9CEOZdAdvX19YlAirNO3018uzF+YRYbiwb1dl4bRGidQs+Df1lxI
# Zst9a7cevByMa9U/d99brQuYfJ7kYIyRpa4FdzpXv3RqCcWsxXiWIe8xcTk9Sp2b
# AKHX73nOgB7bvcx0blaG/uurJPz5OOT1HyANXTXQnWPstoRfcfx/jMV5JPkQfHWx
# PekVcCamOBzCq8ZJWH/AJBCApEI7W2aQEjeJk4DvOQMonGnenJCj1+B7+Fm7+buI
# LZYGx1raWxKx2dEyNT/6lTQh35vnMzHfKxsoJdaxW5hQYD07f2MtwgW0QksiReJ/
# XnrCdUf7XYSwXJhV79AiJm2lOQTnNFhg447ZufXW+Df6gfr3a+5Afz05ZE8IVjW/
# gVCEZCpwHeaNc2Otww==
# SIG # End signature block
