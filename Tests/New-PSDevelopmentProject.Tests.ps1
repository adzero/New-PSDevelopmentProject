<#PSScriptInfo

.VERSION 1.2.0

.GUID 00fe9040-1bc7-4862-9e45-e0a59c005d65

.AUTHOR AdZero

.COMPANYNAME AdZero

.COPYRIGHT Copyright 2018-2022 AdZero

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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.Type.ps1xml") -PathType Leaf | Should -Be $true
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.Type.ps1xml") -PathType Leaf | Should -Be $true
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.Type.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Enums") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Classes") -PathType Container | Should -Be $true
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
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Scripts\TestScriptProject\src\TestScriptProject.Type.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\TestModuleProject.Format.ps1xml") -PathType Leaf | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Enums") -PathType Container | Should -Be $true
			Test-Path -Path (Join-Path -Path $testPath -ChildPath "Modules\TestModuleProject\src\Classes") -PathType Container | Should -Be $true
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
# MIILzwYJKoZIhvcNAQcCoIILwDCCC7wCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBpzFlxmGe8+A1/
# +j+EiYUIbjMuBUEkMduyeIR5tUfqKaCCCCAwgggcMIIGBKADAgECAhMtAAHwO7K1
# KpXny8NbAAEAAfA7MA0GCSqGSIb3DQEBDQUAMDwxEjAQBgoJkiaJk/IsZAEZFgJm
# cjEUMBIGCgmSJomT8ixkARkWBGNnNjcxEDAOBgNVBAMTB0NHNjcgQ0EwHhcNMTQw
# NzI0MDc0NDE3WhcNMjQwNzIxMDc0NDE3WjBcMRIwEAYKCZImiZPyLGQBGRYCZnIx
# FDASBgoJkiaJk/IsZAEZFgRjZzY3MRowGAYDVQQLExFTZXJ2aWNlcyBBY2NvdW50
# czEUMBIGA1UEAxMLU2VydmljZUNlcnQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQDB+enIz1Rw0UdMiOAm4iWsgHjjS6xuMQs5e5SCUUdzxRM1sDHhPgkt
# YgEQOTJZZvSiSsUUumPvwVTZJxzFjWVKxO9Imk3m7qQZIBIlbFXt4r43yLh9K6lX
# rYvNMYB6TFvaLmpcgO7pjJyKjbju2Bv3tEX+894LmPsqYhRb3CCB53Hb2cjEa6ra
# vzsi1fL1F1r7BS0WuXjAEsmj/6vOOg06gSRcoD4Nb+rwfoVpoFEyL/SK3/DzExi4
# 9qW2A+GL05Vu+INk9wk6sJPNpZJl/LESMNb2xXCLqpPSr5EYQLwwqgN4ciSUq9Tm
# +AKLXOsOTtbcXonoVtUVSjsGk2nYj4H9TSCvXsGMUpyOGn1RXFaSLlVwmgbNd9kH
# iy22i+Hm6jxfiEgiLRvibdIdU0JNMN+fVKzrpXLwY8r6CRAOni7MVOePeZHZX6vy
# JMCOPQZlPx0gwLZ2Yd122hNkXWpOJ5l7GqVqstc5fo3betRzTn2OXkjblq9T1rtn
# Tgnd7dGGUCr8o2+ANz3aDkJuonFcZ2lKHOtGB086XhLd6bsw0xKxCaxK9XPzh64J
# 2pY0QSwNvlja4braqUf3i3yluh4SAf+zwJTh5a/46RGGRa1tdML23G6ij5jpaBmL
# bnGk1VyoUr1gCWGHEPcBNirnDv4ZVUUsussCvgWqtvljbpA95sqcTQIDAQABo4IC
# 9TCCAvEwPgYJKwYBBAGCNxUHBDEwLwYnKwYBBAGCNxUIgoq1H4HS7myDzZEPhNrj
# UIWX6XuBRoHk8FeH+KUAAgFkAgEIMBMGA1UdJQQMMAoGCCsGAQUFBwMDMAsGA1Ud
# DwQEAwIHgDAMBgNVHRMBAf8EAjAAMBsGCSsGAQQBgjcVCgQOMAwwCgYIKwYBBQUH
# AwMwHQYDVR0OBBYEFJXVQbMlPArU3fa+7RU1C0wX4JMaMB8GA1UdIwQYMBaAFKoe
# U82wSmTpY8Vq3GFNQPlIGLzYMIHwBgNVHR8EgegwgeUwgeKggd+ggdyGgapsZGFw
# Oi8vL0NOPUNHNjclMjBDQSgxKSxDTj1DQSxDTj1DRFAsQ049UHVibGljJTIwS2V5
# JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1jZzY3
# LERDPWZyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Q/YmFzZT9vYmplY3RDbGFz
# cz1jUkxEaXN0cmlidXRpb25Qb2ludIYtaHR0cDovL0NBLmNnNjcuZnIvQ2VydEVu
# cm9sbC9DRzY3JTIwQ0EoMSkuY3JsMIH9BggrBgEFBQcBAQSB8DCB7TCBpAYIKwYB
# BQUHMAKGgZdsZGFwOi8vL0NOPUNHNjclMjBDQSxDTj1BSUEsQ049UHVibGljJTIw
# S2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1j
# ZzY3LERDPWZyP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZp
# Y2F0aW9uQXV0aG9yaXR5MEQGCCsGAQUFBzAChjhodHRwOi8vQ0EuY2c2Ny5mci9D
# ZXJ0RW5yb2xsL0NBLmNnNjcuZnJfQ0c2NyUyMENBKDEpLmNydDAvBgNVHREEKDAm
# oCQGCisGAQQBgjcUAgOgFgwUc2VydmljZS5jZXJ0QGNnNjcuZnIwDQYJKoZIhvcN
# AQENBQADggIBAF/E85ds62m9EM13OER+EckaaCKufbDVTgBJJ0WCCTWMHsYIAJWi
# xwevEhQS3+QLefQkA5UURfNLY5h+KpHtWOUSUhiSPkD82ngRiiphqJWbl9NwKm+q
# GdjKUIBPgH3b19Halkx0RGaRbcW1JBLGD76VRCHLV8nTQD31/+PVTPuALGn411u5
# vIfJgRCSkW/TG0Xg37zMKt7sanSUmfFr9KJfCT6Ut/7+tdcp4cPeeNlHEMHPzs1b
# sTeSE98eJG8CkIK9vMxDAgJsOrp5hb+M+YCnRYJMeT9sMyE0+ZA5iYZ8AnOSgX+2
# EPHLBbXqdngNvTIzJ4oJZPYYVz9JkPtCtIVHu60RsPZMd9Fllv5mbIkUTtShZjvO
# LBWDe/dirCZYyIh+FLpl1Nmgm6PPqgisTtm1yeWv6+GFZG7TmlTqpBkGSsO002Fa
# D++o4E/eRIit7BAaUzVT0mStzFEgfhEOwS+bCx8d7LKVklmdtsNYRGRYkiC/PZVl
# sxkPeGOqHalVtcWMEAOw0aHM9q2H6gmXNUxrCg3I6q32fy6elAJH1/NBeMR+WQ3h
# 0yOS0vuUc74hkMRUbHoOuyBlbi9DpehH0WatIaCzRPuOOPr0G0gi3LvCKIrPgVZB
# /xTDiKsFybRxdmgw3U5eoyISTZFFwVJypeo6NOMLAulBWOpMAFhkcJ7XMYIDBTCC
# AwECAQEwUzA8MRIwEAYKCZImiZPyLGQBGRYCZnIxFDASBgoJkiaJk/IsZAEZFgRj
# ZzY3MRAwDgYDVQQDEwdDRzY3IENBAhMtAAHwO7K1KpXny8NbAAEAAfA7MA0GCWCG
# SAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcN
# AQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUw
# LwYJKoZIhvcNAQkEMSIEIIj+FnOvdLucUJQcgIYXcWUCVaSgvxIPxojI6yKoxcUn
# MA0GCSqGSIb3DQEBAQUABIICAF/xDM9/h2m8fKGIxMagrQeiTZgwdxCUXoQknltd
# QWYU7SYHh9xmvtw50OTKWhMv4rpeQ/XBaPPvoEKWPK2PrU2Iq8UJdzWkI/1tbkau
# dbNLkGdOv8RVZSIaOY+atqYc/g+QLW+W+ZI/Q6T/tRNeEo26hGcAQIpW8n6BCXzo
# +uDdOgSDWe1QuMisj6tBowNfrD5CM6twCQHJ+7PcMrD0X5FGGjZsMC3LB4HRHGiF
# DrHuNA+SAP5pIlVB/OuINcca809y3C4jizzCIWWXitScXAHMvkoTstdQ1jndoQUi
# E4EXlNxEXEmFxbBmjUPciIFtcBDDMoeLpUHmLyKZVqyKe98oVp08XD8I5wUIsuCV
# x4KNDExUQEQi3BZTKxfoVUAa+92UzxGFst5+MhXVIchxEGXfQDgE7t0L+kBB9BNW
# 9ZxhraDGQUd4NHbiz31VAV6hRiyy87gMCe98aqriKVqZC4one70tkAYDa6EH1I1F
# AknvF4n39MWQ1u+ne+fX8znygDT4MCvndmaMEbmbGis/83c39xZTmk0rTonAFA0R
# 15wK7hBK9yCF7thfbWfZ/BnCXj3fzEvfNIsSO0LoW9uyOucbngcaZoyTTw3s+ptg
# 1Tlhl1hNHR7QdPyP2l+v4qggRp1Rq7FsqQjnwGbV/LspUV5u4SwXToWopsNyhq5N
# qmuY
# SIG # End signature block
