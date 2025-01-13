-- To show the most rewarding skills based on salary

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
LIMIT 40;




/*### **Summary Report: Trends in Top-Paying Data Science Skills**

#### **1. Highest-Paying Skills**
- **Asana** and **Airtable** top the list, with mean salaries of $215,477 and $201,143, respectively. These tools are indicative of increasing demand for project management and collaborative platforms in data science projects.
- **Redhat** ($189,500) and **Watson** ($187,417) demonstrate the value of expertise in cloud computing and AI platforms.

#### **2. Specialized Skills**
- **Elixir** ($170,824): A functional programming language, often used in scalable, high-performance systems.
- **Watson**: IBM’s AI platform, which is commonly associated with machine learning and natural language processing tasks, highlights demand for expertise in specialized AI platforms.

#### **3. Salary Insights**
- Tools and platforms that integrate directly with scalable systems, AI workflows, and collaborative project management are commanding top-tier salaries.
- The presence of **Redhat** and **Watson** suggests that employers value skills that contribute to building and maintaining robust enterprise-level solutions.

#### **4. Emerging Trends**
- **Project Management Tools**: High salaries associated with Asana and Airtable indicate a growing emphasis on collaboration and organization in data science teams.
- **AI and Cloud**: Platforms like Watson and Redhat highlight the importance of AI and cloud computing expertise in driving higher salaries.

---

#### **Key Takeaways**
- Developing expertise in specialized AI tools and scalable systems, alongside soft skills like project management, can significantly enhance a data scientist's earning potential.
- Organizations are increasingly valuing tools that improve efficiency and collaboration in data-driven projects.*/
