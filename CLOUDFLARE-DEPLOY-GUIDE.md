# 🚀 Déploiement Frontend sur Cloudflare Pages

## Méthode 1: Déploiement Automatique

```batch
# Exécutez ce script
deploy-frontend-cloudflare.bat
```

## Méthode 2: Déploiement Manuel

### 1. Créer un compte Cloudflare
- Allez sur https://dash.cloudflare.com/
- Créez un compte gratuit

### 2. Installer Wrangler CLI
```bash
npm install -g wrangler
```

### 3. Se connecter
```bash
wrangler auth login
```
(Suivez les instructions dans votre navigateur)

### 4. Déployer
```bash
cd apps/frontend
wrangler pages deploy . --name kortix-frontend --compatibility-date 2024-01-11
```

## Configuration des Variables d'Environnement

Dans le dashboard Cloudflare Pages (https://dash.cloudflare.com/pages), allez dans votre projet `kortix-frontend` > Settings > Environment variables:

```
NEXT_PUBLIC_API_URL = https://chat-i6z7.onrender.com
NEXT_PUBLIC_SUPABASE_URL = https://otxxjczxwhtngcferckz.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90eHhKY3p4d2h0bmdjZmVyY2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTE4NTIsImV4cCI6MjA1MTk4Nzg1Mn0.5VbjomjZucBNVqphxQ8D9gD52Iy5nFzgo7z85hoL5t8
NODE_ENV = production
NEXT_TELEMETRY_DISABLED = 1
```

## URL Finale
Votre site sera disponible sur:
```
https://kortix-frontend.pages.dev
```

## Fonctionnalités Cloudflare
- ✅ Déploiement gratuit
- ✅ CDN mondial
- ✅ HTTPS automatique
- ✅ Domaines personnalisés possibles
- ✅ Analytics intégrés
