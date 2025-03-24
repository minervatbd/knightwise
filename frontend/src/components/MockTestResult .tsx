import React from "react";
import { useNavigate } from "react-router-dom";

interface MockTestResultProps {
  sectionScores: Record<string, { correct: number; total: number }>;
  onRetry: () => void;
}

const MockTestResult: React.FC<MockTestResultProps> = ({ sectionScores, onRetry }) => {
  const navigate = useNavigate();
  const totalCorrect = Object.values(sectionScores).reduce((acc, sec) => acc + sec.correct, 0);
  const total = Object.values(sectionScores).reduce((acc, sec) => acc + sec.total, 0);
  const percentage = (totalCorrect / total) * 100;

  return (

    <div className="flex flex-col justify-center items-center min-h-screen px-4">
      <h1 className="text-5xl font-black mb-6">Test Completed!</h1>
      <p className="text-2xl mb-6">Here is your performance by section:</p>
      
      {/* shows the number of correct answers by section */}
      <div className="text-xl mb-6 space-y-2">
        {["A", "B", "C", "D"].map((sec) => {
          const s = sectionScores[sec] || { correct: 0, total: 3 };
          return (
            <p key={sec}>
              Section {sec} : <strong>{s.correct}</strong> / {s.total} correct
            </p>
          );
        })}
      </div>

      <p className="text-xl font-medium mb-6 text-center">
        Your score is {percentage.toFixed(1)}% –{" "}
        {percentage < 50 ? "below 50%. Keep practicing!" : "great job!"}
      </p>

      {/* button fot topic test or mocktest */}
      <div className="flex gap-6">
        <button
          onClick={() => navigate("/topic-practice")}
          className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 font-semibold rounded-xl shadow"
        >
          Go to Topic Practice
        </button>
        <button
          onClick={onRetry}
          className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 font-semibold rounded-xl shadow"
        >
          Retry Mock Test
        </button>
      </div>
    </div>
  );
};

export default MockTestResult;
