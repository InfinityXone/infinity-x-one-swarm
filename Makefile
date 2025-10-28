SHELL := /bin/bash
PORT ?= 8080
SERVICE ?= api
REGION ?= us-east1
PROJECT ?= $(shell gcloud config get-value project 2>/dev/null)

.PHONY: help
help:
\t@echo "Targets: build run test docker-gha deploy logs health"

build:
\t@echo "[i] Building $(SERVICE) ..."
\tdocker build -t $(SERVICE):dev ./$(SERVICE) || true

run:
\t@echo "[i] Running $(SERVICE) on :$(PORT)"
\tdocker run --rm -e PORT=$(PORT) -p $(PORT):$(PORT) $(SERVICE):dev

health:
\t@echo "[i] Health check"
\tcurl -fsS http://localhost:$(PORT)/health || curl -fsS http://localhost:$(PORT)/healthz

deploy:
\t@echo "[i] Deploying $(SERVICE) to Cloud Run (region $(REGION))"
\tgcloud run deploy $(SERVICE) --source . --region $(REGION) --allow-unauthenticated --port $(PORT)

logs:
\tgcloud run logs read --region $(REGION) --service $(SERVICE) --limit 200
