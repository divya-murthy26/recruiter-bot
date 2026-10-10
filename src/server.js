const express = require("express");
const pool = require("./db");
const jobRoutes = require("./routes/jobRoutes");
const candidateRoutes = require("./routes/candidateRoutes");

const app = express();

app.get("/", (req, res) => {
    res.send("Recruiter Bot API is running");
});

app.get("/test-db", async (req, res) => {
    try {
        const [rows] = await pool.execute("SELECT 1 AS result"); //send sql query to the mysql

        res.json({
            message: "Database connected successfully",
            result: rows[0].result
        });
    } catch (error) {
        console.error(error);

        res.status(500).json({
            message: "Database connection failed"
        });
    }
});

app.use("/jobs", jobRoutes);
app.use("/candidates", candidateRoutes);

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
