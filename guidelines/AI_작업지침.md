# AI를 통한 신규 프로젝트 원터치 세팅 가이드 (AI Workflow)

이 문서는 AI(안티그래비티)에게 다음 프로젝트를 맡길 때, 이 모든 세팅을 **한 번에** 끝내기 위한 **마스터 프롬프트**입니다.

새로운 프로젝트를 시작할 때, 아래 절차만 따르시면 됩니다.

---

## 1단계: 스마트 프로젝트 복제 (Smart Copy & Assembly)

기존 프로젝트를 통째로 복사하는 대신, 핵심 파일만 가져와서 `pnpm`으로 가볍게 재조립합니다. 이 방식은 디스크 용량을 획기적으로 절약합니다.

### 1-1. 파일 복사
새 프로젝트 폴더를 만들고, 기존 프로젝트에서 **다음 폴더와 파일만** 복사해옵니다.
*   ✅ **가져올 것**: `frontend`(단, `node_modules`, `.next` 제외), `backend`(단, `venv`, `__pycache__` 제외), `guidelines`, `docker-compose.yml`, `*.ps1`, `*.sh`, `*.json`, `.env`
*   ❌ **버릴 것**: `node_modules`, `.next`, `.git`, `__pycache__`

### 1-2. 의존성 재조립 (1초컷)
새 폴더의 터미널에서 다음 명령어로 끊어진 연결을 다시 잇습니다.

```powershell
# Frontend: pnpm으로 가볍게 연결 (하드 링크 사용)
cd frontend
pnpm install

# Backend: 기존 방식대로 설치
cd ../backend
pip install -r requirements.txt
```

## 2단계: AI에게 명령하기 (Master Prompt)

개발 툴(Code Editor)을 열고, AI에게 아래 내용을 **복사해서 붙여넣기** 하세요.

```markdown
안티그래비티, 이 프로젝트를 기반으로 새로운 프로젝트 세팅을 시작해줘.
`guidelines/환경세팅.md` 문서를 철저히 준수하여 다음 작업을 원스톱으로 처리해.

1. **변수 수집**: 나에게 [프로젝트명, 외부 포트, DB 정보, 서버 IP]를 먼저 물어봐.
2. **일괄 변경**: 내가 정보를 주면, 아래 파일들의 내용을 찾아서 한 번에 수정해.
   - `.env`: DB 및 URL 정보 업데이트
   - `docker-compose.yml`: 컨테이너 이름 및 포트 매핑 변경
   - `frontend/src/app/page.tsx` & `layout.tsx`: UI 타이틀/브랜드명 변경
   - `deploy.sh` & `test.sh`: 스크립트 내 API/Site URL 자동 변경
   - `README.md`: 프로젝트 명세 업데이트
   - `guidelines/환경세팅.md`: 변경된 포트와 IP 업데이트
3. **개발 및 배포 환경 자동화**:
   - **Local 실행 루틴**: `run_local.ps1` 생성 (Frontend는 반드시 `pnpm` 사용, 브라우저 자동 실행 포함).
   - **원격 게시 루틴**: 
     - `publish.ps1` 생성 (Git Push + SSH 원격 실행).
     - `setup_ssh_key.ps1` 생성 (SSH 키 자동 등록).
   - **테스트 루틴**:
     - `test.sh` 및 `docker-compose.test.yml` 생성 (Staging 환경 구성).
   - **Git & CSS**:
     - `git config user.name "blueeye2024"` 자동 실행.
     - Tailwind CSS v4 문법(`@theme`) 적용 확인.
4. **초기화**: 
   - `VERSION` 파일을 `1.0.0`으로 리셋해.
   - `guidelines/변경이력.md`를 초기화해.
5. **검증**: 변경 후 `docker-compose config`로 설정 오류가 없는지 확인해.

이 모든 과정을 완료하고 "준비 완료" 메시지를 띄워줘.
```

---

## 3단계: 확인 및 배포

AI가 작업을 마치면 바로 배포하시면 됩니다.

1. 변경된 설정 확인 (`.env` 등)
2. 서버에 업로드 및 배포:
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```
