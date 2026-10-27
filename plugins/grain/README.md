# Grain plugin

Gives Claude Code, Codex and Cursor the Grain MCP server and a skill that teaches the agent to use it.

The MCP server connects to the Grain installation managed by the Grain installer. It does not bundle or install a second copy of Grain, and it does not require Node.js. The plugin checks `GRAIN_BIN`, then the installer home (`GRAIN_HOME`, defaulting to `~/.grain`), then a `grain` command on `PATH`. A candidate must identify itself with the Grain CLI's `Usage: grain` help output before the plugin starts it. Install Grain with `curl -fsSL https://grain.tools/install.sh | sh` on macOS or Linux, or `irm https://grain.tools/install.ps1 | iex` in PowerShell on Windows. If Grain is installed outside the default location, set `GRAIN_HOME` to its home directory or `GRAIN_BIN` to its CLI path.

## Privacy Policy

Grain runs on your machine. Queries, results and credentials stay on your machine and are not sent to Pattrnlabs. Grain sends anonymous usage telemetry, which you can turn off. Full policy: https://grain.tools/privacy. Contact: hi@pattrnlabs.com.

## License

Grain is proprietary software. See https://github.com/pattrnlabs/grain/blob/main/LICENSE.
