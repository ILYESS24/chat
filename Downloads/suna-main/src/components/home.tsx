import { Sidebar } from "./kortix/Sidebar";
import { ChatInterface } from "./kortix/ChatInterface";

function Home() {
  return (
    <div className="dark flex w-screen h-screen bg-[#0D0D0D] text-[#F5F5F5] overflow-hidden font-sans">
      <Sidebar />
      <ChatInterface />
    </div>
  )
}

export default Home
