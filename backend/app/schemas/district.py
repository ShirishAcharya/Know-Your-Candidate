from pydantic import BaseModel
from typing import Optional

class DistrictSchema(BaseModel):
    id: int
    name: str
    area_sq_km: Optional[str] = None
    website: Optional[str] = None
    headquarter: Optional[str] = None

    class Config:
        from_attributes = True  # Updated from orm_mode = True