from fastapi import APIRouter, HTTPException
from app.scripts.importPA2079 import process_PA_data_with_pandas
from app.services.candidate_service import save_candidates_to_db

router = APIRouter(prefix="/import-candidates", tags=["Candidates"])

PA_FILE_NAME = "app/data/ALL_CANDIDATE_PA_2079_06_26_19_00.xlsx"

@router.get("/import-PA-2079")
async def import_PA_candidates():
    """
    Import PA candidates from the server-side Excel file and save to DB.
    """
    try:
        candidates = process_PA_data_with_pandas(PA_FILE_NAME)
        save_candidates_to_db(candidates)  # ✅ actually save to DB
        return {
            "message": "File processed and candidates saved successfully",
            "total_candidates": len(candidates),
            "preview": candidates[:5]
        }
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail=f"File not found: {PA_FILE_NAME}")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
