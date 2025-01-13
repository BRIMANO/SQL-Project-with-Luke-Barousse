/*
PURPOSE: To highlight the top paying oppotunities for data scientist.
What are the top paying data scientist jobs?
Identify the top 10 highest paying data scientist role that are available remotely.
Focuses on job postings with specified salaries (remove nulls).
*/

SELECT
    job_id,
    job_posted_date,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist'    -- you can change this to any other job title
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'         -- you can change this to any other location
ORDER BY
    salary_year_avg DESC
LIMIT 50;