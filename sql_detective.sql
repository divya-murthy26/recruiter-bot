--Question 1
select title , name 
from recruiters r 
join job_postings jp
on r.id = jp.recruiter_id
where status = "open";

--Question 2

select job_posting_id , count(applicant_id) as applicants
from interviews
where stage = "Final"
group by job_posting_id;

--Question 3

SELECT
    a.full_name,
    UPPER(a.email) AS normalized_email,
    COUNT(DISTINCT i.job_posting_id) AS job_posting_count
FROM applicants a
JOIN interviews i
    ON a.id = i.applicant_id
GROUP BY
    a.full_name,
    UPPER(a.email)
HAVING
    COUNT(DISTINCT i.job_posting_id) > 1;
    
    
    
-- Question 4
SELECT
    r.id AS recruiter_id,
    r.name AS recruiter_name,
    COUNT(*) AS total_final_interviews,
    SUM(
        CASE
            WHEN i.outcome = 'passed' THEN 1
            ELSE 0
        END
    ) AS passed_final_interviews,
    SUM(
        CASE
            WHEN i.outcome = 'passed' THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*) AS conversion_rate
FROM recruiters r
JOIN job_postings jp
    ON r.id = jp.recruiter_id
JOIN interviews i
    ON jp.id = i.job_posting_id
WHERE i.stage = 'Final'
GROUP BY r.id, r.name
HAVING COUNT(*) >= 3;

--Question 5 
--I attempted the bonus question by first calculating successful placements for each recruiter and department. 
--Since I was unfamiliar with window functions, I learned how `RANK()`, `PARTITION BY`, and `ORDER BY` work and used them to identify the top recruiter in each department. 

WITH recruiter_placements AS (
    SELECT
        jp.department,
        r.id AS recruiter_id,
        r.name AS recruiter_name,
        COUNT(*) AS successful_placements
    FROM recruiters r
    JOIN job_postings jp
        ON r.id = jp.recruiter_id
    JOIN interviews i
        ON jp.id = i.job_posting_id
    WHERE i.stage = 'Final'
      AND i.outcome = 'passed'
    GROUP BY
        jp.department,
        r.id,
        r.name
),
ranked_recruiters AS (
    SELECT
        department,
        recruiter_id,
        recruiter_name,
        successful_placements,
        RANK() OVER (
            PARTITION BY department
            ORDER BY successful_placements DESC
        ) AS placement_rank
    FROM recruiter_placements
)
SELECT
    department,
    recruiter_id,
    recruiter_name,
    successful_placements
FROM ranked_recruiters
WHERE placement_rank = 1;
