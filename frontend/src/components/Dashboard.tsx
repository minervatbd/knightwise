import { useState, useEffect } from "react";

interface TimeLeft {
  days: number;
  hours: number;
  minutes: number;
  seconds: number;
}
const Dashboard: React.FC = () => {
  // set founcdation exam date
  // set the date of the Summer 2025 semester to first weeek Saturday
  const targetDate = new Date("2025-05-17T00:00:00").getTime();

  // function: calculate timeleft
  const calculateTimeLeft = (): TimeLeft => {
    const now = Date.now();
    const difference = targetDate - now;

    return {
      days: Math.floor(difference / (1000 * 60 * 60 * 24)),
      hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
      minutes: Math.floor((difference / (1000 * 60)) % 60),
      seconds: Math.floor((difference / 1000) % 60),
    };
  };

  // store the remaining time
  const [timeLeft, setTimeLeft] = useState<TimeLeft>(calculateTimeLeft());

  // update time per 1 sec
  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft(calculateTimeLeft());
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  return (
    <div className="p-20 flex flex-col items-center">
      {/* countdowm */}
      <div className="bg-gray-200 shadow-lg rounded-xl p-6 text-center mb-8 w-3/4">
        <h2 className="text-3xl font-semibold mb-2">
          The Foundation Exam is in...
        </h2>
        <div className="flex justify-center items-center space-x-8 text-7xl font-bold">
          <div className="text-gray-900">
            {timeLeft.days}{" "}
            <span className="block text-base font-medium">DAYS</span>
          </div>
          <div className="text-gray-900">
            {timeLeft.hours}{" "}
            <span className="block text-base font-medium">HOURS</span>
          </div>
          <div className="text-gray-900">
            {timeLeft.minutes}{" "}
            <span className="block text-base font-medium">MINUTES</span>
          </div>
          <div className="text-gray-900">
            {timeLeft.seconds}{" "}
            <span className="block text-base font-medium">SECONDS</span>
          </div>
        </div>
      </div>

      {/* guideline for UCF foundation exam */}
      {/* note: link didn't work properly locally */}
      <div className=" bg-gray-200 p-10 rounded-lg shadow-md w-3/4">
        <h3 className="text-5xl text-center font-semibold mb-6 p-5">
          Foundation Exam Guideline
        </h3>
        <ul className="list-disc list-inside text-2xl text-gray-800 space-y-4 p-5">
          <li>
            <strong>Purpose:</strong> Required exam for 4000-level CS courses
          </li>
          <li>
            <strong>Eligibility:</strong> Students who passed COP 3502 (C or
            higher)
          </li>
          <li>
            <strong>Attempts:</strong> Max three attempts within one year
          </li>
          <li>
            <strong>Schedule:</strong> First Saturday of each semester
          </li>
          <li>
            <strong>Registration:</strong>{" "}
            <a
              href="https://www.cs.ucf.edu/registration/new/message.php"
              className="text-blue-700 underline font-semibold text-xl"
            >
              Register here
            </a>
          </li>
          <li>
            <strong>Allowed Materials:</strong>{" "}
            <a
              href="https://www.cs.ucf.edu/wp-content/uploads/2019/08/FE-FormulaSheet.pdf"
              className="text-blue-700 underline font-semibold text-xl"
            >
              Formula Sheet
            </a>
          </li>
          <li>
            <strong>Exam Day Rules:</strong>
          </li>
          <ul className="list-disc list-inside ml-8 text-2xl">
            <li>Bring valid ID</li>
            <li>No electronic devices</li>
            <li>Time limit enforced</li>
          </ul>
          <li>
            <strong>Passing Criteria:</strong> Typically 60% or higher
          </li>
          <li>
            <strong>More Info:</strong>{" "}
            <a
              href="https://www.cs.ucf.edu/ucf_section/foundation-exam/"
              className="text-blue-700 underline font-semibold text-xl"
            >
              Official Site
            </a>
          </li>
        </ul>
      </div>
    </div>
  );
};

export default Dashboard;
