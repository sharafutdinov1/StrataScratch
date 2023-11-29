-- Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. 
-- For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, 
-- consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . Output the user_id and their average session time.
-- Table: facebook_web_log

select user_id, avg(diff) as res
from
(select user_id, time_exit - time_load as diff
from
(select user_id,
       min(timestamp) filter(where action = 'page_exit') as time_exit,
       max(timestamp) filter(where action = 'page_load') as time_load       
from facebook_web_log
group by user_id, date_trunc('day', timestamp::date)) t) t1
where diff is not null
group by user_id
