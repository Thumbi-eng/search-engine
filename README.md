# AI Google Search Agent

An AI agent built with [Google ADK](https://google.github.io/adk-docs/) that answers questions using Google Search grounding.

## Structure

```
search-engine/
├── search_agent/       ← ADK agent (discovered automatically)
│   ├── __init__.py
│   ├── agent.py
│   └── .env            ← GEMINI_API_KEY
├── pyproject.toml
└── README.md
```

## Prerequisites

- Python 3.13+
- A [Gemini API key](https://aistudio.google.com/apikey)

Add your key to `search_agent/.env`:

```
GEMINI_API_KEY=your_key_here
```

## Run

**Browser UI** (recommended):

```bash
.venv/bin/adk web .
```

Then open `http://localhost:8000` — select `search_agent` from the dropdown and start chatting.

**Interactive CLI:**

```bash
.venv/bin/adk run search_agent
```

**REST API server:**

```bash
.venv/bin/adk api_server .
```
