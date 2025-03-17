// This code is based on Dr. Reinenker's code : Login.tsx
import React, { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { buildPath } from "./Path";

// onToggle: move to register form
const Login: React.FC<{ onToggle: () => void }> = ({ onToggle }) => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");
  const navigate = useNavigate();

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setSuccessMessage("");

    try {
      // send request to server
      const response = await axios.post(buildPath("api/auth/login"), {
        email,
        password,
      });

      // store token
      localStorage.setItem("token", response.data.token);

      // show the success message if login is successful
      // then, move to the dashboard page after 2 sec
      setSuccessMessage(response.data.message);
      setTimeout(() => {
        navigate("/dashboard");
      }, 2000);
    } catch (err: any) {
      // show error message if login fails
      setError(err.response?.data?.message);
    }
  };

  return (
    <div className="flex flex-col items-center">
      <div className="bg-gray-100 p-12 rounded-xl shadow-lg w-full max-w-2xl min-h-[500px] flex flex-col items-center justify-center">
        <h2 className="text-5xl font-bold text-center text-gray-800 mb-15">
          Sign In
        </h2>

        {/* Login form */}
        <form onSubmit={handleLogin} className="space-y-4 w-full max-w-lg">
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
          {/* button */}
          <button
            type="submit"
            className="w-full bg-yellow-500 text-black font-bold py-4 text-xl rounded-xl shadow-lg hover:bg-yellow-600 transition"
          >
            LOGIN
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

        {/* move to the signup */}
        <p className="text-center text-base text-gray-600 mt-4">
          Not registered?{" "}
          <button onClick={onToggle} className="text-blue-500 hover:underline">
            Create an account.
          </button>
        </p>
      </div>
    </div>
  );
};

export default Login;
