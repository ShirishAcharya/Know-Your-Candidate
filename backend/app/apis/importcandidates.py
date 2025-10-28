# app/apis/importcandidates.py
from fastapi import APIRouter, HTTPException
from app.scripts.importhor2079 import process_hor_data_with_pandas

router = APIRouter(prefix="/import-candidates", tags=["Candidates"])

# Path to the Excel file on your server
HOR_FILE_NAME = "app/data/ALL_CANDIDATE_HOR_2079_06_26_19_00.xlsx"

@router.get("/import-hor2079")
async def import_hor_candidates():
    """
    Import HOR candidates from the server-side Excel file.
    """
    try:
        candidates = process_hor_data_with_pandas(HOR_FILE_NAME)
        return {
            "message": "File processed successfully",
            "total_candidates": len(candidates),
            "preview": candidates[:5]  # preview first 5 candidates
        }
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail=f"File not found: {HOR_FILE_NAME}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
