from fastapi import APIRouter

# Import all router
from app.apis.province import router as province_router
from app.apis.district import router as district_router
from app.apis.candidate import router as candidate_router
from app.apis.candidate_details import router as candidate_details_router
from app.apis.data_population import router as data_population_router
from app.apis.user import router as user_router  # ✅ Added this
from app.apis.news import router as news_router  # Example of another router
from app.apis.importcandidates import router as import_candidates  # ✅ Added this
# Create main API router
api_router = APIRouter()

# Include sub-routers
api_router.include_router(province_router)
api_router.include_router(district_router)
api_router.include_router(candidate_router)
api_router.include_router(candidate_details_router)
api_router.include_router(user_router)  # ✅ Added this
api_router.include_router(news_router)  # Example of another router
api_router.include_router(data_population_router)  # ✅ Added this
api_router.include_router(import_candidates)  # ✅ Added this
