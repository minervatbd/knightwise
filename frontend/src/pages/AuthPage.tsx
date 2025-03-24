// login and signup page

import { useState } from "react";
import Header from "../components/Header";
import PageTitle from "../components/PageTitle";
import Login from "../components/Login";
import Signup from "../components/Signup";
import Footer from "../components/Footer";

const AuthPage = () => {
  const [isSignup, setIsSignup] = useState(false);

  return (
    <div className="min-h-screen w-screen flex flex-col">
      <Header />
      <div className="flex flex-1 flex-col md:flex-row">
      <div className="hidden md:flex w-full md:w-1/2 flex-col items-center justify-center bg-gray-100">
          <PageTitle />
        </div>
        <div className="w-full md:w-1/2 flex items-center justify-center p-10">
          {isSignup ? (
            <Signup onToggle={() => setIsSignup(false)} />
          ) : (
            <Login onToggle={() => setIsSignup(true)} />
          )}
        </div>
      </div>
      <Footer />
    </div>
  );
};

export default AuthPage;
