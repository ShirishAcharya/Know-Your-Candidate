from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent 
PROJECT_ROOT = BASE_DIR.parent                             

UPLOADS_DIR = PROJECT_ROOT / "candidate_image_upload"
UPLOADS_DIR.mkdir(parents=True, exist_ok=True)

UPLOADS_DIR_STR = str(UPLOADS_DIR)