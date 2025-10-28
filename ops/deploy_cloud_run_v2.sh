#!/usr/bin/env bash
set -euo pipefail
REGION="${REGION:-us-east1}"
PORT="${PORT:-8080}"
MAP_FILE="${MAP_FILE:-ops/services.map}"
[[ ! -f "$MAP_FILE" ]] && { echo "[!] Missing $MAP_FILE"; exit 1; }

resolve_path(){ local svc="$1"; local line rhs primary fallback
line="$(grep -E "^${svc}=" "$MAP_FILE" | head -n1 || true)"; [[ -z "$line" ]] && return 1
rhs="${line#*=}"; IFS=',' read -r primary fallback <<<"$rhs"
[[ -d "$primary" ]] && { echo "$primary"; return 0; }
[[ -n "${fallback:-}" && -d "$fallback" ]] && { echo "$fallback"; return 0; }
return 1; }

deploy_one(){ local svc="$1" path
if ! path="$(resolve_path "$svc")"; then echo "[!] No path for '$svc' in $MAP_FILE"; return 1; fi
echo "— Deploying $svc  (source=$path, region=$REGION, port=$PORT)"
gcloud run deploy "$svc" --source "$path" --region "$REGION" --allow-unauthenticated --port "$PORT"
local url; url="$(gcloud run services describe "$svc" --region "$REGION" --format='value(status.url)')"
echo "URL=$url"; echo "- Health:"; (curl -fsS "$url/health" || curl -fsS "$url/healthz" || true) && echo
}

if (( $#==0 )); then cut -d= -f1 "$MAP_FILE" | while read -r s; do [[ -n "$s" ]] && deploy_one "$s"; done
else for s in "$@"; do deploy_one "$s"; done; fi
