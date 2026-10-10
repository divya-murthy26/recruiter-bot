const express = require("express");
const { getCandidateMatches } = require("../controllers/candidateController");

const router = express.Router();

router.get("/:id/matches", getCandidateMatches);

module.exports = router;