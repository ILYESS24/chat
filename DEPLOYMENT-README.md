# 🚀 Déploiement Automatique Kortix sur Render

Ce guide explique comment déployer automatiquement **tous les services Kortix** (backend, frontend et base de données) sur Render en une seule commande.

## 📋 Prérequis

### 1. Méthode de paiement Render
Vous devez avoir configuré une méthode de paiement sur Render :
1. Allez sur [https://dashboard.render.com/billing](https://dashboard.render.com/billing)
2. Ajoutez une carte de crédit ou configurez un autre moyen de paiement

### 2. Clé API Render
1. Allez sur [https://dashboard.render.com/account/api-keys](https://dashboard.render.com/account/api-keys)
2. Créez une nouvelle clé API
3. Copiez-la pour l'utiliser dans les variables d'environnement

### 3. Variables d'environnement
Copiez le fichier `env-example.txt` vers `.env` et remplissez toutes les valeurs :

```bash
cp env-example.txt .env
# Éditez .env avec vos vraies valeurs
```

## ⚡ Déploiement Automatique

### Option 1: Script Python (Recommandé)

```bash
# Installer les dépendances
pip install -r requirements-deploy.txt

# Tester la configuration (recommandé)
python3 test-deploy.py

# Charger les variables d'environnement
source .env

# Lancer le déploiement
python3 auto-deploy-render.py
```

### Option 2: Script Bash

```bash
# Rendre le script exécutable (Windows: ignorez cette étape)
chmod +x deploy-all-render.sh

# Charger les variables d'environnement
source .env

# Lancer le déploiement
./deploy-all-render.sh
```

## 🎯 Ce que fait le script

Le script de déploiement automatique :

1. **Vérifie** que toutes les variables d'environnement sont définies
2. **Crée** la base de données PostgreSQL (`kortix-db`)
3. **Attend** que la base de données soit prête
4. **Crée** le service backend FastAPI (`kortix-backend`)
5. **Crée** le service frontend Next.js (`kortix-frontend`)
6. **Attend** que tous les services soient déployés et opérationnels
7. **Affiche** les URLs finales pour accéder à votre application

## 📊 Services créés

| Service | Type | URL | Coût mensuel |
|---------|------|-----|--------------|
| **kortix-db** | PostgreSQL | Interne | $7 |
| **kortix-backend** | Web Service | `https://kortix-backend.onrender.com` | $7 |
| **kortix-frontend** | Web Service | `https://kortix-frontend.onrender.com` | $7 |
| **Total** | | | **$21/mois** |

## 🔧 Configuration technique

### Backend (FastAPI)
- **Runtime** : Python 3.11
- **Build** : `pip install uv && uv sync --locked`
- **Start** : `uv run gunicorn api:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000`
- **Variables** : Toutes les clés API et configurations

### Frontend (Next.js)
- **Runtime** : Node.js
- **Build** : `npm run build`
- **Start** : `npm start`
- **Variables** : Configuration Supabase et URL API

### Base de données (PostgreSQL)
- **Plan** : Starter (1 GB)
- **Région** : Oregon (us-west-2)
- **Connexion** : Automatique via variables d'environnement

## 🚨 Dépannage

### Erreur "Payment information is required"
- Configurez un moyen de paiement sur Render
- Vérifiez que votre compte n'a pas de restrictions

### Erreur "Variables d'environnement manquantes"
```bash
# Vérifiez quelles variables sont définies
env | grep -E "(RENDER|SUPABASE|JWT|OPENAI|STRIPE)"

# Chargez votre fichier .env
source .env
```

### Erreur "API Key invalid"
- Vérifiez que votre `RENDER_API_KEY` est correcte
- Créez une nouvelle clé API si nécessaire

### Timeout de déploiement
- Les déploiements peuvent prendre 10-15 minutes
- Le script attend automatiquement que tout soit prêt
- Vous pouvez surveiller la progression sur [https://dashboard.render.com](https://dashboard.render.com)

### Échec de build
- Vérifiez les logs dans le dashboard Render
- Les erreurs les plus courantes :
  - Dépendances manquantes dans `pyproject.toml` ou `package.json`
  - Variables d'environnement incorrectes
  - Erreurs de compilation Python/Node.js

## 🔄 Mises à jour

Pour mettre à jour vos services après des changements de code :

```bash
# Le déploiement automatique déclenche automatiquement
# les mises à jour quand vous poussez sur la branche main

# Ou déclenchez manuellement via l'API :
curl -X POST "https://api.render.com/v1/services/{SERVICE_ID}/deploys" \
  -H "Authorization: Bearer $RENDER_API_KEY"
```

## 📈 Monitoring

Une fois déployé, surveillez vos services :

- **Dashboard Render** : [https://dashboard.render.com](https://dashboard.render.com)
- **Logs** : Accès direct aux logs de chaque service
- **Métriques** : CPU, mémoire, requêtes HTTP
- **Health checks** : État des services

## 🎉 Succès !

Après un déploiement réussi, vous aurez :

1. ✅ Base de données PostgreSQL opérationnelle
2. ✅ API FastAPI accessible
3. ✅ Application Next.js accessible
4. ✅ Intégration automatique entre les services

Votre application Kortix est maintenant en production sur Render ! 🎊

## 📞 Support

Si vous rencontrez des problèmes :

1. Vérifiez les logs dans le dashboard Render
2. Consultez la documentation Render : [https://docs.render.com](https://docs.render.com)
3. Ouvrez une issue sur le repository GitHub

---

*Dernière mise à jour : $(date)*
