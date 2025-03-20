import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { buildPath } from "./Path";

const HistoryTable: React.FC = () => {
  const [history, setHistory] = useState<any[]>([]);
  const [totalPages, setTotalPages] = useState<number>(0);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const token = localStorage.getItem('token');

  const fetchHistory = async (page: number) => {
    try {
      const response = await axios.get(buildPath("api/progress/history"), {
        headers: { 'Authorization': `Bearer ${token}` },
        params: { page, limit: 10 },  // Send page and limit as query params
      });

      console.log("Response is", response);

      setHistory(response.data.history);
      setTotalPages(response.data.totalPages);
      setCurrentPage(response.data.currentPage);
    } catch (error) {
      console.error('Error fetching history:', error);
    }
  };

  const fetchProblem = async (problemId: string) => {
    try {
      const response = await axios.get(buildPath(`api/problems/${problemId}`), {
        headers: { 'Authorization': `Bearer ${token}` },
      });

      const problem = response.data;

      // Encode problem details into a query string
      const problemParams = new URLSearchParams({
        question: problem.question,
        category: problem.category,
        subcategory: problem.subcategory,
        answerCorrect: problem.answerCorrect,
        answersWrong: problem.answersWrong.join(','), // Convert array to comma-separated string
      }).toString();

      // Open a new tab with the problem details
      window.open(`/problem-view?${problemParams}`, '_blank');
    } catch (error) {
      console.error('Error fetching problem:', error);
    }
  };

  useEffect(() => {
    fetchHistory(currentPage);
  }, [currentPage]);

  return (
    <div>
      <h2>User History</h2>
      {history.length === 0 ? (
        <p>No history yet!</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>Date</th>
              <th>Topic</th>
              <th>Result</th>
              <th>View Problem</th>
            </tr>
          </thead>
          <tbody>
            {history.map((entry, index) => (
              <tr key={index}>
                <td>{new Date(entry.datetime).toLocaleString()}</td>
                <td>{entry.topic}</td>
                <td>{entry.isCorrect ? '✅' : '❌'}</td>
                <td>
                  <button onClick={() => fetchProblem(entry.problem_id)}>
                    ➡️
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}

      {/* Pagination Controls */}
      <div>
        <button
          disabled={currentPage === 1}
          onClick={() => setCurrentPage(currentPage - 1)}
        >
          Previous
        </button>
        <span>Page {currentPage} of {totalPages}</span>
        <button
          disabled={currentPage === totalPages}
          onClick={() => setCurrentPage(currentPage + 1)}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default HistoryTable;
