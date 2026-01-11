# 🚀 GUIDE RAPIDE - Déploiement Kortix sur Render

## 🔥 PROBLÈME ACTUEL

**Python n'est pas installé** sur votre système ! C'est pour ça que le déploiement ne marche pas.

## ⚡ SOLUTION RAPIDE (5 minutes)

### 1. Installer Python

**Téléchargez Python :**
- Allez sur https://www.python.org/downloads/
- Cliquez sur "Download Python 3.x.x"
- **IMPORTANT :** Cochez "Add Python to PATH" lors de l'installation !

**Vérifiez l'installation :**
```cmd
python --version
```
Devrait afficher : `Python 3.x.x`

### 2. Configurer les variables d'environnement

**Créez un fichier `.env` :**
```cmd
copy env-example.txt .env
```

**Éditez `.env` avec vos vraies valeurs :**
```
RENDER_API_KEY=votre_cle_api_render
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_cle_supabase
JWT_SECRET=votre_secret_jwt
OPENAI_API_KEY=sk-votre_cle_openai
STRIPE_SECRET_KEY=sk_votre_cle_stripe
NEXT_PUBLIC_SUPABASE_URL=https://votre-projet.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=votre_cle_supabase
```

### 3. Lancer le déploiement automatique

**Double-cliquez sur `deploy-windows.bat`** ou exécutez :
```cmd
deploy-windows.bat
```

## 📋 Ce que fait le script

1. ✅ **Vérifie** Python
2. ✅ **Installe** les dépendances
3. ✅ **Teste** la configuration
4. ✅ **Déploie** tout automatiquement sur Render

## 🎯 Résultat attendu

Après 10-15 minutes, vous aurez :
- **Base de données PostgreSQL** sur Render
- **API Backend FastAPI** sur Render
- **Application Frontend Next.js** sur Render

## 🔑 Clés API nécessaires

### Render API Key
1. Allez sur https://dashboard.render.com/account/api-keys
2. Créez une nouvelle clé API
3. Copiez-la dans `.env`

### Autres clés
- **Supabase** : Dans votre projet Supabase > Settings > API
- **OpenAI** : https://platform.openai.com/api-keys
- **Stripe** : https://dashboard.stripe.com/apikeys
- **JWT Secret** : Créez un secret fort (ex: `openssl rand -hex 32`)

## 🚨 Dépannage

### "Python not found"
- Réinstallez Python avec "Add to PATH"
- Redémarrez votre terminal/cmd

### "Variables d'environnement manquantes"
- Vérifiez que le fichier `.env` existe
- Vérifiez que toutes les variables sont définies

### "API Key invalid"
- Vérifiez que votre clé Render API est correcte
- Créez une nouvelle clé si nécessaire

---

**Prêt ? Installez Python et lancez `deploy-windows.bat` !** 🚀
