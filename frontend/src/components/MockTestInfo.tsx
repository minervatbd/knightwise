import React from "react";

const MockTestInfo: React.FC<{ onStart: () => void }> = ({ onStart }) => {
  return (
    <div className="flex justify-center items-center min-h-screen px-4 sm:px-6 md:px-10">
      <div className="bg-gray-200 rounded-lg p-6 sm:p-12 md:p-20 shadow-lg w-full max-w-7xl flex flex-col justify-center items-center text-center">
        <h2 className="text-3xl sm:text-4xl md:text-5xl font-bold mb-6">
          Mock test
        </h2>
        <p className="text-gray-700 mb-8 text-base sm:text-xl md:text-2xl mt-4 max-w-2xl leading-relaxed">
          This test is divided into a total of four sections,
          <br className="hidden sm:block" />
          with each section consisting of three questions.
        </p>
        <button
          onClick={onStart}
          className="bg-yellow-500 hover:bg-yellow-600 text-black font-bold py-2 sm:py-3 px-6 sm:px-8 mt-6 rounded-lg text-base sm:text-lg md:text-xl"
        >
          Start
        </button>
      </div>
    </div>
  );
};

export default MockTestInfo;
