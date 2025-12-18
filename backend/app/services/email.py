# services/email.py
import os
import aiosmtplib
from email.message import EmailMessage
from dotenv import load_dotenv

load_dotenv()

async def send_otp_email(to: str, otp: str, purpose: str):
    subject = "Your Verification Code" if purpose == "register" else "Reset Your Password"
    expiry = "3 minutes" if purpose == "register" else "1 minute"

    msg = EmailMessage()
    msg["From"] = f"Transparency Nepal <{os.getenv('SMTP_USER')}>"
    msg["To"] = to
    msg["Subject"] = subject

    msg.add_alternative(f"""
    <html>
      <body style="font-family: Arial, sans-serif; text-align: center; padding: 40px;">
        <h2>{subject}</h2>
        <div style="font-size: 36px; letter-spacing: 10px; background: #f0f8ff; padding: 20px; border-radius: 10px; display: inline-block;">
          {otp}
        </div>
        <p style="color: #555; margin-top: 20px;">
          Expires in <strong>{expiry}</strong>
        </p>
      </body>
    </html>
    """, subtype="html")

    await aiosmtplib.send(
        msg,
        hostname=os.getenv("SMTP_HOST"),
        port=int(os.getenv("SMTP_PORT")),
        username=os.getenv("SMTP_USER"),
        password=os.getenv("SMTP_PASS"),
        start_tls=True,
    )