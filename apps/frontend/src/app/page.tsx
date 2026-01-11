"use client";

import React from "react";

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
      <div className="max-w-4xl w-full bg-white rounded-2xl shadow-2xl overflow-hidden">
        {/* Header */}
        <div className="bg-gradient-to-r from-blue-600 to-purple-600 text-white p-8 text-center">
          <div className="text-6xl mb-4">ðŸš€</div>
          <h1 className="text-4xl font-bold mb-2">Kortix AI</h1>
          <p className="text-xl opacity-90">Plateforme de crÃ©ation et gestion d'agents IA</p>
        </div>

        {/* Content */}
        <div className="p-8">
          <div className="grid md:grid-cols-2 gap-8 mb-8">
            {/* API Status */}
            <div className="bg-green-50 border border-green-200 rounded-lg p-6">
              <div className="flex items-center mb-4">
                <div className="w-3 h-3 bg-green-500 rounded-full mr-3"></div>
                <h3 className="text-lg font-semibold text-green-800">Backend API</h3>
              </div>
              <p className="text-green-700 mb-4">Votre API est dÃ©ployÃ©e et opÃ©rationnelle sur Render</p>
              <a
                href="https://chat-i6z7.onrender.com/docs"
                className="inline-block bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700 transition-colors"
                target="_blank"
                rel="noopener noreferrer"
              >
                ðŸ“– Documentation API
              </a>
            </div>

            {/* Database Status */}
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-6">
              <div className="flex items-center mb-4">
                <div className="w-3 h-3 bg-blue-500 rounded-full mr-3"></div>
                <h3 className="text-lg font-semibold text-blue-800">Base de donnÃ©es</h3>
              </div>
              <p className="text-blue-700 mb-4">Connexion Supabase active et fonctionnelle</p>
              <div className="text-sm text-blue-600">
                âœ… Tables crÃ©Ã©es<br/>
                âœ… Permissions configurÃ©es<br/>
                âœ… SÃ©curitÃ© activÃ©e
              </div>
            </div>
          </div>

          {/* Features */}
          <div className="mb-8">
            <h2 className="text-2xl font-bold text-gray-800 mb-6 text-center">FonctionnalitÃ©s disponibles</h2>
            <div className="grid md:grid-cols-3 gap-6">
              <div className="text-center p-4">
                <div className="text-4xl mb-3">ðŸ¤–</div>
                <h3 className="font-semibold mb-2">Agents IA</h3>
                <p className="text-gray-600 text-sm">CrÃ©ation et gestion d'agents intelligents</p>
              </div>
              <div className="text-center p-4">
                <div className="text-4xl mb-3">ðŸ’¬</div>
                <h3 className="font-semibold mb-2">Conversations</h3>
                <p className="text-gray-600 text-sm">Interface de chat avancÃ©e</p>
              </div>
              <div className="text-center p-4">
                <div className="text-4xl mb-3">âš™ï¸</div>
                <h3 className="font-semibold mb-2">Workflows</h3>
                <p className="text-gray-600 text-sm">Automatisation de processus</p>
              </div>
            </div>
          </div>

          {/* API Links */}
          <div className="text-center">
            <h3 className="text-xl font-semibold mb-4">Liens utiles</h3>
            <div className="flex flex-wrap justify-center gap-4">
              <a
                href="https://chat-i6z7.onrender.com"
                className="bg-gray-600 text-white px-6 py-3 rounded-lg hover:bg-gray-700 transition-colors"
                target="_blank"
                rel="noopener noreferrer"
              >
                ðŸ”§ API Backend
              </a>
              <a
                href="https://chat-i6z7.onrender.com/docs"
                className="bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors"
                target="_blank"
                rel="noopener noreferrer"
              >
                ðŸ“š Documentation
              </a>
              <a
                href="https://chat-i6z7.onrender.com/health"
                className="bg-green-600 text-white px-6 py-3 rounded-lg hover:bg-green-700 transition-colors"
                target="_blank"
                rel="noopener noreferrer"
              >
                â¤ï¸ Health Check
              </a>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="bg-gray-50 px-8 py-4 text-center text-gray-600">
          <p>DÃ©ployÃ© avec succÃ¨s sur Cloudflare Pages â€¢ Backend sur Render â€¢ Base de donnÃ©es Supabase</p>
        </div>
      </div>
    </div>
  );
}
