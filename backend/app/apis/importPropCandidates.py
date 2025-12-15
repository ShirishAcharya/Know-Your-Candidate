from fastapi import APIRouter, HTTPException
from app.scripts.importProportionateCandidates import extract_from_pdf
from app.services.candidate_service import save_candidates_to_db

router = APIRouter(prefix="/import-candidates", tags=["Candidates"])

Proportionate_FILE_NAME = "app/data/FinalClosedListAllparty_HOR.pdf"

@router.get("/import-proportionate-candidates")
async def import_prop_candidates():
    """
    Import Proportionate candidates from the server-side PDF and save to DB.
    """
    try:
        with open(Proportionate_FILE_NAME, "rb") as file:
            pdf_bytes = file.read()

        extracted_list = extract_from_pdf(pdf_bytes)
        save_candidates_to_db(extracted_list)       #Save to DB

        if not extracted_list:
            raise HTTPException(status_code = 400, detail = "No data found in the PDF")
    
        return{
            "status" : "success",
            "rows_found" : len(extracted_list),
            "data_preview" : extracted_list[:10]
        }
    except FileNotFoundError:
        raise HTTPException(status_code = 404, detail = f"File not found: {Proportionate_FILE_NAME}")

    except Exception as e:
        raise HTTPException(status_code = 500, detail = f"Error processing PDF: {str(e)}")