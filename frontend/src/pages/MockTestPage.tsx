// This page is for the mock test
import React, { useState, useEffect } from "react";
import Layout from "../components/Layout";
import MockTestInfo from "../components/MockTestInfo";
import MockTestRunner from "../components/MockTestProblem ";
import MockTestResult from "../components/MockTestResult ";

// since no api for question, I'm adding them manually
const dummyProblems = [
  {
    _id: "a1",
    section: "A",
    question: "A1?",
    answerCorrect: "Yes",
    answersWrong: ["No", "Maybe", "What?"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "a2",
    section: "A",
    question: "A1?",
    answerCorrect: "Yes",
    answersWrong: ["No", "Maybe", "What?"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "a3",
    section: "A",
    question: "A13?",
    answerCorrect: "Yes",
    answersWrong: ["No", "Maybe", "What?"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "a4",
    section: "A",
    question: "A12?",
    answerCorrect: "Yes",
    answersWrong: ["No", "Maybe", "What?"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "a4",
    section: "A",
    question: "A15?",
    answerCorrect: "Yes",
    answersWrong: ["No", "Maybe", "What?"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "b1",
    section: "B",
    question: "B1?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "b2",
    section: "B",
    question: "B1?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "b3",
    section: "B",
    question: "B1?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "c1",
    section: "C",
    question: "c121?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "c2",
    section: "C",
    question: "c1?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "c3",
    section: "C",
    question: "sc12?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "d1",
    section: "D",
    question: "d123?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "d2",
    section: "D",
    question: "2s123d?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "d3",
    section: "D",
    question: "d231?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
  {
    _id: "d4",
    question: "d11?",
    answerCorrect: "Correct",
    answersWrong: ["Wrong", "Nope", "Nah"],
    exam_id: "Jan2025",
    category: "DSN",
    subcategory: "Stack",
    points: 10,
  },
];

// function:  select n random questions from a specific section
const getRandomFromSection = (section: string, n: number) => {
  const filtered = dummyProblems.filter(p => p.section === section);
  return filtered.sort(() => 0.5 - Math.random()).slice(0, n);
};

const MockTestPage: React.FC = () => {
  const [step, setStep] = useState<"info" | "test" | "result">("info");
  const [questions, setQuestions] = useState<any[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [sectionScores, setSectionScores] = useState<Record<string, { correct: number; total: number }>>({});
  const [showFeedback, setShowFeedback] = useState(false);

  // 3 random questions from each section
  useEffect(() => {
    if (step === "test") {
      const all = [
        ...getRandomFromSection("A", 3),
        ...getRandomFromSection("B", 3),
        ...getRandomFromSection("C", 3),
        ...getRandomFromSection("D", 3),
      ].map(p => ({
        ...p,
        options: [p.answerCorrect, ...p.answersWrong].sort(() => 0.5 - Math.random()),
      }));
  
      setQuestions(all); 
      setSectionScores({});
      setCurrentIndex(0);
      setSelectedAnswer(null);
      setShowFeedback(false);
    }
  }, [step]);
  

  const current = questions[currentIndex];
  const isCorrect = selectedAnswer?.trim().toLowerCase() === current?.answerCorrect?.trim().toLowerCase();

  // Check whether the answer is correct or not
  // update the score and the status
  const handleSubmit = () => {
    if (!selectedAnswer || !current) return;
    const section = current.section;
    setSectionScores(prev => ({
      ...prev,
      [section]: {
        correct: (prev[section]?.correct || 0) + (isCorrect ? 1 : 0),
        total: (prev[section]?.total || 0) + 1,
      },
    }));
    setShowFeedback(true);
  };

  // show the next question or display the result
  const handleNext = () => {
    if (currentIndex + 1 === questions.length) {
      setStep("result");
    } else {
      setSelectedAnswer(null);
      setShowFeedback(false);
      setCurrentIndex(prev => prev + 1);
    }
  };

  // resets the entire test state
  const restartTest = () => {
    setStep("info");
    setQuestions([]);
    setSectionScores({});
    setCurrentIndex(0);
  };

  return (
    <Layout>
      {/* display info */}
      {step === "info" && <MockTestInfo onStart={() => setStep("test")} />}
      {/* display question */}
      {step === "test" && current && (
        <MockTestRunner
          current={current}
          currentIndex={currentIndex}
          total={questions.length}
          selectedAnswer={selectedAnswer}
          setSelectedAnswer={setSelectedAnswer}
          handleSubmit={handleSubmit}
          handleNext={handleNext}
          showFeedback={showFeedback}
          isCorrect={isCorrect}
        />
      )}
      {/* display result */}
      {step === "result" && (
        <MockTestResult
          sectionScores={sectionScores}
          onRetry={restartTest}
        />
      )}
    </Layout>
  );
};

export default MockTestPage;
