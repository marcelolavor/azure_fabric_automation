#!/usr/bin/env bash
set -euo pipefail

# Caminho base dos ambientes
BASE_DIR="envs"
ENVS=("dev" "pre" "prd")

# Provider antigo e novo
OLD_PROVIDER="registry.terraform.io/hashicorp/fabric"
NEW_PROVIDER="registry.terraform.io/microsoft/fabric"

echo "🔎 Corrigindo providers de $OLD_PROVIDER -> $NEW_PROVIDER em todos os ambientes..."

for ENV in "${ENVS[@]}"; do
  echo "➡️ Ambiente: $ENV"

  cd "$BASE_DIR/$ENV"

  # Limpa cache e lockfile
  rm -rf .terraform .terraform.lock.hcl || true

  # Reinit para garantir modules/providers atualizados
  terraform init -upgrade -input=false

  # Se não houver state, cria um state inicial só de refresh
  if [ ! -f terraform.tfstate ]; then
    echo "📦 Criando state inicial em $ENV..."
    terraform apply -refresh-only -auto-approve || true
  fi

  # Faz o replace de provider
  echo "🔧 Ajustando providers no state..."
  terraform state replace-provider -auto-approve "$OLD_PROVIDER" "$NEW_PROVIDER" || true

  cd - > /dev/null
done

echo "✅ Providers corrigidos com sucesso em todos os ambientes!"
