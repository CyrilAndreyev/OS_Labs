<#
  .SYNOPSIS
  Writes Windows user registry key.

  .DESCRIPTION
  Writes Windows user registry key.
  Checks if the required folder exists in the registry.
  If not, creates it.
  Then writes the registry key.
#>

$RegistryPath = "HKCU:\Software\PowershellScriptRunTime"
$KeyName = "RunTime"
$KeyValue = Get-Date -Format "yyyy-MM-dd HH:mm"

if ( !(Test-Path $RegistryPath) )
{
    Write-Host "Creating registry folder"
    ni $RegistryPath -Force | Out-Null
}

Write-Host "Writing registry key"
New-ItemProperty -Path $RegistryPath -Name $KeyName -Value $KeyValue -PropertyType String -Force | Out-Null
