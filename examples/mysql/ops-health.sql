-- MySQL: ops health checks
-- Run these against your app database when something feels slow or stuck.

-- Queries running longer than 5 minutes right now
select
  id,
  time as running_for_seconds,
  state,
  left(info, 200) as query
from information_schema.processlist
where command != 'Sleep'
  and time > 300
order by time desc;

-- Table sizes — biggest first
select
  table_schema,
  table_name,
  round((data_length + index_length) / 1024 / 1024, 1) as size_mb,
  table_rows
from information_schema.tables
where table_schema not in ('information_schema', 'mysql', 'performance_schema', 'sys')
order by (data_length + index_length) desc
limit 20;

-- Connections by user — find what's hammering the database
select
  user,
  count(*) as connections
from information_schema.processlist
group by user
order by connections desc;
