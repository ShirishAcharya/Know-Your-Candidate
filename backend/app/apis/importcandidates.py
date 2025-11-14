# app/apis/importcandidates.py
from fastapi import APIRouter, HTTPException
from app.scripts.importhor2079 import process_hor_data_with_pandas
from app.services.candidate_service import save_candidates_to_db  # ✅ import the DB function

router = APIRouter(prefix="/import-candidates", tags=["Candidates"])

HOR_FILE_NAME = "app/data/ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx"

@router.get("/import-hor2079")
async def import_hor_candidates():
    """
    Import HOR candidates from the server-side Excel file and save to DB.
    """
    try:
        candidates = process_hor_data_with_pandas(HOR_FILE_NAME)
        save_candidates_to_db(candidates)  # ✅ actually save to DB
        return {
            "message": "File processed and candidates saved successfully",
            "total_candidates": len(candidates),
            "preview": candidates[:5]
        }
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail=f"File not found: {HOR_FILE_NAME}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
