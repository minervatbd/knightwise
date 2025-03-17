import { useState } from "react";
import { Link } from "react-router-dom";
import { LogOut, BookOpen, BarChart2, Lightbulb, GraduationCap } from "lucide-react"; // for icons

const Sidebar = () => {
  const [active, setActive] = useState("Dashboard");

  const menuItems = [
    { name: "Dashboard", icon: <BookOpen size={24} />, path: "/dashboard" },
    { name: "Topic Practice", icon: <Lightbulb size={24} />, path: "/topic-practice" },
    { name: "Mock Test", icon: <GraduationCap size={24} />, path: "/mock-test" },
    { name: "My Progress", icon: <BarChart2 size={24} />, path: "/my-progress" },
  ];

  // This code is based on Dr.Reinenker's code
  const doLogout = (event: React.MouseEvent<HTMLButtonElement, MouseEvent>) => {
    event.preventDefault();
    localStorage.removeItem("user_data"); 
    window.location.href = "/"; 
  };

  return (
    <div className="h-screen w-72 bg-gray-100 p-6 shadow-lg flex flex-col">
      <h1 className="text-2xl font-bold pt-10 mb-10 text-center">John Doe</h1>
      <nav className="flex-1">
        {menuItems.map((item) => (
          <Link
            key={item.name}
            to={item.path}
            className={`flex items-center gap-4 p-4 rounded-lg mb-3 text-xl transition-colors cursor-pointer ${
              active === item.name ? "bg-yellow-500 text-white font-semibold" : "hover:bg-gray-200"
            }`}
            onClick={() => setActive(item.name)}
          >
            {item.icon}
            {item.name}
          </Link>
        ))}
      </nav>
      <button
        className="flex items-center gap-4 p-4 mt-6 rounded-lg text-xl text-gray-700 bg-white shadow-md border border-gray-300 hover:bg-gray-200 transition-all"
        onClick={doLogout}
      >
        <LogOut size={24} className=" text-gray-700" />
        <span className=" text-gray-700 font-semibold">Log out</span>
      </button>
    </div>
  );
};

export default Sidebar;