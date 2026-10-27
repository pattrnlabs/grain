using System;
using System.Diagnostics;
using System.IO;

internal static class GrainMcpWindows
{
    private static int Main()
    {
        var script = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "grain-mcp.cmd");
        var commandProcessor = Environment.GetEnvironmentVariable("ComSpec");
        if (String.IsNullOrEmpty(commandProcessor))
        {
            commandProcessor = "cmd.exe";
        }

        var start = new ProcessStartInfo();
        start.FileName = commandProcessor;
        start.Arguments = "/d /s /c \"\"" + script + "\"\"";
        start.UseShellExecute = false;

        using (var process = Process.Start(start))
        {
            process.WaitForExit();
            return process.ExitCode;
        }
    }
}
