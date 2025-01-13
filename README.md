# INTRODUCTION
In the ever-evolving landscape of data-driven industries, the role of data scientists has become pivotal. Organizations across sectors are leveraging data to drive decisions, optimize operations, and innovate their products and services. Consequently, the demand for skilled data scientists has surged, with competitive salaries and specialized roles reflecting the critical nature of these professionals in today's market.

This project delves into the data job market, focusing on the role of data scientists. The analysis explores several key aspects to provide insights into the trends shaping the industry:

**Top-Paying Jobs:** Identifying the roles and organizations offering the highest salaries to data scientists, shedding light on what drives compensation in these positions.

**Most In-Demand Skills:** Highlighting the technical and domain-specific skills that employers prioritize, such as programming languages, machine learning frameworks, cloud platforms, and visualization tools.

**Highest Salaries by Skill:** Analyzing which technical proficiencies lead to the most lucrative opportunities, providing valuable guidance for individuals looking to enhance their skillsets.

Through this analysis, the project aims to uncover trends, patterns, and actionable insights for aspiring data scientists, recruiters, and organizations navigating the competitive data job market. By combining data on job titles, skills, salaries, and demand, this project serves as a comprehensive resource to understand the dynamics of one of the fastest-growing fields in the tech industry.

Find the SQL queries here: [Project_sql folder](/Project_sql/)

# BACKGROUND
The rapid digital transformation across industries has elevated the importance of data as a strategic asset. Businesses now rely on data scientists to extract meaningful insights, predict trends, and develop data-driven solutions. With the exponential growth of data, roles in the field of data science have expanded significantly, encompassing a variety of positions ranging from generalist data scientists to highly specialized roles like machine learning engineers and AI researchers.

The data science job market has seen continuous evolution, driven by advancements in technology, such as artificial intelligence, big data analytics, and cloud computing. Employers are seeking professionals equipped with a blend of technical expertise, domain knowledge, and analytical skills. This high demand for talent has resulted in competitive compensation, particularly for those proficient in in-demand skills like Python, SQL, and TensorFlow.

However, the field is diverse, with significant variation in salaries, skill requirements, and demand for different roles. This project was initiated to explore these variations and provide a comprehensive overview of the data job market, focusing on top-paying roles, most sought-after skills, and emerging trends. By analyzing the data obtained from job postings in 2023, provided by [LUKE BAROUSSE](/www.lukebarousse.com/) which contains information about job titles, salaries, location, type of contracts, job flexibility, skills among others. This project aims to inform both aspiring data scientists and industry stakeholders about the current state of this dynamic profession.

# TOOLS I USED
In this project, a diverse range of tools was utilized to efficiently handle, analyze, and visualize the data:

- **SQL:** Used for querying and extracting structured data from databases, enabling powerful data manipulation and aggregation.

- **PostgreSQL:** The database management system used to store and manage the data, providing robust and scalable solutions for data analysis tasks. Alternatively, **MYSQL** can also be used.

- **Excel:** Utilized for initial data exploration, cleaning, and performing basic aggregations to gain quick insights into the dataset.

- **VS Code:** Served as the primary code editor, offering a flexible and efficient environment for writing and executing code.

- **Git & GitHub:** Employed for version control and collaboration, ensuring changes to the code and analysis were tracked and managed effectively.

These tools worked in synergy to enable a structured and comprehensive approach to analyzing the data science job market.

# COMPREHENSIVE ANALYSIS SUMMARY

Each query for this study focused on a specific facet of the data scientist employment market. Below is how I highlighted the key knowledge needed to understand the area of data science:

### 1. Top Paying Data Scientist Jobs
To find the highest-paying offers, I sorted data scientist positions by average annual salary and location, with a concentration on remote jobs. This question focusses on the high-paying prospects in the field.

```sql
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
    job_title_short = 'Data Scientist'    -- you can change this to any job title
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'         -- you can change this to any location
ORDER BY
    salary_year_avg DESC
LIMIT 50;
```

![Roles by Salary](/Images/Job%20title%20by%20salary.png)
*Bar chart showing the top 7 job roles by average salary: generated by CHATGPT from my SQL queries results*

### Insights Summary:
**High Variability in Salaries:** The chart highlights significant differences in average annual salaries across job titles.

**Specialized Roles Pay Higher:** Positions such as "Staff Data Scientist/Quant Researcher" and "Staff Data Scientist - Business Analytics" offer notably higher average salaries.

**Management-Oriented Roles:** Titles like "Head of Data Science" show slightly lower averages compared to specialist roles but still remain competitive.

**Demand Impact:** The data suggests that roles combining data science expertise with niche business or quantitative skills are more lucrative.

### 2. Skills for Top Paying Jobs
To determine the required skills for the highest-paying occupations, I combined job postings and skill data, providing clues into what organisations prioritise in high-rewarding roles.

```sql
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
```

![Skills for Job](/Images/Most%20used%20skills.png)
*Bar chart showing the top 10 skills need for data science: generated by CHATGPT from my SQL queries results*

### Insights Summary:
- Proficiency in SQL and Python is indispensable for most data science roles.
- Advanced skills in machine learning frameworks like TensorFlow and PyTorch command higher salaries.
- Companies' skill requirements vary based on their domain focus, such as cloud, AI, or big data. 

### 3. In-Demand Data Scientist Skills
This query assisted in identifying the most often requested talents in job advertisements, focussing attention to areas of strong demand.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

|  Skills   | Demand Count |
|-----------|--------------|
| Python    | 10390        |
| SQL       | 7488         |
| R         | 4674         |
| AWS       | 2593         |
| Tableau   | 2458         |

*Table of the demand for the top 5 skills in data scientist job postings*

### Insights Summary:
- Python and SQL dominate the skills landscape, forming the backbone of most data science roles.

- Emerging priorities like cloud (AWS) and visualization tools (Tableau) suggest a growing need for well-rounded professionals who can manage data pipelines end-to-end and communicate insights effectively.

- Building proficiency in these skills can significantly enhance employability in data-focused careers.

### 4. Skills Based on Salary
Analysing the average earnings linked with various skills reveals which skills are the most lucrative.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS mean_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY
    mean_salary DESC
LIMIT 10;
```

|  Skills       | Mean Salary |
|---------------|-------------|
| Asana         | 215477      |
| Airtable      | 201143      |
| Redhat        | 189500      |
| Watson        | 187417      |
| Elixir        | 170824      |
| Lua           | 170500      |
| Slack         | 168219      |
| Solidity      | 166980      |
| Ruby on rails | 166500      |
| Rshiny        | 166436      |

*Table of the average salary for the top 10 paying skills for data scientists*

### Insights Summary:
- **Asana** and **Airtable** top the list, with mean salaries of $215,477 and $201,143, respectively. These tools are indicative of increasing demand for project management and collaborative platforms in data science projects, while **Redhat** ($189,500) and **Watson** ($187,417) demonstrate the value of expertise in cloud computing and AI platforms.

- Developing expertise in specialized AI tools and scalable systems, alongside soft skills like project management, can significantly enhance a data scientist's earning potential because organizations are increasingly valuing tools that improve efficiency and collaboration in data-driven projects.



### 5. Most Efficient Skills to Learn
Utilising observations from demand and income data, this query seeks to identify talents that are both in sought-after and greatly compensated, providing an optimal basis for skill development.

```sql
WITH skills_demand AS (
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id,
        skills_dim.skill_id
), average_salary AS (            -- Two CTES used so don't need to use WITH again
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS mean_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id,
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.mean_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 20
ORDER BY
    mean_salary DESC,
    demand_count DESC
LIMIT 30;



-- concise writing of the query above
SELECT
    skills_job_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS mean_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id,
    skills_dim.skills
HAVING  
    COUNT(skills_job_dim.job_id) > 20
ORDER BY    
    mean_salary DESC,
    demand_count DESC
LIMIT 30;
```

|  Skills      | Demmand Count| Mean Salary |
|--------------|--------------|-------------|
| C            |    48        | 164865      |
| Go           |    57        | 164691      |
| Looker       |    57        | 158715      |
| Airflow      |    23        | 157414      |
| Bigquery     |    36        | 157142      |
| Scala        |    56        | 156702      |
| Gcp          |    59        | 155811      |
| Snowflake    |    72        | 152687      |
| Pytorch      |    115       | 152603      |
| Redshift     |    36        | 151708      |

*Table of the most efficient skills for data scientist sorted by salary*

### Insights Summary:

- High Reward for Low Demand Skills: Skills like C, Go, and Airflow offer higher-than-average salaries, suggesting their scarcity and critical application in specialized areas.

- Growing Importance of Cloud and Big Data Tools: Tools like GCP, BigQuery, and Snowflake reflect the continued shift toward cloud-centric data ecosystems.

- AI and ML Focus: The demand for PyTorch signals a clear trend toward AI/ML expertise being essential in the job market.


# CONCLUSION
**Aspiring Data Scientists:** Focus on mastering foundational skills (Python, SQL) while gaining expertise in high-demand technologies like TensorFlow, AWS, and Tableau.

**Organizations:** Invest in upskilling employees in collaborative tools and advanced machine learning frameworks to stay competitive.

**Industry Outlook:** The rise of AI, big data, and cloud computing continues to reshape the data job market, emphasizing the need for continuous learning.

This comprehensive analysis provides actionable insights into the data science job market, guiding both job seekers and employers in navigating this dynamic field.