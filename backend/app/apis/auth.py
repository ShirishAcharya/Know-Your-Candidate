from fastapi import APIRouter, HTTPException , Depends
from sqlalchemy.orm import Session
from app.schemas.user import UserCreate
from app.schemas.auth import VerifyOTPRequest , ResetPasswordRequest , ForgotPasswordRequest
from app.models.user import User
from app.services.otp import send_otp , verify_otp , generate_otp
from app.services.pending import save_pending_registration , get_pending_registration
from app.utils.security import hash_password
from pydantic import EmailStr
from app.database.session import get_db


router = APIRouter(prefix = "/auth" , tags = ["auth"])

@router.post("/register", response_model=dict)
async def register_start(
    user_in: UserCreate,
    db: Session = Depends(get_db)
):
    existing_user = db.query(User).filter(
        User.email.ilike(user_in.email.lower())
    ).first()

    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    await send_otp(user_in.email, "register")
    await save_pending_registration(user_in.email, user_in.dict())
    return {"message": "OTP sent to email"}


@router.post("/verify-otp", response_model=dict)
async def verify_otp_endpoint(
    payload: VerifyOTPRequest,
    db: Session = Depends(get_db)
):
    email = payload.email.lower()
    purpose = payload.purpose
    otp = payload.otp

    if not await verify_otp(email, purpose, otp):
        raise HTTPException(status_code=400, detail="Invalid or Expired OTP")

    if purpose == "register":
        pending = await get_pending_registration(email)
        if not pending:
            raise HTTPException(status_code=400, detail="Registration expired")

        # Create new user
        new_user = User(
            email=pending["email"].lower(),
            password=hash_password(pending["password"]),
            name=pending.get("name"),
            is_verified=True
        )
        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        return {"message": "Account created successfully"}

    return {"message": "OTP verified"}


@router.post("/forgot-password")
async def forgot_password(request: ForgotPasswordRequest, db: Session = Depends(get_db)):
    email = request.email.lower()
    user = db.query(User).filter(User.email.ilike(email)).first()
    
    if user:
        await send_otp(email, "reset_password")
        print(f"[DEV] OTP sent to {email}")
    
    return {"message": "If this email is registered, an OTP has been sent"}


@router.post("/reset-password")
async def reset_password(
    payload: ResetPasswordRequest,
    db: Session = Depends(get_db)
):
    email = payload.email.lower()
    new_password = payload.new_password

    user = db.query(User).filter(User.email.ilike(email)).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.password = hash_password(new_password)
    db.commit()

    return {"message": "Password updated successfully!"}