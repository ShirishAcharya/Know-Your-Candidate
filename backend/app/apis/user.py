# app/apis/user.py
from datetime import timedelta
from typing import List, Optional

from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    Response,
    Cookie,
    status,
)
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from redis import Redis

from app.database.base import SessionLocal, redis_client
from app.models.user import User
from app.schemas.user import UserCreate, UserOut
from app.utils.security import hash_password, verify_password
from app.core.logger import logger
from app.utils.token_helpers import (
    create_token,
    store_token,
    logout_tokens,
    decode_token,
    logout_all_user_tokens,
)
from app.utils.login_user import get_current_user_from_cookie

# JWT / token configuration
ACCESS_TOKEN_EXPIRE_MINUTES = 30
REFRESH_TOKEN_EXPIRE_DAYS = 7

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")
router = APIRouter(prefix="/users", tags=["Users"])

# ------------------------------
# Dependencies
# ------------------------------
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def get_redis() -> Optional[Redis]:
    return redis_client

# ------------------------------
# Routes
# ------------------------------
@router.post("/register", response_model=UserOut, status_code=status.HTTP_201_CREATED)
def register_user(user_data: UserCreate, db: Session = Depends(get_db)):
    """Register a new user"""
    try:
        logger.info(f"Register request for email: {user_data.email}")

        existing_user = db.query(User).filter(User.email == user_data.email).first()
        if existing_user:
            logger.warning(f"Attempted registration with existing email: {user_data.email}")
            raise HTTPException(status_code=400, detail="Email already registered")

        hashed_password = hash_password(user_data.password)
        new_user = User(
            name=user_data.name,
            email=user_data.email,
            password=hashed_password,
        )

        db.add(new_user)
        db.commit()
        db.refresh(new_user)

        logger.info(f"User registered successfully: {new_user.email}")
        return new_user

    except HTTPException:
        raise
    except Exception as e:
        db.rollback()
        logger.error(f"Registration failed: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error during registration")


@router.post("/token")
def login_for_access_token(
    response: Response,   
    db: Session = Depends(get_db),
    redis: Optional[Redis] = Depends(get_redis),
    form_data: OAuth2PasswordRequestForm = Depends(),
):
    """
    Authenticate user and issue JWT tokens.
    Reuse existing tokens if valid, otherwise generate new ones.
    """
    try:
        logger.info(f"Login attempt for user: {form_data.username}")

        # Fetch user
        user = db.query(User).filter(User.email == form_data.username).first()
        if not user or not verify_password(form_data.password, user.password):
            logger.warning(f"Invalid login credentials for {form_data.username}")
            raise HTTPException(status_code=401, detail="Invalid email or password")

        user_id = str(user.id)
        access_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
        refresh_expires = timedelta(days=REFRESH_TOKEN_EXPIRE_DAYS)

        access_token = None
        refresh_token = None

        # Reuse existing valid tokens if present
        existing_tokens = redis.smembers(f"user_tokens:{user_id}") if redis else None
        if existing_tokens:
            for token_str in existing_tokens:  # Redis returns str, no decode needed
                payload = decode_token(token_str)
                if not payload:
                    continue
                token_type = payload.get("type")
                if token_type == "access":
                    access_token = token_str
                elif token_type == "refresh":
                    refresh_token = token_str
            if access_token and refresh_token:
                logger.info(f"Reusing existing tokens for user {form_data.username}")

        # Generate new tokens if missing
        if not access_token or not refresh_token:
            access_token = create_token({"sub": user_id, "type": "access"}, access_expires)
            refresh_token = create_token({"sub": user_id, "type": "refresh"}, refresh_expires)

            if redis:
                store_token(redis, access_token, user_id, int(access_expires.total_seconds()))
                store_token(redis, refresh_token, user_id, int(refresh_expires.total_seconds()))

        # Set tokens as HttpOnly cookies
        response.set_cookie(
            key="access_token",
            value=access_token,
            httponly=True,
            samesite="lax",
            max_age=int(access_expires.total_seconds()),
        )
        response.set_cookie(
            key="refresh_token",
            value=refresh_token,
            httponly=True,
            samesite="lax",
            max_age=int(refresh_expires.total_seconds()),
        )

        logger.info(f"User {form_data.username} logged in successfully")
        return {
            "access_token": access_token,
            "refresh_token": refresh_token,
            "token_type": "bearer",
            "message": "Login successful",
        }

    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Login failed: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error during login")

@router.post("/logout")
def logout(
    response: Response,
    access_token: str = Cookie(None),
    refresh_token: str = Cookie(None),
    redis: Optional[Redis] = Depends(get_redis),
    db: Session = Depends(get_db),
):
    """
    Logout user by deleting tokens from Redis and clearing cookies.
    """
    try:
        logger.info("Logout request received")

        # Remove specific tokens
        logout_tokens(redis, access_token, refresh_token)

        # Optionally, clear all tokens for this user
        if access_token:
            payload = decode_token(access_token)
            if payload and "sub" in payload:
                logout_all_user_tokens(redis, payload["sub"])

        response.delete_cookie("access_token")
        response.delete_cookie("refresh_token")

        logger.info("User logged out successfully")
        return {"message": "Logged out successfully"}

    except Exception as e:
        logger.error(f"Logout failed: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error during logout")


@router.get("/", response_model=List[UserOut])
def get_all_users(db: Session = Depends(get_db)):
    """Get list of all users"""
    try:
        logger.info("Fetching all users")
        users = db.query(User).all()
        return users
    except Exception as e:
        logger.error(f"Error fetching users: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error while fetching users")
    
@router.get("/me")
def get_current_user(current_user: User = Depends(get_current_user_from_cookie)):
    return {
        "id": current_user.id,
        "name": current_user.name,
        "email": current_user.email
    }


@router.get("/{id}", response_model=UserOut)
def get_user_by_id(id: int, db: Session = Depends(get_db)):
    """Get user by ID"""
    try:
        logger.info(f"Fetching user with ID: {id}")
        db_user = db.query(User).filter(User.id == id).first()
        if not db_user:
            logger.warning(f"User not found: {id}")
            raise HTTPException(status_code=404, detail="User not found")
        return db_user
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error fetching user {id}: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error while fetching user")
