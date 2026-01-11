@echo off
echo 🚀 Déploiement IMMÉDIAT du frontend Kortix...
echo.

echo 📦 Étape 1: Installation de Render CLI si nécessaire...
call npm install -g @render/cli 2>nul
if %errorlevel% neq 0 (
    echo ❌ Échec d'installation de Render CLI
    echo Installez-le manuellement: npm install -g @render/cli
    pause
    exit /b 1
)

echo.
echo 🔐 Étape 2: Connexion à Render...
call render login
if %errorlevel% neq 0 (
    echo ❌ Connexion échouée. Veuillez vous connecter manuellement.
    pause
    exit /b 1
)

echo.
echo 🏗️ Étape 3: Création du service frontend...
echo Repository: https://github.com/ILYESS24/chat.git
echo Branch: master
echo Root Directory: apps/frontend
echo.

call render services create ^
    --name kortix-frontend ^
    --type web ^
    --repo https://github.com/ILYESS24/chat.git ^
    --branch master ^
    --runtime node ^
    --root-dir apps/frontend ^
    --build-command "npm install --legacy-peer-deps && npm run build" ^
    --start-command "npm start" ^
    --plan starter ^
    --region oregon ^
    --env NEXT_PUBLIC_API_URL=https://chat-i6z7.onrender.com ^
    --env NEXT_PUBLIC_SUPABASE_URL=https://otxxjczxwhtngcferckz.supabase.co ^
    --env NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90eHhKY3p4d2h0bmdjZmVyY2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTE4NTIsImV4cCI6MjA1MTk4Nzg1Mn0.5VbjomjZucBNVqphxQ8D9gD52Iy5nFzgo7z85hoL5t8 ^
    --env NODE_ENV=production ^
    --env NEXT_TELEMETRY_DISABLED=1

if %errorlevel% neq 0 (
    echo ❌ Échec de création du service frontend
    pause
    exit /b 1
)

echo.
echo ✅ Frontend déployé avec succès!
echo.
echo 🌐 URL du frontend: https://kortix-frontend.onrender.com
echo.
echo ⏳ Le déploiement peut prendre 2-3 minutes...
echo.
echo 📊 Pour voir les logs en temps réel:
echo render logs kortix-frontend
echo.
echo 🔄 Une fois déployé, allez sur: https://kortix-frontend.onrender.com
echo.

pause
