<#
  .SYNOPSIS
  Filters processes by selected parameter.

  .DESCRIPTION
  Filters processes by selected parameter.
  Asks user to enter baseline parameter value.
  Each 30 seconds validates process list.
  If the parameter value of processes is greater than the baseline, writes these processes to the CSV file.
  Takes care of the housekeeping (there are no more than 5 generated files at any given moment).
#>

Write-Host "1 - Handles: The number of handles that the process has opened"
Write-Host "2 - NPM(K): The amount of non-paged memory that the process is using, in kilobytes"
Write-Host "3 - PM(K): The amount of pageable memory that the process is using, in kilobytes"
Write-Host "4 - WS(K): The size of the working set of the process, in kilobytes. The working set consists of the pages of memory that were recently referenced by the process"
Write-Host "5 - VM(M): The amount of virtual memory that the process is using, in megabytes. Virtual memory includes storage in the paging files on disk"
Write-Host "6 - CPU(s): The amount of processor time that the process has used on all processors, in seconds"
[string]$Prompt = Read-Host "Please choose the filtering parameter"
$Parameter = switch ( $Prompt )
{
    "1" { "Handles" }
    "2" { "NPM"     }
    "3" { "PM"      }
    "4" { "WS"      }
    "5" { "VM"      }
    "6" { "CPU"     }
}
if ( $Parameter )
{
    Write-Host "Filtering processes by $Parameter"
    [float]$Baseline = Read-Host "Please enter the baseline"
    Write-Host "Starting the infinite loop"
    while ($true)
    {
        Write-Host "New iteration"
        $Files = ls C:\Temp\FilteredProcessList_*.csv
        $Files[0..($Files.Length - 5)] | rm
        ps |
          ? {$_.$Parameter -gt $Baseline} |
            select ProcessName, Id, $Parameter |
              epcsv "C:\Temp\FilteredProcessList_$(Get-Date -Format "yyyyMMdd_HHmmss").csv" -NoTypeInformation
        Write-Host "Sleeping for 30 seconds"
        sleep 30
    }
}
else
{
    Write-Host "Incorrect input"
}
