-- You are given a table of product launches by company by year. Write a query to count the net difference between the number of products companies launched in 2020 with the number of products companies launched in the previous year. 
-- Output the name of the companies and a net difference of net products released for 2020 compared to the previous year.
-- Table: car_launches

with agg_car_launches as
(select cl.year, 
        cl.company_name, 
        count(cl.product_name) as cnt
from car_launches cl
group by cl.year, 
       cl.company_name
order by cl.company_name, year)

select company_name,
       cnt - lag_cnt as diff
from
(select acl.year, 
       acl.company_name, 
       acl.cnt,
       lag(acl.cnt) over(partition by acl.company_name order by acl.year) as lag_cnt
from agg_car_launches acl) t
where lag_cnt is not null
