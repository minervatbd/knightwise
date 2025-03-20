const express = require('express');
const Problem = require('../models/Problem');
const router = express.Router();

// GET request to fetch a problem by its ID
router.get('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    // Find the problem by ID
    const problem = await Problem.findById(id);

    if (!problem) {
      return res.status(404).json({ message: 'Problem not found' });
    }

    res.json(problem);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;