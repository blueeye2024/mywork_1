# AI를 통한 신규 프로젝트 원터치 세팅 가이드 (AI Workflow)

이 문서는 AI(안티그래비티)에게 다음 프로젝트를 맡길 때, 이 모든 세팅을 **한 번에** 끝내기 위한 **마스터 프롬프트**입니다.

새로운 프로젝트를 시작할 때, 아래 절차만 따르시면 됩니다.

---

## 1단계: 기존 프로젝트 복제 (Clone)

먼저 안정화된 이 프로젝트(`mywork_1`)를 템플릿으로 사용합니다.

```bash
# 새 프로젝트 폴더 생성 및 소스 가져오기
git clone https://github.com/blueeye2024/mywork_1.git new_project
cd new_project
# 기존 git 이력 제거 (새 출발)
rm -rf .git
git init
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
   - `deploy.sh`: 스크립트 내 주석/로그 메시지 변경
   - `README.md`: 프로젝트 명세 업데이트
   - `guidelines/환경세팅.md`: 변경된 포트와 IP 업데이트
3. **로컬 개발 환경 및 Git 설정**:
   - `run_local.ps1` (로컬 논-도커 실행 스크립트)가 있는지 확인하고 유지해. 없다면 생성해.
   - **Git 설정**: `git config user.name "blueeye2024"` 명령을 실행해.
   - **Tailwind CSS v4 대응**: 
     - `create-next-app` 사용 시 `frontend/tailwind.config.ts` 파일이 생성되었다면 **삭제**해.
     - `frontend/src/app/globals.css`를 Tailwind v4 문법(`@import "tailwindcss"; @theme { ... }`)으로 작성해.
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
