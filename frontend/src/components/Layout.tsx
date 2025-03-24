// to keep same layout for content page
// top: header, left: sidebar
import React, { PropsWithChildren } from "react";
import Sidebar from "./Sidebar";
import Header from "./Header";

const Layout: React.FC<PropsWithChildren<{}>> = ({ children }) => {
  return (
    <div className="flex flex-col h-screen">
      <Header />
      <div className="flex flex-1 overflow-hidden">
        <Sidebar />
        <main className="flex-grow min-h-0 overflow-y-auto">{children}</main>
      </div>
    </div>
  );
};

export default Layout;
