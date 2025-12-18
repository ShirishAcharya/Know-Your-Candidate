from fastapi import APIRouter

# Import all router
from app.apis.province import router as province_router
from app.apis.district import router as district_router
from app.apis.candidate import router as candidate_router
from app.apis.candidate_details import router as candidate_details_router
from app.apis.data_population import router as data_population_router
from app.apis.user import router as user_router  
from app.apis.news import router as news_router  
from app.apis.importcandidates import router as import_candidates  
from app.apis.importPropCandidates import router as import_proportionate_candidates
from app.apis.importPAcandidates import router as import_PA_candidates
from app.apis.candidate import router as get_election_types
from app.apis.candidate import router as get_all_data_for_display
from app.apis.google_auth import router as google_auth
from app.apis.auth import router as auth

# Create main API router
api_router = APIRouter()

# Include sub-routers
api_router.include_router(province_router)
api_router.include_router(district_router)
api_router.include_router(candidate_router)
api_router.include_router(candidate_details_router)
api_router.include_router(user_router)
api_router.include_router(news_router)  
api_router.include_router(data_population_router) 
api_router.include_router(import_candidates)  
api_router.include_router(import_proportionate_candidates)
api_router.include_router(import_PA_candidates)
api_router.include_router(get_election_types)
api_router.include_router(get_all_data_for_display)
api_router.include_router(google_auth)
api_router.include_router(auth)