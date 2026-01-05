$ErrorActionPreference = "Stop"

# ==============================================================================
# Cheongan (청안) 원격 게시(Publish) 스크립트
# - 로컬의 코드를 Git에 올리고, 즉시 원격 서버를 조종하여 배포까지 마무리합니다.
# ==============================================================================

Write-Host ">>> [1/2] GitHub로 코드 전송 중..." -ForegroundColor Cyan

# 변경 사항이 있으면 커밋 (메시지 없으면 자동 메시지)
$git_status = git status --porcelain
if ($git_status) {
    git add .
    git commit -m "Auto-publish: Code changes applied"
}

# 원격 저장소 푸시
git push origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Git Push 실패. 배포를 중단합니다." -ForegroundColor Red
    exit 1
}

Write-Host ">>> [2/2] 운영 서버(114.108.180.228) 원격 배포 명령 실행..." -ForegroundColor Cyan
Write-Host "    (비밀번호를 물어보면 입력해 주세요)" -ForegroundColor Yellow

# SSH를 통해 서버 내부의 deploy.sh 실행
# -t 옵션: TTY 강제 할당 (스크립트 출력 보기 위해)
ssh -p 1975 -t blue@114.108.180.228 "cd /home/blue/blue/my_project/mywork_1 && ./deploy.sh"

Write-Host "`n✅ 모든 배포 작업이 완료되었습니다!" -ForegroundColor Green
