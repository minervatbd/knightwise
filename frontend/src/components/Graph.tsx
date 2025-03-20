import React from 'react';
import { Radar } from "react-chartjs-2";
import {
  Chart as ChartJS,
  RadialLinearScale,
  PointElement,
  LineElement,
  Filler,
  Tooltip,
  Legend,
  ChartOptions,
} from "chart.js";

// Register required chart elements
ChartJS.register(RadialLinearScale, PointElement, LineElement, Filler, Tooltip, Legend);

const data = {
  labels: ["Algorithm Analysis",
           "AVL Trees", 
           "Backtracking", 
           "Base Conversion", 
           "Binary Trees", 
           "Bitwise Operators",
           "Dynamic Memory",
           "Hash Tables",
           "Heaps",
           "Linked Lists",
           "Queues",
           "Recurrence Relations",
           "Recursion",
           "Sorting",
           "Stacks",
           "Summations",
           "Tries"],
  datasets: [
    {
      label: "Mastery Level",
      // Dummy data for now
      data: [80, 
             70, 
             65, 
             90, 
             60, 
             75,
             50,
             60,
             35,
             70,
             90,
             93,
             39,
             50,
             79,
             49,
             90], // Example data values
      backgroundColor: "rgba(255, 201, 4, 0.2)",
      borderColor: "rgba(255, 201, 4, 1)",
      borderWidth: 2,
      pointBackgroundColor: "rgba(255, 201, 4, 1)",
    },
  ],
};

const options: ChartOptions<"radar"> = {
  responsive: true,
  maintainAspectRatio: false,
  scales: {
    r: {
      beginAtZero: true,
      suggestedMin: 0,
      suggestedMax: 100,
      angleLines: { color: "rgba(0,0,0,0.2)" },
      grid: { color: "rgba(0,0,0,0.2)" },
      pointLabels: { font: { size: 14 } },
    },
  },
  plugins: {
    legend: { display: true, position: "top" },
    tooltip: { enabled: true },
  },
};

const Graph: React.FC = () => {
  return (
    <div style={{ width: "100%", height: "400px" }}>
      <Radar data={data} options={options} />
    </div>
  );
};

export default Graph;
