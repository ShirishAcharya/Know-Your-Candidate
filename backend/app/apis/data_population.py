from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import Dict, Any
from pydantic import BaseModel

from app.database.session import get_db
from app.services.data_population_service import DataPopulationService

# --- Fixed Path Handling ---
import os
from pathlib import Path
import json

# Get absolute path to the app directory
BASE_DIR = Path(__file__).resolve().parent.parent  # -> /app/app
DATA_PATH = BASE_DIR / "data" / "en.json"

# Load JSON safely
if not DATA_PATH.exists():
    raise FileNotFoundError(f"Data file not found at: {DATA_PATH}")

with open(DATA_PATH, "r", encoding="utf-8") as f:
    NEPAL_DATA = json.load(f)


router = APIRouter()

# Response models
class PopulationResponse(BaseModel):
    message: str
    stats: Dict[str, int]

class ClearResponse(BaseModel):
    message: str

@router.post("/populate-nepal-data", response_model=PopulationResponse)
async def populate_nepal_data(db: Session = Depends(get_db)):
    """
    Populate Nepal administrative data (provinces, districts, municipalities, wards)
    """
    try:
        service = DataPopulationService(db)
        stats = service.populate_nepal_data(NEPAL_DATA)
        
        return {
            "message": "Nepal data populated successfully",
            "stats": stats
        }
        
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error populating data: {str(e)}"
        )

@router.delete("/clear-nepal-data", response_model=ClearResponse)
async def clear_nepal_data(db: Session = Depends(get_db)):
    """
    Clear all Nepal administrative data
    """
    try:
        from app.models.ward import Ward
        from app.models.municipality import Municipality
        from app.models.district import District
        from app.models.province import Province
        from app.models.country import Country
        
        # Delete in correct order to handle foreign key constraints
        db.query(Ward).delete()
        db.query(Municipality).delete()
        db.query(District).delete()
        db.query(Province).delete()
        db.query(Country).filter(Country.name == "Nepal").delete()
        
        db.commit()
        
        return {"message": "Nepal data cleared successfully"}
        
    except Exception as e:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Error clearing data: {str(e)}"
        )

@router.get("/data-status", response_model=Dict[str, int])
async def get_data_status(db: Session = Depends(get_db)):
    """
    Get current data population status
    """
    from app.models.country import Country
    from app.models.province import Province
    from app.models.district import District
    from app.models.municipality import Municipality
    from app.models.ward import Ward
    
    counts = {
        "countries": db.query(Country).count(),
        "provinces": db.query(Province).count(),
        "districts": db.query(District).count(),
        "municipalities": db.query(Municipality).count(),
        "wards": db.query(Ward).count()
    }
    
    return counts