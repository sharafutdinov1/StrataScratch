-- Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
-- Output a list of user_ids of these returning active users.
-- Table: amazon_transactions

select distinct t.user_id
from
(select at.user_id,
       created_at,
       lag(created_at) over(partition by user_id order by created_at) as lag_created_at,
       created_at - lag(created_at) over(partition by user_id order by created_at) as day_diff
from amazon_transactions at
order by user_id, created_at) t
where day_diff <=7
order by t.user_id
