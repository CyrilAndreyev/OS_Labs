Write-Host "1 - Search processes by name"
Write-Host "2 - Search processes by part of name"
Write-Host "3 - Search process by Id"
$Prompt = Read-Host "Please choose the action"
switch ( $Prompt )
{
    1
    {
        $Name = Read-Host "Please specify process name"
        $Processes = ps -Name $Name -ErrorAction SilentlyContinue -ErrorVariable ProcessError
        if ( $ProcessError )
        {
            Write-Host "Processes not found"
        }
        else
        {
            $Processes
            $Prompt = Read-Host "Do you want to kill found processes? y/[n]"
            if ( $Prompt -eq "y" )
            {
                kill -Name $Name
            }
        }
    }
    2
    {
        $NameSubstring = Read-Host "Please specify part of process name"
        $Processes = ps | ? {$_.ProcessName -match $NameSubstring}
        if ( $Processes )
        {
            $Processes
            $Prompt = Read-Host "Do you want to kill found processes? y/[n]"
            if ( $Prompt -eq "y" )
            {
                $Processes | % { kill -InputObject $_ }
            }
        }
        else
        {
            Write-Host "Processes not found"
        }
    }
    3
    {
        $Id = Read-Host "Please specify process Id"
        $Processes = ps -Id $Id -ErrorAction SilentlyContinue -ErrorVariable ProcessError
        if ( $ProcessError )
        {
            Write-Host "Process not found"
        }
        else
        {
            $Processes
            $Prompt = Read-Host "Do you want to kill the found process? y/[n]"
            if ( $Prompt -eq "y" )
            {
                kill -Id $Id
            }
        }
    }
    default
    {
        Write-Host "Incorrect input"
    }
}
