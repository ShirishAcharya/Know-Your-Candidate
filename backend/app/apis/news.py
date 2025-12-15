from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from app.database.base import SessionLocal
from app.models.news import News
from app.schemas.news import NewsCreate, NewsOut, NewsUpdate
from app.core.logger import logger

router = APIRouter(prefix="/news", tags=["News"])

# ------------------------------
# Dependency
# ------------------------------
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# ------------------------------
# Routes
# ------------------------------

@router.post("/", response_model=NewsOut, status_code=status.HTTP_201_CREATED)
def create_news(news_data: NewsCreate, db: Session = Depends(get_db)):
    """Create a news article"""
    try:
        new_news = News(**news_data.dict())
        db.add(new_news)
        db.commit()
        db.refresh(new_news)
        logger.info(f"News created: {new_news.title}")
        return new_news
    except Exception as e:
        db.rollback()
        logger.error(f"Error creating news: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error while creating news")


@router.put("/{news_id}", response_model=NewsOut)
def update_news(news_id: int, news_data: NewsUpdate, db: Session = Depends(get_db)):
    """Update a news article"""
    try:
        news_item = db.query(News).filter(News.id == news_id).first()
        if not news_item:
            logger.warning(f"News not found: {news_id}")
            raise HTTPException(status_code=404, detail="News not found")

        for key, value in news_data.dict(exclude_unset=True).items():
            setattr(news_item, key, value)

        db.commit()
        db.refresh(news_item)
        logger.info(f"News updated: {news_item.title}")
        return news_item
    except HTTPException:
        raise
    except Exception as e:
        db.rollback()
        logger.error(f"Error updating news {news_id}: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error while updating news")


@router.get("/", response_model=List[NewsOut])
def get_all_news(db: Session = Depends(get_db), category: Optional[str] = None):
    """Get all news or filter by category"""
    try:
        query = db.query(News)
        if category:
            query = query.filter(News.category == category)
        news_list = query.order_by(News.date.desc()).all()
        logger.info(f"Fetched {len(news_list)} news items")
        return news_list
    except Exception as e:
        logger.error(f"Error fetching news: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error while fetching news")


@router.get("/{news_id}", response_model=NewsOut)
def get_news_by_id(news_id: int, db: Session = Depends(get_db)):
    """Get a news article by ID"""
    try:
        news_item = db.query(News).filter(News.id == news_id).first()
        if not news_item:
            logger.warning(f"News not found: {news_id}")
            raise HTTPException(status_code=404, detail="News not found")
        return news_item
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error fetching news {news_id}: {str(e)}", exc_info=True)
        raise HTTPException(status_code=500, detail="Internal server error while fetching news")
