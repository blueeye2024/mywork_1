from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import DeclarativeBase
from app.core.config import settings
import logging

# 로거 설정
logger = logging.getLogger("uvicorn")

# 비동기 데이터베이스 엔진 생성
# Pool Configuration:
# - pool_size=5: 기본 유지 연결 수
# - max_overflow=10: 트래픽 급증 시 추가 허용 연결 수
# - pool_recycle=3600: 1시간마다 연결 재설정 (MySQL 타임아웃 방지)
engine = create_async_engine(
    settings.DATABASE_URL,
    echo=False,
    pool_size=5,
    max_overflow=10,
    pool_recycle=3600,
    pool_pre_ping=True,
)

# 비동기 세션 팩토리
SessionLocal = async_sessionmaker(
    bind=engine,
    class_=AsyncSession,
    autocommit=False,
    autoflush=False,
)

class Base(DeclarativeBase):
    pass

# DB 세션 의존성 (Dependency)
async def get_db():
    async with SessionLocal() as session:
        try:
            yield session
        except Exception as e:
            logger.error(f"❌ DB 세션 오류: {str(e)}")
            await session.rollback()
            raise
        finally:
            await session.close()
