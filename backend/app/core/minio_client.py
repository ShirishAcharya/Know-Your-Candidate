import boto3
from botocore.client import Config
from botocore.exceptions import ClientError
from fastapi import HTTPException, UploadFile
import uuid
import os
from dotenv import load_dotenv

load_dotenv()

MINIO_INTERNAL = os.getenv("MINIO_INTERNAL")
MINIO_EXTERNAL = os.getenv("MINIO_EXTERNAL")
MINIO_ACCESS_KEY = os.getenv("MINIO_ACCESS_KEY")
MINIO_SECRET_KEY = os.getenv("MINIO_SECRET_KEY")

# Lazy initialization - don't create client at module level
_s3_client = None

def get_s3_client():
    """Get or initialize S3 client with error handling"""
    global _s3_client
    if _s3_client is None:
        try:
            _s3_client = boto3.client(
                "s3",
                endpoint_url=MINIO_INTERNAL,
                aws_access_key_id=MINIO_ACCESS_KEY,
                aws_secret_access_key=MINIO_SECRET_KEY,
                config=Config(
                    signature_version="s3v4",
                    connect_timeout=30,
                    read_timeout=30,
                    retries={'max_attempts': 3}
                ),
                region_name="us-east-1",
                verify=False
            )
            # Test connection
            _s3_client.list_buckets()
            print("✅ MinIO client initialized successfully")
        except Exception as e:
            print(f"❌ MinIO client initialization failed: {e}")
            _s3_client = None
            raise
    return _s3_client

def upload_to_minio(bucket_name: str, file: UploadFile, content_type: str) -> str:
    try:
        s3_client = get_s3_client()
        
        # Check if bucket exists, create if not
        try:
            s3_client.head_bucket(Bucket=bucket_name)
        except ClientError:
            s3_client.create_bucket(Bucket=bucket_name)

        # Generate unique file name
        file_ext = os.path.splitext(file.filename)[-1] if file.filename else ""
        file_key = f"{uuid.uuid4()}{file_ext}"

        # Reset file pointer to beginning
        file.file.seek(0)
        
        # Upload file
        s3_client.upload_fileobj(
            file.file,
            bucket_name,
            file_key,
            ExtraArgs={"ContentType": content_type},
        )

        return f"{MINIO_EXTERNAL}/{bucket_name}/{file_key}"

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"MinIO upload failed: {str(e)}")