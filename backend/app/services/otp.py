import os
import random
import string
from fastapi import HTTPException
from redis.asyncio import Redis

from app.services.email import send_otp_email

from dotenv import load_dotenv

load_dotenv()

redis = Redis.from_url(os.getenv("REDIS_URL"), decode_responses=True)

def generate_otp() -> str:
    return "".join(random.choices(string.digits, k=6))

async def send_otp(email: str, purpose: str):
    # Rate limiting
    key = f"rate:{purpose}:{email.lower()}"
    attempts = await redis.incr(key)
    if attempts == 1:
        await redis.expire(key, 3600 if purpose == "register" else 86400)
    if attempts > (3 if purpose == "register" else 5):
        raise HTTPException(429, "Too many attempts")

    otp = generate_otp()
    await redis.setex(f"otp:{purpose}:{email.lower()}", 
                      180 if purpose == "register" else 60, otp)

    await send_otp_email(email, otp, purpose)

async def verify_otp(email: str, purpose: str, code: str) -> bool:
    stored = await redis.get(f"otp:{purpose}:{email.lower()}")
    if stored and stored == code.strip():
        await redis.delete(f"otp:{purpose}:{email.lower()}")
        return True
    return False