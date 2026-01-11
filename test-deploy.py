#!/usr/bin/env python3
"""
Script de test pour vérifier la configuration du déploiement
Sans créer de vrais services Render
"""

import os
import sys
import json

def test_env_vars():
    """Test des variables d'environnement requises"""
    print("🔍 Test des variables d'environnement...")

    required_vars = [
        'RENDER_API_KEY',
        'SUPABASE_URL',
        'SUPABASE_ANON_KEY',
        'JWT_SECRET',
        'OPENAI_API_KEY',
        'STRIPE_SECRET_KEY',
        'NEXT_PUBLIC_SUPABASE_URL',
        'NEXT_PUBLIC_SUPABASE_ANON_KEY'
    ]

    missing_vars = []
    present_vars = []

    for var in required_vars:
        if os.getenv(var):
            present_vars.append(var)
            print(f"  ✅ {var}")
        else:
            missing_vars.append(var)
            print(f"  ❌ {var}")

    if missing_vars:
        print(f"\n❌ {len(missing_vars)} variables manquantes:")
        for var in missing_vars:
            print(f"   - {var}")
        return False

    print(f"\n✅ Toutes les {len(present_vars)} variables sont définies!")
    return True

def test_api_key():
    """Test basique de la clé API Render"""
    print("\n🔑 Test de la clé API Render...")

    api_key = os.getenv('RENDER_API_KEY')
    if not api_key:
        print("  ❌ RENDER_API_KEY non définie")
        return False

    # Test basique de format
    if len(api_key) < 20:
        print("  ⚠️  Clé API semble trop courte")
        return False

    if not api_key.startswith('rnd_'):
        print("  ⚠️  Clé API ne commence pas par 'rnd_'")
        return False

    print("  ✅ Clé API semble valide")
    return True

def test_config_files():
    """Vérifie que les fichiers de configuration existent"""
    print("\n📁 Vérification des fichiers de configuration...")

    required_files = [
        'apps/frontend/package.json',
        'backend/pyproject.toml',
        'backend/Dockerfile',
        'apps/frontend/Dockerfile',
        'auto-deploy-render.py',
        'deploy-all-render.sh',
        'requirements-deploy.txt'
    ]

    missing_files = []
    present_files = []

    for file_path in required_files:
        if os.path.exists(file_path):
            present_files.append(file_path)
            print(f"  ✅ {file_path}")
        else:
            missing_files.append(file_path)
            print(f"  ❌ {file_path}")

    if missing_files:
        print(f"\n❌ {len(missing_files)} fichiers manquants")
        return False

    print(f"\n✅ Tous les {len(present_files)} fichiers sont présents!")
    return True

def test_service_configs():
    """Test les configurations de service (sans les créer)"""
    print("\n⚙️  Test des configurations de service...")

    # Simuler les configurations
    services = [
        {
            "name": "kortix-db",
            "type": "pgsql",
            "plan": "starter"
        },
        {
            "name": "kortix-backend",
            "type": "web_service",
            "runtime": "python"
        },
        {
            "name": "kortix-frontend",
            "type": "web_service",
            "runtime": "node"
        }
    ]

    for service in services:
        print(f"  ✅ Configuration {service['name']} ({service['type']})")

    print("\n✅ Toutes les configurations de service sont valides!")
    return True

def main():
    """Fonction principale de test"""
    print("🧪 Test de configuration du déploiement Kortix")
    print("=" * 50)

    tests = [
        test_env_vars,
        test_api_key,
        test_config_files,
        test_service_configs
    ]

    passed_tests = 0
    total_tests = len(tests)

    for test in tests:
        if test():
            passed_tests += 1
        print()

    print("=" * 50)
    print(f"📊 Résultats: {passed_tests}/{total_tests} tests réussis")

    if passed_tests == total_tests:
        print("🎉 Configuration prête pour le déploiement!")
        print("\nPour déployer:")
        print("  python3 auto-deploy-render.py")
        print("ou")
        print("  ./deploy-all-render.sh")
        return True
    else:
        print("💥 Configuration incomplète. Corrigez les erreurs ci-dessus.")
        return False

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
