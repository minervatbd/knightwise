import React from "react";
import logo from "../assets/ucflogo.png";
import { Menu } from "lucide-react";
import { useLocation } from "react-router-dom";


const Header: React.FC<{ onMenuClick?: () => void }> = ({ onMenuClick }) => {

  // collapse sidebar on small screens 
  // but hide sidebar when logging in/signing up
  const location = useLocation();
  const hideMenu = location.pathname === "/";

  return (
    <header className="bg-black text-yellow-400 py-4 px-6 flex items-center justify-between">
      <div className="flex items-center space-x-4">
        {!hideMenu && (
          <button className="md:hidden mr-2" onClick={onMenuClick}>
            <Menu size={28} />
          </button>
        )}
        <img src={logo} alt="UCF Logo" className="w-12 h-12" />
        <h1 className="text-lg font-bold hidden sm:block">
          UNIVERSITY OF CENTRAL FLORIDA
        </h1>
      </div>
    </header>
  );
};

export default Header;


