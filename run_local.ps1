# Powershell Script for Local Development (No Docker)
Write-Host ">>> Starting Local Development Environment (Cheongan)..." -ForegroundColor Cyan

# 0. 환경 변수 동기화
Write-Host "[0/3] Syncing .env files..."
Copy-Item -Path ".env" -Destination "backend/.env" -Force

# Frontend용 .env.local 생성 (로컬 전용 설정 덮어쓰기)
Get-Content ".env" | ForEach-Object { 
    if ($_ -match "NEXT_PUBLIC_API_URL=") { "NEXT_PUBLIC_API_URL=http://localhost:8000" }
    elseif ($_ -match "NEXT_PUBLIC_SITE_URL=") { "NEXT_PUBLIC_SITE_URL=http://localhost:3000" }
    else { $_ }
} | Set-Content "frontend/.env.local"

# 1. Backend 실행 (새 창에서)
Write-Host "[1/3] Launching Backend (FastAPI)..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; pip install -r requirements.txt; Write-Host 'Starting Backend...'; uvicorn app.main:app --reload --port 8000"

# 잠시 대기
Start-Sleep -Seconds 5

# 2. Frontend 실행 (새 창에서)
Write-Host "[2/3] Launching Frontend (Next.js)..."
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; pnpm install; Write-Host 'Starting Frontend...'; pnpm dev"

Write-Host "[3/3] All services started!" -ForegroundColor Green
Write-Host "   - Backend API: http://localhost:8000/docs"
Write-Host "   - Frontend UI: http://localhost:3000"
Write-Host "   (Note: 창을 닫으면 서버가 종료됩니다)"

# 웹 브라우저 자동 실행
Start-Sleep -Seconds 2
Start-Process "http://localhost:3000"
