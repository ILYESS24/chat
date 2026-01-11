#!/bin/bash

# Script de déploiement automatique simultané pour Kortix
# Déploie backend, frontend et base de données en parallèle

set -e

echo "🚀 Déploiement automatique de Kortix sur Render"
echo "=============================================="

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher des messages colorés
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Vérification des prérequis
check_prerequisites() {
    print_info "Vérification des prérequis..."

    # Vérifier curl
    if ! command -v curl &> /dev/null; then
        print_error "curl n'est pas installé"
        exit 1
    fi

    # Vérifier python3
    if ! command -v python3 &> /dev/null; then
        print_error "python3 n'est pas installé"
        exit 1
    fi

    print_success "Prérequis vérifiés"
}

# Vérification des variables d'environnement
check_env_vars() {
    print_info "Vérification des variables d'environnement..."

    local required_vars=(
        "RENDER_API_KEY"
        "SUPABASE_URL"
        "SUPABASE_ANON_KEY"
        "JWT_SECRET"
        "OPENAI_API_KEY"
        "STRIPE_SECRET_KEY"
        "NEXT_PUBLIC_SUPABASE_URL"
        "NEXT_PUBLIC_SUPABASE_ANON_KEY"
    )

    local missing_vars=()

    for var in "${required_vars[@]}"; do
        if [[ -z "${!var}" ]]; then
            missing_vars+=("$var")
        fi
    done

    if [[ ${#missing_vars[@]} -ne 0 ]]; then
        print_error "Variables d'environnement manquantes:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        echo ""
        print_info "Définissez-les avec: export VARIABLE=votre_valeur"
        print_info "Ou créez un fichier .env avec ces variables"
        exit 1
    fi

    print_success "Toutes les variables d'environnement sont définies"
}

# Fonction pour créer un service Render
create_service() {
    local service_config=$1
    local service_name=$2

    print_info "Création du service $service_name..."

    local response=$(curl -s -w "\n%{http_code}" \
        -X POST "https://api.render.com/v1/services" \
        -H "Authorization: Bearer $RENDER_API_KEY" \
        -H "Content-Type: application/json" \
        -d "$service_config")

    local http_code=$(echo "$response" | tail -n1)
    local response_body=$(echo "$response" | head -n -1)

    if [[ "$http_code" == "201" ]]; then
        local service_id=$(echo "$response_body" | python3 -c "import sys, json; print(json.load(sys.stdin)['service']['id'])")
        print_success "Service $service_name créé: $service_id"
        echo "$service_id"
    else
        print_error "Échec création $service_name (HTTP $http_code): $response_body"
        return 1
    fi
}

# Fonction pour attendre qu'un service soit prêt
wait_for_service() {
    local service_id=$1
    local service_name=$2
    local timeout=${3:-600}  # 10 minutes par défaut

    print_info "Attente que $service_name soit prêt..."

    local start_time=$(date +%s)

    while true; do
        local current_time=$(date +%s)
        local elapsed=$((current_time - start_time))

        if [[ $elapsed -gt $timeout ]]; then
            print_error "Timeout atteint pour $service_name"
            return 1
        fi

        local response=$(curl -s -w "\n%{http_code}" \
            -X GET "https://api.render.com/v1/services/$service_id" \
            -H "Authorization: Bearer $RENDER_API_KEY")

        local http_code=$(echo "$response" | tail -n1)
        local response_body=$(echo "$response" | head -n -1)

        if [[ "$http_code" == "200" ]]; then
            local status=$(echo "$response_body" | python3 -c "import sys, json; print(json.load(sys.stdin).get('status', 'unknown'))")
            echo "  Status de $service_name: $status"

            if [[ "$status" == "live" ]]; then
                print_success "$service_name est prêt!"
                return 0
            elif [[ "$status" == "build_failed" || "$status" == "update_failed" ]]; then
                print_error "Échec du déploiement de $service_name"
                return 1
            fi
        else
            echo "  Erreur API pour $service_name (HTTP $http_code)"
        fi

        sleep 10
    done
}

# Fonction principale de déploiement
deploy_all() {
    # Configuration de la base de données
    local db_config='{
        "type": "pgsql",
        "name": "kortix-db",
        "plan": "starter",
        "region": "oregon"
    }'

    # Configuration du backend
    local backend_config=$(cat <<EOF
{
    "type": "web_service",
    "name": "kortix-backend",
    "repo": "https://github.com/kortix-ai/suna",
    "branch": "main",
    "rootDir": "backend",
    "runtime": "python",
    "plan": "starter",
    "region": "oregon",
    "buildCommand": "pip install uv && uv sync --locked",
    "startCommand": "uv run gunicorn api:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000 --timeout 75 --graceful-timeout 30 --keep-alive 65",
    "envVars": [
        {"key": "ENV_MODE", "value": "production"},
        {"key": "PYTHONPATH", "value": "/app"},
        {"key": "SUPABASE_URL", "value": "$SUPABASE_URL"},
        {"key": "SUPABASE_ANON_KEY", "value": "$SUPABASE_ANON_KEY"},
        {"key": "JWT_SECRET", "value": "$JWT_SECRET"},
        {"key": "OPENAI_API_KEY", "value": "$OPENAI_API_KEY"},
        {"key": "STRIPE_SECRET_KEY", "value": "$STRIPE_SECRET_KEY"}
    ]
}
EOF
)

    # Configuration du frontend
    local frontend_config=$(cat <<EOF
{
    "type": "web_service",
    "name": "kortix-frontend",
    "repo": "https://github.com/kortix-ai/suna",
    "branch": "main",
    "rootDir": "apps/frontend",
    "runtime": "node",
    "plan": "starter",
    "region": "oregon",
    "buildCommand": "npm run build",
    "startCommand": "npm start",
    "envVars": [
        {"key": "NODE_ENV", "value": "production"},
        {"key": "NEXT_TELEMETRY_DISABLED", "value": "1"},
        {"key": "NEXT_PUBLIC_SUPABASE_URL", "value": "$NEXT_PUBLIC_SUPABASE_URL"},
        {"key": "NEXT_PUBLIC_SUPABASE_ANON_KEY", "value": "$NEXT_PUBLIC_SUPABASE_ANON_KEY"}
    ]
}
EOF
)

    print_info "Début du déploiement simultané..."

    # Étape 1: Création de la base de données
    print_info "Étape 1: Création de la base de données PostgreSQL"
    local db_id=$(create_service "$db_config" "Base de données")
    if [[ $? -ne 0 ]]; then exit 1; fi

    # Attendre que la DB soit prête
    if ! wait_for_service "$db_id" "Base de données"; then exit 1; fi

    # Récupérer la chaîne de connexion de la DB
    print_info "Récupération de la chaîne de connexion de la base de données..."
    local db_response=$(curl -s \
        -X GET "https://api.render.com/v1/services/$db_id" \
        -H "Authorization: Bearer $RENDER_API_KEY")

    local db_connection_string=$(echo "$db_response" | python3 -c "
import sys, json
data = json.load(sys.stdin)
env_vars = data.get('envVars', [])
for env_var in env_vars:
    if env_var.get('key') == 'DATABASE_URL':
        print(env_var.get('value', ''))
        break
")

    # Étape 2: Création du backend avec connexion DB
    print_info "Étape 2: Création du backend FastAPI"
    local backend_config_with_db=$(echo "$backend_config" | sed "s|\"STRIPE_SECRET_KEY\": \"\$STRIPE_SECRET_KEY\"|\"STRIPE_SECRET_KEY\": \"$STRIPE_SECRET_KEY\", \"DATABASE_URL\": \"$db_connection_string\"|g")

    local backend_id=$(create_service "$backend_config_with_db" "Backend")
    if [[ $? -ne 0 ]]; then exit 1; fi

    # Étape 3: Création du frontend
    print_info "Étape 3: Création du frontend Next.js"
    local frontend_config_with_backend=$(echo "$frontend_config" | sed "s|\"NEXT_PUBLIC_SUPABASE_ANON_KEY\": \"\$NEXT_PUBLIC_SUPABASE_ANON_KEY\"|\"NEXT_PUBLIC_SUPABASE_ANON_KEY\": \"$NEXT_PUBLIC_SUPABASE_ANON_KEY\", \"NEXT_PUBLIC_API_URL\": \"https://kortix-backend.onrender.com\"|g")

    local frontend_id=$(create_service "$frontend_config_with_backend" "Frontend")
    if [[ $? -ne 0 ]]; then exit 1; fi

    # Attendre que tous les services soient prêts
    print_info "Attente que tous les services soient déployés..."

    local backend_ready=false
    local frontend_ready=false

    # Démarrer les attentes en arrière-plan
    wait_for_service "$backend_id" "Backend" 900 &
    local backend_pid=$!

    wait_for_service "$frontend_id" "Frontend" 900 &
    local frontend_pid=$!

    # Attendre que les deux processus se terminent
    wait $backend_pid
    backend_ready=$?

    wait $frontend_pid
    frontend_ready=$?

    if [[ $backend_ready -eq 0 && $frontend_ready -eq 0 ]]; then
        print_success "Déploiement réussi!"
        echo ""
        print_info "URLs des services:"
        echo "  - Frontend: https://kortix-frontend.onrender.com"
        echo "  - Backend: https://kortix-backend.onrender.com"
        echo "  - Base de données: Configurée automatiquement"
        echo ""
        print_success "🎉 Votre application Kortix est maintenant déployée sur Render!"
        return 0
    else
        print_error "Certains services ont échoué à se déployer"
        return 1
    fi
}

# Fonction d'aide
show_help() {
    echo "Script de déploiement automatique de Kortix sur Render"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help          Afficher cette aide"
    echo "  --dry-run          Simuler le déploiement sans rien créer"
    echo ""
    echo "Variables d'environnement requises:"
    echo "  RENDER_API_KEY      Clé API Render (https://dashboard.render.com/account/api-keys)"
    echo "  SUPABASE_URL        URL de votre projet Supabase"
    echo "  SUPABASE_ANON_KEY   Clé anonyme Supabase"
    echo "  JWT_SECRET          Secret JWT pour l'authentification"
    echo "  OPENAI_API_KEY      Clé API OpenAI"
    echo "  STRIPE_SECRET_KEY   Clé secrète Stripe"
    echo "  NEXT_PUBLIC_SUPABASE_URL      URL publique Supabase"
    echo "  NEXT_PUBLIC_SUPABASE_ANON_KEY Clé publique Supabase"
    echo ""
    echo "Exemple:"
    echo "  export RENDER_API_KEY=your_api_key"
    echo "  export SUPABASE_URL=https://your-project.supabase.co"
    echo "  # ... autres variables ..."
    echo "  $0"
}

# Gestion des arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    --dry-run)
        print_info "Mode dry-run: simulation du déploiement"
        print_warning "Les services ne seront pas réellement créés"
        exit 0
        ;;
    *)
        # Script principal
        check_prerequisites
        check_env_vars
        deploy_all
        ;;
esac
