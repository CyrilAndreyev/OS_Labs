<#
  .SYNOPSIS
  Writes selected PC parameters to file.

  .DESCRIPTION
  Using WMI object gets information about computer name,
  storage devices, CPU usage averaged to the last second,
  amount of total physical memory and free physical memory in MB.
  Writes this information to a text file with date and time when the information was retrieved.
#>

"$(Get-Date)
----------------------------------------------------------------
Computer name: $((gwmi Win32_ComputerSystem).Name)
----------------------------------------------------------------
Storage devices info:
$(gwmi Win32_LogicalDisk | Out-String)
----------------------------------------------------------------
CPU usage: $((gwmi Win32_Processor).LoadPercentage)%
----------------------------------------------------------------
Total memory: $((gwmi Win32_OperatingSystem).TotalVisibleMemorySize / 1KB) MB
Free memory: $((gwmi Win32_OperatingSystem).FreePhysicalMemory / 1KB) MB" |
  Out-File C:\Temp\PC_Info.txt
