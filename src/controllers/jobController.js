const { getMatchesForJob } = require("../services/matchingService");

async function getJobMatches(req, res) {
    try {
        const jobId = req.params.id;

        const matches = await getMatchesForJob(jobId);

        res.json(matches);
    } catch (error) {
        console.error(error);

        if (error.message === "JOB_NOT_FOUND") {
            return res.status(404).json({
                message: "Job not found"
            });
        }

        res.status(500).json({
            message: "Something went wrong"
        });
    }
}

module.exports = {
    getJobMatches
};