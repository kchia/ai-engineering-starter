# 🤖 AI Engineering Starter Template

A production-ready AI engineering project template with modern full-stack architecture, authentication, monitoring, and containerized services.

## ✨ Features

- **🔐 Authentication**: Next.js with Auth.js v5 (next-auth)
- **⚡ Modern Stack**: Next.js 15.5.4, FastAPI, TypeScript, Tailwind CSS v4
- **📊 Monitoring**: Prometheus metrics, health checks
- **🗄️ Database**: PostgreSQL with async support
- **🧠 Vector Search**: Qdrant for AI/ML applications
- **⚡ Cache**: Redis for high-performance caching
- **🐳 Containerized**: Docker Compose for easy deployment
- **🧪 Testing**: Playwright for E2E, pytest for backend
- **🔧 Developer Tools**: Hot reloading, type safety, linting

## 🚀 Quick Start

### Prerequisites

- **Node.js** 18+
- **Python** 3.11+
- **Docker Desktop** (for services)

### 1. Install Dependencies

```bash
make install
```

This will:

- Install npm packages and Playwright browsers
- Create Python virtual environment
- Install Python dependencies
- Copy environment templates

### 2. Start Development Environment

```bash
make dev
```

Or manually in separate terminals:

```bash
# Terminal 1: Start Docker services
docker-compose up -d

# Terminal 2: Start backend
cd backend && source venv/bin/activate && uvicorn src.main:app --reload

# Terminal 3: Start frontend
cd app && npm run dev
```

### 3. Access Your Application

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000/docs
- **Qdrant Dashboard**: http://localhost:6333/dashboard

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │   Backend       │    │   Services      │
│   (Next.js)     │◄──►│   (FastAPI)     │◄──►│   (Docker)      │
│                 │    │                 │    │                 │
│ • Next.js 15    │    │ • FastAPI       │    │ • PostgreSQL    │
│ • Auth.js v5    │    │ • LangChain     │    │ • Qdrant        │
│ • Tailwind v4   │    │ • Prometheus    │    │ • Redis         │
│ • TypeScript    │    │ • Pydantic      │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Tech Stack

**Frontend (`/app`)**

- **Next.js 15.5.4** with App Router
- **TypeScript** for type safety
- **Tailwind CSS v4** for styling
- **Auth.js v5** for authentication
- **Playwright** for E2E testing

**Backend (`/backend`)**

- **FastAPI** for high-performance API
- **LangChain & LangGraph** for AI workflows
- **SQLAlchemy** with async PostgreSQL
- **Prometheus** for metrics collection
- **Pydantic** for data validation

**Services (`docker-compose.yml`)**

- **PostgreSQL 16** - Primary database (Port 5432)
- **Qdrant** - Vector database for AI (Ports 6333/6334)
- **Redis 7** - Cache and sessions (Port 6379)

## 🛠️ Development Commands

```bash
# Install all dependencies
make install

# Start development environment
make dev

# Run all tests
make test

# Prepare demo environment
make demo

# Clean up containers and dependencies
make clean

# Show help
make help
```

## 📁 Project Structure

```
ai-engineering-project/
├── app/                     # Next.js frontend
│   ├── src/app/            # App Router pages
│   ├── auth.config.ts      # Auth.js configuration
│   ├── middleware.ts       # Auth middleware
│   └── package.json
├── backend/                # FastAPI backend
│   ├── src/
│   │   └── main.py        # FastAPI application
│   ├── requirements.txt   # Python dependencies
│   └── venv/             # Virtual environment
├── docker-compose.yml     # Service containers
├── Makefile              # Development commands
└── README.md            # This file
```

## 🔧 Configuration

### Environment Variables

**Frontend (`.env.local`)**

```bash
# Authentication
AUTH_SECRET=your-secret-key
AUTH_URL=http://localhost:3000

# API Connection
NEXT_PUBLIC_API_URL=http://localhost:8000
```

**Backend (`.env`)**

```bash
# Database
DATABASE_URL=postgresql+asyncpg://demo_user:demo_pass@localhost:5432/demo_db

# Vector Database
QDRANT_URL=http://localhost:6333

# Cache
REDIS_URL=redis://localhost:6379

# AI Services (add your keys)
OPENAI_API_KEY=your-openai-key
LANGCHAIN_API_KEY=your-langchain-key
```

## 🧪 Testing

```bash
# Backend tests
cd backend && source venv/bin/activate && pytest tests/ -v

# Frontend unit tests
cd app && npm test

# E2E tests with Playwright
cd app && npm run test:e2e
```

## 📊 Monitoring & Health Checks

- **Backend Health**: http://localhost:8000/health
- **Metrics**: http://localhost:8000/metrics (Prometheus format)
- **API Documentation**: http://localhost:8000/docs (OpenAPI/Swagger)
- **Qdrant Dashboard**: http://localhost:6333/dashboard

## 🐳 Docker Services

The project includes three essential services:

```yaml
# PostgreSQL Database
postgres:5432
  - User: demo_user
  - Password: demo_pass
  - Database: demo_db

# Qdrant Vector Database
qdrant:6333/6334
  - Dashboard: :6333/dashboard
  - API: :6333

# Redis Cache
redis:6379
  - Memory limit: 256MB
  - Policy: allkeys-lru
```

## 🚨 Troubleshooting

### Common Issues

**Docker not starting:**

```bash
# Ensure Docker Desktop is running
open -a Docker

# Check Docker status
docker --version
docker-compose ps
```

**Python environment issues:**

```bash
# Recreate virtual environment
rm -rf backend/venv
cd backend && python -m venv venv
source venv/bin/activate && pip install -r requirements.txt
```

**Node.js dependency issues:**

```bash
# Clean install
cd app && rm -rf node_modules package-lock.json
npm install
```

**Port conflicts:**

- Frontend (3000), Backend (8000), PostgreSQL (5432), Qdrant (6333), Redis (6379)
- Check for other services using these ports: `lsof -i :3000`

## 📝 Notes

- **Authentication**: Demo credentials configured in `auth.config.ts`
- **Hot Reloading**: Both frontend and backend support hot reloading
- **Type Safety**: Full TypeScript support with strict mode
- **Code Quality**: Pre-commit hooks with linting and formatting
- **Scalability**: Designed for easy deployment to cloud platforms

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy coding!** 🚀
