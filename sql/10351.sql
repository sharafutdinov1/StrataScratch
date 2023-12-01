-- Find the email activity rank for each user. Email activity rank is defined by the total number of emails sent. 
-- The user with the highest number of emails sent will have a rank of 1, and so on. Output the user, total emails, and their activity rank. Order records by the total emails in descending order. 
-- Sort users with the same number of emails in alphabetical order.
-- In your rankings, return a unique value (i.e., a unique rank) even if multiple users have the same number of emails. For tie breaker use alphabetical order of the user usernames.

select t.from_user as user,
       t.cnt_sent,
       row_number() over(order by t.cnt_sent desc, t.from_user) as rn
from
(select gge.from_user,
      count(gge.id) as cnt_sent
from google_gmail_emails gge
group by gge.from_user) t
