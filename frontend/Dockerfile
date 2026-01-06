FROM node:18-slim AS base

# 빌드 인자(ARG) 정의 - 버전 정보 주입용
ARG NEXT_PUBLIC_APP_VERSION
ENV NEXT_PUBLIC_APP_VERSION=$NEXT_PUBLIC_APP_VERSION

# 1. 의존성 설치 (Deps)
FROM base AS deps
# Debian uses glibc, so libc6-compat is not needed.
WORKDIR /app

COPY package.json pnpm-lock.yaml* ./
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# 2. 빌드 (Builder)
FROM base AS builder
WORKDIR /app

# 빌드 시점에도 ARG 필요
ARG NEXT_PUBLIC_APP_VERSION
ENV NEXT_PUBLIC_APP_VERSION=$NEXT_PUBLIC_APP_VERSION

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Next.js 텔레메트리 끄기
ENV NEXT_TELEMETRY_DISABLED 1

# 빌드 실행
RUN npm install -g pnpm && pnpm run build

# 3. 실행 (Runner)
FROM base AS runner
WORKDIR /app

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

RUN groupadd --system --gid 1001 nodejs
RUN useradd --system --uid 1001 nextjs

# 정적 파일 및 Standalone 빌드 복사
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Healthcheck 도구 설치
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

USER nextjs

EXPOSE 3000

ENV PORT 3000
ENV HOSTNAME "0.0.0.0"

CMD ["node", "server.js"]
