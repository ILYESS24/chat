@echo off
echo 🚀 Déploiement du Frontend Kortix - Version Simple...
echo.

echo 🔧 Vérification de Render CLI...
render --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Render CLI pas installé.
    echo Installation...
    npm install -g @render/cli
    if %errorlevel% neq 0 (
        echo ❌ Échec installation. Installez manuellement.
        pause
        exit /b 1
    )
)

echo 🔐 Connexion à Render...
render login
if %errorlevel% neq 0 (
    echo ❌ Connexion échouée.
    pause
    exit /b 1
)

echo 📦 Création du service frontend...
render services create --name kortix-frontend --type web --repo https://github.com/ILYESS24/chat.git --branch master --runtime node --root-dir apps/frontend --build-command "npm install --legacy-peer-deps && npm run build" --start-command "npm start" --plan starter --region oregon

if %errorlevel% neq 0 (
    echo ❌ Échec création service.
    pause
    exit /b 1
)

echo ✅ Service frontend créé!
echo 🌐 URL: https://kortix-frontend.onrender.com
echo.
echo ⚙️ IMPORTANT: Ajoutez ces variables dans Render Dashboard:
echo   NEXT_PUBLIC_API_URL=https://chat-i6z7.onrender.com
echo   NEXT_PUBLIC_SUPABASE_URL=https://otxxjczxwhtngcferckz.supabase.co
echo   NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90eHhKY3p4d2h0bmdjZmVyY2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTE4NTIsImV4cCI6MjA1MTk4Nzg1Mn0.5VbjomjZucBNVqphxQ8D9gD52Iy5nFzgo7z85hoL5t8
echo.

pause