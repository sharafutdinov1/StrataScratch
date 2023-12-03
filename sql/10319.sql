-- Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
-- The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
-- The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.
-- Table: sf_transactions

with revenue_table as
(SELECT 
    to_char(created_at,'YYYY-MM') as year_month,
    sum(value) as revenue,
    lag(sum(value)) over(order by to_char(created_at,'YYYY-MM')) as last_revenue
from sf_transactions
group by year_month)

select 
    year_month,
    round((revenue::decimal - last_revenue)/last_revenue*100, 2) as percentage_diff
from revenue_table
order by year_month
