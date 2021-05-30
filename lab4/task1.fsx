/// <summary>
/// Writes all the processes that are running on local machine at the current moment to the CSV file.
/// </summary>

open System
open System.Diagnostics
open System.IO
open System.Text

let sb = StringBuilder()
sb.AppendLine("ProcessId,ProcessName")

Console.WriteLine("Getting process list")
Process.GetProcesses()
|> Seq.iter (fun elem ->
    sb.AppendLine($"{elem.Id},{elem.ProcessName}")
    |> ignore)

let path =
    if Environment.OSVersion.Platform = PlatformID.Win32NT then "C:\Temp\CurrentProcessList.csv"
    else "~/Temp/CurrentProcessList.csv"

Console.WriteLine("Writing process list to file")
File.WriteAllText(path, sb.ToString())
