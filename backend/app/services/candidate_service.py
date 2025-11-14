# app/services/candidate_service.py

from typing import List, Dict
from app.database.base import SessionLocal
from app.models.candidate import Candidate
from app.models.province import Province
from app.models.district import District
from app.logger import logger  # centralized logger

def save_candidates_to_db(candidates: List[Dict]):
    """Store parsed candidates into the database with type-safe handling."""
    session = SessionLocal()
    inserted, skipped = 0, 0

    try:
        for data in candidates:
            # Ensure province and district exist
            province = (
                session.query(Province)
                .filter(Province.name.ilike(str(data.get("province", ""))))
                .first()
            )
            district = (
                session.query(District)
                .filter(District.name.ilike(str(data.get("birthplace", ""))))
                .first()
            )

            if not province and not district:
                skipped += 1
                logger.warning(f"Skipping candidate {data.get('name')} due to missing province/district.")
                continue

            # Convert constituency to string to match DB type
            constituency_str = str(data.get("constituency", ""))

            # Check for duplicates
            existing = (
                session.query(Candidate)
                .filter(
                    Candidate.name == str(data.get("name", "")),
                    Candidate.constituency == constituency_str,
                    Candidate.election_type == str(data.get("election_type", "")),
                )
                .first()
            )
            if existing:
                skipped += 1
                logger.info(f"Skipping duplicate candidate: {data.get('name')}, {constituency_str}")
                continue

            # Safely cast age to integer
            age = None
            try:
                age_val = data.get("age")
                if age_val is not None:
                    age = int(age_val)
            except (ValueError, TypeError):
                logger.warning(f"Invalid age for candidate {data.get('name')}: {age_val}")

            candidate = Candidate(
                election_type=str(data.get("election_type", "")),
                name=str(data.get("name", "")),
                age=age,
                gender=str(data.get("gender", "")),
                nationality=str(data.get("nationality", "Nepali")),
                party=str(data.get("party", "")),
                constituency=constituency_str,
                source_file=str(data.get("source_file", "")),
                province_id=province.id if province else None,
                district_id=district.id if district else None,
            )

            session.add(candidate)
            inserted += 1

        session.commit()
        logger.info(f"✅ Inserted {inserted} candidates, skipped {skipped}.")
    except Exception as e:
        logger.exception(f"❌ Failed to save candidates: {e}")
        session.rollback()
    finally:
        session.close()
