from pydantic import BaseModel
from typing import Optional
from datetime import datetime

class NewsBase(BaseModel):
    title: str
    excerpt: Optional[str]
    content: str
    author: Optional[str]
    category: Optional[str]
    image: Optional[str]
    read_time: Optional[str]
    featured: Optional[bool] = False

class NewsCreate(NewsBase):
    pass

class NewsUpdate(BaseModel):
    title: Optional[str]
    excerpt: Optional[str]
    content: Optional[str]
    author: Optional[str]
    category: Optional[str]
    image: Optional[str]
    read_time: Optional[str]
    featured: Optional[bool]

class NewsOut(NewsBase):
    id: int
    date: datetime

    class Config:
        orm_mode = True
