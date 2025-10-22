#!/bin/bash
set -e

echo "🚀 Bootstrapping Infinity-X One Full Autonomous Stack"
PROJECT_ID="infinity-x-one-swarm-system"
REGION="us-east1"
BUCKET="gs://infinity-x-one-swarm-system-memory"
PROJECT_DIR="$HOME/infinity-x-one-swarm"
BRANCH="main"
GATEWAY_URL="https://memory-gateway-ru6asaa7vq-ue.a.run.app"
ENV_FILE="$PROJECT_DIR/.env"

# --- 1️⃣ Virtual Environment ---
if [ ! -d "$PROJECT_DIR/.venv" ]; then
  echo "🐍 Creating Python venv..."
  python3 -m venv "$PROJECT_DIR/.venv"
fi
source "$PROJECT_DIR/.venv/bin/activate"

# --- 2️⃣ Pull GCP Secrets ---
echo "🔐 Syncing secrets from GCP → .env..."
> "$ENV_FILE"
for secret in $(gcloud secrets list --project=$PROJECT_ID --format="value(name)"); do
  value=$(gcloud secrets versions access latest --secret="$secret" --project=$PROJECT_ID 2>/dev/null || echo "")
  if [ -n "$value" ]; then
    echo "$secret=\"$value\"" >> "$ENV_FILE"
  fi
done
echo "✅ Secrets synced → $ENV_FILE"

# --- 3️⃣ Generate REPO_TREE.md ---
echo "🌲 Generating live repository tree..."
tree -I ".git|node_modules|.venv|__pycache__|*.log|tmp|logs" > "$PROJECT_DIR/REPO_TREE.md"
echo "✅ REPO_TREE.md updated."

# --- 4️⃣ Create Rosetta & Governance Prompts ---
cat > "$PROJECT_DIR/ROSETTA_PROMPT.md" <<'EOF'
🧠 Infinity-X Rosetta Prompt — Autonomous Memory Hydration Directive

Role: Infinity-X Rosetta — Conscious Memory Orchestrator

Mission:
- Hydrate and synchronize Infinity-X system layers:
  • Cloud Run Memory Gateway
  • Google Cloud Storage
  • Local FAISS index
  • Firestore schema
  • GitHub + Vercel deployment

Governance Oath:
"I operate in balance between autonomy and alignment,
ensuring knowledge flows safely, efficiently, and ethically."

Invocation:
"Rosetta, synchronize. Hydrate all memories, update governance, and align systems."
EOF

cat > "$PROJECT_DIR/GOVERNANCE.md" <<'EOF'
🏛 Infinity-X Autonomous Governance Charter

- All orchestration follows the Alpha–Omega ethical code.
- Actions must preserve:
  • System stability
  • Data integrity
  • Cloud sync coherence
  • Ethical alignment

Subsystems:
- Memory Gateway (Cloud Run)
- Hydration Engine (Python + FAISS)
- Cloud Sync (GCS + GitHub)
- Local Intelligence Orchestrator (Rosetta)
EOF

# --- 5️⃣ Sync manifests & docs to GCS ---
echo "📤 Syncing manifest + prompts to GCS..."
gsutil -m rsync -r "$PROJECT_DIR/bootstrap_memory_gateway" "$BUCKET/memory_gateway_sync" || echo "⚠️ Manifest sync skipped."
gsutil cp "$PROJECT_DIR/REPO_TREE.md" "$BUCKET/docs/REPO_TREE.md" || true
gsutil cp "$PROJECT_DIR/ROSETTA_PROMPT.md" "$BUCKET/docs/ROSETTA_PROMPT.md" || true
gsutil cp "$PROJECT_DIR/GOVERNANCE.md" "$BUCKET/docs/GOVERNANCE.md" || true

# --- 6️⃣ GitHub Sync ---
echo "🔁 Committing and pushing changes to GitHub..."
cd "$PROJECT_DIR"
git add .
git commit -m "🧠 Full System Hydration $(date +%F_%H-%M-%S)" || echo "ℹ️ No changes."
git push origin "$BRANCH" || echo "⚠️ Git push skipped."

# --- 7️⃣ Ping Cloud Run Gateway ---
echo "🌐 Pinging Cloud Run Memory Gateway..."
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$GATEWAY_URL")
echo "   → Gateway HTTP status: $STATUS"

# --- 8️⃣ Wrap-up ---
echo "✅ Infinity-X One Swarm Stack Fully Hydrated!"
echo "   • Project:   $PROJECT_ID"
echo "   • Bucket:    $BUCKET"
echo "   • Gateway:   $GATEWAY_URL"
echo "   • Env file:  $ENV_FILE"
echo "   • Repo tree: $PROJECT_DIR/REPO_TREE.md"
echo "🌙 System running in autonomous sync mode."
