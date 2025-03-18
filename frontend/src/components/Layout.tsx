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
        <main className="flex-1 overflow-y-auto p-5">{children}</main>
      </div>
    </div>
  );
};

export default Layout;
