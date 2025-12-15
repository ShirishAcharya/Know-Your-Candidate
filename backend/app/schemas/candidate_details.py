# app/schemas/candidate_details.py
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

# -------------------------
# Section: Create Schemas
# -------------------------
class PoliticalExperienceCreate(BaseModel):
    title: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    year: Optional[int] = None

class CampaignFocusCreate(BaseModel):
    title: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    priority: Optional[int] = None

class PositiveContributionCreate(BaseModel):
    title: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    date: Optional[datetime] = None
    impact: Optional[str] = None

class ControversyCreate(BaseModel):
    title: str
    description: Optional[str] = None
    image_url: Optional[str] = None
    date: Optional[datetime] = None
    severity: Optional[str] = None

class AchievementCreate(BaseModel):
    description: Optional[str] = None

# -------------------------
# Section: Overall Candidate Details Schema
# -------------------------
class CreateCandidateDetailsSchema(BaseModel):
    candidate_id: int
    overall_rating: Optional[float] = 0.0
    total_ratings: Optional[int] = 0
    past_elections: Optional[dict] = {}
    social_links: Optional[dict] = {}
    political_experiences: List[PoliticalExperienceCreate] = []
    campaign_focuses: List[CampaignFocusCreate] = []
    contributions: List[PositiveContributionCreate] = []
    controversies: List[ControversyCreate] = []
    achievements: List[AchievementCreate] = []

    class Config:
        from_attributes = True

# -------------------------
# Section: Update Schemas
# -------------------------
class UpdatePoliticalExperience(BaseModel):
    candidate_id: int
    political_experiences: List[PoliticalExperienceCreate]

class UpdateCampaignFocus(BaseModel):
    candidate_id: int
    campaign_focuses: List[CampaignFocusCreate]

class UpdateContributions(BaseModel):
    candidate_id: int
    contributions: List[PositiveContributionCreate]

class UpdateControversies(BaseModel):
    candidate_id: int
    controversies: List[ControversyCreate]

class UpdateAchievements(BaseModel):
    candidate_id: int
    achievements: List[AchievementCreate]

class UpdateSocialLinks(BaseModel):
    candidate_id: int
    social_links: dict

class UpdatePastElections(BaseModel):
    candidate_id: int
    past_elections: dict

class RateCandidatePayload(BaseModel):
    candidate_id: int
    rating: int
