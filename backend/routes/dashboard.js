const express = require("express");
const jwt = require("jsonwebtoken");
const User = require("../models/User");

const router = express.Router();

// Middleware to check authentication
router.use(async (req, res, next) => {
  const authHeader = req.headers.authorization;
  if(!authHeader || !authHeader.startsWith("Bearer ")){
    return res.status(403).json({ error: "Unauthorized: No Token Provided"});
  }
  token = authHeader.split(" ")[1];

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = await User.findById(decoded.id).select("-password"); // Exclude password
    next();
  } catch (error) {
    console.error("JWT Error: ", error);
    res.status(401).json({ error: "Invalid Token" });
  }
});

// Protected Dashboard Route
router.get("/", (req, res) => {
  res.json({ message: "Dashboard Access", user: req.user });
});

module.exports = router;