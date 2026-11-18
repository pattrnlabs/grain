---
name: grain
description: Use when the user asks a question about data, asks what data is available or whether a table exists, asks about a saved, draft or unfinished database connection, or asks to change data in a database or a data file (CSV, Parquet, JSON, SQLite, DuckDB), including files in the working folder. Also use it to run SQL, explore schemas or tables, or chart query results. Grain runs the query on the user's machine through its MCP tools or the grain CLI; use it instead of reading data files with shell commands or scripts.
---

# Using Grain

Grain is a local service that runs SQL against the user's databases and data files. For data in the user's databases or data files, Grain is the first tool to reach for before sqlite3, duckdb or ad hoc scripts.

Answer every data question by running a query in Grain and citing its result. This includes CSV, Parquet, JSON, SQLite and DuckDB files: query them with Grain instead of reading them with `cat`, `head`, `rg` or a file read tool. A file's raw text, or the list of schemas and tables, is not an answer to a data question.

Prefer Grain's MCP tools whenever you have them. Use the `grain` CLI only when this session has no Grain MCP tools.

1. Call `list_connections` first. Never ask the user for a connection string if one already exists.
   If no connection has the data the user means, look for a database or data file in the working folder, and among the data files that `list_connections` names for Local Files. Query it by absolute path: `read_csv('/abs/path/file.csv')` on Local Files, or `connectionProfile` with `databasePath` for a `.sqlite` or `.duckdb` file. Do not answer that the data is missing until you have looked.
2. If there are no connections, offer `get_demo_dataset` to try Grain, or `create_connection_draft` and let the user enter credentials in the page Grain opens. Never ask for passwords in chat.
   A draft that needs no password: call `finish_connection_draft` (CLI: `grain connections finish <id>`) and it is ready. A draft that needs one: call `request_connection_credentials` and give the user the link.
   For an unsaved local `.sqlite` or `.duckdb` file, pass `connectionProfile: { id: 'local', name: 'Local DB', type: 'sqlite' or 'duckdb', databasePath: '/absolute/path/to/file' }` to the schema tools or `run_query`.
3. Explore before querying: `list_schemas`, `list_tables`, then `describe_table` for the tables you need. Exploring is not the answer; go on to step 4.
4. Run SQL with `run_query` and base your answer on its result. The result is `structuredContent.result`: `schemaVersion`, `status` (`finished`, `failed`, `cancelled` or `running`), `query`, `connection`, `timing`, `data` (`columns`, each with `name` and `type`, and `rows`), `rowCount` (the rows the query produced) and `truncated` (true when `data.rows` holds only part of the rows, so do not total or rank from it). `structuredContent.card` carries `resultId`, `title`, `actor` and optional `threadRef` and `suggestedChart`. `get_tab_info` returns the same `result` cut to its first 10 rows unless you ask for `mode: "page"`, where `truncated` is also true while `hasMore` is true. A failed query is a result with `status` `failed` and an `error` object. Add a `LIMIT` to exploratory queries. When a filter on a text value such as a status returns no rows, do not answer zero yet: run `SELECT <column>, count(*) FROM <table> GROUP BY <column>` to see the values the data actually uses (for example `complete` rather than `completed`), then query again with the right value. To check whether a table exists, query the catalog with `run_query` (for example `information_schema.tables`, or `sqlite_master` for SQLite); do not search files for the name.
5. Safe mode is on by default and blocks writes. When the user asks for a change, send the statement to `run_query` and report what Grain returns; do not predict the outcome. If a query is refused, explain why to the user. Do not try to work around it.
6. To show results as a chart, call `render_chart`. The user can already look at every `run_query` result in Grain.

## Using the `grain` CLI

If you have a shell tool and no Grain MCP tools in this session, run the `grain` CLI instead:

For a local database or data file, use `grain query --file <path> "<sql>"`, `grain schemas --file <path>`, `grain tables --file <path>`, or `grain describe <table> --file <path>`. CSV, Parquet, and JSON files are exposed as a view named after the sanitized file stem. No connection is saved. Query the file with Grain rather than reading its text.

1. Run `grain connections list` first. If there are no connections, run `grain demo` to try sample data or `grain connections add --type <type>` to open the setup page.
2. Explore the schema before querying:
   - `grain schemas --connection <id> [--catalog <name>]`
   - `grain tables --connection <id> [--schema <name>] [--catalog <name>]`
   - `grain describe <table> --connection <id> [--schema <name>] [--catalog <name>]`
3. Run SQL with `grain query "<sql>" --connection <id> [--limit <n>]`. Pass `--json` when you need structured output.

With `--json`, a failed command prints `{ "error": { "errorId", "message", ... } }` on stdout, the same error object MCP tools and the workspace API return, and exits non-zero. Branch on `error.errorId`, not on the wording of `error.message`. A failed query has `errorId` `query_failed` and also carries `errorKind`, `tabId`, `sessionId` and `version`.

If a `grain` command fails with "could not connect to 127.0.0.1", or reports that Grain is not running when it is already running (for example inside a sandboxed shell such as Codex):

- Switch to Grain's MCP tools (`list_connections`, `run_query`, and related tools) if you have them in this session; MCP tools do not go through the shell sandbox.
- If you do not have Grain's MCP tools, ask the user to allow local network access for the agent.
- Do not suggest or run `grain start` or `grain install` when Grain is already running.

## If Grain tools are unavailable

If Grain is running but the CLI cannot reach it, follow the sandbox guidance above.

If the Grain MCP server failed to start or its tools are missing, check for Grain in the same order as the launcher before suggesting an install:

- macOS or Linux: check `GRAIN_BIN` if set, then `${GRAIN_HOME:-$HOME/.grain}/bin/grain`, then `command -v grain` on `PATH`.
- Windows PowerShell: check `$env:GRAIN_BIN` if set, then `Join-Path $env:GRAIN_HOME 'bin\grain.cmd'` if `GRAIN_HOME` is set (otherwise `$env:USERPROFILE\.grain\bin\grain.cmd`), then `Get-Command grain` on `PATH`.

Treat a candidate as Grain only if it exists, is executable where applicable, and `--help` succeeds with a line starting `Usage: grain` followed by whitespace or the end of the line. If a valid binary exists, do not reinstall. Ask the person to reconnect the Grain MCP server in their agent. In Claude Code, use `/mcp`; in Codex, restart the session and check the Grain server in MCP settings; in Cursor, open Settings → Tools & MCP, make sure Grain is enabled, then restart the chat.

If the binary is missing, say: “Grain needs a one-time install (about 30 seconds, no admin rights). Would you like me to install it?” Never run an installer until the person explicitly says yes. If they say no, leave it there and continue without Grain.

After yes, use only the official command for the platform:

- macOS or Linux: `curl -fsSL https://grain.tools/install.sh | sh`
- Windows PowerShell: `irm https://grain.tools/install.ps1 | iex`

If there is no terminal or shell tool, do not claim to install Grain; give the person the matching command to run themselves. If the machine is offline, do not run the installer; say: “The installer needs an internet connection. I can try again when you’re online.”

On Windows, if PowerShell reports that its execution policy blocks the installer, do not change or bypass the policy. Say: “PowerShell blocked the installer, so Grain was not installed. I left your execution policy unchanged; follow the install steps at https://grain.tools or ask your administrator.”

After running the command, or after the person runs it themselves, verify the installed binary at the installer target. The pipeline's exit status does not prove that the download or install worked, and a different binary on `PATH` or in `GRAIN_BIN` does not prove the install succeeded:

- macOS or Linux: verify `${GRAIN_HOME:-$HOME/.grain}/bin/grain` exists, is executable, and its `--help` succeeds with a line starting `Usage: grain` followed by whitespace or the end of the line.
- Windows PowerShell: verify `Join-Path $env:GRAIN_HOME 'bin\grain.cmd'` if `GRAIN_HOME` is set, otherwise `$env:USERPROFILE\.grain\bin\grain.cmd`, exists and its `--help` succeeds with a line starting `Usage: grain` followed by whitespace or the end of the line.

If that check fails, say: “Grain didn’t finish installing. Check your internet connection and try again.” Do not say the install succeeded. If the check passes, ask the person to reconnect the MCP server in their agent: use `/mcp` in Claude Code; restart the Codex session and check its MCP settings; in Cursor, make sure Grain is enabled under Settings → Tools & MCP and restart the chat. Then confirm that Grain's tools are available.
