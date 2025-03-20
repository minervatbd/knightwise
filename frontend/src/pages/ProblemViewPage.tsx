import React from 'react';
import { useLocation } from 'react-router-dom';

const ProblemViewPage: React.FC = () => {
  const location = useLocation();
  const params = new URLSearchParams(location.search);

  const problem = {
    question: params.get('question') || 'Unknown',
    category: params.get('category') || 'Unknown',
    subcategory: params.get('subcategory') || 'Unknown',
    answerCorrect: params.get('answerCorrect') || 'Unknown',
    answersWrong: params.get('answersWrong') ? params.get('answersWrong')!.split(',') : [],
  };

  return (
    <div>
      <h2>Problem Details</h2>
      <p><strong>Question:</strong> {problem.question}</p>
      <p><strong>Category:</strong> {problem.category}</p>
      <p><strong>Subcategory:</strong> {problem.subcategory}</p>
      <p><strong>Correct Answer:</strong> {problem.answerCorrect}</p>
      <p><strong>Wrong Answers:</strong> {problem.answersWrong.join(', ')}</p>
    </div>
  );
};

export default ProblemViewPage;
