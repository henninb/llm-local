#!/bin/sh
set -e

if [ -z "$HF_TOKEN" ]; then
  echo "ERROR: HF_TOKEN is not set. Export it before running this script."
  exit 1
fi

http_status=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $HF_TOKEN" https://huggingface.co/api/whoami-v2)
if [ "$http_status" != "200" ]; then
  echo "ERROR: HF_TOKEN is invalid (HTTP $http_status)."
  exit 1
fi

OLLAMA_OVERRIDE=/etc/systemd/system/ollama.service.d/override.conf

if ! grep -q 'OLLAMA_HOST=0.0.0.0' "$OLLAMA_OVERRIDE" 2>/dev/null; then
  echo "Configuring Ollama to listen on all interfaces..."
  sudo mkdir -p "$(dirname "$OLLAMA_OVERRIDE")"
  printf '[Service]\nEnvironment="OLLAMA_HOST=0.0.0.0"\n' | sudo tee "$OLLAMA_OVERRIDE" > /dev/null
  sudo systemctl daemon-reload
  sudo systemctl restart ollama
fi

docker compose down --volumes --remove-orphans
docker compose up --build -d
