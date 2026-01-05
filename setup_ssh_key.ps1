# SSH 키 생성 및 서버 등록 스크립트

$ErrorActionPreference = "Stop"
$KeyPath = "$env:USERPROFILE\.ssh\id_rsa"

Write-Host ">>> SSH 키 자동 등록 설정을 시작합니다..." -ForegroundColor Cyan

# 1. SSH 키 존재 여부 확인 및 생성
if (-Not (Test-Path "$KeyPath")) {
    Write-Host "[1/2] SSH 키가 없어서 새로 생성합니다..."
    # -f: 파일경로, -N: 비밀번호 없음(엔터), -q: 조용히
    ssh-keygen -t rsa -b 4096 -f $KeyPath -N "" -q
    Write-Host "✅ SSH 키 생성 완료!" -ForegroundColor Green
}
else {
    Write-Host "[1/2] 기존 SSH 키를 사용합니다."
}

# 2. 서버에 원격 전송
Write-Host "[2/2] 서버(114.108.180.228)에 키를 등록합니다."
Write-Host "⚠️  주의: 등록을 위해 '마지막으로 한 번만' 비밀번호(blueeye0037!)를 입력해주세요." -ForegroundColor Yellow

$PublicKey = Get-Content "$KeyPath.pub"

# SSH 명령어로 키 등록 (Windows 호환 방식)
# remote server: 114.108.180.228, port: 1975, user: blue
$RemoteCmd = "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$PublicKey' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

ssh -p 1975 blue@114.108.180.228 $RemoteCmd

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n🎉 설정이 완료되었습니다! 이제 비밀번호 없이 접속 가능합니다." -ForegroundColor Green
    Write-Host "테스트: ssh -p 1975 blue@114.108.180.228 'echo 접속성공'" -ForegroundColor Gray
}
else {
    Write-Host "`n❌ 설정에 실패했습니다. 비밀번호가 틀렸거나 네트워크 문제일 수 있습니다." -ForegroundColor Red
}
