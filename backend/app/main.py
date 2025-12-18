from fastapi import FastAPI, HTTPException
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware  # <--- import this
import subprocess
from app.apis.base import api_router
from app.middleware.logging_middleware import LoggingMiddleware
from app.config import UPLOADS_DIR_STR
from fastapi.staticfiles import StaticFiles

app = FastAPI(title="Know Your Candidate")

# --- CORS Setup ---
origins = [
    "http://localhost:3000",  # frontend URL
    "http://127.0.0.1:3000",
    "http://110.34.25.249", 
    "http://110.34.25.249:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,      # allow these origins
    allow_credentials=True,
    allow_methods=["*"],        # allow all HTTP methods
    allow_headers=["*"],        # allow all headers
)
# --- End CORS Setup ---

# Add logging middleware
app.add_middleware(LoggingMiddleware)

# Routers
app.include_router(api_router)

app.mount("/candidates/uploads", StaticFiles(directory=str(UPLOADS_DIR_STR)), name="uploads")

@app.get("/")
async def root():
    return {"message": "Hello, Know Your Candidate!"}

@app.get("/health")
async def health():
    return {"status": "ok"}

# Import scripts endpoints
@app.post("/import-parties")
async def import_parties():
    try:
        result = subprocess.run(
            ["python3", "-m", "app.scripts.import_party"],
            capture_output=True,
            text=True,
            cwd=str(Path(__file__).resolve().parent.parent)
        )
        if result.returncode != 0:
            raise HTTPException(status_code=500, detail=result.stderr)
        return {"message": "Party import script executed successfully", "output": result.stdout}
    except Exception as e:
        return JSONResponse(status_code=500, content={"message": str(e)})

# You need to rename the other endpoints too:
@app.post("/import-candidates")
async def import_candidates():
    ...

@app.post("/partiy")
async def party():
    ...

@app.post("/all-data")
async def import_all():
    ...