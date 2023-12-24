-- Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. 
-- The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.

-- Tables: ms_user_dimension, ms_acc_dimension, ms_download_facts

with orders as
(select 
    df.date,
    df.user_id,
    df.downloads,
    ad.paying_customer
from ms_download_facts df
left join ms_user_dimension ud on df.user_id = ud.user_id
left join ms_acc_dimension ad on ud.acc_id = ad.acc_id)

select 
    date, non_paying_downloads, paying_downloads 
from
(select 
    o.date,
    sum(case when o.paying_customer = 'yes' then o.downloads else 0 end) as paying_downloads,
    sum(case when o.paying_customer = 'no' then o.downloads else 0 end) as non_paying_downloads
from orders o
group by o.date
order by o.date) t
where non_paying_downloads > paying_downloads
order by date
