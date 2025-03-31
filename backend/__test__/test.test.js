const request = require("supertest");
const mongoose = require("mongoose");
const jwt = require("jsonwebtoken");
const app = require("../server");

const Problem = require("../models/Problem");
const Answer = require("../models/Answer");
const User = require("../models/User");

require("dotenv").config({ path: ".env.test" });

let token, userId;

beforeAll(async () => {
  await mongoose.connect(process.env.MONGO_URI);
  const user = await User.create({
    username: "tester",
    email: "test@example.com",
    password: "pass",
    firstName: "Test",
    lastName: "User",
  });

  userId = user._id.toString();
  token = jwt.sign({ userId }, process.env.JWT_SECRET);
});

afterEach(async () => {
  await Problem.deleteMany({});
  await Answer.deleteMany({});
});

afterAll(async () => {
  await User.deleteMany({});
  await mongoose.connection.close();
});

test("GET /api/test/topic/:topicName", async () => {
  // give
  await Problem.insertMany([
    { question: "Q1", subcategory: "test", section: "A" },
    { question: "Q2", subcategory: "test", section: "A" },
  ]);

  // when
  const res = await request(app).get("/api/test/topic/test");

  // then
  expect(res.statusCode).toBe(200);
  expect(res.body.length).toBe(2);
  expect(res.body[0].subcategory).toBe("OS");
});

test("GET /api/test/mocktest", async () => {
  // give
  const sections = ["A", "B", "C", "D"];
  const problems = sections.flatMap((sec) =>
    Array.from({ length: 5 }, (_, i) => ({
      question: `Q${sec}${i + 1}`,
      subcategory: "Test",
      section: sec,
    }))
  );
  await Problem.insertMany(problems);

  // when
  const res = await request(app).get("/api/test/mocktest");

  // then
  expect(res.statusCode).toBe(200);
  expect(res.body.total).toBe(12);
  expect(res.body.problems.length).toBe(12);
});
