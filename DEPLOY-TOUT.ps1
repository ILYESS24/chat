# Script PowerShell complet pour déployer Kortix sur Render
# Ce script fait TOUT automatiquement !

param(
    [string]$RenderApiKey = "",
    [string]$SupabaseUrl = "",
    [string]$SupabaseAnonKey = "",
    [string]$JwtSecret = "",
    [string]$OpenAiKey = "",
    [string]$StripeKey = ""
)

# Configuration
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

# Fonctions utilitaires
function Write-Success { param($Message) Write-Host "✅ $Message" -ForegroundColor Green }
function Write-Error { param($Message) Write-Host "❌ $Message" -ForegroundColor Red }
function Write-Info { param($Message) Write-Host "ℹ️  $Message" -ForegroundColor Blue }
function Write-Warning { param($Message) Write-Host "⚠️  $Message" -ForegroundColor Yellow }
function Write-Step { param($Step, $Message) Write-Host "`n🔥 ÉTAPE $Step : $Message" -ForegroundColor Magenta }

# Fonction pour demander une valeur
function Read-Value {
    param($Prompt, $Default = "")
    $value = Read-Host "$Prompt $(if($Default){'['+$Default+']'})"
    if($value -eq "" -and $Default) { return $Default }
    return $value
}

# Fonction pour installer Python
function Install-Python {
    Write-Step 1 "Installation de Python"

    # Vérifier si Python est déjà installé
    try {
        $pythonVersion = python --version 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Python est déjà installé: $pythonVersion"
            return $true
        }
    } catch {}

    Write-Info "Python n'est pas installé. Installation automatique..."

    # Télécharger Python
    $pythonUrl = "https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe"
    $installerPath = "$env:TEMP\python-installer.exe"

    Write-Info "Téléchargement de Python 3.11.9..."
    try {
        Invoke-WebRequest -Uri $pythonUrl -OutFile $installerPath -UseBasicParsing
    } catch {
        Write-Error "Impossible de télécharger Python. Téléchargez-le manuellement depuis https://www.python.org/downloads/"
        return $false
    }

    # Installer Python silencieusement
    Write-Info "Installation de Python (cette opération peut prendre quelques minutes)..."
    $installArgs = "/quiet InstallAllUsers=1 PrependPath=1 Include_launcher=0"

    try {
        Start-Process -FilePath $installerPath -ArgumentList $installArgs -Wait -NoNewWindow
    } catch {
        Write-Error "Erreur lors de l'installation de Python"
        return $false
    }

    # Nettoyer
    Remove-Item $installerPath -Force -ErrorAction SilentlyContinue

    # Actualiser la session PowerShell
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

    # Vérifier l'installation
    try {
        $pythonVersion = python --version 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Python installé avec succès: $pythonVersion"
            return $true
        }
    } catch {}

    Write-Error "L'installation de Python a échoué. Installez-le manuellement."
    return $false
}

# Fonction pour configurer les variables d'environnement
function Configure-Environment {
    Write-Step 2 "Configuration des variables d'environnement"

    $envFile = ".env"

    # Si le fichier .env existe déjà, demander si on le remplace
    if (Test-Path $envFile) {
        $replace = Read-Host "Le fichier .env existe déjà. Voulez-vous le remplacer ? (o/N)"
        if ($replace -notmatch "^[oO]") {
            Write-Info "Utilisation du fichier .env existant"
            return $true
        }
    }

    Write-Info "Configuration des clés API..."

    # Demander les clés API
    if (!$RenderApiKey) { $RenderApiKey = Read-Value "Clé API Render (https://dashboard.render.com/account/api-keys)" }
    if (!$SupabaseUrl) { $SupabaseUrl = Read-Value "URL Supabase (https://votre-projet.supabase.co)" }
    if (!$SupabaseAnonKey) { $SupabaseAnonKey = Read-Value "Clé anonyme Supabase" }
    if (!$JwtSecret) { $JwtSecret = Read-Value "Secret JWT (laissez vide pour générer automatiquement)" }
    if (!$OpenAiKey) { $OpenAiKey = Read-Value "Clé API OpenAI (sk-...)" }
    if (!$StripeKey) { $StripeKey = Read-Value "Clé secrète Stripe (sk_...)" }

    # Générer un JWT secret si non fourni
    if (!$JwtSecret) {
        $JwtSecret = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 32 | ForEach-Object {[char]$_})
        Write-Info "JWT Secret généré automatiquement"
    }

    # Créer le fichier .env
    $envContent = @"
# Configuration pour le déploiement Render
RENDER_API_KEY=$RenderApiKey
SUPABASE_URL=$SupabaseUrl
SUPABASE_ANON_KEY=$SupabaseAnonKey
JWT_SECRET=$JwtSecret
OPENAI_API_KEY=$OpenAiKey
STRIPE_SECRET_KEY=$StripeKey
NEXT_PUBLIC_SUPABASE_URL=$SupabaseUrl
NEXT_PUBLIC_SUPABASE_ANON_KEY=$SupabaseAnonKey
"@

    try {
        $envContent | Out-File -FilePath $envFile -Encoding UTF8 -Force
        Write-Success "Fichier .env créé avec succès"
        return $true
    } catch {
        Write-Error "Impossible de créer le fichier .env"
        return $false
    }
}

# Fonction pour installer les dépendances
function Install-Dependencies {
    Write-Step 3 "Installation des dépendances"

    # Installer pip si nécessaire
    try {
        python -m pip --version >$null 2>&1
    } catch {
        Write-Info "Installation de pip..."
        python -m ensurepip --upgrade >$null 2>&1
    }

    # Installer les dépendances
    Write-Info "Installation des dépendances Python..."
    try {
        python -m pip install --upgrade pip >$null 2>&1
        python -m pip install -r requirements-deploy.txt >$null 2>&1
        Write-Success "Dépendances installées"
        return $true
    } catch {
        Write-Error "Erreur lors de l'installation des dépendances"
        return $false
    }
}

# Fonction pour tester la configuration
function Test-Configuration {
    Write-Step 4 "Test de configuration"

    Write-Info "Test des variables d'environnement..."
    try {
        $result = python test-deploy.py
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Configuration validée"
            return $true
        } else {
            Write-Error "Configuration invalide"
            return $false
        }
    } catch {
        Write-Error "Erreur lors du test de configuration"
        return $false
    }
}

# Fonction pour déployer sur Render
function Deploy-To-Render {
    Write-Step 5 "Déploiement sur Render"

    Write-Info "Lancement du déploiement automatique..."
    Write-Info "Cette opération peut prendre 10-15 minutes..."

    try {
        # Charger les variables d'environnement
        $envContent = Get-Content ".env" -Raw
        foreach ($line in ($envContent -split "`n")) {
            if ($line -match "^([^#][^=]+)=(.*)$") {
                $key = $matches[1].Trim()
                $value = $matches[2].Trim()
                [Environment]::SetEnvironmentVariable($key, $value, "Process")
            }
        }

        # Lancer le déploiement
        python auto-deploy-render.py
        if ($LASTEXITCODE -eq 0) {
            Write-Success "DÉPLOIEMENT RÉUSSI !"
            Write-Info "Votre application Kortix est maintenant en ligne !"
            return $true
        } else {
            Write-Error "Échec du déploiement"
            return $false
        }
    } catch {
        Write-Error "Erreur lors du déploiement: $($_.Exception.Message)"
        return $false
    }
}

# Fonction principale
function Main {
    Clear-Host
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║      DÉPLOIEMENT COMPLET KORTIX SUR RENDER     ║" -ForegroundColor Cyan
    Write-Host "║              SCRIPT AUTOMATIQUE               ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Write-Info "Ce script va tout faire automatiquement :"
    Write-Info "1. Installer Python (si nécessaire)"
    Write-Info "2. Configurer les variables d'environnement"
    Write-Info "3. Installer les dépendances"
    Write-Info "4. Tester la configuration"
    Write-Info "5. Déployer sur Render"
    Write-Host ""

    $continue = Read-Host "Voulez-vous continuer ? (O/n)"
    if ($continue -match "^[nN]") {
        Write-Info "Annulation du déploiement"
        return
    }

    # Exécuter toutes les étapes
    $steps = @(
        ${function:Install-Python},
        ${function:Configure-Environment},
        ${function:Install-Dependencies},
        ${function:Test-Configuration},
        ${function:Deploy-To-Render}
    )

    foreach ($step in $steps) {
        if (!$step.Invoke()) {
            Write-Error "ÉCHEC ! Arrêt du processus."
            Write-Info "Résolvez le problème et relancez le script."
            return
        }
    }

    # Succès final
    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║           🎉 DÉPLOIEMENT RÉUSSI ! 🎉          ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Info "Votre application Kortix est maintenant déployée sur Render !"
    Write-Info "URLs à vérifier dans le dashboard Render :"
    Write-Info "- kortix-frontend.onrender.com (Application)"
    Write-Info "- kortix-backend.onrender.com (API)"
    Write-Host ""
    Read-Host "Appuyez sur Entrée pour quitter"
}

# Lancer le script
try {
    Main
} catch {
    Write-Error "Erreur inattendue: $($_.Exception.Message)"
    Write-Info "Redémarrez le script ou contactez le support"
    Read-Host "Appuyez sur Entrée pour quitter"
}
