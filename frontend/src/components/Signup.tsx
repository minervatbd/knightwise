// This code is based on Dr. Reinenker's code : Login.tsx
// The implementation of the password checklist was based on the article: https://www.geeksforgeeks.org/how-to-create-password-checklist-in-reactjs/
import React, { useState } from "react";
import axios from "axios";
import PasswordChecklist from "react-password-checklist";
import { buildPath } from "./Path";

const Signup: React.FC<{ onToggle: () => void }> = ({ onToggle }) => {
  const [firstName, setFirstname] = useState("");
  const [lastName, setLastname] = useState("");
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  const nameRegex = /^[A-Za-z]{1,}$/;
  const usernameRegex = /^[A-Za-z\d]{5,}$/;
  const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{5,}$/;

  const handleSignup = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setSuccessMessage("");

    if (!nameRegex.test(firstName) || !nameRegex.test(lastName)) {
      setError("Name must be at least one letter");
      return;
    }

    if (!usernameRegex.test(username)) {
      setError("Username must be at least 5 characters (letters or numbers)");
      return;
    }

    if (!passwordRegex.test(password)) {
      setError(
        "Password must be at least 5 characters with uppercase, lowercase, number, and special character."
      );
      return;
    }

    if (password !== confirmPassword) {
      setError("Passwords do not match.");
      return;
    }

    try {
      // send request to server
      const response = await axios.post(buildPath("api/auth/signup"), {
        username,
        email,
        password,
        firstName,
        lastName,
      });

      setSuccessMessage(response.data.message);
      setTimeout(() => onToggle(), 2000);
    } catch (err: any) {
      setError(err.response?.data?.message);
    }
  };

  return (
    <div className="flex flex-col items-center">
      <div className="bg-gray-100 p-12 rounded-xl shadow-lg w-full max-w-3xl min-h-[600px] flex flex-col items-center justify-center">
        <h2 className="text-5xl font-bold text-center text-gray-800 mb-6">
          Sign Up
        </h2>

        {/* signup form */}
        <form onSubmit={handleSignup} className="space-y-4 w-full max-w-2xl">
          {/* firstName */}
          <div className="flex items-center space-x-6 w-full">
            <label className="w-2/5 text-lg font-semibold text-gray-700">
              First Name
            </label>
            <input
              type="text"
              placeholder="First Name"
              className="w-3/5 px-6 py-3 text-lg border border-gray-300 bg-white rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
              value={firstName}
              onChange={(e) => setFirstname(e.target.value)}
              required
            />
          </div>

          {/* lastName */}
          <div className="flex items-center space-x-6 w-full">
            <label className="w-2/5 text-lg font-semibold text-gray-700">
              Last Name
            </label>
            <input
              type="text"
              placeholder="Last Name"
              className="w-3/5 px-6 py-3 text-lg border border-gray-300 bg-white rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
              value={lastName}
              onChange={(e) => setLastname(e.target.value)}
              required
            />
          </div>
          
          {/* username */}
          <div className="flex flex-col w-full">
            <div className="flex items-center space-x-6 w-full">
              <label className="w-2/5 text-lg font-semibold text-gray-700">
                Username
              </label>
              <input
                type="text"
                placeholder="Username"
                className="w-3/5 px-6 py-3 text-lg border border-gray-300 bg-white rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
              />
            </div>

            <p className="text-sm text-gray-600 mt-1 ml-[40%]">
              Username must be at least 5 characters
            </p>
          </div>

          {/* email */}
          <div className="flex items-center space-x-6 w-full">
            <label className="w-2/5 text-lg font-semibold text-gray-700">
              Email
            </label>
            <input
              type="email"
              placeholder="Email"
              className="w-3/5 px-6 py-3 text-lg border border-gray-300 bg-white rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
            />
          </div>

          {/* password */}
          <div className="flex flex-col w-full">
            <div className="flex items-center space-x-6 w-full">
              <label className="w-2/5 text-lg font-semibold text-gray-700">
                Password
              </label>
              <input
                type="password"
                placeholder="Password"
                className="w-3/5 px-6 py-3 text-lg border border-gray-300 bg-white rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>

            {/* Password Checklist */}
            <PasswordChecklist
              className="ml-[40%] mt-2 text-gray-700"
              rules={["minLength", "specialChar", "number", "capital"]}
              minLength={5}
              value={password}
              messages={{
                minLength: "At least 5 characters",
                specialChar: "At least one special character",
                number: "At least one number",
                capital: "At least one uppercase letter",
              }}
            />
          </div>

          {/* confirm password */}
          <div className="flex items-center space-x-6 w-full">
            <label className="w-2/5 text-lg font-semibold text-gray-700">
              Confirm Password
            </label>
            <input
              type="password"
              placeholder="Confirm Password"
              className="w-3/5 px-6 py-3 text-lg border border-gray-300 bg-white rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              required
            />
          </div>

          {/* signup button */}
          <button
            type="submit"
            className="w-full bg-yellow-500 text-black font-bold py-4 text-xl rounded-xl shadow-lg hover:bg-yellow-600 transition"
          >
            SIGN UP
          </button>
        </form>

        {/* display message */}
        {error && (
          <p className="text-red-500 text-lg text-center mt-2">{error}</p>
        )}
        {successMessage && (
          <p className="text-green-500 text-sm text-center mt-2">
            {successMessage}
          </p>
        )}

        {/* move to login */}
        <p className="text-center text-base text-gray-600 mt-4">
          Already have an account?{" "}
          <button onClick={onToggle} className="text-blue-500 hover:underline">
            Sign in here.
          </button>
        </p>
      </div>
    </div>
  );
};

export default Signup;
