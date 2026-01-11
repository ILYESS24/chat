@echo off
echo 🚀 Déploiement Frontend Kortix via Wrangler CLI...
echo.

echo 🔧 Vérification de Wrangler...
wrangler --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Wrangler pas installé. Installation...
    npm install -g wrangler
    if %errorlevel% neq 0 (
        echo ❌ Échec installation Wrangler.
        pause
        exit /b 1
    )
)

echo 🔐 Connexion à Cloudflare (ouvrez votre navigateur)...
wrangler auth login
if %errorlevel% neq 0 (
    echo ❌ Connexion échouée.
    echo Ouvrez https://dash.cloudflare.com/profile/api-tokens
    echo Créez un token avec "Cloudflare Pages" permissions
    echo Puis exécutez: wrangler auth login --api-token YOUR_TOKEN
    pause
    exit /b 1
)

echo 📦 Déploiement sur Cloudflare Pages...
cd apps/frontend

echo Configuration des variables d'environnement...
set NEXT_PUBLIC_API_URL=https://chat-i6z7.onrender.com
set NEXT_PUBLIC_SUPABASE_URL=https://otxxjczxwhtngcferckz.supabase.co
set NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90eHhKY3p4d2h0bmdjZmVyY2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTE4NTIsImV4cCI6MjA1MTk4Nzg1Mn0.5VbjomjZucBNVqphxQ8D9gD52Iy5nFzgo7z85hoL5t8
set NODE_ENV=production
set NEXT_TELEMETRY_DISABLED=1

echo Build du projet...
npm install --legacy-peer-deps
if %errorlevel% neq 0 (
    echo ❌ Échec installation dépendances.
    pause
    exit /b 1
)

npm run build
if %errorlevel% neq 0 (
    echo ❌ Échec build.
    pause
    exit /b 1
)

echo Déploiement...
wrangler pages deploy .next --name kortix-frontend --compatibility-date 2024-01-11
if %errorlevel% neq 0 (
    echo ❌ Échec déploiement.
    pause
    exit /b 1
)

echo.
echo ✅ Déploiement réussi!
echo 🌐 Votre site est disponible sur: https://kortix-frontend.pages.dev
echo.
echo ⏳ Le déploiement peut prendre quelques minutes pour être actif.
echo.

pause
