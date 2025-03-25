import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import "./App.css";

import AuthPage from "./pages/AuthPage";
import DashBoardPage from "./pages/DashboardPage";
import TopicPage from "./pages/TopicPage";
import MockTestPage from "./pages/MockTestPage";
import MyProgessPage from "./pages/MyProgressPage";
import TopicTestPage from "./pages/TopicTestPage"
import ForgotPassword from "./components/ForgetPassword";
import ResetPassword from "./components/ResetPassword"; 
import ProblemViewPage from "./pages/ProblemViewPage";


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<AuthPage />} />
        <Route path="/dashboard" element={<DashBoardPage />} />
        <Route path="/topic-practice" element={<TopicPage />} />
        <Route path="/topic-practice/:topicName" element={<TopicTestPage />} />
        <Route path="/mock-test" element={<MockTestPage />} />
        <Route path="/my-progress" element={<MyProgessPage />} />
        <Route path="/problem-view" element={<ProblemViewPage />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/reset-password/" element={<ResetPassword />} />
      </Routes>
    </Router>
  );
}

export default App;
