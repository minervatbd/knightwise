import React from "react";
import Layout from "../components/Layout";
import TopicCard from "../components/TopicCard";

const TopicPage: React.FC = () => (
  <Layout>
    <h1 className="text-5xl pt-6 font-bold text-center my-6">Choose your topics</h1>
    <TopicCard />
  </Layout>
);

export default TopicPage;

