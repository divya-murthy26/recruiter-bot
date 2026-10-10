const pool = require("../db");

async function getMatchesForJob(jobId) {
    const [jobRows] = await pool.execute(
        "SELECT id FROM jobs WHERE id = ?",
        [jobId]
    );

    if (jobRows.length === 0) {
        throw new Error("JOB_NOT_FOUND");
    }

    const [rows] = await pool.execute(
        `
        SELECT
            c.id,
            c.name,
            c.experience,
            j.min_experience,
            COUNT(DISTINCT js.skill_id) AS required_skills,
            COUNT(DISTINCT CASE
                WHEN cs.skill_id IS NOT NULL THEN js.skill_id
            END) AS matched_skills
        FROM candidates c
        JOIN jobs j
            ON j.id = ?
        JOIN job_skills js
            ON js.job_id = j.id
        LEFT JOIN candidate_skills cs
            ON cs.candidate_id = c.id
            AND cs.skill_id = js.skill_id
        GROUP BY
            c.id,
            c.name,
            c.experience,
            j.min_experience
        `,
        [jobId] //ON j.id = ? The ? is a parameter placeholder.
    );

    const matches = rows.map((candidate) => {
        const skillScore =
            (candidate.matched_skills / candidate.required_skills) * 100;

        const experienceScore =
            Math.min(
                candidate.experience / candidate.min_experience,
                1
            ) * 100;

        const score =
            skillScore * 0.7 +
            experienceScore * 0.3;

        return {
            id: candidate.id,
            name: candidate.name,
            experience: candidate.experience,
            matched_skills: candidate.matched_skills,
            required_skills: candidate.required_skills,
            score: Number(score.toFixed(2)),
            reason: `Matched ${candidate.matched_skills}/${candidate.required_skills} required skills and has ${candidate.experience} years of experience against a ${candidate.min_experience}-year minimum.`
        };
    });

    matches.sort((a, b) => {
        if (b.score !== a.score) {
            return b.score - a.score;
        }

        if (b.matched_skills !== a.matched_skills) {
            return b.matched_skills - a.matched_skills;
        }

        return b.experience - a.experience;
    });

    return matches;
}

async function getMatchesForCandidate(candidateId) {
    const [candidateRows] = await pool.execute(
        "SELECT id FROM candidates WHERE id = ?",
        [candidateId]
    );

    if (candidateRows.length === 0) {
        throw new Error("CANDIDATE_NOT_FOUND");
    }

    const [rows] = await pool.execute(
        `
        SELECT
            j.id,
            j.title,
            j.min_experience,
            c.experience,
            COUNT(DISTINCT js.skill_id) AS required_skills,
            COUNT(DISTINCT CASE
                WHEN cs.skill_id IS NOT NULL THEN js.skill_id
            END) AS matched_skills
        FROM jobs j
        JOIN candidates c
            ON c.id = ?
        JOIN job_skills js
            ON js.job_id = j.id
        LEFT JOIN candidate_skills cs
            ON cs.candidate_id = ?
            AND cs.skill_id = js.skill_id
        GROUP BY
            j.id,
            j.title,
            j.min_experience,
            c.experience
        `,
        [candidateId, candidateId]
    );

    const matches = rows.map((job) => {
        const skillScore =
            (job.matched_skills / job.required_skills) * 100;

        const experienceScore =
            Math.min(
                job.experience / job.min_experience,
                1
            ) * 100;

        const score =
            skillScore * 0.7 +
            experienceScore * 0.3;

        return {
            id: job.id,
            title: job.title,
            experience: job.experience,
            matched_skills: job.matched_skills,
            required_skills: job.required_skills,
            score: Number(score.toFixed(2)),
            reason: `Matched ${job.matched_skills}/${job.required_skills} required skills and has ${job.experience} years of experience against a ${job.min_experience}-year minimum.`
        };
    });

    matches.sort((a, b) => b.score - a.score);

    return matches;
}

module.exports = {
    getMatchesForJob,
    getMatchesForCandidate
};