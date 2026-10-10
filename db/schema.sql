CREATE DATABASE IF NOT EXISTS recruiter_bot;

USE recruiter_bot;

CREATE TABLE candidates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    experience INT NOT NULL,
    availability VARCHAR(50),
    traits TEXT,
    quirk TEXT
);

CREATE TABLE skills (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE candidate_skills (
    candidate_id INT NOT NULL,
    skill_id INT NOT NULL,

    PRIMARY KEY (candidate_id, skill_id),

    FOREIGN KEY (candidate_id)
        REFERENCES candidates(id),

    FOREIGN KEY (skill_id)
        REFERENCES skills(id)
);

CREATE TABLE jobs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    min_experience INT NOT NULL,
    culture_keywords TEXT,
    tagline TEXT
);

CREATE TABLE job_skills (
    job_id INT NOT NULL,
    skill_id INT NOT NULL,

    PRIMARY KEY (job_id, skill_id),

    FOREIGN KEY (job_id)
        REFERENCES jobs(id),

    FOREIGN KEY (skill_id)
        REFERENCES skills(id)
);