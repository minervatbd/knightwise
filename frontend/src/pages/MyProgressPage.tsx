import React from "react";
import Layout from "../components/Layout";
import Graph from "../components/Graph";

const MyProgressPage: React.FC = () => {
  return (
    <Layout>
      <div className="flex flex-col justify-center items-center h-full">
        <h1 className="text-5xl font-bold mb-4">My Progress</h1>
          <div className="w-5/8 border-3 border-gray-300 p-4 rounded-lg shadow">
            <Graph />
          </div>
      </div>
    </Layout>
  );
};

export default MyProgressPage;
