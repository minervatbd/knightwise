////////////////////////////////////////////////////////////////
//
//  Project:       KnightWise
//  Year:          2025
//  Author(s):     Daniel Landsman
//  File:          api.ts
//  Description:   Defines Axios instance used across app.
//                 Applies base URL from .env, used for
//                 all API calls.
//
//  Dependencies:  axios
//
////////////////////////////////////////////////////////////////

import axios from "axios";

// Try to get base URL from .env
const baseURL = import.meta.env.VITE_API_BASE_URL;
if (!baseURL)
{
  console.warn("VITE_API_BASE_URL not set, using http://localhost:5000.");
}

const api = axios.create(
  {
    baseURL: baseURL || "http://localhost:5000",
  }
);

// Interceptor to add token
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  // Add token if it exists (protected routes) 
  if (token) 
  {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

export default api;