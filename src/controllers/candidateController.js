const { getMatchesForCandidate } = require("../services/matchingService");

async function getCandidateMatches(req, res) {
    try {
        const candidateId = req.params.id;

        const matches = await getMatchesForCandidate(candidateId);

        res.json(matches);
    } catch (error) {
        console.error(error);

        if (error.message === "CANDIDATE_NOT_FOUND") {
            return res.status(404).json({
                message: "Candidate not found"
            });
        }

        res.status(500).json({
            message: "Something went wrong"
        });
    }
}

module.exports = {
    getCandidateMatches
};