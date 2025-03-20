const express = require('express');
const Answer = require('../models/Answer');
const User = require('../models/User');
const jwt = require("jsonwebtoken");
const router = express.Router();
const mongoose = require('mongoose');

// Middleware to check authentication
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

// GET Progress Data Route
router.get('/graph', authMiddleware, async (req, res) => {
  try {
    const userId = req.user._id;

    // Fetch user progress data from the database
    const userAnswers = await Answer.find({ user_id: userId });

    // Process the data to calculate the user's progress (can aggregate by topic/category)
    const progressData = processProgressData(userAnswers);

    res.status(200).json({ progress: progressData });
  } catch (error) {
    console.error("Error fetching progress: ", error);
    res.status(500).json({ message: "Server Error: Unable to fetch progress data" });
  }
});

// Helper function to process the data and calculate the user's progress (you can refine this)
const processProgressData = (answers) => {
  const progress = {};

  answers.forEach((answer) => {
    const topic = answer.topic;
    const isCorrect = answer.isCorrect;

    // Initialize topic if not already in progress
    if (!progress[topic]) {
      progress[topic] = { correct: 0, total: 0 };
    }

    // Increment correct/total answers for the topic
    progress[topic].total += 1;
    if (isCorrect) {
      progress[topic].correct += 1;
    }
  });

  // Calculate percentage or other metrics per topic
  for (const topic in progress) {
    const { correct, total } = progress[topic];
    progress[topic].percentage = ((correct / total) * 100).toFixed(2);
  }

  return progress;
};

// History endpoint with pagination
router.get('/history', authMiddleware, async (req, res) => {
  try {
    const userId = req.user.id;
    console.log("User ID is ", userId);
    
    // Pagination logic: default to page 1, limit to 10 results per page
    const page = parseInt(req.query.page) || 1;
    const limit = 10;
    const skip = (page - 1) * limit;  // Calculate the number of results to skip
    const ObjectId = require('mongoose').Types.ObjectId;

    // Fetch the user's history with pagination
    const history = await Answer.find({ user_id: new mongoose.Types.ObjectId(userId) })
      .sort({ datetime: -1 }) // Sort by datetime, descending
      .skip(skip)
      .limit(limit)
      .select('datetime topic isCorrect problem_id'); // Only select necessary fields

    // Count the total number of entries for pagination
    const totalEntries = await Answer.countDocuments({ user_id: new mongoose.Types.ObjectId(userId) });
    console.log("totalEntries is ", totalEntries);

    res.status(200).json({
      history,
      totalEntries,
      currentPage: page,
      totalPages: Math.ceil(totalEntries / limit),
    });
  } catch (error) {
    console.error('Error fetching history:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
