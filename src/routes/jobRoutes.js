const express = require("express");
const { getJobMatches } = require("../controllers/jobController");

const router = express.Router();

router.get("/:id/matches", getJobMatches);

module.exports = router;