-- Find the 3 most profitable companies in the entire world.
-- Output the result along with the corresponding company name.
-- Sort the result based on profits in descending order.

-- Table: forbes_global_2010_2014

select company, sum(profits) as prof
from forbes_global_2010_2014
group by company
order by prof desc 
limit 3
