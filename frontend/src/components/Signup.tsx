// This code refer on Dr.Reinenker's code : Login.tsx
import React, { useState } from "react";
import axios from "axios";
import { buildPath } from "./Path";

// onToggle: move to login form
const Signup: React.FC<{onToggle: () => void;}> = ({ onToggle }) => {
  const [firstname, setFirstname] = useState("");
  const [lastname, setLastname] = useState("");
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");

  const handleSignup = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setSuccessMessage("");

    // check if password match 
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
      });
      
      // show the success message if login is successful
      // then, move to the login form after 2 sec
      setSuccessMessage(response.data.message);
      setTimeout(() => onToggle(), 2000);
    } catch (err: any) {
      setError(err.response?.data?.message);
    }
  };

  return (
    <div className="flex flex-col items-center">
      <div className="bg-gray-100 p-12 rounded-xl shadow-lg w-full max-w-2xl min-h-[500px] flex flex-col items-center justify-center">
        <h2 className="text-5xl font-bold text-center text-gray-800 mb-15">Sign Up</h2>

        {/* signup form */}
        <form onSubmit={handleSignup} className="space-y-4 w-full max-w-lg">
          {/* firstname */}
          <input
            type="text"
            placeholder="First Name"
            className="w-full px-6 py-4 text-lg border border-gray-300 bg-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
            value={firstname}
            onChange={(e) => setFirstname(e.target.value)}
            required
          />
          {/* lastname */}
          <input
            type="text"
            placeholder="Last Name"
            className="w-full px-6 py-4 text-lg border border-gray-300 bg-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
            value={lastname}
            onChange={(e) => setLastname(e.target.value)}
            required
          />
          {/* username */}
          <input
            type="text"
            placeholder="Username"
            className="w-full px-6 py-4 text-lg border border-gray-300 bg-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
          {/* email */}
          <input
            type="email"
            placeholder="Email"
            className="w-full px-6 py-4 text-lg border border-gray-300 bg-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
          {/* password */}
          <input
            type="password"
            placeholder="Password"
            className="w-full px-6 py-4 text-lg border border-gray-300 bg-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          {/* confirm password */}
          <input
            type="password"
            placeholder="Confirm Password"
            className="w-full px-6 py-4 text-lg border border-gray-300 bg-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-yellow-500"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            required
          />
          {/* signup button */}
          <button
            type="submit"
            className="w-full bg-yellow-500 text-black font-bold py-4 text-xl rounded-xl shadow-lg hover:bg-yellow-600 transition"
          >
            SIGN UP
          </button>
        </form>

        {/* display message */}
        {error && <p className="text-red-500 text-lg text-center mt-2">{error}</p>}
        {successMessage && <p className="text-green-500 text-sm text-center mt-2">{successMessage}</p>}

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