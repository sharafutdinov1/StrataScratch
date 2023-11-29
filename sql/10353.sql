-- You have been asked to find the job titles of the highest-paid employees.
-- Your output should include the highest-paid title or multiple titles with the same salary.
-- Tables: worker, title

select worker_title
from
(select worker_title,
       salary,
       rank() over(order by salary desc) as rn
from
(select t.worker_title,
       w.salary
from worker w
left join title t on w.worker_id = t.worker_ref_id) t) t1
where rn = 1
