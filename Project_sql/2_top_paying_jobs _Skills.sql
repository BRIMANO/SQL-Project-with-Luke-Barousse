-- Get to know the skills required for the top paying jobs in the market
-- Helps job seekers to understand the skills to develop to get a job

WITH top_paying_jobs AS (
    SELECT
        job_id,
        name AS company_name,
        job_title,
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
    LIMIT 50
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;




/***Brief Report on Data Science Skills Analysis***

#### **1. Most Frequent Data Science Skills**
- The top 10 skills frequently required for data science roles include SQL, Python, and Tableau.
- These skills are foundational and reflect the industry's demand for data manipulation, analysis, and visualization capabilities.

#### **2. Skills by Average Salary**
- The highest-paying skills include advanced tools like TensorFlow, PyTorch, and Snowflake.
- These tools are often associated with specialized roles in machine learning, AI, and cloud-based data engineering, leading to higher salaries.

#### **3. Skills by Job Title**
- **Data Scientist**: Frequently associated with SQL and Python, which are essential for data querying and programming.
- **Head of Data Science**: Involves more strategic tools like Tableau and Spark, highlighting leadership and big data responsibilities.
- **Staff Data Scientist**: Shows a mix of technical expertise with tools like TensorFlow and Scikit-learn for machine learning tasks.

#### **4. Skills by Company**
- Companies often have specific skill preferences:
  - **Algo Capital Group**: Focuses on SQL and Spark for big data tasks.
  - **Braintrust**: Requires a combination of Python and AWS, indicating cloud and programming integration.

#### **Key Insights**
- Proficiency in SQL and Python is indispensable for most data science roles.
- Advanced skills in machine learning frameworks like TensorFlow and PyTorch command higher salaries.
- Companies' skill requirements vary based on their domain focus, such as cloud, AI, or big data. 