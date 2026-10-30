---
name: grain
description: Use when the user asks about data in a database or data files, wants to run SQL, explore schemas or tables, or chart query results. Grain runs the query on the user's machine through its MCP tools or the grain CLI.
---

# Using Grain

Grain is a local service that runs SQL against the user's databases and data files. For data in the user's databases or data files, Grain is the first tool to reach for before sqlite3, duckdb or ad hoc scripts.

1. Call `list_connections` first. Never ask the user for a connection string if one already exists.
2. If there are no connections, offer `get_demo_dataset` to try Grain, or `create_connection_draft` and let the user enter credentials in the page Grain opens. Never ask for passwords in chat.
   For an unsaved local `.sqlite` or `.duckdb` file, pass `connectionProfile: { id: 'local', name: 'Local DB', type: 'sqlite' or 'duckdb', databasePath: '/absolute/path/to/file' }` to the schema tools or `run_query`.
3. Explore before querying: `list_schemas`, `list_tables`, then `describe_table` for the tables you need.
4. Run SQL with `run_query`. Add a `LIMIT` to exploratory queries.
5. Safe mode is on by default and blocks writes. If a query is refused, explain why to the user. Do not try to work around it.
6. To show results as a chart, call `render_chart`. To let the user look at results themselves, call `open_result_view`.

## Using the `grain` CLI

If you have a shell tool and no Grain MCP tools in this session, run the `grain` CLI instead:

1. Run `grain connections list` first. If there are no connections, run `grain demo` to try sample data or `grain connections add --type <type>` to open the setup page.
2. Explore the schema before querying:
   - `grain schemas --connection <id> [--catalog <name>]`
   - `grain tables --connection <id> --schema <name> [--catalog <name>]`
   - `grain describe <table> --connection <id> --schema <name> [--catalog <name>]`
3. Run SQL with `grain query "<sql>" --connection <id> [--limit <n>]`. Pass `--json` when you need structured output.

If `grain` CLI commands cannot reach `127.0.0.1` or report that Grain is not running when Grain is already running (for example inside a sandboxed shell that blocks localhost):

- Use Grain's MCP tools (`list_connections`, `run_query`, and related tools) if you have them in this session; MCP tools do not go through the shell sandbox.
- If you do not have Grain's MCP tools, ask the user to allow local network access for the agent.
- Do not suggest or run `grain start` or `grain install` when Grain is already running.

## If Grain tools are unavailable

If Grain is running but the CLI cannot reach it, follow the sandbox guidance above.

If the Grain MCP server failed to start or its tools are missing, check for Grain in the same order as the launcher before suggesting an install:

- macOS or Linux: check `GRAIN_BIN` if set, then `${GRAIN_HOME:-$HOME/.grain}/bin/grain`, then `command -v grain` on `PATH`.
- Windows PowerShell: check `$env:GRAIN_BIN` if set, then `Join-Path $env:GRAIN_HOME 'bin\grain.cmd'` if `GRAIN_HOME` is set (otherwise `$env:USERPROFILE\.grain\bin\grain.cmd`), then `Get-Command grain` on `PATH`.

If the binary exists, do not reinstall. Ask the person to reconnect the Grain MCP server in their agent. In Claude Code, use `/mcp`; in Codex, restart the session and check the Grain server in MCP settings; in Cursor, open Settings → Tools & MCP, make sure Grain is enabled, then restart the chat.

If the binary is missing, say: “Grain needs a one-time install (about 30 seconds, no admin rights). Would you like me to install it?” Never run an installer until the person explicitly says yes. If they say no, leave it there and continue without Grain.

After yes, use only the official command for the platform:

- macOS or Linux: `curl -fsSL https://grain.tools/install.sh | sh`
- Windows PowerShell: `irm https://grain.tools/install.ps1 | iex`

If there is no terminal or shell tool, do not claim to install Grain; give the person the matching command to run themselves. If the machine is offline, do not run the installer; say: “The installer needs an internet connection. I can try again when you’re online.”

On Windows, if PowerShell reports that its execution policy blocks the installer, do not change or bypass the policy. Say: “PowerShell blocked the installer, so Grain was not installed. I left your execution policy unchanged; follow the install steps at https://grain.tools or ask your administrator.”

After running the command, repeat the same checks in the same order (`GRAIN_BIN`, then `GRAIN_HOME` or the default home, then `PATH`); the pipeline's exit status does not prove that the download or install worked:

- macOS or Linux: check `GRAIN_BIN` if set, then `${GRAIN_HOME:-$HOME/.grain}/bin/grain`, then `command -v grain` on `PATH`.
- Windows PowerShell: check `$env:GRAIN_BIN` if set, then `Join-Path $env:GRAIN_HOME 'bin\grain.cmd'` if `GRAIN_HOME` is set (otherwise `$env:USERPROFILE\.grain\bin\grain.cmd`), then `Get-Command grain` on `PATH`.

If the check fails, say: “Grain didn't finish installing. Check your internet connection and try again.” Do not say the install succeeded. If the binary exists, ask the person to reconnect the MCP server in their agent: use `/mcp` in Claude Code; restart the Codex session and check its MCP settings; in Cursor, make sure Grain is enabled under Settings → Tools & MCP and restart the chat. Then confirm that Grain's tools are available.
