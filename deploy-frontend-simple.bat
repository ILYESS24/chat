@echo off
echo 🚀 Déploiement rapide du frontend Kortix sur Render...
echo Repository: https://github.com/ILYESS24/chat.git
echo.

REM Vérifier si render CLI est installé
render --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Render CLI n'est pas installé.
    echo Installez-le avec: npm install -g @render/cli
    pause
    exit /b 1
)

echo 🔐 Connexion à Render...
render login
if %errorlevel% neq 0 (
    echo ❌ Échec de connexion à Render.
    echo Veuillez vous reconnecter.
    pause
    exit /b 1
)

echo.
echo 📦 Création du service frontend...
echo.

render services create ^
    --name kortix-frontend ^
    --type web ^
    --repo https://github.com/ILYESS24/chat.git ^
    --branch master ^
    --runtime node ^
    --root-dir apps/frontend ^
    --build-command "npm install --legacy-peer-deps && npm run build" ^
    --start-command "npm start" ^
    --plan starter ^
    --region oregon

echo.
echo ✅ Service frontend créé avec succès!
echo.
echo 🌐 URL du frontend:
echo    https://kortix-frontend.onrender.com
echo.
echo ⚙️ IMPORTANT: Configurez ces variables dans Render Dashboard:
echo    - NEXT_PUBLIC_API_URL=https://kortix-backend.onrender.com
echo    - NEXT_PUBLIC_SUPABASE_URL=[votre-url-supabase]
echo    - NEXT_PUBLIC_SUPABASE_ANON_KEY=[votre-cle-anon-supabase]
echo.
echo 📊 Pour voir les logs:
echo    render logs kortix-frontend
echo.

pause
