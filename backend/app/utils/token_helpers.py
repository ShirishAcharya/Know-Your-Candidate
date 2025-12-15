# app/utils/token_helpers.py
import os
from datetime import datetime, timedelta
from typing import Optional
from jose import jwt, JWTError
from redis import Redis
from app.core.logger import logger
from dotenv import load_dotenv


load_dotenv()
ALGORITHM = os.getenv("ALGORITHM")
SECRET_KEY = os.getenv("SECRET_KEY")


def create_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    """
    Generate a JWT token with expiration.
    """
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=15))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


def decode_token(token: str) -> Optional[dict]:
    """
    Decode a JWT token safely.
    Returns the payload if valid, else None.
    """
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except JWTError as e:
        logger.warning(f"Failed to decode token: {e}")
        return None


def store_token(redis: Optional[Redis], token: str, user_id: str, expire_seconds: int):
    """
    Store token in Redis safely with expire time.
    """
    if redis is None:
        logger.warning(f"Redis unavailable: cannot store token for user {user_id}")
        return
    try:
        pipe = redis.pipeline()
        pipe.setex(f"token:{token}", expire_seconds, user_id)
        pipe.sadd(f"user_tokens:{user_id}", token)
        pipe.execute()
    except Exception as e:
        logger.error(f"Failed to store token in Redis: {e}", exc_info=True)


def logout_tokens(redis: Optional[Redis], access_token: str = None, refresh_token: str = None):
    """
    Remove specific tokens from Redis safely.
    """
    if redis is None:
        logger.warning("Redis unavailable: cannot delete tokens")
        return
    try:
        pipe = redis.pipeline()
        if access_token:
            pipe.delete(f"token:{access_token}")
        if refresh_token:
            pipe.delete(f"token:{refresh_token}")
        pipe.execute()
    except Exception as e:
        logger.error(f"Failed to remove tokens from Redis: {e}", exc_info=True)


def logout_all_user_tokens(redis: Optional[Redis], user_id: str):
    """
    Remove all tokens of a user from Redis.
    """
    if redis is None:
        logger.warning(f"Redis unavailable: cannot delete tokens for user {user_id}")
        return
    try:
        tokens = redis.smembers(f"user_tokens:{user_id}")
        if tokens:
            pipe = redis.pipeline()
            for token in tokens:
                pipe.delete(f"token:{token.decode()}")
            pipe.delete(f"user_tokens:{user_id}")
            pipe.execute()
            logger.info(f"All tokens cleared for user {user_id}")
    except Exception as e:
        logger.error(f"Failed to remove all tokens for user {user_id}: {e}", exc_info=True)
