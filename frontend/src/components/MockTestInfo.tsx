import React from "react";

const MockTestInfo: React.FC = () => {
  return (
    <div className="flex justify-center items-center min-h-screen p-10">
      <div className="bg-gray-200 rounded-lg p-32 hadow-lg w-full max-w-7xl flex flex-col justify-center items-center text-center">
        <h2 className="text-5xl font-bold mb-6">Mock test</h2>
        <p className="text-gray-700 mb-8 text-3xl mt-8 max-w-2xl">
          This test is divided into a total of four sections,<br/>
          with each section consisting of three questions.
        </p>
        <button className="bg-yellow-500 hover:bg-yellow-600 text-black font-bold py-3 px-8 mt-8 rounded-lg text-2xl">
          Start
        </button>
      </div>
    </div>
  );
};

export default MockTestInfo;