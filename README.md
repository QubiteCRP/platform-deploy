# Q-BIT Trading Platform - Deployment

**Autonomous crypto & equities trading terminal with ML-powered signals**

## 🏗️ Architecture

This platform orchestrates 4 microservices:

```
┌─────────────────────────────────────────────────────────┐
│  chart-ui (React)          :5173                        │
│  ↓ GraphQL queries                                      │
│  servergoQbites (Go)       :8080                        │
│  ↓ reads MongoDB                                        │
│  MongoDB                   :27017                       │
│  ↑ written by                                           │
│  cryptoAi (Python ML)      background pipeline          │
└─────────────────────────────────────────────────────────┘
```

## 📦 Repositories

| Service | Repository | Description |
|---------|-----------|-------------|
| **chart-ui** | `../chart-ui` | React + MUI trading dashboard |
| **servergoQbites** | `../servergoQbites` | Go GraphQL API server |
| **cryptoAi** | `../cryptoAi` | Python ML pipeline (signals, indicators, bot) |
| **MongoDB** | Docker image | Data persistence |

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Git

### 1. Clone repositories (if not already present)

```bash
cd /Users/achenak/expedia/q-bit

# If repos aren't cloned yet:
# git clone <chart-ui-repo-url>
# git clone <servergoQbites-repo-url>
# git clone <cryptoAi-repo-url>
```

### 2. Set up environment files

```bash
# Create cryptoAi/.env with API keys
cp cryptoAi/.env.example cryptoAi/.env
# Edit with your keys: BINANCE_API_KEY, ALPACA_API_KEY, etc.
```

### 3. Start the platform

```bash
cd platform-deploy
docker compose up -d
```

### 4. Access the UI

- **Trading Terminal**: http://localhost:5173
- **GraphQL API**: http://localhost:8080/graphql
- **MongoDB**: mongodb://localhost:27017

## 🛠️ Development

### Start individual services

```bash
# Frontend only (with HMR)
cd ../chart-ui && npm run dev

# Backend only
cd ../servergoQbites && go run .

# Pipeline only
cd ../cryptoAi && python -m src.main
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
├── platform-deploy/          ← YOU ARE HERE
│   ├── docker-compose.yml    ← Orchestration
│   └── README.md
├── chart-ui/                 ← React frontend
├── servergoQbites/          ← Go GraphQL API
├── cryptoAi/                ← Python ML pipeline
└── chart-ui-design/         ← POC worktree (port 5180)
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
docker volume rm platform-deploy_mongo-data
docker compose up -d
```

**Frontend not updating:**
- Check `CHOKIDAR_USEPOLLING=true` is set in docker-compose.yml
- Restart: `docker compose restart web`

**Python dependencies missing:**
```bash
cd ../cryptoAi
pip install -r requirements.txt
```

---

Built with ❤️ for autonomous trading
