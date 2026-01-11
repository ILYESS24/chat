#!/usr/bin/env python3
"""
Script automatique de déploiement pour Kortix sur Render
Déploie simultanément le backend et le frontend
"""

import os
import sys
import time
import requests
import json
from typing import Dict, Any, Optional
import subprocess

class RenderDeployer:
    def __init__(self):
        self.api_key = os.getenv('RENDER_API_KEY')
        self.workspace_id = os.getenv('RENDER_WORKSPACE_ID', 'tea-d48i8kbuibrs7398sv20')  # Votre workspace
        self.repo_url = 'https://github.com/kortix-ai/suna'
        self.branch = os.getenv('RENDER_BRANCH', 'main')

        if not self.api_key:
            print("❌ RENDER_API_KEY non défini. Obtenez une clé API sur https://dashboard.render.com/account/api-keys")
            sys.exit(1)

        self.headers = {
            'Authorization': f'Bearer {self.api_key}',
            'Content-Type': 'application/json'
        }
        self.base_url = 'https://api.render.com/v1'

    def check_payment_method(self) -> bool:
        """Vérifie si une méthode de paiement est configurée"""
        try:
            response = requests.get(f'{self.base_url}/workspace/{self.workspace_id}', headers=self.headers)
            if response.status_code == 200:
                workspace_data = response.json()
                return workspace_data.get('hasPaymentMethod', False)
            return False
        except Exception as e:
            print(f"Erreur lors de la vérification du paiement: {e}")
            return False

    def create_postgres_service(self, service_name: str = 'kortix-db') -> Optional[str]:
        """Crée une base de données PostgreSQL"""
        print(f"🗄️  Création de la base de données PostgreSQL: {service_name}")

        data = {
            "type": "pgsql",
            "name": service_name,
            "plan": "starter",
            "region": "oregon"
        }

        try:
            response = requests.post(f'{self.base_url}/services', headers=self.headers, json=data)
            if response.status_code == 201:
                service = response.json()
                print(f"✅ Base de données créée: {service['service']['id']}")
                return service['service']['id']
            else:
                print(f"❌ Erreur création DB: {response.status_code} - {response.text}")
                return None
        except Exception as e:
            print(f"❌ Erreur lors de la création de la DB: {e}")
            return None

    def create_backend_service(self, db_service_id: Optional[str] = None, service_name: str = 'kortix-backend') -> Optional[str]:
        """Crée le service backend FastAPI"""
        print(f"🔧 Création du service backend: {service_name}")

        env_vars = [
            {"key": "ENV_MODE", "value": "production"},
            {"key": "PYTHONPATH", "value": "/app"},
            {"key": "SUPABASE_URL", "value": os.getenv('SUPABASE_URL', '')},
            {"key": "SUPABASE_ANON_KEY", "value": os.getenv('SUPABASE_ANON_KEY', '')},
            {"key": "JWT_SECRET", "value": os.getenv('JWT_SECRET', '')},
            {"key": "OPENAI_API_KEY", "value": os.getenv('OPENAI_API_KEY', '')},
            {"key": "STRIPE_SECRET_KEY", "value": os.getenv('STRIPE_SECRET_KEY', '')}
        ]

        # Ajouter la connexion DB si disponible
        if db_service_id:
            env_vars.append({
                "key": "DATABASE_URL",
                "fromService": {
                    "type": "pgsql",
                    "id": db_service_id,
                    "property": "connectionString"
                }
            })

        data = {
            "type": "web_service",
            "name": service_name,
            "repo": self.repo_url,
            "branch": self.branch,
            "rootDir": "backend",
            "runtime": "python",
            "plan": "starter",
            "region": "oregon",
            "buildCommand": "pip install uv && uv sync --locked",
            "startCommand": "uv run gunicorn api:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000 --timeout 75 --graceful-timeout 30 --keep-alive 65",
            "envVars": env_vars
        }

        try:
            response = requests.post(f'{self.base_url}/services', headers=self.headers, json=data)
            if response.status_code == 201:
                service = response.json()
                print(f"✅ Backend créé: {service['service']['id']}")
                return service['service']['id']
            else:
                print(f"❌ Erreur création backend: {response.status_code} - {response.text}")
                return None
        except Exception as e:
            print(f"❌ Erreur lors de la création du backend: {e}")
            return None

    def create_frontend_service(self, backend_service_id: Optional[str] = None, service_name: str = 'kortix-frontend') -> Optional[str]:
        """Crée le service frontend Next.js"""
        print(f"🌐 Création du service frontend: {service_name}")

        env_vars = [
            {"key": "NODE_ENV", "value": "production"},
            {"key": "NEXT_TELEMETRY_DISABLED", "value": "1"},
            {"key": "NEXT_PUBLIC_SUPABASE_URL", "value": os.getenv('NEXT_PUBLIC_SUPABASE_URL', '')},
            {"key": "NEXT_PUBLIC_SUPABASE_ANON_KEY", "value": os.getenv('NEXT_PUBLIC_SUPABASE_ANON_KEY', '')}
        ]

        # Ajouter l'URL du backend si disponible
        if backend_service_id:
            env_vars.append({
                "key": "NEXT_PUBLIC_API_URL",
                "fromService": {
                    "type": "web_service",
                    "id": backend_service_id,
                    "property": "host"
                }
            })

        data = {
            "type": "web_service",
            "name": service_name,
            "repo": self.repo_url,
            "branch": self.branch,
            "rootDir": "apps/frontend",
            "runtime": "node",
            "plan": "starter",
            "region": "oregon",
            "buildCommand": "npm run build",
            "startCommand": "npm start",
            "envVars": env_vars
        }

        try:
            response = requests.post(f'{self.base_url}/services', headers=self.headers, json=data)
            if response.status_code == 201:
                service = response.json()
                print(f"✅ Frontend créé: {service['service']['id']}")
                return service['service']['id']
            else:
                print(f"❌ Erreur création frontend: {response.status_code} - {response.text}")
                return None
        except Exception as e:
            print(f"❌ Erreur lors de la création du frontend: {e}")
            return None

    def wait_for_service_ready(self, service_id: str, service_name: str, timeout: int = 600) -> bool:
        """Attend qu'un service soit prêt"""
        print(f"⏳ Attente que {service_name} soit prêt...")
        start_time = time.time()

        while time.time() - start_time < timeout:
            try:
                response = requests.get(f'{self.base_url}/services/{service_id}', headers=self.headers)
                if response.status_code == 200:
                    service_data = response.json()
                    status = service_data.get('status')
                    print(f"   Status de {service_name}: {status}")

                    if status == 'live':
                        print(f"✅ {service_name} est prêt!")
                        return True
                    elif status in ['build_failed', 'update_failed']:
                        print(f"❌ Échec du déploiement de {service_name}")
                        return False
                else:
                    print(f"Erreur API pour {service_name}: {response.status_code}")
            except Exception as e:
                print(f"Erreur connexion pour {service_name}: {e}")

            time.sleep(10)

        print(f"⏰ Timeout atteint pour {service_name}")
        return False

    def deploy_all(self):
        """Déploie tous les services automatiquement"""
        print("🚀 Déploiement automatique de Kortix sur Render")
        print("=" * 50)

        # Vérification du paiement
        if not self.check_payment_method():
            print("❌ Aucune méthode de paiement configurée.")
            print("Configurez un moyen de paiement sur https://dashboard.render.com/billing")
            return False

        print("✅ Méthode de paiement vérifiée")

        # Étape 1: Création de la base de données
        db_id = self.create_postgres_service()
        if not db_id:
            return False

        # Attendre que la DB soit prête
        if not self.wait_for_service_ready(db_id, "Base de données"):
            return False

        # Étape 2: Création du backend
        backend_id = self.create_backend_service(db_id)
        if not backend_id:
            return False

        # Étape 3: Création du frontend (avec référence au backend)
        frontend_id = self.create_frontend_service(backend_id)
        if not frontend_id:
            return False

        # Attendre que les services soient prêts
        print("\n⏳ Attente que tous les services soient déployés...")

        backend_ready = self.wait_for_service_ready(backend_id, "Backend", 900)  # 15 min timeout
        frontend_ready = self.wait_for_service_ready(frontend_id, "Frontend", 900)  # 15 min timeout

        if backend_ready and frontend_ready:
            print("\n🎉 Déploiement réussi!")
            print("URLs des services:")
            print(f"- Frontend: https://kortix-frontend.onrender.com")
            print(f"- Backend: https://kortix-backend.onrender.com")
            print(f"- Base de données: Configurée automatiquement")
            return True
        else:
            print("\n❌ Certains services ont échoué à se déployer")
            return False

def main():
    """Fonction principale"""
    print("Vérification des variables d'environnement...")

    required_env_vars = [
        'RENDER_API_KEY',
        'SUPABASE_URL',
        'SUPABASE_ANON_KEY',
        'JWT_SECRET',
        'OPENAI_API_KEY',
        'STRIPE_SECRET_KEY',
        'NEXT_PUBLIC_SUPABASE_URL',
        'NEXT_PUBLIC_SUPABASE_ANON_KEY'
    ]

    missing_vars = [var for var in required_env_vars if not os.getenv(var)]
    if missing_vars:
        print("❌ Variables d'environnement manquantes:")
        for var in missing_vars:
            print(f"   - {var}")
        print("\nDéfinissez-les avec: export VARIABLE=valeur")
        sys.exit(1)

    print("✅ Toutes les variables d'environnement sont définies")

    # Lancement du déploiement
    deployer = RenderDeployer()
    success = deployer.deploy_all()

    if success:
        print("\n✨ Votre application Kortix est maintenant déployée sur Render!")
        print("Vous pouvez accéder à l'application via les URLs ci-dessus.")
    else:
        print("\n💥 Échec du déploiement. Vérifiez les logs ci-dessus.")
        sys.exit(1)

if __name__ == "__main__":
    main()
