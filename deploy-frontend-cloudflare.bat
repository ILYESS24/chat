@echo off
echo 🚀 Déploiement du Frontend Kortix sur Cloudflare Pages...
echo.

echo 🔧 Installation de Wrangler CLI...
npm install -g wrangler
if %errorlevel% neq 0 (
    echo ❌ Échec installation Wrangler.
    pause
    exit /b 1
)

echo 🔐 Connexion à Cloudflare...
wrangler auth login
if %errorlevel% neq 0 (
    echo ❌ Connexion échouée. Utilisez votre navigateur.
    pause
    exit /b 1
)

echo 📦 Déploiement sur Cloudflare Pages...
wrangler pages deploy apps/frontend --name kortix-frontend --compatibility-date 2024-01-11

if %errorlevel% neq 0 (
    echo ❌ Déploiement échoué.
    pause
    exit /b 1
)

echo ✅ Déploiement réussi!
echo 🌐 Votre site sera disponible sur: https://kortix-frontend.pages.dev
echo.

pause
