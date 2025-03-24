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
        params: { page, limit: 10 },
      });

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
      const problemParams = new URLSearchParams({
        question: problem.question,
        category: problem.category,
        subcategory: problem.subcategory,
        answerCorrect: problem.answerCorrect,
        answersWrong: problem.answersWrong.join(','),
      }).toString();

      const width = 600;
      const height = 400;
      const left = (window.innerWidth - width) / 2;
      const top = (window.innerHeight - height) / 2;

      const popupWindow = window.open(
        `/problem-view?${problemParams}`, 
        '_blank', 
        `width=${width},height=${height},top=${top},left=${left},resizable=yes,scrollbars=yes`
      );

      if (popupWindow) {
        popupWindow.focus();
      }
    } catch (error) {
      console.error('Error fetching problem:', error);
    }
  };

  useEffect(() => {
    fetchHistory(currentPage);
  }, [currentPage]);

  return (
    <div className="m-1">
      <h2 className="text-2xl font-semibold text-center mb-4">Problem History</h2>
      {history.length === 0 ? (
        <p className="text-center">No history yet!</p>
      ) : (
        <div className="overflow-hidden rounded-lg shadow-lg">
          <table className="min-w-full table-auto">
            <thead className="bg-[#333333] text-white">
              <tr>
                <th className="px-4 py-2">Date</th>
                <th className="px-4 py-2">Topic</th>
                <th className="px-4 py-2">Result</th>
                <th className="px-4 py-2">View Problem</th>
              </tr>
            </thead>
            <tbody>
              {history.map((entry, index) => (
                <tr key={index} className={index % 2 === 0 ? 'bg-[#EEEEEE]' : 'bg-[#BBBBBB]'}>
                  <td className="px-4 py-2 text-center">{new Date(entry.datetime).toLocaleString()}</td>
                  <td className="px-4 py-2 text-center">{entry.topic}</td>
                  <td className="px-4 py-2 text-center">{entry.isCorrect ? '✅' : '❌'}</td>
                  <td className="px-4 py-2 text-center">
                    <button
                      className="px-3 py-1 text-white bg-blue-500 rounded hover:bg-blue-700"
                      onClick={() => fetchProblem(entry.problem_id)}
                    >
                      ➡️
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
  
      {/* Pagination Controls */}
      <div className="flex justify-center items-center mt-4 space-x-4">
        <button
          disabled={currentPage === 1}
          onClick={() => setCurrentPage(currentPage - 1)}
          className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-700 disabled:bg-gray-300 disabled:text-gray-700 disabled:border-gray-400 disabled:cursor-not-allowed"
        >
          Previous
        </button>
        <span className="text-lg">{`Page ${currentPage} of ${totalPages}`}</span>
        <button
          disabled={currentPage === totalPages}
          onClick={() => setCurrentPage(currentPage + 1)}
          className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-700 disabled:bg-gray-300 disabled:text-gray-700 disabled:border-gray-400 disabled:cursor-not-allowed"
        >
          Next
        </button>
      </div>
    </div>
  );
}  

export default HistoryTable;
