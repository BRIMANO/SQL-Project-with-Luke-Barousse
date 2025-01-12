-- PRACTICE QUESTIONS 6


SELECT
    job_schedule_type AS schedule,
    job_posted_date AS date_day,
    ROUND(AVG(salary_year_avg), 2) AS mean_year_salary,
    ROUND(AVG(salary_hour_avg), 2) AS mean_hour_salary
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    schedule,
    date_day,
    salary_year_avg,
    salary_hour_avg
ORDER BY
    salary_year_avg,
    salary_hour_avg



SELECT 
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'AMERICA/NEW_YORK' AS date_day,
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_posted_date >= '2023-01-01' 
    AND job_title = 'Data Analyst'
GROUP BY
    job_posted_date,
    month
ORDER BY
    month DESC;



SELECT 
    job_postings_fact.company_id,
    company_dim.name,
    job_postings_fact.job_health_insurance,
    EXTRACT(QUARTER FROM job_posted_date) AS quarter
FROM
    job_postings_fact
INNER JOIN
    company_dim
ON
    job_postings_fact.company_id = company_dim.company_id
WHERE
    job_posted_date >= '2023-01-01'
    AND job_posted_date <= '2023-12-31'
    AND job_health_insurance = 'Yes'
GROUP BY
    job_postings_fact.company_id,
    company_dim.name,
    job_health_insurance,
    quarter
HAVING
    EXTRACT(QUARTER FROM job_posted_date) = 2
ORDER BY
    quarter;





-- CREATE TABLES FROM EXISTING TABLE
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS    
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;          

CREATE TABLE march_jobs AS                
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

CREATE TABLE april_jobs AS              
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

CREATE TABLE may_jobs AS                                    
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

CREATE TABLE june_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

CREATE TABLE july_jobs AS    
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

CREATE TABLE august_jobs AS               
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

CREATE TABLE september_jobs AS            
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

CREATE TABLE october_jobs AS          
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

CREATE TABLE november_jobs AS     
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 11;


CREATE TABLE december_jobs AS    
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 12; 


--CASE WHEN STATEMENT
SELECT 
    COUNT(job_id) AS job_count,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Paris, France' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category;



SELECT 
    COUNT(job_id) AS job_count,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High'
        WHEN salary_year_avg >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_category
ORDER BY
    job_count;



-- Subqueries and CTEs

WITH remote_jobs_skills AS (
SELECT
    skill_id,
    COUNT(*) AS skill_count 
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS jobs_postings ON jobs_postings.job_id = skills_to_job.job_id
WHERE
    jobs_postings.job_work_from_home = TRUE
    AND jobs_postings.job_title_short = 'Data Analyst'
GROUP BY
    skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM
    remote_jobs_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_jobs_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;



--UNION ALLand UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs



SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs



SELECT
    job_title_short,
    job_posted_date::date,
    job_location,
    salary_year_avg
FROM (
SELECT *
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_posted_date >= '2023-01-01'
    AND job_posted_date <= '2023-01-31'

UNION ALL

SELECT *
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_posted_date >= '2023-02-01'
    AND job_posted_date <= '2023-02-28'
    
UNION ALL

SELECT *
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_posted_date >= '2023-03-01'
    AND job_posted_date <= '2023-03-31'
)
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'




SELECT
    job_title_short,
    job_posted_date::date,
    job_location,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter_jobs
WHERE
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;
