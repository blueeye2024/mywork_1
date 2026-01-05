# Cheongan (청안) 프로젝트

이 프로젝트는 Next.js 프론트엔드와 FastAPI 백엔드로 구성된 풀스택 웹 애플리케이션입니다.

## 프로젝트 정보

- **프로젝트명**: Cheongan (청안)
- **버전**: v1.0.1
- **저장소**: [GitHub](https://github.com/blueeye2024/mywork_1.git)

## 기술 스택

- **Frontend**: Next.js (App Router), Tailwind CSS
- **Backend**: FastAPI (Python 3.11+)
- **Database**: MariaDB (External)
- **Infrastructure**: Docker & Docker Compose

## 시작하기 (Getting Started)

### 사전 요구 사항

- Docker 및 Docker Compose가 설치되어 있어야 합니다.

### 실행 방법

1. 저장소 클론:
   ```bash
   git clone https://github.com/blueeye2024/mywork_1.git
   cd mywork_1
   ```

2. Docker Compose 실행:
   ```bash
   docker-compose up -d --build
   ```

3. 서비스 접속:
   - **Frontend**: http://localhost:3000
   - **Backend API**: http://localhost:8000
   - **API 문서**: http://localhost:8000/docs

## 폴더 구조

- `frontend/`: Next.js 웹 애플리케이션
- `backend/`: FastAPI 애플리케이션
- `docker-compose.yml`: 컨테이너 오케스트레이션 설정

## 리소스 제한

- **Backend**: CPU 1.0 / Memory 1GB
- **Frontend**: CPU 0.5 / Memory 512MB
