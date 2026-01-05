from datetime import datetime
from sqlalchemy import Column, DateTime
from sqlalchemy.orm import Mapped, mapped_column
from sqlalchemy.sql import func
from app.core.database import Base

class TimestampMixin:
    """
    생성일시(created_at)와 수정일시(updated_at)를 자동으로 관리하는 Mixin
    """
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), nullable=False)
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now(), nullable=False)
