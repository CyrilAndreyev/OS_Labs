Get-Process chrome

Get-Process | Where-Object {$_.ProcessName -eq 'chrome'}
Get-Process | Where-Object {$_.ProcessName.Contains('sm')}
Get-Process | Where-Object {$_.Id -eq '2200'}

Stop-Process -Name notepad

"Hello, World!" > "C:\Temp\FirstWayToSave.txt"
"Hello, World!" | Out-File "C:\Temp\SecondWayToSave.txt"

Get-Date -Format "yyyyMMdd_HHmmss"

Get-ChildItem "C:\Temp" | Where-Object {$_.Length -eq 8} | Remove-Item

While($True)
{
    $cDateTime = Get-Date -Format "ss"
    Write-Host "CurrentTime $($cDateTime)"
    Sleep(1)
    if($cDateTime -eq 10)
    {
        break
    }
}

Get-Process | Where-Object {$_.ProcessName.Contains('a')} | Select-Object Id, ProcessName | Export-Csv "C:\Temp\APList.csv" -NoTypeInformation
ps | ? {$_.ProcessName.Contains('a')} | select Id, ProcessName | epcsv "C:\Temp\APList.csv" -NoTypeInformation

Get-Alias
