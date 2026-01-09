import React, { useState } from "react";
import {
  Bell,
  ChevronDown,
  Plus,
  Paperclip,
  Mic,
  ArrowRight,
  MonitorPlay,
  BarChart3,
  FileText,
  Layout,
  Video,
  Search,
  Image as ImageIcon,
  X,
  Lock,
  RefreshCw,
  Cloud
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

interface HomeViewProps {
  onStartChat: () => void;
}

export const HomeView = ({ onStartChat }: HomeViewProps) => {
  const [activeTab, setActiveTab] = useState("Slides");

  return (
    <div className="flex-1 flex flex-col h-screen bg-[#0D0D0D] text-[#F5F5F5] font-sans overflow-hidden">
      {/* Top Header */}
      <header className="h-14 border-b border-transparent flex items-center justify-between px-6 shrink-0">
        <div className="flex items-center gap-2 cursor-pointer hover:bg-[#1A1A1A] px-2 py-1 rounded-md transition-colors">
          <span className="font-heading font-bold text-lg">AURION CHAT</span>
          <ChevronDown className="w-4 h-4 text-[#A0A0A0]" />
        </div>
      </header>

      {/* Main Content - Centered */}
      <main className="flex-1 flex flex-col items-center justify-center p-4 sm:p-8 max-w-5xl mx-auto w-full overflow-y-auto scrollbar-hide">

        {/* Hero Text */}
        <h1 className="text-3xl md:text-4xl font-heading font-bold mb-8 text-center tracking-tight">
          Qu'est-ce que tu veux accomplir ?
        </h1>

        {/* Upgrade Banner */}
        <div className="w-full max-w-3xl bg-[#151515] border border-[#2A2A2A] rounded-xl p-4 mb-6 flex items-center justify-between relative group">
          <div className="flex items-center gap-3">
            <Badge className="bg-[#2A2A2A] text-[#A0A0A0] hover:bg-[#2A2A2A] border-0 px-2 py-0.5 text-xs font-normal">⌘ Plus</Badge>
            <div>
              <div className="font-medium text-sm">Unlock the full Kortix experience</div>
              <div className="text-xs text-[#A0A0A0]">Kortix Advanced mode, 100+ Integrations, Triggers, Custom AI Workers & more</div>
            </div>
          </div>
          <Button variant="ghost" size="icon" className="h-6 w-6 text-[#A0A0A0] hover:text-[#F5F5F5] hover:bg-[#2A2A2A]">
            <X className="w-3 h-3" />
          </Button>
        </div>

        {/* Main Input Area */}
        <div className="w-full max-w-3xl relative mb-6">
          <div className="bg-[#151515] border border-[#2A2A2A] rounded-2xl p-4 min-h-[140px] flex flex-col shadow-lg transition-all focus-within:border-[#333] focus-within:shadow-[0_0_20px_rgba(0,0,0,0.5)]">
            <textarea
              placeholder="Décris ce dont tu as besoin d'aide..."
              className="w-full bg-transparent border-none focus:ring-0 resize-none text-[#F5F5F5] placeholder:text-[#555] text-lg min-h-[60px] outline-none"
              onKeyDown={(e) => {
                if (e.key === 'Enter' && !e.shiftKey) {
                  e.preventDefault();
                  onStartChat();
                }
              }}
            />

            <div className="mt-auto flex items-center justify-between pt-4">
              <div className="flex items-center gap-2">
                <Button variant="ghost" size="icon" className="h-9 w-9 rounded-full text-[#A0A0A0] hover:bg-[#2A2A2A] hover:text-[#F5F5F5]">
                  <Paperclip className="w-4 h-4" />
                </Button>

                <Button variant="ghost" size="icon" className="h-9 w-9 rounded-full text-[#0066FF] hover:bg-[#2A2A2A] relative border border-[#333]/50">
                    <Cloud className="w-4 h-4 fill-current" />
                </Button>

                <div className="flex items-center gap-1 bg-[#222] rounded-full px-3 py-1.5 border border-[#333] cursor-pointer hover:bg-[#2A2A2A] transition-colors">
                  <MonitorPlay className="w-3.5 h-3.5 text-[#F5F5F5]" />
                  <span className="text-xs font-medium">Slides</span>
                  <X className="w-3 h-3 text-[#A0A0A0] ml-1" />
                </div>
              </div>

              <div className="flex items-center gap-2">
                <Button variant="ghost" size="icon" className="h-9 w-9 rounded-full text-[#A0A0A0] hover:bg-[#2A2A2A] hover:text-[#F5F5F5]">
                  <Mic className="w-4 h-4" />
                </Button>
                <Button
                  size="icon"
                  onClick={onStartChat}
                  className="h-9 w-9 rounded-xl bg-[#2A2A2A] hover:bg-[#333] text-[#F5F5F5] border border-[#333]"
                >
                  <ArrowRight className="w-4 h-4" />
                </Button>
              </div>
            </div>
          </div>
        </div>

        {/* Content Type Selector */}
        <div className="w-full max-w-3xl flex items-center gap-2 mb-12 overflow-x-auto pb-2 scrollbar-hide">
          <TypeButton icon={<MonitorPlay className="w-4 h-4" />} label="Slides" active={activeTab === "Slides"} onClick={() => setActiveTab("Slides")} />
          <TypeButton icon={<BarChart3 className="w-4 h-4" />} label="Data" active={activeTab === "Data"} onClick={() => setActiveTab("Data")} />
          <TypeButton icon={<FileText className="w-4 h-4" />} label="Docs" active={activeTab === "Docs"} onClick={() => setActiveTab("Docs")} />
          <TypeButton icon={<Layout className="w-4 h-4" />} label="Canvas" active={activeTab === "Canvas"} onClick={() => setActiveTab("Canvas")} />
          <TypeButton icon={<Video className="w-4 h-4" />} label="Video" active={activeTab === "Video"} onClick={() => setActiveTab("Video")} />
          <TypeButton icon={<Search className="w-4 h-4" />} label="Research" active={activeTab === "Research"} onClick={() => setActiveTab("Research")} />
          <TypeButton icon={<ImageIcon className="w-4 h-4" />} label="Image" active={activeTab === "Image"} onClick={() => setActiveTab("Image")} />
        </div>

        {/* Template Gallery */}
        <div className="w-full max-w-4xl">
           <div className="flex items-center justify-between mb-4">
             <h3 className="text-sm text-[#555] font-medium">Exemples de prompts</h3>
             <Button variant="ghost" size="icon" className="h-6 w-6 text-[#555] hover:text-[#A0A0A0]">
               <RefreshCw className="w-3 h-3" />
             </Button>
           </div>

           <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
             <TemplateCard
               image="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=300&q=80"
               title="Minim"
               subtitle="Développer un deck de vente"
               onClick={onStartChat}
             />
             <TemplateCard
               title="Welcome to this presentation!"
               subtitle="Concevoir une présentation"
               type="text"
               onClick={onStartChat}
             />
             <TemplateCard
               title="721M"
               subtitle="Construire une revue"
               extra="10,000 3112K"
               type="data"
               color="bg-[#00D9B4]"
               onClick={onStartChat}
             />
             <TemplateCard
               title="%"
               subtitle="Créer une mise à jour"
               topText="Number Data"
               type="big-text"
               onClick={onStartChat}
             />
           </div>
        </div>

      </main>
    </div>
  );
};

const TypeButton = ({ icon, label, active, onClick }: { icon: React.ReactNode, label: string, active?: boolean, onClick: () => void }) => (
  <button
    onClick={onClick}
    className={cn(
      "flex items-center gap-2 px-4 py-2 rounded-full text-sm font-medium transition-all border",
      active
        ? "bg-[#F5F5F5] text-black border-[#F5F5F5]"
        : "bg-transparent text-[#A0A0A0] border-[#2A2A2A] hover:bg-[#1A1A1A] hover:text-[#F5F5F5]"
    )}
  >
    {icon}
    <span>{label}</span>
  </button>
);

const TemplateCard = ({ image, title, subtitle, topText, extra, type = "image", color, onClick }: any) => {
  return (
    <div className="group cursor-pointer" onClick={onClick}>
      <div className={cn(
        "h-32 rounded-xl overflow-hidden mb-3 border border-[#2A2A2A] relative transition-transform group-hover:-translate-y-1 group-hover:shadow-lg",
        type === "text" ? "bg-white text-black p-4 flex items-center" :
        type === "data" ? "bg-[#1A1A1A] p-4 flex flex-col justify-between" :
        type === "big-text" ? "bg-[#F5F5F5] text-black p-4" : "bg-[#1A1A1A]"
      )}>
        {type === "image" && (
          <div className="h-full w-full relative">
            <img src={image} alt="" className="w-full h-full object-cover opacity-60" />
            <div className="absolute inset-0 flex items-end p-4">
               <span className="text-white font-heading font-bold text-xl">{title}</span>
            </div>
          </div>
        )}

        {type === "text" && (
           <h3 className="font-heading text-2xl font-bold leading-tight">{title}</h3>
        )}

        {type === "data" && (
           <div className="w-full h-full flex flex-col">
             <div className="flex justify-between items-start">
               <div className={cn("px-2 py-0.5 rounded text-xs font-bold", color ? "bg-[#00D9B4] text-black" : "bg-gray-200")}>
                 {title}
               </div>
               <div className="text-[10px] text-gray-400">Overview of Key<br/>Yearly Achievements</div>
             </div>
             <div className="flex items-end gap-2 mt-auto">
                <span className="text-xs bg-gray-800 text-white px-1 rounded">4,876</span>
                <span className="text-2xl text-white font-mono">721M</span>
             </div>
           </div>
        )}

        {type === "big-text" && (
          <div className="h-full flex flex-col">
            <div className="text-xs font-bold uppercase mb-1">{topText}</div>
            <div className="text-[10px] text-gray-500">Visualization</div>
            <div className="mt-auto self-end text-6xl font-light">{title}</div>
          </div>
        )}
      </div>
      <div className="text-xs text-[#A0A0A0] group-hover:text-[#F5F5F5] transition-colors">{subtitle}</div>
    </div>
  )
};
