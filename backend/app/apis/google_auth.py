import os
from fastapi import APIRouter, Request, HTTPException , Depends
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session
import httpx
from google.oauth2 import id_token
from google.auth.transport import requests as google_requests
from app.apis.user import get_db
from app.models.user import User
from dotenv import load_dotenv
from app.utils.login_user import login_oauth_user
from app.utils.security import hash_password
import uuid

load_dotenv()

CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
CLIENT_SECRET = os.getenv("GOOGLE_CLIENT_SECRET")
REDIRECT_URI = os.getenv("GOOGLE_REDIRECT_URI")
TOKEN_URL = "https://oauth2.googleapis.com/token"
FRONTEND_URL  = os.getenv("FRONTEND_URL")

AUTH_URL = (
    "https://accounts.google.com/o/oauth2/v2/auth"
    "?response_type=code"
    f"&client_id={CLIENT_ID}"
    f"&redirect_uri={REDIRECT_URI}"
    "&scope=openid%20email%20profile"
    "&access_type=offline"
)

router = APIRouter(prefix="/users", tags=["Users"])

# -------------------------------
# Redirect user to Google login
# -------------------------------
@router.get("/auth/google/login")
def google_login():
    return RedirectResponse(AUTH_URL)

# -------------------------------
# Callback from Google OAuth
# -------------------------------
@router.get("/auth/google/callback")
async def google_callback(
    request: Request,
    code: str | None = None,
    db: Session = Depends(get_db)
):
    if not code:
        raise HTTPException(status_code=400, detail="No code provided")

    async with httpx.AsyncClient() as client:
        token_res = await client.post(
            TOKEN_URL,
            data={
                "code": code,
                "client_id": CLIENT_ID,
                "client_secret": CLIENT_SECRET,
                "redirect_uri": REDIRECT_URI,
                "grant_type": "authorization_code",
            },
        )
        token_res.raise_for_status()
        token_data = token_res.json()

    if "id_token" not in token_data:
        raise HTTPException(status_code=400, detail="Failed to get tokens from Google")

    idinfo = id_token.verify_oauth2_token(token_data["id_token"], google_requests.Request(), CLIENT_ID)

    email = idinfo["email"]
    name = idinfo.get("name", "Google User")
    picture = idinfo.get("picture")

    user = db.query(User).filter(User.email == email).first()
    if not user:
        user = User(name=name, email=email, picture=picture, password=hash_password(str(uuid.uuid4())))
        db.add(user)
        db.commit()
        db.refresh(user)

    redirect = RedirectResponse(url=FRONTEND_URL)

    login_oauth_user(user, redirect, db)

    return redirect