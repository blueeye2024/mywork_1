#!/bin/bash

# ==============================================================================
# [TEST] 내부 테스트 서버 배포 스크립트
# - 운영 서버(9200)에 영향을 주지 않고, 테스트 서버(9201)를 띄웁니다.
# ==============================================================================

echo -e "\033[1;33m>>> [TEST MODE] Deploying to Staging Environment (Port 9201)...\033[0m"

# 1. 소스 업데이트
git pull origin main

# 2. 테스트 버전 태그 생성
export APP_VERSION="TEST-$(date +%H%M)"
export NEXT_PUBLIC_API_URL_TEST="http://114.108.180.228:8001"
export NEXT_PUBLIC_SITE_URL_TEST="http://114.108.180.228:9201"

# 3. 테스트 컨테이너 실행 (리소스 절약을 위해 제한된 자원 사용)
# -f 옵션으로 기본 설정에 테스트 설정을 덮어씌움
docker-compose -f docker-compose.yml -f docker-compose.test.yml up -d --build

echo -e "\033[1;32m"
echo "========================================================"
echo "✅ 테스트 서버 배포 완료!"
echo "   - 접속 주소: http://114.108.180.228:9201"
echo "   - 확인 후 이상이 없으면 './deploy.sh'를 실행하여 배포하세요."
echo "========================================================"
echo -e "\033[0m"
