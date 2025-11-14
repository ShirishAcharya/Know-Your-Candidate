from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from sqlalchemy.orm import Session
from typing import List

import io
import uuid

from app.database.session import get_db
from app.models.candidate import Candidate
from app.schemas.candidate import CandidateSchema
import logging
from app.logger import logger
from app.core.minio_client import upload_to_minio
from app.core.config import settings

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
async def upload_candidate_image(
    image: UploadFile = File(...),
    candidate_id: int = Form(...),
    bucket_name: str = Form(settings.DEFAULT_MINIO_BUCKET if hasattr(settings, "DEFAULT_MINIO_BUCKET") else "candidate"),
    db: Session = Depends(get_db)
):
    """
    Upload candidate image to MinIO and update database with URL
    """

    # --- Sanitize bucket name ---
    bucket_name = bucket_name.lower().replace("/", "")
    if not bucket_name:
        bucket_name = "candidate"
    logger.info(f"Using bucket: {bucket_name}")

    try:
        # --- Validate file type ---
        if not image.content_type.startswith("image/"):
            raise HTTPException(status_code=400, detail="File must be an image")

        # --- Validate file size (max 5 MB) ---
        file_content = await image.read()
        MAX_FILE_SIZE = 5 * 1024 * 1024
        if len(file_content) > MAX_FILE_SIZE:
            raise HTTPException(status_code=400, detail="File too large")

        # --- Check candidate exists ---
        db_candidate = db.query(Candidate).filter(Candidate.id == candidate_id).first()
        if not db_candidate:
            raise HTTPException(status_code=404, detail="Candidate not found")

        logger.info(f"Uploading image for candidate {candidate_id}")

        # --- Create a dummy UploadFile for MinIO ---
        class DummyFile:
            def __init__(self, filename, content, content_type):
                self.filename = filename
                self.content = content
                self.content_type = content_type

            async def read(self):
                return self.content

        dummy_file = DummyFile(image.filename, file_content, image.content_type)

        # --- Upload to MinIO ---
        minio_url = await upload_to_minio(dummy_file, bucket_name)

        # --- Update candidate record ---
        db_candidate.image = minio_url
        db.commit()
        db.refresh(db_candidate)

        logger.info(f"Successfully uploaded image for candidate {candidate_id}: {minio_url}")

        return {
            "message": "Image uploaded successfully",
            "image_url": minio_url,
            "candidate_id": candidate_id
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error uploading candidate image: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Internal server error: {str(e)}")
