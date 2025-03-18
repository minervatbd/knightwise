import React from "react";
import Layout from "../components/Layout";
import MockTestInfo from "../components/MockTestInfo";

const MockTestPage: React.FC = () => {
  return (
    <Layout>
      <div className="flex justify-center items-center h-full">
        <MockTestInfo />
      </div>
    </Layout>
  );
};

export default MockTestPage;
