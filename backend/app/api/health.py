from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.core.database import get_db
from app.core.config import settings
from app.schemas.base import HealthCheck

router = APIRouter()

@router.get("/health", response_model=HealthCheck)
async def health_check(db: AsyncSession = Depends(get_db)):
    """
    서버 및 데이터베이스 상태를 확인합니다.
    """
    db_status = "unknown"
    try:
        # 간단한 쿼리로 DB 연결 테스트
        await db.execute(text("SELECT 1"))
        db_status = "connected"
    except Exception as e:
        db_status = f"disconnected ({str(e)})"
    
    return HealthCheck(
        status="ok",
        version=settings.VERSION,
        db_status=db_status
    )
