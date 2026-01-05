from fastapi import Request, status
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from sqlalchemy.exc import SQLAlchemyError
import logging

logger = logging.getLogger("uvicorn.error")

async def global_exception_handler(request: Request, exc: Exception):
    """
    모든 처리되지 않은 예외를 잡아서 500 에러 및 로그로 남김
    """
    logger.error(f"🔴 서버 내부 오류 발생 (URL: {request.url}): {str(exc)}")
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={"detail": "서버 내부 오류가 발생했습니다. 잠시 후 다시 시도해주세요.", "error": str(exc)},
    )

async def db_exception_handler(request: Request, exc: SQLAlchemyError):
    """
    데이터베이스 관련 예외 처리
    """
    logger.error(f"🔴 데이터베이스 오류 (URL: {request.url}): {str(exc)}")
    return JSONResponse(
        status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
        content={"detail": "데이터베이스 연결에 문제가 발생했습니다.", "error": str(exc)},
    )

async def validation_exception_handler(request: Request, exc: RequestValidationError):
    """
    Pydantic 데이터 검증 실패 처리
    """
    logger.warning(f"⚠️ 데이터 검증 실패: {exc.errors()}")
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={"detail": "입력 데이터 형식이 올바르지 않습니다.", "errors": exc.errors()},
    )
