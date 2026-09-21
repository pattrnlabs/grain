-- Postgres: ops health checks
-- Run these against your app database when something feels slow or stuck.
-- Grain: open this file, put your cursor in a query, Ctrl+Enter (Cmd+Enter on macOS).

-- Queries running longer than 5 minutes right now
select
  pid,
  now() - query_start as running_for,
  state,
  wait_event_type,
  left(query, 200) as query
from pg_stat_activity
where state != 'idle'
  and query_start < now() - interval '5 minutes'
order by running_for desc;

-- Table and index bloat estimate — biggest tables first
select
  schemaname,
  relname as table_name,
  pg_size_pretty(pg_total_relation_size(relid)) as total_size,
  pg_size_pretty(pg_relation_size(relid)) as table_size,
  pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as index_size
from pg_catalog.pg_statio_user_tables
order by pg_total_relation_size(relid) desc
limit 20;

-- Active connections by application_name — find what's hammering the database
select
  application_name,
  state,
  count(*) as connections
from pg_stat_activity
group by application_name, state
order by connections desc;
