<#
  .SYNOPSIS
  Calls Sysinternal application and writes its output to file.

  .DESCRIPTION
  Calls "PsInfo" Sysinternal tool and writes application's output to a text file.
#>

Invoke-Command -ScriptBlock {
    Downloads\SysinternalsSuite\PsInfo.exe
} > C:\Temp\PsInfo.txt
