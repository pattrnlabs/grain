# Using Grain from an AI agent

Grain exposes your database connections to AI coding agents through MCP
(Model Context Protocol) — read-only by default, using the same connections
you've already set up in the editor. Queries an agent runs show up in your
results panel, the same as if you'd run them yourself.

<!-- TODO(open item, see plan doc): confirm exact MCP setup steps per client
     — this repo's onboarding notes say install is two steps (Grain, then its
     MCP server) as of the 09-17 sync. Update this file to match the shipped
     flow before publishing. -->

## Claude Code

1. Install the [Grain extension](https://marketplace.visualstudio.com/items?itemName=pattrnlabs.grain)
2. Run **Grain: Connect an AI Agent** from the command palette
3. Follow the prompt to register Grain's MCP server with Claude Code

## Cursor

1. Install Grain from [Open VSX](https://open-vsx.org/extension/pattrnlabs/grain)
   <!-- TODO(open item): confirm Open VSX is live before publishing this link -->
2. Run **Grain: Connect an AI Agent**, select Cursor

## GitHub Copilot

Copilot picks up Grain's MCP tools automatically once Grain is installed and
a connection is active — no extra setup step.

## What the agent can do

- List your saved connections and their schemas
- Run read-only queries against an active connection
- See table structure before writing a query

The agent uses your existing per-connection permissions — if a connection is
read-only in Grain, it's read-only for the agent too.

See `prompts.md` in this folder for prompts that work well once you're
connected.
