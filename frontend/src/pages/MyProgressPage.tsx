import React from "react";
import Layout from "../components/Layout";
import Graph from "../components/Graph";

const MockTestPage: React.FC = () => {
  return (
    <Layout>
      <div className="flex justify-center items-center h-full">
        <Graph />
      </div>
    </Layout>
  );
};

export default MockTestPage;
