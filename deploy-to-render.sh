#!/bin/bash

# Script de déploiement automatisé pour Render
# Utilisation: ./deploy-to-render.sh

set -e

echo "🚀 Déploiement de Kortix sur Render"
echo "==================================="

# Vérification des prérequis
if ! command -v curl &> /dev/null; then
    echo "❌ curl n'est pas installé"
    exit 1
fi

# Fonction pour vérifier si une variable d'environnement est définie
check_env_var() {
    if [[ -z "${!1}" ]]; then
        echo "❌ Variable d'environnement $1 non définie"
        echo "Définissez-la avec: export $1=votre_valeur"
        exit 1
    fi
}

# Vérification des variables d'environnement requises
echo "🔍 Vérification des variables d'environnement..."
check_env_var "SUPABASE_URL"
check_env_var "SUPABASE_ANON_KEY"
check_env_var "JWT_SECRET"
check_env_var "OPENAI_API_KEY"
check_env_var "STRIPE_SECRET_KEY"
check_env_var "NEXT_PUBLIC_SUPABASE_URL"
check_env_var "NEXT_PUBLIC_SUPABASE_ANON_KEY"

echo "✅ Toutes les variables d'environnement sont définies"

# Fonction pour créer un service Render
create_render_service() {
    local service_name=$1
    local service_type=$2
    local config_file=$3

    echo "📦 Création du service $service_name..."

    # Utilisation de l'API Render pour créer le service
    # Note: Cette partie nécessiterait une clé API Render
    echo "Service $service_name configuré"
}

# Étape 1: Création de la base de données
echo "🗄️  Étape 1: Configuration de la base de données PostgreSQL"
echo "Créez une base de données PostgreSQL dans le dashboard Render:"
echo "- Nom: kortix-db"
echo "- Plan: Starter"
echo "- Region: Oregon"
echo ""
read -p "Appuyez sur Entrée quand la base de données est créée..."

# Étape 2: Déploiement du backend
echo "🔧 Étape 2: Déploiement du backend FastAPI"
echo "Créez un Web Service dans le dashboard Render:"
echo "- Nom: kortix-backend"
echo "- Runtime: Python 3.11"
echo "- Repository: https://github.com/kortix-ai/suna"
echo "- Branch: main"
echo "- Root Directory: backend"
echo "- Build Command: pip install uv && uv sync --locked"
echo "- Start Command: uv run gunicorn api:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000 --timeout 75 --graceful-timeout 30 --keep-alive 65"
echo ""
echo "Variables d'environnement à configurer:"
echo "- ENV_MODE=production"
echo "- PYTHONPATH=/app"
echo "- SUPABASE_URL=$SUPABASE_URL"
echo "- SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY"
echo "- JWT_SECRET=$JWT_SECRET"
echo "- OPENAI_API_KEY=$OPENAI_API_KEY"
echo "- STRIPE_SECRET_KEY=$STRIPE_SECRET_KEY"
echo "- DATABASE_URL=<copiez depuis la base de données>"
echo ""
read -p "Appuyez sur Entrée quand le backend est déployé..."

# Étape 3: Déploiement du frontend
echo "🌐 Étape 3: Déploiement du frontend Next.js"
echo "Créez un Web Service dans le dashboard Render:"
echo "- Nom: kortix-frontend"
echo "- Runtime: Node.js"
echo "- Repository: https://github.com/kortix-ai/suna"
echo "- Branch: main"
echo "- Root Directory: apps/frontend"
echo "- Build Command: npm run build"
echo "- Start Command: npm start"
echo ""
echo "Variables d'environnement à configurer:"
echo "- NODE_ENV=production"
echo "- NEXT_TELEMETRY_DISABLED=1"
echo "- NEXT_PUBLIC_API_URL=<URL du backend>"
echo "- NEXT_PUBLIC_SUPABASE_URL=$NEXT_PUBLIC_SUPABASE_URL"
echo "- NEXT_PUBLIC_SUPABASE_ANON_KEY=$NEXT_PUBLIC_SUPABASE_ANON_KEY"
echo ""
read -p "Appuyez sur Entrée quand le frontend est déployé..."

# Étape 4: Test de connectivité
echo "🧪 Étape 4: Test de connectivité"
echo "Testez les URLs suivantes:"
echo "- Frontend: https://kortix-frontend.onrender.com"
echo "- Backend: https://kortix-backend.onrender.com/docs (API documentation)"
echo ""

# Étape 5: Migration de la base de données
echo "💾 Étape 5: Migration de la base de données"
echo "Si nécessaire, exécutez les migrations Supabase:"
echo "cd supabase && npx supabase db push"
echo ""

echo "🎉 Déploiement terminé!"
echo "Votre application Kortix est maintenant déployée sur Render."
echo ""
echo "URLs importantes:"
echo "- Application: https://kortix-frontend.onrender.com"
echo "- API: https://kortix-backend.onrender.com"
echo "- Base de données: Configurez dans Supabase Dashboard"
