# app/database/base.py
import os
import logging
import time
import redis
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv

load_dotenv()
# -------------------------------------------------
# Logger Setup
# -------------------------------------------------
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s - %(message)s",
)
logger = logging.getLogger("database")

# -------------------------------------------------
# PostgreSQL Configuration
# -------------------------------------------------
POSTGRES_USER = os.getenv("POSTGRES_USER")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD")
POSTGRES_DB = os.getenv("POSTGRES_DB")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = int(os.getenv("DB_PORT"))

SQLALCHEMY_DATABASE_URL = (
    f"postgresql+psycopg2://{POSTGRES_USER}:{POSTGRES_PASSWORD}@{DB_HOST}:{DB_PORT}/{POSTGRES_DB}"
)

engine = create_engine(SQLALCHEMY_DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

logger.info(f"PostgreSQL engine created: {SQLALCHEMY_DATABASE_URL}")

# -------------------------------------------------
# Redis Configuration with Retry
# -------------------------------------------------
REDIS_HOST = os.getenv("REDIS_HOST")
REDIS_PORT = int(os.getenv("REDIS_PORT"))
REDIS_DB = int(os.getenv("REDIS_DB", 0))

redis_client = None
MAX_RETRIES = 1
RETRY_DELAY = 2  # seconds

for attempt in range(1, MAX_RETRIES + 1):
    try:
        redis_client = redis.Redis(
            host=REDIS_HOST,
            port=REDIS_PORT,
            db=REDIS_DB,
            decode_responses=True,
            socket_connect_timeout=5,
        )
        redis_client.ping()
        logger.info(f"Connected to Redis at {REDIS_HOST}:{REDIS_PORT} (DB {REDIS_DB})")
        break
    except redis.ConnectionError:
        logger.warning(f"Redis not ready (attempt {attempt}/{MAX_RETRIES}), retrying in {RETRY_DELAY}s...")
        time.sleep(RETRY_DELAY)
else:
    logger.error(f"Could not connect to Redis at {REDIS_HOST}:{REDIS_PORT} after {MAX_RETRIES} attempts")
    redis_client = None  # safely handle unavailable Redis
