# Grain

**A fast SQL workspace for VS Code — and for the AI agents you work with.**

[Docs](https://grain.tools/docs) · [Changelog](CHANGELOG.md) · [Report a bug](https://github.com/pattrnlabs/grain/issues/new?template=01-bug-report.yml) · [Ask a question](https://github.com/pattrnlabs/grain/issues/new?template=04-question.yml)

[![VS Code Marketplace](https://vsmarketplacebadges.dev/version/pattrnlabs.grain.svg)](https://marketplace.visualstudio.com/items?itemName=pattrnlabs.grain)
[![Installs](https://vsmarketplacebadges.dev/installs/pattrnlabs.grain.svg)](https://marketplace.visualstudio.com/items?itemName=pattrnlabs.grain)
<!-- TODO(open item): confirm Open VSX is live before publishing this badge -->
[![OpenVSX](https://img.shields.io/open-vsx/v/pattrnlabs/grain?label=OpenVSX&color=a60ee5)](https://open-vsx.org/extension/pattrnlabs/grain)
[![Closed issues](https://img.shields.io/github/issues-closed/pattrnlabs/grain?color=green)](https://github.com/pattrnlabs/grain/issues?q=is%3Aissue+is%3Aclosed)

Open a `.sql` file, press `Ctrl+Enter`, and read the results in a real grid —
without leaving the editor. Nine databases, credentials in your OS keychain,
nothing sent anywhere.

<!-- HERO GIF -->

![Run a query in Grain](media/demo/hero-run-query.gif)

---

## Quick Start

1. Install Grain from the
   [Marketplace](https://marketplace.visualstudio.com/items?itemName=pattrnlabs.grain)
   or [OpenVSX](https://open-vsx.org/extension/pattrnlabs/grain).
   <!-- TODO(open item): drop the OpenVSX link if not live at launch -->
2. Open a folder in VS Code — Grain puts a demo dataset there.
3. Open the **Grain** panel and click **Try the Demo**.
4. Press **`Ctrl+Enter`** (**`Cmd+Enter`** on macOS) on any query in the file
   that opens.

That's a real query against real data, no connection or credentials needed.
When you want your own database, run **Grain: Manage Connections** — add a
profile, set its password, test it, make it active.

![The Grain panel, annotated](media/demo/panel-annotated.png)

---

## Your AI agent, same grid

Grain exposes your databases to AI coding agents — Claude Code, Cursor,
GitHub Copilot — as **read-only** MCP tools, using the connections you've
already set up. When an agent runs a query, the result lands in your VS Code
results panel next to the ones you ran yourself.

<!-- TODO(open item): the setup steps and command below need to match the
     shipped MCP flow exactly — confirm before publishing. See
     examples/agents/README.md for the per-client breakdown. -->

Setup takes one command from the Grain panel: **Grain: Connect an AI Agent**,
then pick your client. Full walkthrough and example prompts:
[`examples/agents/`](examples/agents/).

---

## Features

| Feature | What it does |
| --- | --- |
| Run SQL from the editor | `Ctrl+Enter` on any `.sql` file, results in a panel beside your code |
| Connection manager | Create, test, and switch database profiles; passwords in the OS keychain |
| Tabbed result grid | Sort, filter, adjust density, copy TSV, export every row to CSV/TSV/JSON |
| Your AI agent, same grid | Read-only MCP tools for Claude, Cursor, and Copilot — their queries show up in your results panel |
| Nine databases | Postgres, MySQL, Elasticsearch, Snowflake, BigQuery, DuckDB, and more |
| Local-first by design | No hosted service, no bundled model, no credentials in config files |

---

## Supported databases

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-005571?style=flat&logo=elasticsearch&logoColor=white)
![DuckDB](https://img.shields.io/badge/DuckDB-FFF000?style=flat&logo=duckdb&logoColor=black)
![SQLite](https://img.shields.io/badge/SQLite-003B57?style=flat&logo=sqlite&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![BigQuery](https://img.shields.io/badge/BigQuery-669DF6?style=flat&logo=googlebigquery&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![Trino](https://img.shields.io/badge/Trino%2FPresto-DD00A1?style=flat)

**Bundled with the extension** — nothing else to install: PostgreSQL · Trino / Presto

**Lazy-loaded** — may need their driver runtime in your environment: MySQL ·
SQLite · DuckDB · Elasticsearch · Snowflake · BigQuery · SQL Server

When a driver is missing, Grain reports a guided error telling you what to
install rather than failing silently.

Database you need isn't here? [Request a connector](https://github.com/pattrnlabs/grain/issues/new?template=03-connector-request.yml) —
connector demand is how we prioritize what to build next.

---

## Examples

Runnable queries by database, plus AI agent setup, live in
[`/examples`](examples/): [Postgres](examples/postgres/) ·
[MySQL](examples/mysql/) · [Elasticsearch](examples/elasticsearch/) ·
[DuckDB](examples/duckdb/) · [Agents](examples/agents/).

---

## Local-first by design

- **Read-only by default.** Safe mode restricts agents to `SELECT`, `SHOW`,
  `DESCRIBE`, `EXPLAIN`, `WITH`, and metadata queries.
- **Agents can't touch your credentials.** An agent cannot change saved
  connections or read stored passwords.
- **Nothing leaves your machine.** No hosted Grain service, no bundled AI
  model. Credentials live in your OS keychain or VS Code Secret Storage,
  never in a config file.

---

## Docs

- [grain.tools/docs](https://grain.tools/docs) — installation, connectors, MCP setup
- [CHANGELOG.md](CHANGELOG.md) — release history

## Getting help

- **Found a bug?** [File a bug report](https://github.com/pattrnlabs/grain/issues/new?template=01-bug-report.yml)
- **Want a feature?** [File a feature request](https://github.com/pattrnlabs/grain/issues/new?template=02-feature-request.yml)
- **Need a connector?** [Request one](https://github.com/pattrnlabs/grain/issues/new?template=03-connector-request.yml)
- **Have a question?** [File a question issue](https://github.com/pattrnlabs/grain/issues/new?template=04-question.yml) — check the [docs](https://grain.tools/docs) first, a lot of these are answered there

We don't have a rigid roadmap yet — what gets built next is shaped largely by
what shows up here, especially connector requests.

See [CONTRIBUTING.md](CONTRIBUTING.md) for more on filing a good issue.

## License

Grain is closed-source. See [LICENSE](LICENSE).
