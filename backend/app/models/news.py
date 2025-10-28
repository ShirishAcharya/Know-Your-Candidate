from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime
from datetime import datetime
from app.database.base import Base

class News(Base):
    __tablename__ = "news"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    excerpt = Column(String(500), nullable=True)
    content = Column(Text, nullable=False)
    author = Column(String(100), nullable=True)
    date = Column(DateTime, default=datetime.utcnow)
    category = Column(String(50), nullable=True)
    image = Column(String(255), nullable=True)
    read_time = Column(String(50), nullable=True)
    featured = Column(Boolean, default=False)
