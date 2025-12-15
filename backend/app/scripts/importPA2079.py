import pandas as pd
import json
import unicodedata
import re
from typing import List
from sqlalchemy.orm import Session
from app.models.candidate import Candidate
from app.models.province import Province
from app.models.district import District
from app.database.session import get_db
from app.logger import logger  # Central election_api logger

ELECTION_YEAR = 2079

# --- Helper functions ---
def normalize_text(text: str) -> str:
    """Normalize and clean Nepali text for matching"""
    if not isinstance(text, str):
        return text
    text = text.strip()
    return unicodedata.normalize("NFC", text)

# Load conversion mappings with logging
try:
    with open("app/data/convertDistrict.json", "r", encoding="utf-8") as f:
        district_map = {normalize_text(item["nepali"]): item["english"] for item in json.load(f)}
    logger.info(f"Loaded {len(district_map)} districts from convertDistrict.json")
except Exception as e:
    logger.error(f"Failed to load convertDistrict.json: {e}")
    district_map = {}

try:
    with open("app/data/convertProvince.json", "r", encoding="utf-8") as f:
        province_map = {normalize_text(item["nepali"]): item["english"] for item in json.load(f)}
    logger.info(f"Loaded {len(province_map)} provinces from convertProvince.json")
except Exception as e:
    logger.error(f"Failed to load convertProvince.json: {e}")
    province_map = {}

numbered_provinces = {
    "१": "Koshi Province",
    "२": "Madhesh Province",
    "३": "Bagmati Province",
    "४": "Gandaki Province",
    "५": "Lumbini Province",
    "६": "Karnali Province",
    "७": "Sudurpashchim Province"
}

def map_province(prov: str) -> str:
    prov_norm = normalize_text(prov)
    if prov_norm in province_map:
        return province_map[prov_norm]
    match = re.search(r"प्रदेश\s*([१२३४५६७])", prov_norm)
    if match:
        num = match.group(1)
        return numbered_provinces.get(num, prov_norm)
    return prov_norm

# --- Process Excel ---
def process_PA_data_with_pandas(file_path_or_buffer) -> List[dict]:
    try:
        df = pd.read_excel(file_path_or_buffer, header=1)
        logger.info(f"Successfully loaded Excel file: {file_path_or_buffer}")
    except Exception as e:
        logger.exception(f"Failed to read Excel file: {file_path_or_buffer}")
        raise e

    df.columns = [
        'cr_san', 'pradesh', 'jilla', 'constituency_hor','constituency_pa',
        'party', 'name', 'gender', 'age'
    ]
    logger.debug(f"Excel columns after renaming: {df.columns.tolist()}")

    # Normalize province and district names
    df['pradesh'] = df['pradesh'].apply(lambda x: map_province(x))
    df['jilla'] = df['jilla'].apply(lambda x: district_map.get(normalize_text(x), x))
    logger.info("Normalized provinces and districts in Excel data.")

    # Build candidate dicts
    candidates = df.apply(lambda row: {
        'election_id': 3,
        'name': row['name'],
        'age': int(row['age']),
        'gender' : row['gender'],
        'province': row['pradesh'],
        'birthplace': row['jilla'],
        'nationality': 'Nepali',
        'election_year': ELECTION_YEAR,
        'party': row['party'],
        'federal_constituency': row['constituency_hor'],
        'provincial_constituency' : row['constituency_pa'],
        'constituency' : f"{row['constituency_hor']}({row['constituency_pa']})",
        'election_type': 'Provincial Assembly',
        'election_level': 'Provincial',
        'sources': 'ECN data 2079'
    }, axis=1).tolist()


    logger.info(f"Processed {len(candidates)} candidates from Excel data. First 10 candidates: {candidates[:10]}")

    return candidates

#  --- Insert into DB ---
def insert_candidates(file_path_or_buffer):
    candidates_data = process_PA_data_with_pandas(file_path_or_buffer)
    db: Session = next(get_db())
    inserted_count = 0

    for cand in candidates_data:
        try:
            province = db.query(Province).filter(Province.name == cand['province']).first()
            province_id = province.id if province else None
            if not province_id:
                logger.warning(f"Province not found in DB: {cand['province']}")

            district = db.query(District).filter(District.name == cand['birthplace']).first()
            district_id = district.id if district else None
            if not district_id:
                logger.warning(f"District not found in DB: {cand['birthplace']}")

            candidate = Candidate(
                election_id=cand['election_id'],
                name=cand['name'],
                age=cand['age'],
                gender = cand['gender'],
                province_id=province_id,
                district_id=district_id,
                nationality=cand['nationality'],
                election_year=cand['election_year'],
                party=cand['party'],
                federal_constituency=cand['federal_constituency'],
                provincial_constituency=cand['provincial_constituency'],
                constituency = cand['constituency'],
                election_type=cand['election_type'],
                election_level=cand['election_level'],
                sources=cand['sources']
            )

            db.add(candidate)
            inserted_count += 1
        except Exception as e:
            logger.exception(f"Failed to insert candidate {cand['name']}: {e}")

    db.commit()
    logger.info(f"Inserted {inserted_count} candidates into the database.")
    print(f"Inserted {inserted_count} candidates into the database.")

# --- Run script ---
if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        logger.error("Usage: python insert_candidates.py <path_to_excel_file>")
        print("Usage: python insert_candidates.py <path_to_excel_file>")
        sys.exit(1)

    excel_file = sys.argv[1]
    logger.info(f"Starting candidate insertion for file: {excel_file}")
    insert_candidates(excel_file)
    logger.info("Candidate insertion completed.")