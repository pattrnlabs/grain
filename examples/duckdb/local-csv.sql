-- DuckDB: query a local CSV, no database or connection needed
-- This is the fastest way to try Grain — open this file and press Ctrl+Enter.

-- Point read_csv_auto at any CSV on your machine
select *
from read_csv_auto('sales.csv')
limit 20;

-- Aggregate straight over the file, no import step
select
  category,
  count(*) as orders,
  sum(amount) as revenue
from read_csv_auto('sales.csv')
group by category
order by revenue desc;

-- Join two CSVs directly
select
  o.order_id,
  o.amount,
  c.customer_name
from read_csv_auto('sales.csv') o
join read_csv_auto('customers.csv') c
  on o.customer_id = c.customer_id
limit 20;
