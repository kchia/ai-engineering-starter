.PHONY: help install dev test build deploy demo clean template-setup fix-npm

help:
	@echo "🤖 AI Engineering Starter Template"
	@echo "=================================="
	@echo "  make install         - Install dependencies"
	@echo "  make dev             - Start development environment"
	@echo "  make test            - Run all tests"
	@echo "  make demo            - Prepare demo environment"
	@echo "  make template-setup  - Setup guide for template users"
	@echo "  make fix-npm         - Fix npm configuration warnings"
	@echo "  make clean           - Clean up containers and dependencies"

install:
	@echo "📦 Installing dependencies..."
	@echo "Checking prerequisites..."
	@if ! command -v node >/dev/null 2>&1; then \
		echo "❌ Node.js not found. Please install Node.js 18+ first."; \
		exit 1; \
	fi
	@if ! command -v python3 >/dev/null 2>&1; then \
		echo "❌ Python 3 not found. Please install Python 3.11+ first."; \
		exit 1; \
	fi
	@if [ ! -f "app/package.json" ]; then \
		echo "❌ Frontend app/package.json not found."; \
		echo "💡 This might be a template repository issue. See troubleshooting in CLAUDE.md"; \
		exit 1; \
	fi
	@if [ ! -f "backend/requirements.txt" ]; then \
		echo "❌ Backend requirements.txt not found."; \
		exit 1; \
	fi
	@echo "✅ Prerequisites check passed"
	@echo "Installing frontend dependencies..."
	cd app && npm install --loglevel=error && npx playwright install
	@echo "Setting up backend environment..."
	cd backend && rm -rf venv 2>/dev/null || true
	cd backend && python3 -m venv venv && ./venv/bin/pip install --upgrade pip
	@echo "Installing backend dependencies..."
	cd backend && ./venv/bin/pip install -r requirements.txt
	@echo "Setting up environment files..."
	cp backend/.env.example backend/.env 2>/dev/null || true
	cp app/.env.local.example app/.env.local 2>/dev/null || true
	@echo "✅ Installation complete!"
	@echo "📝 Next: Edit .env files with your API keys"
	@echo "🚀 Then run: make dev"

dev:
	@echo "🚀 Starting development..."
	@echo "Checking Docker availability..."
	@if [ -f "/Applications/Docker.app/Contents/Resources/bin/docker" ]; then \
		DOCKER_CMD="/Applications/Docker.app/Contents/Resources/bin/docker"; \
	elif command -v docker >/dev/null 2>&1; then \
		DOCKER_CMD="docker"; \
	else \
		echo "❌ Docker not found. Please install Docker Desktop and start it."; \
		exit 1; \
	fi; \
	if ! $$DOCKER_CMD info >/dev/null 2>&1; then \
		echo "❌ Docker daemon not running. Please start Docker Desktop."; \
		exit 1; \
	fi; \
	echo "✅ Docker is running"; \
	echo "Starting services..."; \
	$$DOCKER_CMD compose up -d 2>/dev/null || $$DOCKER_CMD-compose up -d
	@echo ""
	@echo "🎯 Next steps - Run these in separate terminals:"
	@echo "1. cd backend && source venv/bin/activate && uvicorn src.main:app --reload"
	@echo "2. cd app && npm run dev"
	@echo ""
	@echo "📱 Access points:"
	@echo "- Frontend: http://localhost:3000"
	@echo "- Backend API: http://localhost:8000"
	@echo "- API Docs: http://localhost:8000/docs"

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

template-setup:
	@echo "🎯 Template Setup Guide"
	@echo "======================"
	@echo "1. Update package.json name and description"
	@echo "2. Configure environment variables (.env files)"
	@echo "3. Update README.md with your project details"
	@echo "4. Customize authentication in app/auth.config.ts"
	@echo "5. Add your AI models and prompts"
	@echo "6. Run 'make install' to install dependencies"
	@echo ""
	@echo "📖 For detailed instructions, see TEMPLATE_SETUP.md"

fix-npm:
	@echo "🔧 Fixing npm configuration warnings..."
	@echo "Checking for problematic npm config entries..."
	@npm config list | grep -E "(userstory|myPort|file|python|NPM_TOKEN)" || true
	@echo ""
	@echo "To fix npm warnings, run these commands:"
	@echo "npm config delete userstory"
	@echo "npm config delete myPort"
	@echo "npm config delete file"
	@echo "npm config delete python"
	@echo "npm config delete NPM_TOKEN"
	@echo ""
	@echo "Or reset all user config: npm config edit --global"
