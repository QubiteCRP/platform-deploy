#!/bin/bash
# Clone all Q-BIT platform repositories

set -e

PARENT_DIR="../"
REPOS=(
  "chart-ui"
  "servergoQbites"
  "cryptoAi"
)

echo "🚀 Q-BIT Platform Setup"
echo "======================="
echo ""

cd "$PARENT_DIR"

for repo in "${REPOS[@]}"; do
  if [ -d "$repo" ]; then
    echo "✅ $repo already exists"
  else
    echo "📦 Cloning $repo..."
    # TODO: Replace with your actual repo URLs
    # git clone https://github.com/yourusername/$repo.git
    echo "⚠️  Please update this script with your repository URLs"
    exit 1
  fi
done

echo ""
echo "✅ All repositories ready!"
echo ""
echo "Next steps:"
echo "  1. Copy .env.example to ../cryptoAi/.env and add API keys"
echo "  2. Run: docker compose up -d"
echo "  3. Open: http://localhost:5173"
