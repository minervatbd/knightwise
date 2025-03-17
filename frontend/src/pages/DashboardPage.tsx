// dashboard main page 

import Header from "../components/Header";
import Sidebar from "../components/Sidebar";
import Dashboard from "../components/Dashboard";

const DashBoardPage = () => (
    <div className="flex flex-col h-screen">
        <Header /> 
        <div className="flex flex-1">
            <Sidebar /> 
            <main className="flex-1 p-5 overflow-y-auto">
                <Dashboard />
            </main>
        </div>
    </div>
);

export default DashBoardPage;
