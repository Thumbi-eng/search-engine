#!/usr/bin/env bash
set -euo pipefail

# ── config ────────────────────────────────────────────────────────────────────
PROJECT_ID="${GCP_PROJECT:-mustangsellers-29d50}"
REGION="${GCP_REGION:-us-east1}"
SERVICE_NAME="search-agent"
IMAGE="gcr.io/${PROJECT_ID}/${SERVICE_NAME}"

# ── build & push ──────────────────────────────────────────────────────────────
echo "▶ Building and pushing image: ${IMAGE}"
gcloud builds submit \
  --project="${PROJECT_ID}" \
  --tag="${IMAGE}" \
  .

# ── deploy to Cloud Run ───────────────────────────────────────────────────────
echo "▶ Deploying to Cloud Run (${REGION})..."
gcloud run deploy "${SERVICE_NAME}" \
  --project="${PROJECT_ID}" \
  --image="${IMAGE}" \
  --region="${REGION}" \
  --platform=managed \
  --allow-unauthenticated \
  --port=8080 \
  --memory=512Mi \
  --cpu=1 \
  --min-instances=0 \
  --max-instances=5 \
  --set-env-vars="GEMINI_API_KEY=${GEMINI_API_KEY:?GEMINI_API_KEY must be set}"

echo ""
echo "✅ Deployed! Service URL:"
gcloud run services describe "${SERVICE_NAME}" \
  --project="${PROJECT_ID}" \
  --region="${REGION}" \
  --format="value(status.url)"
