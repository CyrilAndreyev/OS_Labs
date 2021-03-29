<#
  .SYNOPSIS
  Creates Windows Scheduled Task.

  .DESCRIPTION
  Creates Windows Scheduled Task. The task starts at the scheduled time.
#>

$A = New-ScheduledTaskAction -Execute "notepad.exe"
$T = New-ScheduledTaskTrigger -Once -At 5pm
$S = New-ScheduledTaskSettingsSet

$D = New-ScheduledTask -Action $A -Trigger $T -Settings $S

Register-ScheduledTask T1 -InputObject $D
