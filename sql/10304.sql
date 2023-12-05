-- Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.
-- You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, then the total half-year salary of all employees assigned to the project should not exceed $10K. 
-- Salary is defined on a yearly basis, so be careful how to calculate salaries for the projects that last less or more than one year.
-- Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).
-- HINT: to make it simpler, consider that all years have 365 days. You don't need to think about the leap years.

Tables: linkedin_projects, linkedin_emp_projects, linkedin_employees

with main_table as (
select p.id as  p_id,
       p.title as p_title,
       p.budget p_budget,
       (p.end_date - p.start_date) as p_duration,
       ep.emp_id as emp_id,
       e.salary/365.0 as daily_emp_salary,
       e.salary/365.0 * (p.end_date - p.start_date) as emp_salary_for_p
from linkedin_projects p
left join linkedin_emp_projects ep on p.id = ep.project_id
left join linkedin_employees e on ep.emp_id = e.id 
order by p_id)

select p_title, p_budget, ceil( sum(emp_salary_for_p)) as p_cost
from main_table
group by p_title, p_budget
having p_budget < sum(emp_salary_for_p)
order by p_title
