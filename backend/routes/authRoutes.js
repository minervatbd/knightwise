const express = require("express");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { sendNotification } = require("../services/discordWebhook");
const User = require("../models/User");
const router = express.Router();

// Mailjet for sending verification code
const Mailjet = require("node-mailjet");
const mailjet = Mailjet.apiConnect(
    process.env.MJ_APIKEY_PUBLIC,
    process.env.MJ_APIKEY_PRIVATE
);

const EmailCode = require("../models/EmailCode");
const otpGenerator = require("otp-generator");

// create code using otp-generator library
function generateCode() {
  return otpGenerator.generate(6, {
    digits: true,
    alphabets: false,
    upperCase: false,
    specialChars: false,
  });
}

// Sign Up Route
router.post("/signup", async (req, res) => {
  try {
    const { username, email, password, firstName, lastName } = req.body;
    if (!username || !email || !password || !firstName || !lastName) {
      return res.status(400).json({ message: "Invalid Fields" });
    }

    // need email verification to sign up
    const record = await EmailCode.findOne({ email });
    if (!record || record.verified !== true)
      return res
        .status(400)
        .json({ message: "Email verification is required" });

    let user = await User.findOne({ username });
    if (user) return res.status(400).json({ message: "User already exists" });

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);
    user = new User({
      username,
      email,
      password: hashedPassword,
      firstName,
      lastName,
      isVerified: true,
    });

    await user.save();
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });

    // Signup success, send notification to Discord admin channel
    res.status(201).json({ message: "User Registered", token });
    sendNotification(`New user signed up: ${user.username}`)
      .then(success => {
        if (!success) console.warn(`Discord notification not sent for new user "${user.username}"`);
      })
      .catch(error => console.error("Failed to send new user notification:", error));

  } catch (error) {
    console.error("Signup error: ", error);
    res.status(500).json({ message: "Server error" });
  }
});

// Login Route
router.post("/login", async (req, res) => {
  try {
    const { username, password } = req.body;
    const user = await User.findOne({ username });
    if (!user) return res.status(400).json({ message: "User not found" });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch)
      return res.status(400).json({ message: "Invalid credentials" });

    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1h",
    });
    res.status(200).json({
      message: "User Logged In",
      token,
      user: {
        id: user._id,
        name: user.username,
        email: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
      },
    });
  } catch (error) {
    console.error("Login Error: ", error);
    res.status(500).json({ message: "Server error" });
  }
});

// send OTP via email
// email template by @anandu-ap from TailwindFlex
// https://tailwindflex.com/@anandu-ap/otp-code-template
router.post("/sendotp", async (req, res) => {
  try 
  {
    const { email, purpose } = req.body;
    const otp = generateCode();
    const expires = new Date(Date.now() + 5 * 60 * 1000);
    const user = await User.findOne({ email });

    // check if the email is already registered to avoid duplicate email
    if (purpose === "signup") {
      if (user) {
        return res.status(400).json({ message: "Email already registered" });
      }
    }
    // check if the email is already registered to avoid unregistered users from reset password
    if (purpose === "reset") {
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
    }

    const found = await EmailCode.findOne({ email });

    // if email exists, update the OTP and expires
    // if email doesn't exist, create EmailCode in MongoDB
    if (found) {
      await EmailCode.updateOne({ email }, { $set: { otp, expires } });
    } else {
      await EmailCode.create({ email, otp, expires });
    }

    // send email containing an OTP to user
    try
    {
      const request = await mailjet
        .post('send', { version: 'v3.1' })
        .request(
        {
          Messages: 
          [{
            From: 
            {
              Email: "webdevpeeps@gmail.com",
              Name: "KnightWise Developers"
            },
            To: 
            [{
              Email: email,
              Name: "Studious User"
            }],
            Subject: "Your KnightWise verification code!",
            TextPart: `Your verification code is: ${otp}. This code is valid for 5 minutes. Please do not share this code with anyone. If you didn't request this code, please ignore this email. Thank you for using KnightWise!`,
            HTMLPart: 
            `
              <html lang="en">
              <head>
                <meta charset="UTF-8" />
                <title>Your KnightWise Verification Code</title>
              </head>
              <body style="font-family: Arial, sans-serif; margin: 0; padding: 0;">
                <div style="max-width: 600px; margin: 40px auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
                  <div style="background-color: #ba9b37; padding: 24px; text-align: center;">
                    <h1 style="font-size: 28px; color: white; margin: 0;">Your Verification Code</h1>
                  </div>
                  <div style="padding: 32px;">
                    <p style="color: #374151; font-size: 16px;">Hello,</p>
                    <p style="color: #374151; font-size: 16px; margin-bottom: 24px;">
                      Your Verification Code is:
                    </p>
                    <div style="background-color: #f3f4f6; padding: 16px; border-radius: 8px; text-align: center; margin-bottom: 24px;">
                      <p style="font-size: 36px; color: black; font-weight: bold; margin: 0;">${otp}</p>
                    </div>
                    <p style="color: #374151; font-size: 16px; margin-bottom: 16px;">
                      This code is valid for <strong>5 minutes</strong>. Please do not share this code with anyone.
                    </p>
                    <p style="color: #6b7280; font-size: 14px; margin-bottom: 8px;">If you didn't request this code, please ignore this email.</p>
                    <p style="color: #6b7280; font-size: 14px;">Thank you for using KnightWise!</p>
                  </div>
                </div>
              </body>
              </html>
            `
          }]
        })
        console.log("Email sent successfully:", request.body);
        return res.json({ message: "Code sent successfully" });
    } catch (emailErr)
    {
      console.error("Mailjet Error:", emailErr.statusCode, emailErr.message);
      return res.status(500).json({ message: "Failed to send verification code" });
    }
  } catch (apiErr)
  {
    console.error("Send OTP Error:", apiErr);
    return res.status(500).json({ message: "Server error" });
  }
});

// check verification code
router.post("/verify", async (req, res) => {
  try {
    const { email, otp } = req.body;
    const record = await EmailCode.findOne({ email });

    // check the OTP and expiration time related to email in MongoDB
    if (!record) return res.status(400).json({ message: "No Record" });
    if (record.otp !== otp)
      return res.status(400).json({ message: "Wrong OTP" });
    if (record.expires < new Date())
      return res.status(400).json({ message: "Expired" });

    // ensure email verification is marked as complete
    // if other fields (e.g. password, username) are changed when sign in
    await EmailCode.updateOne({ email }, { $set: { verified: true } });
    res.json({ message: "Verify" });
  } catch (error) {
    console.error("Verify Error: ", error);
    res.status(500).json({ message: "Server error", error: error.message });
  }
});

// reset password
router.post("/resetPassword", async (req, res) => {
  try {
    const { email, password } = req.body;
    const record = await EmailCode.findOne({ email });

    // double check that user email has been verified
    if (!record || !record.verified) {
      return res.status(403).json({ message: "Email verification required" });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // update new password
    await User.updateOne({ email }, { $set: { password: hashedPassword } });
    res.json({ message: "Password reset" });
  } catch (error) {
    console.error("Reset Password Error:", error);
    res.status(500).json({ message: "Server error", error: error.message });
  }
});

module.exports = router;
