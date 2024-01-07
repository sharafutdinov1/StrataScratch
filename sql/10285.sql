-- What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest.
-- Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. 
-- If the request is accepted, the table logs action = 'accepted'. If the request is not accepted, no record of action = 'accepted' is logged.

-- Table: fb_friend_requests

with request_tabe as
(select
    date, user_id_sender, user_id_receiver,
    count(action) as request
from fb_friend_requests
where action = 'sent'
group by date, user_id_sender, user_id_receiver),
accepted_table as
(select
    user_id_sender, user_id_receiver,
    count(action) as confirm
from fb_friend_requests
where action = 'accepted'
group by date, user_id_sender, user_id_receiver),
main_table as
(select r.date, r.user_id_sender, r.user_id_receiver, a.confirm, r.request
from request_tabe r
left join accepted_table a on r.user_id_sender = a.user_id_sender and r.user_id_receiver = a.user_id_receiver)
select 
    date,
    sum(confirm) / sum(request)
from main_table
group by date
order by date
