<#
  .SYNOPSIS
  Writes running and stopped services to separate files.

  .DESCRIPTION
  Writes running and stopped services to separate files: one file for running services and one for stopped services.
#>

gsv | ? {$_.Status -eq "Running"} > C:\Temp\running-services.txt
gsv | ? {$_.Status -eq "Stopped"} > C:\Temp\stopped-services.txt


function Get-ServiceStatus {

<#
  .SYNOPSIS
  Returns service status.

  .DESCRIPTION
  Returns service status (Running or Stopped).

  .PARAMETER ServiceName
  Specifies the service name of service to be retrieved. Wildcards are permitted.

  .INPUTS
  None. You cannot pipe objects to Get-ServiceStatus.

  .OUTPUTS
  This function returns service status.
#>

    param (
        $ServiceName
    )

    (gsv $ServiceName).Status | Write-Output

}
