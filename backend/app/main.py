from fastapi import FastAPI
from fastapi.exceptions import RequestValidationError
from sqlalchemy.exc import SQLAlchemyError
from contextlib import asynccontextmanager

from app.core.config import settings
from app.core.database import engine
from app.core.exceptions import global_exception_handler, db_exception_handler, validation_exception_handler
from app.api import health

# 수명 주기 관리 (Startup/Shutdown)
@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: 필요한 초기화 로직
    print(f"✅ {settings.PROJECT_NAME} Backend Started (Env: {settings.DB_HOST})")
    yield
    # Shutdown: DB 연결 종료
    print("🛑 Shutting down server, closing DB connections...")
    await engine.dispose()

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    lifespan=lifespan
)

# 예외 처리기 등록
app.add_exception_handler(Exception, global_exception_handler)
app.add_exception_handler(SQLAlchemyError, db_exception_handler)
app.add_exception_handler(RequestValidationError, validation_exception_handler)

# 라우터 등록
app.include_router(health.router, tags=["Health"])

@app.get("/")
def read_root():
    return {
        "project": settings.PROJECT_NAME, 
        "version": settings.VERSION,
        "docs_url": "/docs"
    }
