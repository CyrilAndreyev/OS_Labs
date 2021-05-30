/// <summary>
/// Writes top 5 processes that are using most TotalProcessorTime to the CSV file.
/// </summary>

open System
open System.Diagnostics
open System.IO
open System.Text

let sb = StringBuilder()
sb.AppendLine("ProcessId,ProcessName,TotalProcessorTime")

let cDate = DateTime.Now.ToString("yyyyMMdd_HHmmss")

Console.WriteLine("Getting process list")
Process.GetProcesses()
|> Seq.map (fun elem ->
    let time = 
        try
            elem.TotalProcessorTime.TotalMilliseconds
        with
        | _ ->
            Console.WriteLine($"Cannot get TotalProcessorTime for process {elem.ProcessName} ({elem.Id})")
            0.
    {| Id = elem.Id; ProcessName = elem.ProcessName; TotalProcessorTime = time |})
|> Seq.sortByDescending (fun elem ->
    elem.TotalProcessorTime)
|> Seq.truncate 5
|> Seq.iter (fun elem ->
    sb.AppendLine($"{elem.Id},{elem.ProcessName},{elem.TotalProcessorTime}")
    |> ignore)

let path =
    if Environment.OSVersion.Platform = PlatformID.Win32NT then $"C:\Temp\TopProcessList_{cDate}.csv"
    else $"~/Temp/TopProcessList_{cDate}.csv"

Console.WriteLine("Writing process list to file")
File.WriteAllText(path, sb.ToString())
