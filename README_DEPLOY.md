# Cheongan (청안) 배포 매뉴얼

이 문서는 Cheongan 프로젝트의 운영 서버 배포 절차를 안내합니다.

## 1. 서버 정보

- **Host**: `114.108.180.228`
- **Port**: `1975` (SSH)
- **User**: `blue`
- **Path**: `/home/blue/blue/my_project/mywork_1`
- **Service**: [http://114.108.180.228:9200](http://114.108.180.228:9200)

## 2. 자동 배포 (권장)

서버에 접속하여 제공된 스크립트를 실행하면 전체 과정이 자동으로 처리됩니다.

```bash
# 1. 서버 접속
ssh -p 1975 blue@114.108.180.228

# 2. 프로젝트 폴더 이동
cd /home/blue/blue/my_project/mywork_1

# 3. 배포 스크립트 실행
./deploy.sh
```

## 3. 수동 배포 (문제 발생 시)

스크립트 실행 실패 시 아래 절차를 따르세요.

1. **소스 업데이트**: `git pull`
2. **컨테이너 재실행**: `docker-compose up -d --build`
3. **로그 확인**: `docker-compose logs -f`

## 4. 환경 변수 트러블슈팅

접속 문제가 발생할 경우 `.env` 파일의 `NEXT_PUBLIC_SITE_URL`과 `DB_HOST`가 정확한지 확인하십시오.
