# Using Grain from an AI agent

Grain can serve your database connections to Claude Code, Cursor, and GitHub
Copilot over MCP. Agents use the connections you've already set up in Grain,
and every query an agent runs shows up in your Grain results panel.

## Setup

1. Install [Grain](https://marketplace.visualstudio.com/items?itemName=pattrnlabs.grain).
2. Turn on `grain.mcpEnabled` in VS Code settings. MCP is off by default.
3. Follow the steps for your client in the [MCP docs](https://grain.tools/docs/mcp).

To check the server is reachable, run **Grain: Test MCP Server Connection**.

## What an agent can do

- Run queries against your connections
- Explore a database: schemas, tables, and column types
- Inspect result tabs, cancel a long query, or close a tab
- List and manage connection profiles, without ever seeing a stored password

With `grain.mcpSafeMode` on (the default), agents can only run read-only SQL:
`SELECT`, `SHOW`, `DESCRIBE`, `EXPLAIN`, `WITH`, and metadata queries.

See [`prompts.md`](prompts.md) for prompts that work well once you're connected.
