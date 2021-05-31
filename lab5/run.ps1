$FilePath = Join-Path -Path $pwd -ChildPath MachineInfo/MachineInfo/bin/Debug/net5.0/MachineInfo.dll
[System.Reflection.Assembly]::LoadFile($FilePath)

[MachineInfo.SystemInfoReader]::ShowSystemInfo()

[MachineInfo.SystemInfoReader]::ShowApplicationLogs("DockerService")
