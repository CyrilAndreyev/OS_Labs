/// <summary>
/// Checks if there are running instances of Notepad app and asks if user wants to kill them.
/// </summary>

open System
open System.Diagnostics

Console.WriteLine("Getting process list")
let notepadInstances = Process.GetProcessesByName("notepad")

Console.WriteLine("Checking if there are running instances of Notepad app")
if notepadInstances.Length > 0 then
    Console.WriteLine("Iterating over running Notepad instances")
    notepadInstances
    |> Seq.iter(fun elem ->
        Console.WriteLine($"Do you want to kill notepad instance {elem.Id}? y/[n]")
        if String.Compare(Console.ReadLine(), "y", StringComparison.OrdinalIgnoreCase) = 0 then
            Console.WriteLine("Killing")
            elem.Kill()
            Console.WriteLine("Killed"))
else
    Console.WriteLine("Notepad is not running")
