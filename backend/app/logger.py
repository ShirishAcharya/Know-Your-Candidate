import logging
from logging.handlers import RotatingFileHandler
from pathlib import Path

# Ensure logs directory exists
log_dir = Path("/app/logs")
log_dir.mkdir(parents=True, exist_ok=True)

# Create the main logger
logger = logging.getLogger("election_api")
logger.setLevel(logging.INFO)

# Formatter for all handlers
formatter = logging.Formatter(
    "%(asctime)s - %(levelname)s - %(name)s - %(message)s"
)

# --- General API log ---
file_handler_api = RotatingFileHandler(
    log_dir / "api.log", maxBytes=5*1024*1024, backupCount=5
)
file_handler_api.setFormatter(formatter)
logger.addHandler(file_handler_api)

# --- User-specific log ---
file_handler_users = RotatingFileHandler(
    log_dir / "users.log", maxBytes=5*1024*1024, backupCount=5
)
file_handler_users.setFormatter(formatter)
logger.addHandler(file_handler_users)

# --- Console output (useful for Docker logs) ---
console_handler = logging.StreamHandler()
console_handler.setFormatter(formatter)
logger.addHandler(console_handler)
