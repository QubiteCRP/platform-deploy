# Nexora Platform - Deployment

**Autonomous crypto & equities trading terminal with ML-powered signals**

## 🏗️ Architecture

This platform orchestrates 4 microservices:

```
┌─────────────────────────────────────────────────────────┐
│  nexora-web (React)        :5173                        │
│  ↓ GraphQL queries                                      │
│  nexora-api (Go)           :8090                        │
│  ↓ reads MongoDB                                        │
│  MongoDB                   :27017                       │
│  ↑ written by                                           │
│  nexora-engine (Python ML) background pipeline          │
└─────────────────────────────────────────────────────────┘
```

## 📦 Repositories

| Service | Repository | Description |
|---------|-----------|-------------|
| **nexora-web** | `../nexora-web` | React + MUI trading dashboard |
| **nexora-api** | `../nexora-api` | Go GraphQL API server |
| **nexora-engine** | `../nexora-engine` | Python ML pipeline (signals, indicators, bot) |
| **MongoDB** | Docker image | Data persistence |

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Git

### 1. Clone repositories (if not already present)

```bash
cd /path/to/q-bit

# If repos aren't cloned yet:
# git clone <chart-ui-repo-url> nexora-web
# git clone <servergoQbites-repo-url> nexora-api
# git clone <cryptoAi-repo-url> nexora-engine
```

### 2. Set up environment files

```bash
# Create nexora-engine/.env with API keys
cp nexora-engine/.env.example nexora-engine/.env
# Edit with your keys: BINANCE_API_KEY, ALPACA_API_KEY, etc.
```

### 3. Start the platform

```bash
cd nexora-infra
docker compose up -d
```

### 4. Access the UI

- **Trading Terminal**: http://localhost:5173
- **GraphQL API**: http://localhost:8090/ (playground) · /query (API)
- **MongoDB**: mongodb://localhost:27017

## 🛠️ Development

### Start individual services

```bash
# Frontend only (with HMR)
cd ../nexora-web && npm run dev

# Backend only
cd ../nexora-api && go run .

# Pipeline only
cd ../nexora-engine && python main.py
```

### Logs

```bash
docker compose logs -f              # all services
docker compose logs -f server       # Go API only
docker compose logs -f pipeline     # Python ML only
```

## 📊 Features

- **Live Market Data**: Real-time crypto (Binance) & stocks (Alpaca, IBKR)
- **ML Signals**: Z-score deep-value, RSI, MACD, Aroon indicators
- **Smart Exit Bot**: Automated profit-taking ("BEATS BUY & HOLD")
- **Paper Trading**: Limit orders, positions, P&L tracking
- **Portfolio VT35**: Volatility-targeted 35% strategy with 8-asset allocation
- **Professional UI**: Dark glass design inspired by TradingView & DEX interfaces

## 🔧 Configuration

Edit `docker-compose.yml` to customize:
- Port mappings
- Volume mounts (for live code editing)
- Environment variables

## 📁 Project Structure

```
q-bit/
├── nexora-infra/             ← YOU ARE HERE
│   ├── docker-compose.yml    ← Orchestration
│   └── README.md
├── nexora-web/               ← React frontend
├── nexora-api/               ← Go GraphQL API
└── nexora-engine/            ← Python ML pipeline
```

## 🧹 Cleanup

```bash
docker compose down              # Stop services
docker compose down -v           # Stop + delete volumes (MongoDB data)
```

## 🐛 Troubleshooting

**MongoDB connection failed:**
```bash
docker compose down
docker volume rm q-bit_mongo-data
docker compose up -d
```

**Frontend not updating:**
- Check `CHOKIDAR_USEPOLLING=true` is set in docker-compose.yml
- Restart: `docker compose restart web`

**Python dependencies missing:**
```bash
cd ../nexora-engine
pip install -r requirements.txt
```

---

Built with ❤️ for autonomous trading
