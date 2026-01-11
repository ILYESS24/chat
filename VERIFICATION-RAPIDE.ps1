# Script de vérification rapide pour Kortix
# Vérifie que tout est prêt pour le déploiement

Write-Host "🔍 VÉRIFICATION RAPIDE - KORTIX" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier PowerShell
Write-Host "1. PowerShell :" -NoNewline
$psVersion = $PSVersionTable.PSVersion
if ($psVersion.Major -ge 5) {
    Write-Host " ✅ $($psVersion.Major).$($psVersion.Minor)" -ForegroundColor Green
} else {
    Write-Host " ❌ Version trop ancienne" -ForegroundColor Red
}

# Vérifier Python
Write-Host "2. Python :" -NoNewline
try {
    $pythonVersion = python --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host " ✅ $pythonVersion" -ForegroundColor Green
    } else {
        Write-Host " ❌ Non installé" -ForegroundColor Red
    }
} catch {
    Write-Host " ❌ Non installé" -ForegroundColor Red
}

# Vérifier les fichiers requis
Write-Host "3. Fichiers du projet :" -NoNewline
$requiredFiles = @(
    "auto-deploy-render.py",
    "requirements-deploy.txt",
    "DEPLOY-TOUT.ps1"
)
$missingFiles = @()
foreach ($file in $requiredFiles) {
    if (!(Test-Path $file)) {
        $missingFiles += $file
    }
}
if ($missingFiles.Count -eq 0) {
    Write-Host " ✅ Tous présents" -ForegroundColor Green
} else {
    Write-Host " ❌ Fichiers manquants: $($missingFiles -join ', ')" -ForegroundColor Red
}

# Vérifier la politique d'exécution
Write-Host "4. Politique d'exécution :" -NoNewline
$executionPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($executionPolicy -eq "RemoteSigned" -or $executionPolicy -eq "Unrestricted") {
    Write-Host " ✅ $executionPolicy" -ForegroundColor Green
} else {
    Write-Host " ❌ $executionPolicy (devrait être RemoteSigned)" -ForegroundColor Yellow
}

# Vérifier la connexion internet
Write-Host "5. Connexion internet :" -NoNewline
try {
    $testConnection = Test-Connection -ComputerName "google.com" -Count 1 -Quiet
    if ($testConnection) {
        Write-Host " ✅ OK" -ForegroundColor Green
    } else {
        Write-Host " ❌ Pas de connexion" -ForegroundColor Red
    }
} catch {
    Write-Host " ❌ Erreur de test" -ForegroundColor Red
}

Write-Host ""
Write-Host "📋 RÉSUMÉ :" -ForegroundColor Magenta

# Compter les succès
$checks = 5
$successCount = 0
if ($psVersion.Major -ge 5) { $successCount++ }
try { python --version >$null 2>&1; if ($LASTEXITCODE -eq 0) { $successCount++ } } catch {}
if ($missingFiles.Count -eq 0) { $successCount++ }
if ($executionPolicy -eq "RemoteSigned" -or $executionPolicy -eq "Unrestricted") { $successCount++ }
try { if (Test-Connection -ComputerName "google.com" -Count 1 -Quiet) { $successCount++ } } catch {}

Write-Host "✅ $successCount/$checks vérifications réussies" -ForegroundColor $(if($successCount -eq $checks){"Green"}elseif($successCount -ge 3){"Yellow"}else{"Red"})

if ($successCount -eq $checks) {
    Write-Host ""
    Write-Host "🎉 TOUT EST PRÊT !" -ForegroundColor Green
    Write-Host "Lancez maintenant : .\DEPLOY-TOUT.ps1" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠️  PROBLÈMES DÉTECTÉS :" -ForegroundColor Yellow
    Write-Host "Résolvez les erreurs ci-dessus avant de continuer." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Solutions courantes :" -ForegroundColor Cyan
    Write-Host "- Python : Téléchargez depuis https://python.org" -ForegroundColor Cyan
    Write-Host "- Politique : Set-ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Cyan
}

Write-Host ""
Read-Host "Appuyez sur Entrée pour continuer"
