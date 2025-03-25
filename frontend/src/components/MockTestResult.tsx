import React from "react";
import { useNavigate } from "react-router-dom";

interface MockTestResultProps {
  sectionScores: Record<string, { correct: number; total: number }>;
  onRetry: () => void;
}

const MockTestResult: React.FC<MockTestResultProps> = ({
  sectionScores,
  onRetry,
}) => {
  const navigate = useNavigate();

  // calculate total score
  let totalCorrect = 0;
  let totalQuestions = 0;
  for (const sec in sectionScores) {
    totalCorrect += sectionScores[sec].correct;
    totalQuestions += sectionScores[sec].total;
  }

  // calcualate percentage
  const percentage = (totalCorrect / totalQuestions) * 100;

  return (
    <div className="flex flex-col justify-center items-center min-h-screen px-4 sm:px-8 py-8 text-center">
      <h1 className="text-3xl sm:text-4xl md:text-5xl font-black mb-4 sm:mb-6">
        Test Completed!
      </h1>

      <p className="text-lg sm:text-xl md:text-2xl mb-4 sm:mb-6">
        Here is your performance by section:
      </p>

      {/* display section score */}
      <div className="text-base sm:text-lg md:text-xl mb-4 sm:mb-6 space-y-2">
        {["A", "B", "C", "D"].map((sec) => {
          const score = sectionScores[sec] || { correct: 0, total: 3 };
          return (
            <p key={sec}>
              Section {sec} : <strong>{score.correct}</strong> / {score.total} correct
            </p>
          );
        })}
      </div>

      {/* total */}
      <p className="text-base sm:text-lg md:text-xl font-medium mb-4 sm:mb-6">
        Your score is {percentage.toFixed(1)}% –{" "}
        {percentage < 50 ? "below 50%. Keep practicing!" : "great job!"}
      </p>

      {/* next option */}
      <div className="flex flex-col sm:flex-row gap-4 sm:gap-6">
        <button
          onClick={() => navigate("/topic-practice")}
          className="bg-yellow-400 hover:bg-yellow-500 text-black px-5 sm:px-6 py-2 sm:py-3 text-sm sm:text-base md:text-lg font-semibold rounded-xl shadow"
        >
          Go to Topic Practice
        </button>
        <button
          onClick={onRetry}
          className="bg-yellow-400 hover:bg-yellow-500 text-black px-5 sm:px-6 py-2 sm:py-3 text-sm sm:text-base md:text-lg font-semibold rounded-xl shadow"
        >
          Retry Mock Test
        </button>
      </div>
    </div>
  );
};

export default MockTestResult;
