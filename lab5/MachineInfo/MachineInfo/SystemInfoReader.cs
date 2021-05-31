using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace MachineInfo
{
    public class SystemInfoReader
    {
        private static string GetMachineName()
        {
            return Environment.MachineName;
        }

        private static string GetDrivesInfo()
        {
            var sb = new StringBuilder();
            var drives = DriveInfo.GetDrives();
            foreach (var drive in drives)
            {
                sb.AppendLine(drive.Name);
                if (drive.IsReady)
                {
                    sb.AppendLine(drive.TotalSize.ToString());
                }
            }
            return sb.ToString();
        }

        private static string GetCpuUsage()
        {
            if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                return RuntimeInformation.OSDescription;
            }

            var cpuUsage = new PerformanceCounter("Processor", "% Processor Time", "_Total");
            Thread.Sleep(1000);
            cpuUsage.NextValue();
            Thread.Sleep(1000);
            return $"{cpuUsage.NextValue()}%";
        }

        private static double GetTotalPhysicalMemory()
        {
            var gcMemoryInfo = GC.GetGCMemoryInfo();
            var physicalMemoryBytes = gcMemoryInfo.TotalAvailableMemoryBytes;
            var physicalMemoryMb = physicalMemoryBytes / 1048576.0;
            return physicalMemoryMb;
        }

        private static double GetFreePhysicalMemory()
        {
            var gcMemoryInfo = GC.GetGCMemoryInfo();
            var freeMemoryBytes = gcMemoryInfo.TotalAvailableMemoryBytes - gcMemoryInfo.HighMemoryLoadThresholdBytes;
            var freeMemoryMb = freeMemoryBytes / 1048576.0;
            return freeMemoryMb;
        }

        public static void ShowSystemInfo()
        {
            Console.WriteLine($"Computer name: {GetMachineName()}");
            Console.WriteLine("Storage devices info:");
            Console.WriteLine(GetDrivesInfo());
            Console.WriteLine("CPU usage:");
            Console.WriteLine(GetCpuUsage());
            Console.WriteLine($"Total memory: {GetTotalPhysicalMemory()} MB");
            Console.WriteLine($"Free memory: {GetFreePhysicalMemory()} MB");
        }

        public static void ShowApplicationLogs(string appName, int count = 10)
        {
            if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
            {
                var eventLog = new EventLog("Application");
                var eventLogEntryArray = new EventLogEntry[eventLog.Entries.Count];
                eventLog.Entries.CopyTo(eventLogEntryArray, 0);
                var logs =
                    (
                        from entry in eventLogEntryArray
                        where entry.Source == appName
                        orderby entry.TimeGenerated descending
                        select entry
                        )
                    .Take(count);
                foreach (var entry in logs)
                {
                    Console.WriteLine($"Index: {entry.Index} | Time: {entry.TimeGenerated} | Message: {entry.Message}");
                }
            }
            else
            {
                Console.WriteLine(RuntimeInformation.OSDescription);
            }
        }
    }
}
