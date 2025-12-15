from pydantic import BaseModel, EmailStr
from typing import Literal

class VerifyOTPRequest(BaseModel):
    email: EmailStr
    otp: str
    purpose: Literal["register", "reset_password"]

class ResetPasswordRequest(BaseModel):
    email: EmailStr
    new_password: str

class ForgotPasswordRequest(BaseModel):
    email: EmailStr