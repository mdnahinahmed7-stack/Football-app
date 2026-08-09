const express = require("express");
const router = express.Router();
const { matches } = require("../data/mockMatches");

// GET /api/matches            -> all matches
// GET /api/matches?status=LIVE -> filter by status (LIVE, UPCOMING, FINISHED)
router.get("/", (req, res) => {
  const { status } = req.query;
  const result = status
    ? matches.filter((m) => m.status === status.toUpperCase())
    : matches;
  res.json({ success: true, count: result.length, data: result });
});

// GET /api/matches/:id -> single match detail (score + streams)
router.get("/:id", (req, res) => {
  const match = matches.find((m) => m.id === req.params.id);
  if (!match) {
    return res.status(404).json({ success: false, message: "Match not found" });
  }
  res.json({ success: true, data: match });
});

// GET /api/matches/:id/streams -> just the streaming links for a match
router.get("/:id/streams", (req, res) => {
  const match = matches.find((m) => m.id === req.params.id);
  if (!match) {
    return res.status(404).json({ success: false, message: "Match not found" });
  }
  res.json({ success: true, data: match.streams });
});

module.exports = router;
