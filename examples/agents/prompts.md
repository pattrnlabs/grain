# Prompts that work well against a connected database

A few starting points once your agent has access through Grain's MCP tools.

## Understanding a schema

> What tables are in the `public` schema, and how are they related?

> Show me the columns and types on the `orders` table.

## Debugging

> Query the `events` table for anything with `status = 'failed'` in the
> last hour. Summarize what's failing.

## Writing a query for you

> Write a query that finds users who signed up in the last 30 days but
> haven't logged an event since. Run it and show me the count.

## Iterating

> That query works — now break it down by signup week instead of one total.
