// this page shows questions related to the chosen topic
import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import Layout from "../components/Layout";

// since no api for question, I'm adding them manually
const dummyProblems = [
  {
    _id: "1",
    exam_id: "jan2025",
    section: "A",
    category: "DSN",
    subcategory: "Sorting",
    points: 10,
    question: "test1-multiple",
    answerCorrect: "test1",
    answersWrong: ["test2", "test3", "test4"],
  },
  {
    _id: "2",
    exam_id: "jan2025",
    section: "B",
    category: "DSN",
    subcategory: "Sorting",
    points: 10,
    question: "test2-subjective",
    answerCorrect: "test1",
    answersWrong: ["test2", "test3", "test4"],
  },
  {
    _id: "3",
    exam_id: "jan2025",
    section: "C",
    category: "DSN",
    subcategory: "Sorting",
    points: 10,
    question: "test3-t/f",
    answerCorrect: "test1",
    answersWrong: ["test2", "test3", "test4"],
  },
  {
    _id: "4",
    exam_id: "jan2025",
    section: "D",
    category: "DSN",
    subcategory: "Sorting",
    points: 10,
    question: "test4-code",
    answerCorrect: "test1",
    answersWrong: ["test2", "test3", "test4"],
  },
];

const TopicTestPage: React.FC = () => {
  const { topicName } = useParams<{ topicName: string }>();
  const [problems, setProblems] = useState<any[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [answered, setAnswered] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  const [showResult, setShowResult] = useState(false);
  const navigate = useNavigate();

  // need an API that can retrieve questions based on a topic or section
  useEffect(() => {
    if (topicName?.toUpperCase() === "SORTING") {
      const withOptions = dummyProblems.map((p) => ({
        ...p,
        options: [p.answerCorrect, ...p.answersWrong].sort(
          () => 0.5 - Math.random()
        ),
      }));
      setProblems(withOptions);
    }
  }, [topicName]);

  // Check whether the answer is correct or not
  // update the score and the status
  const handleSubmit = () => {
    if (!selectedAnswer) return;
    const current = problems[currentIndex];
    if (selectedAnswer === current.answerCorrect)
      setCorrectCount((prev) => prev + 1);
    setAnswered(true);
  };

  // show the next question or display the result
  const handleNext = () => {
    setSelectedAnswer(null);
    setAnswered(false);
    if (currentIndex + 1 < problems.length) {
      setCurrentIndex((prev) => prev + 1);
    } else {
      setShowResult(true);
    }
  };

  // if the question doesn't exist
  if (!problems.length) {
    return (
      <Layout>
        <div className="text-center text-2xl mt-20 font-semibold text-gray-700">
          Problem not found
        </div>
      </Layout>
    );
  }

  // after finishing all the questions, display the number of correct answers
  // then, choose whether to select another topic or take a mock test
  if (showResult) {
    return (
      <Layout>
        <div className="text-center mt-56">
          <h1 className="text-6xl font-bold mb-4">Quiz Completed!</h1>
          <p className="text-2xl font-medium mb-2">
            You got {correctCount} out of {problems.length} question correct!
          </p>
          <p className="text-2xl mb-6">Great job!</p>
          <div className="flex justify-center space-x-6">
            <button
              onClick={() => navigate("/topic-practice")}
              className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 font-semibold rounded-full shadow"
            >
              Go to different topic
            </button>
            <button
              onClick={() => navigate("/mock-test")}
              className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 font-semibold rounded-full shadow"
            >
              Go to mock test
            </button>
          </div>
        </div>
      </Layout>
    );
  }

  const current = problems[currentIndex];

  // show question
  return (
    <Layout>
      <div className="max-w-5xl mx-auto p-8 mt-20">
        {/* top: subcategory, exam date */}
        <div className="flex justify-between mb-6">
          <h1 className="text-5xl font-bold text-gray-900 flex items-center gap-4">
            <span>{current.subcategory}</span>
            <span className="text-2xl text-gray-500 font-normal">
              (Exam Date: {current.exam_id})
            </span>
          </h1>
          <p className="text-2xl font-medium">
            Question {currentIndex + 1} of {problems.length}
          </p>
        </div>

        {/* content: question, multiple chioce, and summit button */}
        <div className="mb-4">
          <h2 className="text-2xl font-bold mb-2">
            Q{currentIndex + 1}. {current.question}
          </h2>
        </div>
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
        <div className="mt-6 flex space-x-4 text-xl">
          {!answered ? (
            <button
              onClick={handleSubmit}
              className="bg-yellow-600 hover:bg-yellow-700 text-white px-6 py-3 rounded shadow"
            >
              Submit
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 rounded shadow"
            >
              {currentIndex + 1 === problems.length ? "Result" : "Next"}
            </button>
          )}
        </div>

        {/* bottom: display correct answer */}
        {answered && (
          <div className="mt-6 p-4 bg-gray-100 text-center rounded text-lg font-medium">
            {selectedAnswer === current.answerCorrect ? (
              <p className="text-black">Correct answer!</p>
            ) : (
              <p className="text-red-600">
                Incorrect. Correct answer:{" "}
                <strong>{current.answerCorrect}</strong>
              </p>
            )}
          </div>
        )}
      </div>
    </Layout>
  );
};

export default TopicTestPage;
