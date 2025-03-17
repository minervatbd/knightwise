import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import "./App.css";

import AuthPage from "./pages/AuthPage";
import Dashboard from "./pages/DashboardPage";

function App() {
  return (
    <Router>
      <Routes>
        {/* '/': go to  AuthPage*/}
        <Route path="/" element={<AuthPage />} />
        
        {/* '/dashboard/: go to dashboard */}
        <Route path="/dashboard" element={<Dashboard />} />
      </Routes>
    </Router>
  );
}

export default App;
