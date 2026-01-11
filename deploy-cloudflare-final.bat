@echo off
echo 🚀 Déploiement FINAL Cloudflare Pages depuis GitHub...
echo.

echo 🔧 Installation de Wrangler...
npm install -g wrangler
if %errorlevel% neq 0 (
    echo ❌ Échec installation Wrangler
    pause
    exit /b 1
)

echo 🔐 Connexion Cloudflare (ouvrez votre navigateur)...
wrangler auth login
if %errorlevel% neq 0 (
    echo ❌ Connexion échouée
    pause
    exit /b 1
)

echo 📦 Déploiement depuis GitHub...
wrangler pages deploy --project-name kortix-frontend --production-branch master --build-command "cd apps/frontend && npm install && npm run build" --destination-dir apps/frontend/.next --source-dir apps/frontend --repo https://github.com/ILYESS24/chat.git

if %errorlevel% neq 0 (
    echo ❌ Déploiement échoué
    echo.
    echo 🔄 Tentative alternative...
    wrangler pages deploy --project-name kortix-frontend --repo https://github.com/ILYESS24/chat.git --branch master --build-command "npm install && npm run build" --destination-dir .next
)

if %errorlevel% neq 0 (
    echo ❌ Toutes les tentatives ont échoué
    echo Essayez de déployer manuellement sur https://dash.cloudflare.com/pages
    pause
    exit /b 1
)

echo.
echo ✅ DÉPLOIEMENT RÉUSSI !
echo 🌐 URL: https://kortix-frontend.pages.dev
echo.
echo ⏳ Attendez 2-3 minutes pour que ce soit actif
echo.

pause
