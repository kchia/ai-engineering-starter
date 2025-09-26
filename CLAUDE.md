# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Quick Start

```bash
make install    # Install all dependencies
make dev        # Start development environment
make test       # Run all tests
make demo       # Prepare demo environment
```

### Manual Development

```bash
# Start services
docker-compose up -d

# Backend (in separate terminal)
cd backend && source venv/bin/activate && uvicorn src.main:app --reload

# Frontend (in separate terminal)
cd app && npm run dev
```

### Testing

```bash
# Backend tests
cd backend && source venv/bin/activate && pytest tests/ -v

# Frontend tests
cd app && npm test

# E2E tests
cd app && npm run test:e2e
```

## Architecture

**Full-stack AI engineering project** with three-tier architecture:

### Frontend (`/app`)

- **Next.js 15.5.4** with App Router and TypeScript
- **Auth.js v5** for authentication
- **Tailwind CSS v4** for styling
- **Playwright** for E2E testing
- Runs on port 3000

### Backend (`/backend`)

- **FastAPI** for high-performance API
- **LangChain/LangGraph** for AI workflows
- **SQLAlchemy** with async PostgreSQL
- **Prometheus** metrics collection
- Runs on port 8000

### Services (Docker Compose)

- **PostgreSQL 16** - Primary database (port 5432)
- **Qdrant** - Vector database for AI (ports 6333/6334)
- **Redis 7** - Cache and sessions (port 6379)

## Key Endpoints

- Frontend: http://localhost:3000
- Backend API docs: http://localhost:8000/docs
- Health check: http://localhost:8000/health
- Metrics: http://localhost:8000/metrics
- Qdrant dashboard: http://localhost:6333/dashboard

## Environment Setup

Copy `.env.example` files and configure:

- `backend/.env` - Database URLs, AI API keys
- `app/.env.local` - Auth secrets, API URLs

## Tech Stack Dependencies

- **Node.js 18+**, **Python 3.11+**, **Docker Desktop**
- AI: OpenAI, LangChain, LangGraph, LangSmith
- Vector: Qdrant, sentence-transformers
- Database: PostgreSQL with asyncpg, SQLAlchemy, Alembic
- Auth: Next-auth v5 with Auth.js core
- Testing: Playwright (E2E), pytest (backend)
