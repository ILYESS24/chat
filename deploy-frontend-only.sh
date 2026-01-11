#!/bin/bash

# Script de déploiement rapide du frontend uniquement sur Render
# Utilise le repo de l'utilisateur: https://github.com/ILYESS24/chat.git

set -e

echo "🚀 Déploiement du frontend Kortix sur Render..."
echo "Repository: https://github.com/ILYESS24/chat.git"
echo ""

# Vérifier si render CLI est installé
if ! command -v render &> /dev/null; then
    echo "❌ Render CLI n'est pas installé."
    echo "Installez-le avec: npm install -g @render/cli"
    exit 1
fi

# Se connecter à Render (si nécessaire)
echo "🔐 Connexion à Render..."
render login || {
    echo "❌ Échec de connexion à Render. Veuillez vous connecter manuellement avec 'render login'"
    exit 1
}

echo "📦 Création du service frontend..."

# Créer le service frontend
render services create \
    --name kortix-frontend \
    --type web \
    --repo https://github.com/ILYESS24/chat.git \
    --branch master \
    --runtime node \
    --root-dir apps/frontend \
    --build-command "npm install --legacy-peer-deps && npm run build" \
    --start-command "npm start" \
    --plan starter \
    --region oregon

echo ""
echo "✅ Service frontend créé avec succès!"
echo ""
echo "🌐 URLs du service:"
echo "   - Frontend: https://kortix-frontend.onrender.com"
echo ""
echo "⚙️ Configuration des variables d'environnement:"
echo "   Allez dans le dashboard Render pour configurer:"
echo "   - NEXT_PUBLIC_API_URL=https://kortix-backend.onrender.com"
echo "   - NEXT_PUBLIC_SUPABASE_URL=[votre-supabase-url]"
echo "   - NEXT_PUBLIC_SUPABASE_ANON_KEY=[votre-supabase-anon-key]"
echo ""
echo "📊 Suivi du déploiement:"
echo "   render logs kortix-frontend"
