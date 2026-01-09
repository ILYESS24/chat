import React from "react";
import { MessageSquare, Library, Zap, Plus, ChevronRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

export const Sidebar = () => {
  return (
    <div className="w-[260px] h-screen bg-[#0A0A0A] border-r border-[#2A2A2A] flex flex-col text-[#F5F5F5] font-sans">
      {/* Top Section */}
      <div className="p-4">
        <Button
          variant="outline"
          className="w-full justify-start gap-2 bg-[#1A1A1A] border-[#2A2A2A] hover:bg-[#252525] text-[#F5F5F5] h-10 rounded-lg"
        >
          <Plus className="w-4 h-4" />
          <span className="text-sm font-medium">Nouveau Chat</span>
        </Button>
      </div>

      {/* Main Nav */}
      <div className="px-2 py-2 flex gap-1 justify-between">
        <NavIconItem icon={<MessageSquare className="w-5 h-5" />} label="Chats" active />
        <NavIconItem icon={<Library className="w-5 h-5" />} label="Library" />
        <NavIconItem icon={<Zap className="w-5 h-5" />} label="Triggers" />
      </div>

      {/* Trigger Config Section */}
      <div className="mt-6 px-4">
        <div className="text-xs font-medium text-[#A0A0A0] mb-2 uppercase tracking-wider">Trigger Config</div>

        <div className="space-y-1">
          <Button variant="ghost" className="w-full justify-between hover:bg-[#1A1A1A] text-[#F5F5F5] h-10 px-2">
            <div className="flex items-center gap-3">
              <div className="w-6 h-6 rounded-full bg-[#1A1A1A] flex items-center justify-center border border-[#2A2A2A]">
                <Zap className="w-3 h-3 text-[#A0A0A0]" />
              </div>
              <span className="text-sm">All Triggers</span>
            </div>
            <ChevronRight className="w-4 h-4 text-[#A0A0A0]" />
          </Button>
        </div>
      </div>

      <div className="mt-4 px-4">
        <Button
          variant="outline"
          className="w-full justify-start gap-2 bg-transparent border-[#2A2A2A] hover:bg-[#1A1A1A] text-[#F5F5F5] h-9 rounded-lg"
        >
          <Plus className="w-4 h-4" />
          <span className="text-sm">Add Trigger</span>
        </Button>
      </div>

      <div className="mt-4 px-4">
        <div className="text-sm text-[#A0A0A0] px-2 py-2 hover:bg-[#1A1A1A] rounded-md cursor-pointer transition-colors">
          Trigger Runs
        </div>
      </div>

      {/* Bottom Section */}
      <div className="mt-auto p-4">
        <Button className="w-full bg-[#F5F5F5] hover:bg-white text-black font-medium h-10 rounded-lg transition-all">
          Améliorer
        </Button>
      </div>
    </div>
  );
};

interface NavIconItemProps {
  icon: React.ReactNode;
  label: string;
  active?: boolean;
}

const NavIconItem = ({ icon, label, active }: NavIconItemProps) => {
  return (
    <div className={cn(
      "flex flex-col items-center justify-center w-full py-3 rounded-lg cursor-pointer transition-colors gap-1",
      active ? "bg-[#1A1A1A] text-[#F5F5F5]" : "text-[#A0A0A0] hover:bg-[#1A1A1A] hover:text-[#F5F5F5]"
    )}>
      {icon}
      <span className="text-[10px] font-medium">{label}</span>
    </div>
  );
};
