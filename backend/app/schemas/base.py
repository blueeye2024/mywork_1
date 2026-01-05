from pydantic import BaseModel, ConfigDict

class BaseSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)

class HealthCheck(BaseSchema):
    status: str
    version: str
    db_status: str
