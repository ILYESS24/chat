@echo off
echo 🚀 Déploiement Rapide Frontend Kortix...
echo.

cd apps/frontend

echo 🔧 Installation dépendances...
npm install --legacy-peer-deps

echo 🏗️ Build...
npm run build

echo 📦 Déploiement...
npx wrangler pages deploy .next --name kortix-frontend --compatibility-date 2024-01-11

echo.
echo ✅ Terminé!
echo 🌐 URL: https://kortix-frontend.pages.dev
echo.

pause
