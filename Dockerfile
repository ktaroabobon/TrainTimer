# Dockerfile
FROM oven/bun:1.1.5 as base

WORKDIR /app

# 依存関係を先にインストール
COPY package.json bun.lockb ./
RUN bun install --frozen-lockfile

# ソースコードをコピー
COPY . .

# 開発用コンテナ設定
FROM base as dev
EXPOSE 9000
CMD ["bun", "run", "dev"]
