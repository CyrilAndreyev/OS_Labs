<#
  .SYNOPSIS
  Performs the search among running processes on local machine.

  .DESCRIPTION
  Performs the search among running processes on local machine.
  Search can be done (user can choose) by process name, part of the name or ID.
  If process was not found, shows info message about that.
  If the process(es) was/were found, asks if user wants to kill the process(es). If yes, then kills the process(es).
#>

Write-Host "1 - Search processes by name"
Write-Host "2 - Search processes by part of name"
Write-Host "3 - Search process by Id"
$Prompt = Read-Host "Please choose the action"
switch ( $Prompt )
{
    1
    {
        Write-Host "Search processes by name"
        $Name = Read-Host "Please specify process name"
        Write-Host "Getting process list"
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
                Write-Host "Killing"
                kill -Name $Name
                Write-Host "Killed"
            }
        }
    }
    2
    {
        Write-Host "Search processes by part of name"
        $NameSubstring = Read-Host "Please specify part of process name"
        Write-Host "Getting process list"
        $Processes = ps | ? {$_.ProcessName -match $NameSubstring}
        if ( $Processes )
        {
            $Processes
            $Prompt = Read-Host "Do you want to kill found processes? y/[n]"
            if ( $Prompt -eq "y" )
            {
                Write-Host "Killing"
                $Processes | % { kill -InputObject $_ }
                Write-Host "Killed"
            }
        }
        else
        {
            Write-Host "Processes not found"
        }
    }
    3
    {
        Write-Host "Search process by Id"
        $Id = Read-Host "Please specify process Id"
        Write-Host "Getting process list"
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
                Write-Host "Killing"
                kill -Id $Id
                Write-Host "Killed"
            }
        }
    }
    default
    {
        Write-Host "Incorrect input"
    }
}
