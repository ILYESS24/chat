# Guide de Déploiement Render pour Kortix

## Architecture du Projet

Le projet Kortix est composé de plusieurs applications :
- **Frontend** : Application Next.js (React) - Port 3000
- **Backend** : API FastAPI (Python) - Port 8000
- **Base de données** : PostgreSQL avec Supabase
- **Mobile** : Application React Native/Expo
- **Desktop** : Application Electron
- **SDK** : Bibliothèque Python

## Services à créer sur Render

### 1. Base de données PostgreSQL

Créez d'abord une base de données PostgreSQL :
- **Type** : PostgreSQL
- **Name** : `kortix-db`
- **Plan** : Starter ($7/mois)
- **Region** : Oregon (us-west-2)

### 2. Service Backend (API FastAPI)

**Configuration du Web Service :**
- **Name** : `kortix-backend`
- **Runtime** : Python 3.11
- **Build Command** :
  ```bash
  pip install uv
  uv sync --locked
  ```
- **Start Command** :
  ```bash
  uv run gunicorn api:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000 --timeout 75 --graceful-timeout 30 --keep-alive 65
  ```
- **Environment Variables** :
  ```
  ENV_MODE=production
  PYTHONPATH=/app
  DATABASE_URL=<PostgreSQL connection string>
  SUPABASE_URL=<your-supabase-url>
  SUPABASE_ANON_KEY=<your-supabase-anon-key>
  JWT_SECRET=<your-jwt-secret>
  OPENAI_API_KEY=<your-openai-key>
  STRIPE_SECRET_KEY=<your-stripe-key>
  ```

### 3. Service Frontend (Next.js)

**Configuration du Web Service :**
- **Name** : `kortix-frontend`
- **Runtime** : Node.js
- **Build Command** : `npm run build`
- **Start Command** : `npm start`
- **Root Directory** : `apps/frontend`
- **Environment Variables** :
  ```
  NODE_ENV=production
  NEXT_TELEMETRY_DISABLED=1
  NEXT_PUBLIC_API_URL=https://kortix-backend.onrender.com
  NEXT_PUBLIC_SUPABASE_URL=<your-supabase-url>
  NEXT_PUBLIC_SUPABASE_ANON_KEY=<your-supabase-anon-key>
  ```

## Variables d'environnement requises

### Backend
```bash
# Base de données
DATABASE_URL=postgresql://user:password@host:5432/database

# Supabase
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key

# Authentification
JWT_SECRET=your-jwt-secret-key

# APIs externes
OPENAI_API_KEY=sk-...
STRIPE_SECRET_KEY=sk_...
TAVILY_API_KEY=your-tavily-key

# Autres services
REDIS_URL=redis://your-redis-url
```

### Frontend
```bash
# API
NEXT_PUBLIC_API_URL=https://kortix-backend.onrender.com

# Supabase
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key

# Analytics
NEXT_PUBLIC_POSTHOG_KEY=your-posthog-key
NEXT_PUBLIC_VERCEL_ENV=production
```

## Commandes de déploiement

### Via Render Dashboard

1. **Connectez votre repository GitHub** : `kortix-ai/suna`
2. **Créez les services** dans l'ordre :
   - PostgreSQL database
   - Backend web service
   - Frontend web service
3. **Configurez les variables d'environnement** pour chaque service
4. **Déployez** automatiquement à chaque push sur main

### Via Render CLI (alternative)

```bash
# Installation
npm install -g @render/cli

# Connexion
render login

# Création des services
render services create --name kortix-db --type pgsql --plan starter
render services create --name kortix-backend --type web --repo https://github.com/kortix-ai/suna --branch main --runtime python --build-command "pip install uv && uv sync --locked" --start-command "uv run gunicorn api:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000 --timeout 75"
render services create --name kortix-frontend --type web --repo https://github.com/kortix-ai/suna --branch main --runtime node --root-dir apps/frontend --build-command "npm run build" --start-command "npm start"
```

## Structure des répertoires

```
suna-main/
├── apps/
│   ├── frontend/          # Application Next.js
│   │   ├── Dockerfile     # Configuration Docker
│   │   ├── package.json   # Dépendances Node.js
│   │   └── src/           # Code source React
│   └── backend/           # Non utilisé directement
├── backend/               # API FastAPI
│   ├── Dockerfile         # Configuration Docker
│   ├── pyproject.toml     # Dépendances Python
│   ├── api.py            # Point d'entrée FastAPI
│   └── core/             # Code source Python
└── supabase/              # Configuration base de données
```

## URLs après déploiement

- **Frontend** : `https://kortix-frontend.onrender.com`
- **Backend** : `https://kortix-backend.onrender.com`
- **Base de données** : `postgresql://...render.com`

## Monitoring et logs

Utilisez Render Dashboard pour :
- **Logs** : Voir les logs en temps réel
- **Metrics** : CPU, mémoire, requêtes
- **Health checks** : État des services
- **Auto-scaling** : Ajustement automatique des ressources

## Sécurité

- **HTTPS** : Activé automatiquement par Render
- **Variables d'environnement** : Stockées de manière sécurisée
- **Firewall** : Réseau isolé entre services
- **Backups** : Automatiques pour PostgreSQL

## Dépannage

### Erreurs communes

1. **Timeout de build** : Augmentez le timeout ou optimisez le build
2. **Mémoire insuffisante** : Passez à un plan supérieur
3. **Variables manquantes** : Vérifiez toutes les env vars requises
4. **Connexion DB** : Vérifiez la chaîne de connexion PostgreSQL

### Commandes de debug

```bash
# Voir les logs
render logs kortix-backend
render logs kortix-frontend

# Redémarrer un service
render services restart kortix-backend

# Voir les variables d'environnement
render services env kortix-backend
```
