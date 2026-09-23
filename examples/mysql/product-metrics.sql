-- MySQL: product metrics
-- Reporting-style queries against typical SaaS app tables.
-- Adjust table/column names to match your schema.

-- Daily signups, last 30 days
select
  date(created_at) as signup_date,
  count(*) as signups
from users
where created_at >= now() - interval 30 day
group by 1
order by 1;

-- Weekly active accounts (distinct account_id with an event in the last 7 days)
select
  count(distinct account_id) as weekly_active_accounts
from events
where occurred_at >= now() - interval 7 day;

-- Revenue by plan, current month
select
  plan_name,
  count(*) as subscriptions,
  sum(amount_cents) / 100.0 as revenue
from subscriptions
where status = 'active'
  and date_format(started_at, '%Y-%m') = date_format(curdate(), '%Y-%m')
group by plan_name
order by revenue desc;
