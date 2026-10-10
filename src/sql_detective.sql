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
