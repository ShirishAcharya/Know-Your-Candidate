from sqlalchemy import Column, BigInteger, String, Integer, ForeignKey
from sqlalchemy.orm import relationship
from app.database.base import Base

class Candidate(Base):
    __tablename__ = "candidate"

    id = Column(BigInteger, primary_key=True, index=True)

    # Basic candidate info
    election_id = Column(BigInteger, nullable=False, comment="Reference to election table if needed")
    name = Column(String(255), nullable=False)
    age = Column(Integer, nullable=True)
    gender = Column(String(20), nullable=True)
    birthplace = Column(String(255), nullable=True)
    nationality = Column(String(100), default="Nepali", nullable=False)

    # Election info
    election_year = Column(Integer, nullable=True)
    election_type = Column(String(100), nullable=False)
    election_level = Column(String(100), nullable=True)
    constituency = Column(String(255), nullable=True)
    party = Column(String(255), nullable=True)
    
    # Source / reference
    sources = Column(String(500), nullable=True, comment="Sources of candidate data")
    source_file = Column(String(255), nullable=True)
    
    # Image
    image = Column(String(500), nullable=True, comment="Store MinIO image URL")

    # --- Foreign Keys ---
    province_id = Column(BigInteger, ForeignKey("province.id", ondelete="SET NULL"), nullable=True)
    district_id = Column(BigInteger, ForeignKey("district.id", ondelete="SET NULL"), nullable=True)

    # --- Relationships ---
    province = relationship("Province", back_populates="candidates")
    district = relationship("District", back_populates="candidates")
    details = relationship("CandidateDetails", back_populates="candidate", uselist=False, cascade="all, delete-orphan")
