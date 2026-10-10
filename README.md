# Recruiter Bot 

## Overview

Recruiter Bot is a backend API that matches candidates with job opportunities based on their skills and experience. It uses Node.js, Express.js, and MySQL to retrieve candidate and job data, calculate matching scores, and return ranked results with explanations.

The application supports two main operations:
- Finding the best candidates for a given job.
- Finding the most suitable jobs for a given candidate.

## Tech Stack

- **Backend:** Node.js, Express.js
- **Database:** MySQL
- **Environment Variables:** dotenv

## Features

- Retrieve ranked candidate matches for a job.
- Retrieve ranked job matches for a candidate.
- Calculate matching scores based on skill overlap and experience.
- Return a short explanation for each match.
- Handle invalid candidate and job IDs with appropriate HTTP 404 responses.
- Use raw SQL queries without an ORM or query builder.

## Project Structure

```text
recruiter-bot/
├── db/
│   ├── schema.sql
│   └── seed.sql
├── src/
│   ├── controllers/
│   │   ├── candidateController.js
│   │   └── jobController.js
│   ├── routes/
│   │   ├── candidateRoutes.js
│   │   └── jobRoutes.js
│   ├── services/
│   │   └── matchingService.js
│   ├── db.js
│   └── server.js
├── .env
├── .gitignore
├── package.json
└── README.md
```

## Prerequisites

Install the following before running the project:

- Node.js and npm
- MySQL Server
- Git (optional, for cloning the repository)

## Installation and Setup

### 1. Clone the repository

```bash
git clone https://github.com/divya-murthy26/recruiter-bot.git
cd Recruiter-bot
```
### 2. Install dependencies

```bash
npm install
```

### 3. Configure environment variables

Create a `.env` file in the root directory:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=recruiter_bot
```

Replace `your_mysql_password` with your local MySQL password.

**Important:** Do not commit your `.env` file or database credentials to GitHub.

### 4. Set up the database

Open MySQL Workbench or your preferred MySQL client.

Execute the SQL files in this order:

1. `db/schema.sql`
2. `db/seed.sql`

The schema file creates the database and tables. The seed file inserts the sample candidates, jobs, skills, and their skill mappings.

Run the seed file on a fresh database to avoid duplicate-data or primary-key errors.

### 5. Start the server

For development:

```bash
npm run dev
```

Or start normally:

```bash
npm start
```

The server runs at:

```text
http://localhost:3000
```

## API Endpoints

### 1. Get candidates matching a job

**Endpoint**

```http
GET /jobs/:id/matches
```

Example:

```bash
curl http://localhost:3000/jobs/1/matches
```

Returns candidates ranked by their matching score, along with their matched skills, experience, score, and a short explanation.

### 2. Get jobs matching a candidate

**Endpoint**

```http
GET /candidates/:id/matches
```

Example:

```bash
curl http://localhost:3000/candidates/1/matches
```

Returns jobs ranked by their matching score for the specified candidate.

### 3. Check server status

```http
GET /
```

Example:

```bash
curl http://localhost:3000/
```

### 4. Check database connectivity

```http
GET /test-db
```

Example:

```bash
curl http://localhost:3000/test-db
```

### Error Handling

If a job or candidate ID does not exist, the API returns HTTP `404 Not Found` with a descriptive error message.

Unexpected server or database errors return HTTP `500 Internal Server Error`.

## Matching Algorithm: Design Decisions and Trade-offs

The matching algorithm uses two factors: skill overlap and experience. Skill overlap contributes **70%** of the final score, while experience contributes **30%**.

### Skill Score

The skill score measures the percentage of a job's required skills that a candidate possesses.

```text
Skill Score =
(Matched Required Skills / Total Required Skills) × 100
```

For example, if a job requires four skills and a candidate has three of them, the skill score is 75.

### Experience Score

The experience score compares a candidate's experience with the minimum experience required for the job.

```text
Experience Score =
MIN(Candidate Experience / Minimum Required Experience, 1) × 100
```

The score is capped at 100 so that experience beyond the minimum requirement does not increase the experience component indefinitely.

### Final Matching Score

```text
Final Score =
(Skill Score × 0.7) + (Experience Score × 0.3)
```

The final score is rounded to two decimal places. Each result includes a short explanation describing the number of matched required skills and the candidate's experience relative to the job's minimum requirement.

Candidates and jobs are ranked in descending order of matching score. For candidate matches for a job, ties are broken by the number of matched skills and then by experience.

### Trade-offs and Limitations

I chose a simple weighted scoring model because it is easy to understand, explain, and maintain. Giving skills a higher weight prioritizes candidates who possess the required technical skills, while the experience component accounts for job seniority requirements.

The algorithm currently uses exact skill-ID matches and does not consider culture keywords, availability, or other contextual factors, even though some of these attributes are stored in the database. The weights are fixed rather than learned from historical hiring outcomes. These choices keep the implementation straightforward but may not capture every aspect of real-world hiring decisions.

The matching scores are calculated when an API request is made instead of being stored in a separate matches table. This avoids storing potentially stale scores when candidate skills, job requirements, or experience change. For a larger application, I would consider configurable weights, additional matching factors, pagination, automated tests, and performance optimizations.

## Database Design

The database uses separate tables for candidates, jobs, skills, and their skill mappings.

- `candidates`: Candidate details, including experience and availability.
- `jobs`: Job details, including minimum experience.
- `skills`: Unique skill records.
- `candidate_skills`: Many-to-many relationship between candidates and skills.
- `job_skills`: Many-to-many relationship between jobs and required skills.

Foreign keys maintain referential integrity, and composite primary keys prevent duplicate candidate-skill and job-skill mappings.

The application uses parameterized SQL queries through `mysql2` to retrieve and compare data.

## Testing

The endpoints were manually tested using Postman, including:

- Successful matching requests for valid job and candidate IDs.
- Database connectivity.
- Invalid job IDs.
- Invalid candidate IDs.


## AI Tool Usage

I used ChatGPT as a learning assistant to understand the project architecture, matching algorithm, and implementation details. It also helped me clarify design decisions and prepare the documentation. I tested the APIs locally and reviewed the code to improve my understanding of the implementation..


## License

This project was developed as part of a backend assignment.
