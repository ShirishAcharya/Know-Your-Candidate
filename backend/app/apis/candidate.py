from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from sqlalchemy.orm import Session
from typing import List
from sqlalchemy import text

from app.database.session import get_db
from app.models.candidate import Candidate
from app.schemas.candidate import CandidateSchema
from app.apis.user import get_current_user
from app.logger import logger
from app.config import UPLOADS_DIR
import uuid
import shutil
from pathlib import Path
import os
from dotenv import load_dotenv

load_dotenv()

BACKEND_URL = os.getenv("BACKEND_URL" , "http://127.0.0.1:8000")

router = APIRouter(prefix="/candidates", tags=["Candidates"])

@router.get("/", response_model=List[CandidateSchema])
def get_all_candidates(db: Session = Depends(get_db)):
    candidates = db.query(Candidate).all()
    if not candidates:
        logger.warning("No candidates found in the database")
        raise HTTPException(status_code=404, detail="No candidates found")
    logger.info(f"Fetched {len(candidates)} candidates")
    return candidates

@router.post("/upload-candidate-image")
async def upload_image(
    file: UploadFile = File(...),
    candidate_id: int = Form(...),
    db: Session = Depends(get_db),
    current_user = Depends(get_current_user)
):
    if not current_user:
        raise HTTPException(status_code = 400 , detail = "Please login to upload image")
    
    if not file.content_type or not file.content_type.startswith("image/"):
        raise HTTPException(status_code = 400 , detail = "Only image files are permitted")
    
    contents = await file.read()
    if len(contents) > 5 * 1024 * 1024:
        raise HTTPException(status_code = 400 , detail = "Image too large (max size : 5 MB)")
    await file.seek(0)

    # --- Check candidate exists ---
    db_candidate = db.query(Candidate).filter(Candidate.id == candidate_id).first()
    if not db_candidate:
        raise HTTPException(status_code=404, detail="Candidate not found")

    suffix = Path(file.filename).suffix.lower()
    if suffix not in [".jpg", ".jpeg", ".png", ".gif", ".webp", ".svg"]:
        raise HTTPException(status_code = 400 , detail = "Unsupported image type")

    unique_name = f"{uuid.uuid4()}{suffix}"
    file_path = UPLOADS_DIR / unique_name

    # if db_candidate.image:
    #     old_file = UPLOADS_DIR / db_candidate.image
    #     if old_file.exists():
    #         old_file.unlink()

    with open(file_path , "wb") as f:
        shutil.copyfileobj(file.file , f)
    
    image_url = f"{BACKEND_URL}/candidates/uploads/{unique_name}"

    db_candidate.image = image_url
    db.commit()

    return {"image_url" : image_url}

@router.delete("delete-candidate-image")
async def delete_candidate_image(
    candidate_id: int = Form(...),
    db: Session = Depends(get_db),
    current_user = Depends (get_current_user)
):
    candidate = db.query(Candidate).filter(Candidate.id == candidate_id).first()
    if not candidate:
        raise HTTPException(status_code = 404 , detail = "Candidate Not Found")

    if not candidate.image:
        return{"message" : "No image found"}

    file_path = UPLOADS_DIR / candidate.image

    if file_path.exists():
        try:
            file_path.unlink()
        except Exception as e:
            print(f"Error deleting file: {e}")
    
    candidate.image = None
    db.commit()

    return {"message" : "Image removed successfully"}


@router.get("/types")
async def get_election_types(db = Depends(get_db)):
    query = text("""
                SELECT DISTINCT election_id, election_type
                FROM candidate ORDER BY election_id
                """)
    rows = db.execute(query).fetchall()
    return [{"election_id": row[0], "election_type": row[1]} for row in rows]

@router.get("/getalldata")
async def get_all_data_for_display(election_id: int, db = Depends(get_db)):
    query = text("""
        SELECT
            id,
            election_id,
            election_type,
            province_id,
            district_id,
            constituency,
            party,
            name,
            age,
            gender,
            birthplace,
            nationality,
            sources,
            election_year,
            source_file,
            election_level,
            image
        FROM candidate
        WHERE election_id = :election_id
        ORDER BY province_id, district_id
    """)

    rows = db.execute(query, {"election_id": election_id}).fetchall()

    return [
        {
            "id":            row[0],
            "election_id":   row[1],
            "election_type": row[2],
            "province_id":   row[3],
            "district_id":   row[4],
            "constituency":  row[5],
            "party":         row[6],
            "name":          row[7],
            "age":           row[8],
            "gender":        row[9],
            "birthplace":    row[10],
            "nationality":   row[11],
            "sources":       row[12],
            "election_year": row[13],
            "source_file":   row[14],
            "election_level":row[15],
            "image":         row[16],
        }
        for row in rows
    ]

# ----------------------------------#
# Get Candidate Personal Details
# ----------------------------------#
@router.get("/{candidate_id}/personal")
def get_candidate_personal(
    candidate_id: int,
    db: Session = Depends(get_db),
):
    candidate = db.query(Candidate).filter(Candidate.id == candidate_id).first()
    if not candidate:
        raise HTTPException(status_code = 404 , detail = "Candidate Not Found")
    
    return candidate