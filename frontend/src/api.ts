////////////////////////////////////////////////////////////////
//
//  Project:       KnightWise
//
//  Year:          2025
//
//  Author(s):     Daniel Landsman
//
//  File:          api.ts
//
//  Description:   Defines Axios instance used across app.
//                 Applies base URL from .env, used for
//                 all API calls.
//
//  Dependencies:  axios
//
//  Last Modified: 10/10/2025 
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

export default api;