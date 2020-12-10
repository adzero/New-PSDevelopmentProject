
<#PSScriptInfo

.VERSION 1.1.0

.GUID 00fe9040-1bc7-4862-9e45-e0a59c005d65

.AUTHOR AdZero

.COMPANYNAME 

.COPYRIGHT Copyright 2018-2020 AdZero

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES Pester

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
# MIILqgYJKoZIhvcNAQcCoIILmzCCC5cCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUhWMHP6WOBRtoldpr0PALYs5w
# 9z2gggggMIIIHDCCBgSgAwIBAgITLQAB8DuytSqV58vDWwABAAHwOzANBgkqhkiG
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUZX/1gOrWK37n
# caziWpN8lZS3xZYwDQYJKoZIhvcNAQEBBQAEggIAhwuD09cvfFsun0arTRMGamec
# +NQByd2OFlrP5nj0OWcn+jaHyG4uRiPN58GgjVXY/cmchBqeZWjWUUUd5KU/PMBN
# 3miBZH4h2olrtJguNBUN1IvINus+uw95nAucFS8ZSuTpTbTIdihIZ827itJRvxU5
# 4YEW2dibKPjXqwQTIWuz2wi1eaS3ahaTJY0QyL/YLgmLqzV5QjaQ7kHldH8pzMuJ
# 5/kmBw1ntoZc4f2hdLNHXTP7TsRKj99xNNEafNoGZduceMEQ+JusCUvtEnnCEVy/
# jE2PsGhhvIgOo6KeEGafIgwqm2mKNUEn3TBRbm+psDGSnHL7F/sX8w6HVNBUVN4h
# aiyWltGOxkcWo2OSFWtAcyucYxon3pk+6QWx2TsyoBO3w+aq8kSjwL9yU2egGYQ+
# uh9bVbuCkIeS3LZHUfJ7xnmZ2vz8057esj4BYz+7X+01LgjOT2WK17l3H2o9IftM
# OIzvIal2gX2dz9sInZPqtxBj6uQg1+k3o/7UBTN+OQ/XA6NHIwzmrv+NGd3OlEW+
# 2gIKUO2y52F8sA2feW0QBCQJh9Q24MUsYL87K60TT6byCBiNQJ24jFe8JL+RfWC4
# jlS4RjpvcgJv06mZsCDBez6TKJtmH/lyENeCfaFbmUMfmeJWW0eXjnDIbPq7czTx
# wZL8ZLWjv/QK3/myWg0=
# SIG # End signature block
