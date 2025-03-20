import React from "react";
import Layout from "../components/Layout";
import Graph from "../components/Graph";
import HistoryTable from "../components/HistoryTable"; // Import HistoryTable component

const MyProgressPage: React.FC = () => {
  return (
    <Layout>
      <div className="flex flex-col justify-center items-center h-full">
        <h1 className="text-5xl font-bold mb-4">My Progress</h1>

        {/* Graph Section */}
        <div className="w-5/8 border-3 border-gray-300 p-4 rounded-lg shadow mb-6">
          <Graph />
        </div>

        {/* History Table Section */}
        <div className="w-5/8 border-3 border-gray-300 p-4 rounded-lg shadow">
          <HistoryTable /> {/* Add the HistoryTable component here */}
        </div>
      </div>
    </Layout>
  );
};

export default MyProgressPage;
