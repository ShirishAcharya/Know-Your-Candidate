import json
from app.services.otp import redis

async def save_pending_registration(email: str, data: dict):
    await redis.setex(f"pending_reg:{email.lower()}", 300, json.dumps(data))

async def get_pending_registration(email: str) -> dict | None:
    data = await redis.get(f"pending_reg:{email.lower()}")
    if data:
        await redis.delete(f"pending_reg:{email.lower()}")
        return json.loads(data)
    return None