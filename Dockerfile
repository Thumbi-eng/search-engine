# ── build stage: install dependencies ────────────────────────────────────────
FROM python:3.13-slim AS builder

WORKDIR /app

RUN pip install --upgrade pip
COPY pyproject.toml .
RUN pip install --no-cache-dir "google-adk==1.26.0" "google-genai==1.66.0"

# ── runtime stage ─────────────────────────────────────────────────────────────
FROM python:3.13-slim

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /usr/local/lib/python3.13/site-packages /usr/local/lib/python3.13/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy only the agent source — no .env (secrets injected at runtime)
COPY search_agent/ ./search_agent/

# Cloud Run injects PORT; ADK api_server respects --port
ENV PORT=8080
EXPOSE 8080

# Run ADK web UI server pointing at the agents directory (current dir)
CMD adk web --host 0.0.0.0 --port "$PORT" .
