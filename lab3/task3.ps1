<#
  .SYNOPSIS
  Reads System events.

  .DESCRIPTION
  Read last 10 System events from EvenLog.
#>

Get-EventLog -LogName System -Newest 10

function Get-AppEvents {

<#
  .SYNOPSIS
  Writes Application events to file.

  .DESCRIPTION
  Writes Application events of specified application from EvenLog to a text file.

  .PARAMETER AppName
  Specifies, as a string array, names of applications that were written to the log that this function gets. Wildcards are permitted.

  .PARAMETER Newest
  Specifies the maximum number of events that are returned.

  .INPUTS
  None. You cannot pipe objects to Get-AppEvents.

  .OUTPUTS
  None. Get-AppEvents does not generate any output.
#>

    param (
        [string[]]$AppName,
        [int]$Newest
    )

    Get-EventLog -LogName Application -Source $AppName -Newest $Newest > "C:\Temp\$($AppName)_$(Get-Date -Format "yyyyMMdd_HHmmss").txt"

}
