from pydantic import BaseModel
from typing import Optional
from app.schemas.province import ProvinceSchema
from app.schemas.district import DistrictSchema

class CandidateSchema(BaseModel):
    id: int
    election_type: str
    name: str
    age: Optional[int] = None
    gender: Optional[str] = None
    nationality: Optional[str] = "Nepali"
    party: Optional[str] = None
    constituency: Optional[str] = None
    source_file: Optional[str] = None
    image_url: Optional[str] = None

    # Foreign keys
    province_id: Optional[int] = None
    district_id: Optional[int] = None

    # 👇 Relationship fields (optional)
    province: Optional[ProvinceSchema] = None
    district: Optional[DistrictSchema] = None

    class Config:
        orm_mode = True
