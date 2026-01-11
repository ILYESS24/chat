# 📱 GUIDE VISUEL - Déploiement Kortix

## 🎯 OBJECTIF
**Déployer automatiquement TOUT Kortix sur Render en 5 minutes**

---

## 🔥 ÉTAPE 1 : Préparation (2 minutes)

### 1.1 Ouvrez PowerShell en tant qu'Administrateur
```
Clique droit sur l'icône Windows → "Windows PowerShell (Admin)"
```

### 1.2 Allez dans le dossier du projet
```powershell
cd "C:\Users\[VOTRE_NOM]\Downloads\suna-main (1)\suna-main"
```

### 1.3 Lancez le script automatique
```powershell
.\DEPLOY-TOUT.ps1
```

---

## 🔑 ÉTAPE 2 : Configuration des Clés API (3 minutes)

Le script va vous demander vos clés API. Voici où les trouver :

### 2.1 Clé API Render
```
🔗 https://dashboard.render.com/account/api-keys
👆 Cliquez "Create API Key"
📋 Copiez la clé qui commence par "rnd_"
```

### 2.2 Clés Supabase
```
🔗 https://supabase.com/dashboard/project/[VOTRE_PROJET]
👆 Settings → API
📋 Copiez :
   - Project URL
   - Anon public key
```

### 2.3 Clé API OpenAI
```
🔗 https://platform.openai.com/api-keys
👆 "Create new secret key"
📋 Copiez la clé (commence par "sk-")
```

### 2.4 Clé API Stripe
```
🔗 https://dashboard.stripe.com/apikeys
👆 Copiez la "Secret key" (commence par "sk_live_" ou "sk_test_")
```

---

## ⚡ ÉTAPE 3 : Attendre le déploiement (10-15 minutes)

Le script va :
- ✅ Installer Python automatiquement
- ✅ Créer le fichier `.env`
- ✅ Installer les dépendances
- ✅ Tester la configuration
- ✅ Déployer sur Render

**Buvez un café ☕ et attendez !**

---

## 🎉 ÉTAPE 4 : Vérification

Allez sur https://dashboard.render.com pour voir vos services :

### Services créés :
```
🗄️  kortix-db         (Base de données PostgreSQL)
🔧 kortix-backend     (API FastAPI)
🌐 kortix-frontend    (Application Next.js)
```

### URLs finales :
```
🌐 Application : https://kortix-frontend.onrender.com
🔧 API : https://kortix-backend.onrender.com
```

---

## 🚨 SI ÇA NE MARCHE PAS

### Problème : PowerShell bloque le script
**Solution :**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Problème : Erreur de clé API
**Solution :**
- Vérifiez que les clés sont correctes
- Pas d'espaces avant/après
- Relancez le script

### Problème : Timeout déploiement
**Solution :**
- Attendez plus longtemps (15-20 minutes)
- Vérifiez les logs sur Render dashboard

---

## 🎊 RÉSULTAT FINAL

Après succès, vous aurez :
- ✅ **Application web** accessible partout
- ✅ **API backend** pour les fonctionnalités
- ✅ **Base de données** pour les données
- ✅ **Déploiement automatique** pour les mises à jour

---

## 🚀 COMMANDES DE RAPPEL

```powershell
# Aller dans le dossier
cd "C:\Users\[VOTRE_NOM]\Downloads\suna-main (1)\suna-main"

# Lancer le déploiement
.\DEPLOY-TOUT.ps1

# Pour les mises à jour futures
python auto-deploy-render.py
```

---

**C'EST PARTI ! 🚀 Lancez `.\DEPLOY-TOUT.ps1` et laissez le script tout faire !**
