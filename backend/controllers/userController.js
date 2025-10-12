////////////////////////////////////////////////////////////////
//
//  Project:       KnightWise
//  Year:          2025
//  Author(s):     Daniel Landsman
//  File:          userController.js
//  Description:   Controller functions for user operations,
//                 including updating profile information and
//                 deleting accounts. Requires authentication.
//
//  Dependencies: mongoose        (TODO: Migration to SQL)
//                User model      (TODO: Migration to SQL)
//                EmailCode model (TODO: Migration to SQL)
//                Answer model    (TODO: Migration to SQL)
//                discordWebhook service (sendNotification)
//
////////////////////////////////////////////////////////////////

const mongoose  = require("mongoose");            // TODO: Migration to SQL
const User      = require("../models/User");      // TODO: Migration to SQL
const EmailCode = require("../models/EmailCode"); // TODO: Migration to SQL
const Answer    = require("../models/Answer");    // TODO: Migration to SQL
const { sendNotification } = require("../services/discordWebhook");

/**
 * @route   DELETE /api/users/:id
 * @desc    Delete user profile
 * @access  Protected
 * 
 * @param {import('express').Request}  req  - Express request object
 * @param {import('express').Response} res  - Express response object
 * @returns {Promise<void>}                 - Sends HTTP/JSON response
 */
const deleteAccount = async (req, res) => {
  const userId = req.params.id;
  try 
  {
    // Account can only be deleted by account owner
    if (req.user.id !== userId) 
    {
      return res
        .status(403)
        .json({ message: "Forbidden" });
    }

    // Ensure userId is a valid ObjectId
    if (!mongoose.Types.ObjectId.isValid(userId))
    {
      return res
        .status(400)
        .json({ message: "Invalid user ID" });
    }

    // Get user info
    const user = await User.findById(userId);
    if (!user)
    { 
      return res
        .status(404)
        .json({ message: "User not found" });
    }

    // Delete user and associated email code/answers
    await User.findByIdAndDelete(userId);
    await EmailCode.deleteMany({ email: user.email });
    await Answer.deleteMany({ user_id: user._id });
    console.log(`User ${userId} and all associated data deleted successfully`);

    // Send delete notification to Discord
    sendNotification(`User deleted: ${user.username}`)
      .then(success => {
        if (!success) console.warn(`Discord notification not sent for deleted user "${user.username}"`);
      })
      .catch(error => console.error("Failed to send deleted user notification:", error));

    return res
      .status(200)
      .json({ message: "Account deleted successfully" });
  } 
  catch (err) 
  {
    console.error(`Error deleting user ${userId}:`, err);
    return res
      .status(500)
      .json({ message: "Server error" });
  }
};

/** TODO
 * @route   GET /api/users/:id
 * @desc    Retrieve user profile (profile picture, etc.)
 * @access  Protected
 *
 * @param {import('express').Request}  req  - Express request object
 * @param {import('express').Response} res  - Express response object
 * @returns {Promise<void>}                 - Sends HTTP/JSON response
 */
const getUserInfo = async (req, res) => {
  // TODO: Implement fetching user data
};

/** TODO
 * @route   PUT /api/users/:id
 * @desc    Update user profile (profile picture, etc.)
 * @access  Protected
 *
 * @param {import('express').Request}  req  - Express request object
 * @param {import('express').Response} res  - Express response object
 * @returns {Promise<void>}                 - Sends HTTP/JSON response
 */
const updateUser = async (req, res) => {
  // TODO: Implement updating user data
};

// TODO: Export getUserInfo and updateUser when implemented
module.exports = {
  deleteAccount
};