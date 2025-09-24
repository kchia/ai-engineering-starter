.PHONY: help install dev test build deploy demo clean

help:
	@echo "�� AI Engineering Demo Day Project"
	@echo "===================================="
	@echo "  make install    - Install dependencies"
	@echo "  make dev        - Start development (no tmux)"
	@echo "  make test       - Run all tests"
	@echo "  make demo       - Prepare demo environment"

install:
	@echo "📦 Installing dependencies..."
	cd app && npm install && npx playwright install
	cd backend && python -m venv venv && ./venv/bin/pip install -r requirements.txt
	cp backend/.env.example backend/.env 2>/dev/null || true
	cp app/.env.local.example app/.env.local 2>/dev/null || true
	@echo "✅ Edit .env files with your API keys"

dev:
	@echo "🚀 Starting development..."
	@echo "Run these in separate terminals:"
	@echo "1. docker-compose up"
	@echo "2. cd backend && source venv/bin/activate && uvicorn src.main:app --reload"
	@echo "3. cd app && npm run dev"
	@docker-compose up -d
	@echo "✅ Services started. Open http://localhost:3000"

test:
	cd backend && source venv/bin/activate && pytest tests/ -v
	cd app && npm test
	cd app && npm run test:e2e

demo:
	@echo "🎬 Preparing demo..."
	docker-compose up -d
	@echo "📊 Opening dashboards..."
	@echo "- App: http://localhost:3000"
	@echo "- API Docs: http://localhost:8000/docs"
	@echo "- Qdrant: http://localhost:6333/dashboard"

clean:
	docker-compose down -v
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".next" -exec rm -rf {} + 2>/dev/null || true
	rm -rf backend/venv app/node_modules
