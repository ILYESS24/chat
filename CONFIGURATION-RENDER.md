# 🚀 Configuration des Variables d'Environnement Render

## 🔥 PROBLÈME ACTUEL

Votre backend se déploie maintenant correctement, mais il manque les variables d'environnement essentielles dans Render.

**Erreur actuelle :**
```
DaytonaError: API key or JWT token is required
No .env file found at /opt/render/project/src/backend/.env
```

## ⚙️ CONFIGURATION DANS RENDER

### 1. Accédez à votre service Render
- Allez sur https://dashboard.render.com
- Sélectionnez votre service backend `kortix-backend`
- Cliquez sur "Environment"

### 2. Ajoutez ces variables (OBLIGATOIRES)

#### Variables essentielles :
```
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_clé_supabase
JWT_SECRET=votre_secret_jwt_unique
OPENAI_API_KEY=sk-votre_clé_openai
STRIPE_SECRET_KEY=sk_votre_clé_stripe
```

#### Variables optionnelles (mais recommandées) :
```
DAYTONA_API_KEY=votre_clé_daytona
DAYTONA_API_URL=https://api.daytona.io
TAVILY_API_KEY=votre_clé_tavily
REDIS_URL=redis://votre_redis_url
```

---

## 🔑 COMMENT OBTENIR LES CLÉS API

### Supabase
1. Allez sur https://supabase.com/dashboard
2. Sélectionnez votre projet
3. Settings → API
4. Copiez :
   - **Project URL** (pour SUPABASE_URL)
   - **anon public** (pour SUPABASE_ANON_KEY)

### OpenAI
1. Allez sur https://platform.openai.com/api-keys
2. "Create new secret key"
3. Copiez la clé commençant par `sk-`

### Stripe
1. Allez sur https://dashboard.stripe.com/apikeys
2. Copiez la **Secret key** (commence par `sk_`)

### Daytona (Optionnel)
1. Allez sur https://app.daytona.io
2. Créez un compte si nécessaire
3. Récupérez votre API key

### Tavily (Optionnel - pour recherche web)
1. Allez sur https://tavily.com
2. Créez un compte
3. Récupérez votre API key

---

## 🎯 JWT SECRET

**Générez un secret unique :**
```bash
# Sur Windows PowerShell :
[System.Web.Security.Membership]::GeneratePassword(32, 0)

# Ou utilisez un générateur en ligne :
# https://www.uuidgenerator.net/
```

**Exemple de JWT secret :** `a1b2c3d4e5f6789012345678901234567890`

---

## 📋 ÉTAPES DANS RENDER

### 1. Ouvrez votre service backend
```
Dashboard Render → kortix-backend → Environment
```

### 2. Ajoutez chaque variable
- Cliquez "Add Environment Variable"
- Remplissez Key et Value
- Cliquez "Save"

### 3. Variables minimales requises :
```
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...
JWT_SECRET=a1b2c3d4...
OPENAI_API_KEY=sk-proj-...
STRIPE_SECRET_KEY=sk_live_...
```

### 4. Redéployez
- Cliquez "Manual Deploy" → "Deploy latest commit"
- Attendez que le déploiement se termine

---

## ✅ VÉRIFICATION

Après configuration, vous devriez voir dans les logs :
```
✅ Configuration loaded successfully
✅ Module initialized (DIRECT MODE)
✅ Application started on port 8000
```

---

## 🚨 SI ÇA NE MARCHE TOUJOURS PAS

### 1. Vérifiez les logs détaillés
- Dans Render Dashboard → Logs
- Cherchez les erreurs spécifiques

### 2. Variables mal configurées
- Vérifiez qu'il n'y a pas d'espaces
- Les clés API doivent être exactes

### 3. Redémarrage forcé
- "Manual Deploy" → "Clear build cache and deploy"

---

## 🎊 RÉSULTAT ATTENDU

Une fois configuré, votre backend sera :
- ✅ Connecté à Supabase
- ✅ Authentification fonctionnelle
- ✅ APIs OpenAI/Stripe opérationnelles
- ✅ Sandbox Daytona (si configuré)
- ✅ Accessible sur `https://kortix-backend.onrender.com`

---

**Configurez ces variables dans Render et votre déploiement sera 100% fonctionnel !** 🚀
