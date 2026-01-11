@echo off
echo ========================================
echo    DEPLOIEMENT KORTIX SUR RENDER
echo ========================================
echo.

echo [1/4] Verification de Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python n'est pas installe !
    echo.
    echo 📥 Installation automatique de Python...
    echo Telechargez et installez Python depuis :
    echo https://www.python.org/downloads/
    echo.
    echo Puis relancez ce script.
    echo.
    pause
    exit /b 1
) else (
    echo ✅ Python trouve !
)

echo.
echo [2/4] Installation des dependances...
pip install -r requirements-deploy.txt
if errorlevel 1 (
    echo ❌ Erreur lors de l'installation des dependances
    pause
    exit /b 1
)

echo.
echo [3/4] Test de configuration...
python test-deploy.py
if errorlevel 1 (
    echo ❌ Configuration invalide !
    echo.
    echo Creez un fichier .env avec vos variables d'environnement.
    echo Utilisez env-example.txt comme template.
    echo.
    pause
    exit /b 1
)

echo.
echo [4/4] Lancement du deploiement...
python auto-deploy-render.py
if errorlevel 1 (
    echo ❌ Erreur lors du deploiement !
    pause
    exit /b 1
)

echo.
echo ✅ DEPLOIEMENT REUSSI !
echo.
echo Votre application est maintenant en ligne sur Render !
echo.
pause
