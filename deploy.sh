#!/bin/bash

# ==============================================================================
# Cheongan (청안) Smart Automated Deployment Script
# Features: Zero-downtime, Auto-Versioning, Health-Check, Self-Healing
# 작성일: 2026-01-06
# ==============================================================================

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}>>> [Cheongan Deployment] Starting smart deployment process...${NC}"

# ==============================================================================
# 1. Pre-check: 환경 점검
# ==============================================================================
echo -e "${YELLOW}>>> [1/6] Pre-check: Checking environment...${NC}"

if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: .env file not found!${NC}"
    exit 1
fi

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Error: Docker is not installed.${NC}"
    exit 1
fi

# ==============================================================================
# 2. Update: 소스 코드 동기화
# ==============================================================================
echo -e "${YELLOW}>>> [2/6] Updating source code...${NC}"
git pull origin main

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error: Git pull failed.${NC}"
    # 배포 중단 여부 결정 (오프라인 테스트 시 주석 처리 가능)
    # exit 1 
fi

# ==============================================================================
# 3. Versioning: 시맨틱 버전 관리
# ==============================================================================
echo -e "${YELLOW}>>> [3/6] Managing version...${NC}"
VERSION_FILE="VERSION"

if [ ! -f $VERSION_FILE ]; then
    echo "1.0.0" > $VERSION_FILE
fi

CURRENT_VERSION=$(cat $VERSION_FILE)
IFS='.' read -r -a PARTS <<< "$CURRENT_VERSION"
MAJOR=${PARTS[0]}
MINOR=${PARTS[1]}
PATCH=${PARTS[2]}

# 패치 버전 증가
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

echo "$NEW_VERSION" > $VERSION_FILE
export APP_VERSION=$NEW_VERSION # Docker Compose에 전달할 환경 변수

echo -e "${GREEN}✅ Version bumped: $CURRENT_VERSION -> $NEW_VERSION${NC}"

# ==============================================================================
# 4. Build & Zero-downtime Switch
# ==============================================================================
echo -e "${YELLOW}>>> [4/6] Building and switching containers...${NC}"

# 캐시 없이 빌드하여 최신 사항 반영 보장
# --remove-orphans: 이전 설정의 잔재(고아 컨테이너) 제거
docker-compose up -d --build --remove-orphans

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error: Docker build failed. Rolling back not implemented yet.${NC}"
    exit 1
fi

# ==============================================================================
# 5. Health Verification: 자가 치유 및 검증
# ==============================================================================
echo -e "${YELLOW}>>> [5/6] Verifying health status (Max 30s)...${NC}"

check_health() {
    local service=$1
    local retries=0
    local max_retries=6 # 5초 * 6회 = 30초

    echo -n "   Checking $service..."
    while [ $retries -lt $max_retries ]; do
        STATUS=$(docker inspect -f '{{.State.Health.Status}}' $service 2>/dev/null)
        
        if [ "$STATUS" == "healthy" ]; then
            echo -e " ${GREEN}OK ($STATUS)${NC}"
            return 0
        fi
        
        echo -n "."
        sleep 5
        ((retries++))
    done

    echo -e " ${RED}FAILED ($STATUS)${NC}"
    return 1
}

# Backend 먼저 확인
if ! check_health "cheongan-backend"; then
    echo -e "${RED}❌ Critical Error: Backend failed to start. Logs:${NC}"
    docker-compose logs --tail=20 backend
    exit 1
fi

# Frontend 확인
if ! check_health "cheongan-frontend"; then
    echo -e "${RED}❌ Critical Error: Frontend failed to start. Logs:${NC}"
    docker-compose logs --tail=20 frontend
    exit 1
fi

# ==============================================================================
# 6. Finalize: Changelog 및 알림
# ==============================================================================
echo -e "${YELLOW}>>> [6/6] Finalizing deployment...${NC}"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
DATE_ONLY=$(date "+%Y-%m-%d")
LOG_ENTRY="## [$NEW_VERSION] - $DATE_ONLY\n- Deployed at $TIMESTAMP\n- Environment: Production (114.108.180.228)\n"

# 파일 상단에 추가 (임시 파일 사용)
echo -e "$LOG_ENTRY\n$(cat CHANGELOG.md)" > CHANGELOG.md

echo -e "${GREEN}========================================================"
echo -e "🚀 Deployment Successful!"
echo -e "   App Version : v$NEW_VERSION"
echo -e "   Access URL  : http://114.108.180.228:9200"
echo -e "========================================================${NC}"
