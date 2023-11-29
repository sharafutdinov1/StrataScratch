-- Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.
-- Tables: db_employee, db_dept

select max(salary) filter(where department = 'marketing')
      - max(salary) filter(where department = 'engineering') as diff_salary
from
(select e.id,
       e.salary,
       d.department
from db_employee e
left join db_dept d
on e.department_id = d.id) t
