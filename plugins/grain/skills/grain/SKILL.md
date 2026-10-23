---
name: grain
description: Use when the user asks about data in a database, wants to run SQL, explore schemas or tables, or chart query results. Grain runs the query on the user's machine through its MCP tools.
---

# Using Grain

Grain is a local service that runs SQL against the user's databases. The `grain` MCP server in this plugin exposes it.

1. Call `list_connections` first. Never ask the user for a connection string if one already exists.
2. If there are no connections, offer `get_demo_dataset` to try Grain, or `create_connection_draft` and let the user enter credentials in the page Grain opens. Never ask for passwords in chat.
3. Explore before querying: `list_schemas`, `list_tables`, then `describe_table` for the tables you need.
4. Run SQL with `run_query`. Add a `LIMIT` to exploratory queries.
5. Safe mode is on by default and blocks writes. If a query is refused, explain why to the user. Do not try to work around it.
6. To show results as a chart, call `render_chart`. To let the user look at results themselves, call `open_result_view`.

If a tool reports that Grain is not running or not installed, tell the user to run `grain install`, which installs Grain as a background service. See https://grain.tools.
