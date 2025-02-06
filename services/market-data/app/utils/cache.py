import redis
import json
from ..config import settings

redis_client = redis.Redis(
    host=settings.REDIS_HOST,
    port=settings.REDIS_PORT,
    decode_responses=True
)

def get_cached_data(key: str):
    return json.loads(redis_client.get(key)) if redis_client.get(key) else None

def set_cached_data(key: str, data: dict, expiry: int = 60):
    redis_client.setex(key, expiry, json.dumps(data)) 