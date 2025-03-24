import React from "react";

type Props = {
  current: any;
  currentIndex: number;
  total: number;
  selectedAnswer: string | null;
  setSelectedAnswer: (val: string) => void;
  handleSubmit: () => void;
  handleNext: () => void;
  showFeedback: boolean;
  isCorrect: boolean;
};

const MockTestProblem: React.FC<Props> = ({
  current,
  currentIndex,
  total,
  selectedAnswer,
  setSelectedAnswer,
  handleSubmit,
  handleNext,
  showFeedback,
  isCorrect,
}) => (
  <div className="max-w-3xl mx-auto p-8 mt-20">
    
    {/* top: section, category, subcategory, exam date */}
    <div className="flex justify-between mb-2 text-2xl">
      <p className="text-gray-600">Section {current.section}</p>
      <p className="font-medium">
        Question {currentIndex + 1} of {total}
      </p>
    </div>
    <h1 className="text-5xl font-bold text-gray-900 mb-2">
      {current.category} <span className="text-yellow-600">&gt;</span>{" "}
      {current.subcategory}
      <span className="text-2xl text-gray-500 font-normal ml-2">
        (Exam Date: {current.exam_id})
      </span>
    </h1>

    {/* content: question, multiple chioce, and summit button */}
    <h2 className="text-2xl font-bold mb-4">
      Q{currentIndex + 1}. {current.question}
    </h2>
    <div className="space-y-3">
      {current.options.map((ans: string, idx: number) => (
        <label
          key={idx}
          className={`block p-4 rounded-lg border transition cursor-pointer text-xl ${
            selectedAnswer === ans
              ? "bg-yellow-100 border-yellow-500"
              : "bg-white border-gray-300 hover:bg-gray-50"
          }`}
        >
          <input
            type="radio"
            name="answer"
            value={ans}
            checked={selectedAnswer === ans}
            onChange={() => setSelectedAnswer(ans)}
            className="mr-3"
          />
          {ans}
        </label>
      ))}
    </div>
    <div className="mt-6 text-xl">
      <button
        onClick={showFeedback ? handleNext : handleSubmit}
        className={`px-6 py-3 rounded shadow font-semibold ${
          showFeedback
            ? "bg-yellow-400 hover:bg-yellow-500 text-black"
            : "bg-yellow-600 hover:bg-yellow-700 text-white"
        }`}
      >
        {showFeedback && currentIndex + 1 === total
          ? "Result"
          : showFeedback
          ? "Next"
          : "Submit"}
      </button>
    </div>

    {/* bottom: display correct answer */}
    {showFeedback && (
      <div className="mt-6 p-4 bg-gray-100 text-center rounded text-lg font-medium">
        {isCorrect ? (
          <p className="text-green-600">Correct answer!</p>
        ) : (
          <p className="text-red-600">
            Incorrect answer. The correct answer is:{" "}
            <strong>{current.answerCorrect}</strong>
          </p>
        )}
      </div>
    )}
  </div>
);

export default MockTestProblem;
