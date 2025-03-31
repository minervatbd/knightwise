jest.mock("@sendgrid/mail", () => ({
  setApiKey: jest.fn(),
  send: jest.fn().mockResolvedValue([{ statusCode: 202 }]),
}));

const request = require("supertest");
const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const app = require("../server");
const User = require("../models/User");
const EmailCode = require("../models/EmailCode");

require("dotenv").config({ path: ".env.test" });

beforeAll(async () => {
  await mongoose.connect(process.env.MONGO_URI);
});

afterEach(async () => {
  jest.clearAllMocks();
  await User.deleteMany({});
  await EmailCode.deleteMany({});
});

afterAll(async () => {
  await mongoose.connection.close();
});

describe("Auth Routes", () => {
  test("sendotp -  send OTP for signup", async () => {
    // give: email
    const email = "test1@example.com";

    // when: request /sendotp
    const res = await request(app).post("/api/auth/sendotp").send({
      email,
      purpose: "signup",
    });

    // then: statusCode and message
    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe("Send email to user");
  });

  test("sendotp -  fail if email is already registered during signup", async () => {
    // give: registed user
    await User.create({
      username: "existinguser",
      email: "existing@example.com",
      password: "123",
      firstName: "Exist",
      lastName: "User",
    });

    // when
    const res = await request(app).post("/api/auth/sendotp").send({
      email: "existing@example.com",
      purpose: "signup",
    });

    // then
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toBe("Email already registered");
  });

  test("sendotp -  fail if user does not exist during reset", async () => {
    // when
    const res = await request(app).post("/api/auth/sendotp").send({
      email: "unknown@example.com",
      purpose: "reset",
    });

    // then
    expect(res.statusCode).toBe(404);
    expect(res.body.message).toBe("User not found");
  });

  test("verify -  verify correct OTP", async () => {
    // give: email, otp
    const email = "test2@example.com";
    const otp = "123456";
    const expires = new Date(Date.now() + 5 * 60 * 1000);

    // when: request /verify
    await EmailCode.create({ email, otp, expires });

    const res = await request(app)
      .post("/api/auth/verify")
      .send({ email, otp });

    // then: statusCode and message
    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe("Verify");

    const record = await EmailCode.findOne({ email });
    expect(record.verified).toBe(true);
  });

  test("verify -  fail with wrong OTP", async () => {
    // give: correct OTP
    const email = "wrongotp@example.com";
    await EmailCode.create({
      email,
      otp: "999999",
      expires: new Date(Date.now() + 5 * 60 * 1000),
    });

    // when: enter wrong OTP
    const res = await request(app).post("/api/auth/verify").send({
      email,
      otp: "000000",
    });

    // then
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toBe("Wrong OTP");
  });

  test("verify -  fail if OTP expired", async () => {
    // give: expired OTP
    const email = "expiredotp@example.com";
    await EmailCode.create({
      email,
      otp: "123456",
      expires: new Date(Date.now() - 1000),
    });

    // when
    const res = await request(app).post("/api/auth/verify").send({
      email,
      otp: "123456",
    });

    // then
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toBe("Expired");
  });

  test("verify -  fail if no OTP record found", async () => {
    // when
    const res = await request(app).post("/api/auth/verify").send({
      email: "notfound@example.com",
      otp: "000000",
    });

    // then
    expect(res.statusCode).toBe(400);
    expect(res.body.message).toBe("No Record");
  });

  test("signup -  succeed if email verified", async () => {
    // give: verified email
    const email = "test3@example.com";
    await EmailCode.create({
      email,
      otp: "000000",
      expires: new Date(Date.now() + 5 * 60 * 1000),
      verified: true,
    });

    // when: request /signup
    const res = await request(app).post("/api/auth/signup").send({
      username: "testuser",
      email,
      password: "Test123!",
      firstName: "New",
      lastName: "User",
    });

    // then: statusCode, messagem ands token
    expect(res.statusCode).toBe(201);
    expect(res.body.message).toBe("User Registered");
    expect(res.body.token).toBeDefined();
  });

  test("login -  login with correct credentials", async () => {
    // give: registed user
    const password = await bcrypt.hash("testuser1", 10);
    await User.create({
      username: "testuser1",
      email: "testuser1@example.com",
      password,
      firstName: "Login",
      lastName: "User",
    });

    // when: request /login
    const res = await request(app).post("/api/auth/login").send({
      username: "testuser1",
      password: "testuser1",
    });

    // then: statusCode, messagem and token
    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe("User Logged In");
    expect(res.body.token).toBeDefined();
  });

  test("resetPassword -  reset password after verify", async () => {
    // give: verified email
    const email = "test4@example.com";
    const hashed = await bcrypt.hash("oldpass", 10);
    await User.create({
      username: "resetuser",
      email,
      password: hashed,
      firstName: "Reset",
      lastName: "User",
    });

    await EmailCode.create({
      email,
      otp: "000000",
      expires: new Date(Date.now() + 5 * 60 * 1000),
      verified: true,
    });

    // when: request /resetPassword
    const res = await request(app).post("/api/auth/resetPassword").send({
      email,
      password: "newpass123",
    });

    // then: statusCode, messagem and match reset password
    expect(res.statusCode).toBe(200);
    expect(res.body.message).toBe("Password reset");

    const updated = await User.findOne({ email });
    const isMatch = await bcrypt.compare("newpass123", updated.password);
    expect(isMatch).toBe(true);
  });
});
