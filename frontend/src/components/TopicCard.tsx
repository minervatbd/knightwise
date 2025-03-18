import React, { useState } from "react";
import { Waypoints, Share2, Layers, ChevronsLeft, Code, MemoryStick, TableProperties , Route, ChevronsRight , Repeat, ArrowUpDown , Sigma } from "lucide-react";

const topics = [
  { title: "Algorithm", icon: <Waypoints size={100} /> },
  { title: "AVL Tree", icon: <Share2 size={100} style={{ transform: "rotate(90deg)" }} /> },
  { title: "Backtracking", icon: <ChevronsLeft  size={100} /> },
  { title: "Binary Tree", icon: <Share2 size={100} style={{ transform: "rotate(90deg)" }} /> },
  { title: "Bitwise Operation", icon: <Code size={100} /> },
  { title: "Dynamic Memory", icon: <MemoryStick size={100} /> },
  { title: "Hash Table", icon: <TableProperties  size={100} /> },
  { title: "Heaps", icon: <Share2 size={100} style={{ transform: "rotate(90deg)" }} /> },
  { title: "Linked List", icon: <Route size={100} /> },
  { title: "Queues", icon: <ChevronsRight  size={100} /> },
  { title: "Recurrence Relations", icon: <Repeat size={100} /> },
  { title: "Recursive", icon: <Repeat size={100} /> },
  { title: "Sorting", icon: <ArrowUpDown size={100} /> },
  { title: "Stacks", icon: <Layers size={100} /> },
  { title: "Summations", icon: <Sigma size={100} /> },
  { title: "Tries", icon: <Share2 size={100} style={{ transform: "rotate(90deg)" }} /> },
];

const TopicCard: React.FC = () => {
  const [selectedTopic, setSelectedTopic] = useState<string | null>(null);

  return (
    <div className="grid grid-cols-4 gap-4 px-4 py-4 justify-items-center w-4/5 h-4/5 mx-auto my-auto items-center">
      {topics.map((topic) => (
        <button
          key={topic.title}
          onClick={() => setSelectedTopic(topic.title)}
          className={`flex flex-col items-center justify-center p-4 border rounded-lg 
            ${
              selectedTopic === topic.title
                ? "bg-yellow-500 text-black"
                : "bg-white text-gray-800"
            }
            hover:bg-gray-200 transition w-48 h-48 shadow-md text-lg font-semibold`}
        >
          <div>{topic.icon}</div>
          <span className="mt-2">{topic.title}</span>
        </button>
      ))}
    </div>
  );
};

export default TopicCard;
