#!/usr/bin/env bash
set -euo pipefail
SERVICE="${1:-api}"
REGION="${REGION:-us-east1}"
PORT="${PORT:-8080}"
gcloud run deploy "$SERVICE" --source . --region "$REGION" --allow-unauthenticated --port "$PORT"
URL="$(gcloud run services describe "$SERVICE" --region "$REGION" --format='value(status.url)')"
echo "URL=$URL"
echo "[i] Health:"
curl -fsS "$URL/health" || curl -fsS "$URL/healthz" || true
