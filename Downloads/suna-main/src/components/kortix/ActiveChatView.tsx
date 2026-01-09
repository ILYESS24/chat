import React from "react";
import {
  Share,
  PanelLeftClose,
  ChevronDown,
  Paperclip,
  Mic,
  ArrowRight,
  MonitorPlay,
  Cloud,
  X,
  Check,
  Zap,
  Library,
  Smartphone,
  Monitor
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

export const ActiveChatView = () => {
  return (
    <div className="flex-1 flex h-screen bg-[#0D0D0D] text-[#F5F5F5] font-sans overflow-hidden">

      {/* LEFT PANEL - CHAT */}
      <div className="flex-1 flex flex-col min-w-[500px] border-r border-[#2A2A2A] relative">
        {/* Header */}
        <header className="h-14 flex items-center justify-between px-4 shrink-0">
          <div className="flex items-center gap-3">
            <Button variant="ghost" size="icon" className="text-[#A0A0A0] hover:text-[#F5F5F5]">
               <PanelLeftClose className="w-5 h-5" />
            </Button>
            <div className="flex items-center gap-2 cursor-pointer hover:bg-[#1A1A1A] px-2 py-1 rounded-md transition-colors">
              <span className="font-heading font-bold text-lg">AURION CHAT</span>
              <ChevronDown className="w-4 h-4 text-[#A0A0A0]" />
            </div>
          </div>

          <div className="flex items-center gap-2">
            <Button variant="outline" className="h-8 gap-2 bg-transparent border-[#2A2A2A] hover:bg-[#1A1A1A] text-[#F5F5F5] text-xs">
              <Share className="w-3.5 h-3.5" />
              Share
            </Button>
            <Button variant="ghost" size="icon" className="h-8 w-8 text-[#A0A0A0]">
              <PanelLeftClose className="w-4 h-4 rotate-180" />
            </Button>
          </div>
        </header>

        {/* Chat History */}
        <div className="flex-1 overflow-y-auto p-4 sm:p-6 scrollbar-hide space-y-8">

          {/* User Message */}
          <div className="flex justify-end">
             <div className="bg-[#1A1A1A] text-[#F5F5F5] px-4 py-3 rounded-2xl max-w-xl border border-[#2A2A2A]">
               Concevoir une présentation de lancement de produit avec des vidéos de démo et des témoignages clients
             </div>
          </div>

          {/* AI Response */}
          <div className="max-w-3xl pr-4">
             <div className="flex items-center gap-2 mb-2">
               <span className="font-heading font-bold text-lg">Ж Kortix</span>
             </div>

             <div className="text-[#A0A0A0] mb-4 space-y-4 text-sm leading-relaxed">
               <p>
                 Je vais vous aider à créer une présentation de lancement de produit professionnelle avec vidéos de démo et témoignages clients. Commençons par initialiser l'outil de présentation.
               </p>

               <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full border border-[#2A2A2A] bg-[#151515] text-xs text-[#A0A0A0]">
                 <Zap className="w-3 h-3" />
                 Mode Activated
               </div>

               <p>
                 Parfait ! L'outil de présentation est maintenant activé. Commençons par la <span className="text-[#F5F5F5] font-medium">Phase 1: Confirmation du sujet.</span>
               </p>

               <p>
                 Avant de créer votre présentation de lancement de produit, j'ai besoin de quelques informations pour la personnaliser au maximum :
               </p>

               <div className="flex items-center gap-2 text-[#F5F5F5] font-medium py-1">
                 <span className="w-4 h-4 rounded-full bg-pink-500/20 text-pink-500 flex items-center justify-center text-[10px]">🎯</span>
                 Présentation de Lancement de Produit
               </div>

               <p>Pour créer une présentation impactante, j'ai besoin de précisions :</p>

               <ol className="list-decimal pl-5 space-y-2 text-[#A0A0A0]">
                 <li><strong className="text-[#F5F5F5]">Quel est le produit/service</strong> que vous lancez ? (nom, domaine, type)</li>
                 <li><strong className="text-[#F5F5F5]">Qui est votre audience cible ?</strong> (investisseurs, clients, partenaires, équipe interne, etc.)</li>
                 <li><strong className="text-[#F5F5F5]">Quels sont vos objectifs principaux ?</strong> (générer de l'intérêt, conclure des ventes, attirer des investisseurs, etc.)</li>
                 <li><strong className="text-[#F5F5F5]">Avez-vous des spécifications particulières ?</strong> (nombre de slides, durée, style, éléments spécifiques à inclure)</li>
               </ol>

               <p>Donnez-moi autant de détails que possible pour que je crée une présentation vraiment adaptée à votre produit ! 🚀</p>

               <div className="flex items-center gap-2 text-orange-500/80 text-xs mt-4">
                 <div className="w-3 h-3 rounded-full border border-current flex items-center justify-center text-[8px]">L</div>
                 Kortix continuera à travailler de manière autonome après ta réponse.
               </div>

               <div className="pt-2">
                 <div className="text-xs text-[#555] mb-2 uppercase tracking-wide font-medium">Exemples de réponses</div>
                 <Button variant="outline" className="w-full justify-between text-[#A0A0A0] border-[#2A2A2A] bg-[#151515] hover:bg-[#1A1A1A] hover:text-[#F5F5F5] h-10 font-normal">
                   <span>Je vais vous donner les détails</span>
                   <ArrowRight className="w-4 h-4 rotate-[-45deg]" />
                 </Button>
               </div>

             </div>
          </div>

        </div>

        {/* Footer Input Area */}
        <div className="p-4 sm:px-6 pb-6 pt-0 bg-gradient-to-t from-[#0D0D0D] via-[#0D0D0D] to-transparent">
          {/* Upgrade Banner */}
          <div className="w-full bg-[#151515] border border-[#2A2A2A] rounded-t-xl p-3 flex items-center justify-between relative border-b-0">
            <div className="flex items-center gap-3">
              <Badge className="bg-[#00D9B4] text-black hover:bg-[#00c4a3] border-0 px-2 py-0.5 text-[10px] font-bold">Ж Ultra</Badge>
              <div>
                <div className="font-medium text-xs text-[#F5F5F5]">Unlock the full Kortix experience</div>
                <div className="text-[10px] text-[#A0A0A0]">Kortix Advanced mode, 100+ Integrations, Triggers, Custom AI Workers & more</div>
              </div>
            </div>
            <Button variant="ghost" size="icon" className="h-6 w-6 text-[#A0A0A0] hover:text-[#F5F5F5]">
              <X className="w-3 h-3" />
            </Button>
          </div>

          {/* Input Box */}
          <div className="bg-[#151515] border border-[#2A2A2A] rounded-b-2xl rounded-tr-2xl p-3 shadow-lg flex flex-col relative z-10">
            <textarea
              placeholder="Décris ce dont tu as besoin d'aide..."
              className="w-full bg-transparent border-none focus:ring-0 resize-none text-[#F5F5F5] placeholder:text-[#555] text-sm min-h-[50px] outline-none px-1"
            />

            <div className="flex items-center justify-between mt-2">
               <div className="flex items-center gap-2">
                  <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full text-[#A0A0A0] hover:bg-[#2A2A2A] hover:text-[#F5F5F5]">
                    <Paperclip className="w-4 h-4" />
                  </Button>
                  <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full text-[#0066FF] hover:bg-[#2A2A2A] relative">
                    <Cloud className="w-4 h-4 fill-current" />
                  </Button>
               </div>

               <div className="flex items-center gap-2">
                 <Button variant="ghost" size="icon" className="h-8 w-8 rounded-full text-[#A0A0A0] hover:bg-[#2A2A2A] hover:text-[#F5F5F5]">
                    <Mic className="w-4 h-4" />
                 </Button>
                 <Button size="icon" className="h-8 w-8 rounded-lg bg-[#2A2A2A] hover:bg-[#333] text-[#F5F5F5] border border-[#333]">
                    <ArrowRight className="w-4 h-4" />
                 </Button>
               </div>
            </div>
          </div>
        </div>
      </div>

      {/* RIGHT PANEL - COMPUTER */}
      <div className="flex-[1.2] flex flex-col bg-black border-l border-[#2A2A2A] relative">
         {/* Computer Header */}
         <header className="h-14 flex items-center justify-between px-4 shrink-0 border-b border-[#2A2A2A]">
           <div className="flex items-center gap-2">
             <Button variant="ghost" size="icon" className="h-8 w-8 text-[#555] hover:text-[#F5F5F5] bg-[#111] rounded-lg border border-[#222]">
               <X className="w-4 h-4" />
             </Button>
           </div>

           <div className="font-heading font-medium text-[#A0A0A0] text-sm flex items-center gap-2">
             <span>Ж Kortix Computer</span>
           </div>

           <div className="flex items-center gap-2">
              <Button variant="ghost" className="h-8 gap-2 bg-[#111] hover:bg-[#1A1A1A] text-[#F5F5F5] text-xs border border-[#222] rounded-lg px-3">
                <Zap className="w-3 h-3 fill-current" />
                Action
              </Button>
              <Button variant="ghost" className="h-8 gap-2 bg-transparent hover:bg-[#1A1A1A] text-[#555] text-xs hover:text-[#A0A0A0]">
                <Library className="w-3 h-3" />
                Library
              </Button>
           </div>
         </header>

         {/* Toast Banner */}
         <div className="px-6 py-4">
           <div className="bg-[#151515] border border-[#2A2A2A] rounded-lg p-3 flex items-center gap-3">
             <div className="w-8 h-8 rounded bg-[#1A1A1A] border border-[#2A2A2A] flex items-center justify-center">
               <MonitorPlay className="w-4 h-4 text-[#F5F5F5]" />
             </div>
             <span className="text-sm font-medium text-[#F5F5F5]">Presentation Mode Activated</span>
           </div>
         </div>

         {/* Empty State / Ready State */}
         <div className="flex-1 flex flex-col items-center justify-center pb-20">
            <div className="flex flex-col items-center gap-6">
               <div className="w-16 h-16 rounded-full border-2 border-[#333] flex items-center justify-center">
                 <Check className="w-8 h-8 text-[#F5F5F5]" />
               </div>

               <div className="text-center space-y-1">
                 <h2 className="text-xl font-medium text-[#F5F5F5]">Presentation Mode Ready</h2>
                 <p className="text-sm text-[#555]">1 tool activated</p>
               </div>

               <Button variant="outline" className="bg-[#111] border-[#2A2A2A] text-[#A0A0A0] hover:text-[#F5F5F5] hover:bg-[#1A1A1A] gap-2 h-9 text-xs">
                 <ChevronDown className="w-3 h-3 rotate-[-90deg]" />
                 Presentation Tool
               </Button>
            </div>
         </div>

         {/* Bottom Floating Card */}
         <div className="absolute bottom-6 right-6">
            <div className="bg-[#F5F5F5] text-black rounded-xl p-2 pr-4 flex items-center gap-3 shadow-2xl">
              <div className="flex gap-1 pl-1">
                <div className="w-6 h-8 border-2 border-black rounded flex items-center justify-center">
                  <Smartphone className="w-3 h-3" />
                </div>
                <div className="w-8 h-8 border-2 border-black rounded flex items-center justify-center">
                  <Monitor className="w-4 h-4" />
                </div>
              </div>
              <div className="flex flex-col">
                <span className="font-bold text-xs leading-none">Get Kortix Apps</span>
                <span className="text-[10px] text-gray-600 leading-tight">Mobile & Desktop</span>
              </div>
              <div className="w-8 h-8 bg-black rounded-lg text-white flex items-center justify-center font-heading font-bold text-lg ml-2">
                Ж
              </div>
            </div>
         </div>

         {/* Bottom Left Status */}
         <div className="absolute bottom-6 left-6">
            <div className="bg-[#151515] border border-[#2A2A2A] text-[#555] text-[10px] font-bold px-2 py-1 rounded">
              READY
            </div>
         </div>
      </div>

    </div>
  );
};
