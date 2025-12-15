from fastapi import APIRouter, Depends , HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.database.session import get_db
from app.apis.user import get_current_user
from app.models.candidate_details import (
    CandidateDetails,
    PoliticalExperience,
    CampaignFocus,
    PositiveContribution,
    Controversy,
    Achievement
)
from app.schemas.candidate_details import (
    CreateCandidateDetailsSchema,
    UpdatePoliticalExperience,
    UpdateCampaignFocus,
    UpdateContributions,
    UpdateControversies,
    UpdateAchievements,
    UpdatePastElections,
    UpdateSocialLinks,
    RateCandidatePayload
)

router = APIRouter(prefix="/candidate-details", tags=["Candidate Details"])

# -----------------------------
# Helper: Get or Create CandidateDetails
# -----------------------------
def get_or_create_candidate(candidate_id: int, db: Session) -> CandidateDetails:
    candidate = db.query(CandidateDetails).filter(CandidateDetails.candidate_id == candidate_id).first()
    if not candidate:
        candidate = CandidateDetails(
            candidate_id=candidate_id,
            overall_rating=0.0,
            total_ratings=0,
            past_elections={},
            social_links={}
        )
        db.add(candidate)
        db.commit()
        db.refresh(candidate)
    return candidate

# -----------------------------
# Update Sections
# -----------------------------
@router.post("/political-experience")
def update_political_experience(payload: UpdatePoliticalExperience, db: Session = Depends(get_db)):
    candidate = get_or_create_candidate(payload.candidate_id, db)
    candidate.political_experiences = [PoliticalExperience(**exp.dict()) for exp in payload.political_experiences]
    db.commit()
    db.refresh(candidate)
    return candidate

@router.post("/campaign-focus")
def update_campaign_focus(payload: UpdateCampaignFocus, db: Session = Depends(get_db)):
    candidate = get_or_create_candidate(payload.candidate_id, db)
    candidate.campaign_focuses = [CampaignFocus(**focus.dict()) for focus in payload.campaign_focuses]
    db.commit()
    db.refresh(candidate)
    return candidate

@router.post("/contributions")
def update_contributions(payload: UpdateContributions, db: Session = Depends(get_db)):
    candidate = get_or_create_candidate(payload.candidate_id, db)
    candidate.contributions = [PositiveContribution(**c.dict()) for c in payload.contributions]
    db.commit()
    db.refresh(candidate)
    return candidate

@router.post("/controversies")
def update_controversies(payload: UpdateControversies, db: Session = Depends(get_db)):
    candidate = get_or_create_candidate(payload.candidate_id, db)
    candidate.controversies = [Controversy(**c.dict()) for c in payload.controversies]
    db.commit()
    db.refresh(candidate)
    return candidate

@router.post("/achievements")
def update_achievements(payload: UpdateAchievements, db: Session = Depends(get_db)):
    candidate = get_or_create_candidate(payload.candidate_id, db)
    candidate.achievements = [Achievement(**a.dict()) for a in payload.achievements]
    db.commit()
    db.refresh(candidate)
    return candidate

# -----------------------------
# Get Candidate Details
# -----------------------------
@router.get("/{candidate_id}", response_model=CreateCandidateDetailsSchema)
def get_candidate_details(candidate_id: int, db: Session = Depends(get_db)):
    candidate = db.query(CandidateDetails).filter(CandidateDetails.candidate_id == candidate_id).first()
    if not candidate:
        # Return empty default structure
        return CreateCandidateDetailsSchema(
            candidate_id=candidate_id,
            political_experiences=[],
            campaign_focuses=[],
            contributions=[],
            controversies=[],
            achievements=[]
        )
    return candidate

@router.put("/social-links")
async def update_social_links(payload: UpdateSocialLinks, db: Session = Depends(get_db)):
    details = get_or_create_candidate(payload.candidate_id, db)
    details.social_links = payload.social_links
    db.commit()
    db.refresh(details)
    return details


@router.put("/past-elections")
def update_past_elections(payload: UpdatePastElections, db: Session = Depends(get_db)):
    details = get_or_create_candidate(payload.candidate_id, db)
    details.past_elections = payload.past_elections
    db.commit()
    db.refresh(details)
    return details

@router.post("/rate")
async def rate_candidate(payload: RateCandidatePayload, db: Session = Depends(get_db)):
    candidate_id = payload.candidate_id
    rating = payload.rating

    if not 1 <= rating <= 5:
        raise HTTPException(status_code=400, detail="Rating must be between 1 and 5")

    details = get_or_create_candidate(candidate_id, db)

    current_total = details.total_ratings or 0
    current_sum = (details.overall_rating or 0) * current_total

    new_total = current_total + 1
    new_average = (current_sum + rating) / new_total

    details.overall_rating = round(new_average, 2)
    details.total_ratings = new_total

    db.commit()
    db.refresh(details)

    return {
        "overall_rating": details.overall_rating,
        "total_ratings": details.total_ratings
    }