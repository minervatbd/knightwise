const express = require("express");
const Problem = require("../models/Problem");
const Answer = require("../models/Answer");
const User = require("../models/User");
const router = express.Router();
const jwt = require("jsonwebtoken");

const authMiddleware = async (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Unauthorized: No Token Provided" });
  }
  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = await User.findById(decoded.userId).select("-password"); // Exclude password
    next();
  } catch (error) {
    console.error("JWT Error: ", error);
    res.status(401).json({ error: "Invalid Token" });
  }
};

// topic test
router.get("/topic/:topicName", async (req, res) => {
  const { topicName } = req.params;

  try {
    // Find the problem by subcategory
    const problem = await Problem.find({ subcategory: topicName });

    if (!problem || problem.length === 0) {
      return res.status(404).json({ message: "Problem not found" });
    }

    res.json(problem);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
});

router.get("/mocktest", async (req, res) => {
  try {
    const sections = ["A", "B", "C", "D"];
    const problemsBySection = {};

    // shuffled problem per section and pick three question randomly
    for (const section of sections) {
      const problems = await Problem.find({ section });
      // note: add later after got all problem
      // if (!problems || problems.length === 0) {
      //   return res
      //     .status(404)
      //     .json({ message: `Problem not found in section ${section}` });
      // }
      const shuffled = problems.sort(() => 0.5 - Math.random());
      problemsBySection[section] = shuffled.slice(0, 3);
    }

    const allProblems = Object.values(problemsBySection).flat();
    res.status(200).json({ total: allProblems.length, problems: allProblems });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server error" });
  }
});

// Note: 'subcategory' from problems collection is stored as 'topic' in answers collection
router.post("/submit", authMiddleware, async (req, res) => {
  try {
    const { problem_id, isCorrect, category, topic } = req.body;
    const user_id = req.user._id;

    const answer = new Answer({
      user_id,
      problem_id,
      isCorrect,
      category,
      topic,
      datetime: new Date(),
    });

    await answer.save();
    res.status(201).json({ message: "Answer submitted" });
  } catch (error) {
    console.error("Submit Answer Error:", error);
    res.status(500).json({ message: "Server Error" });
  }
});

module.exports = router;
