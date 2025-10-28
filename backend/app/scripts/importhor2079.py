import pandas as pd
import json
import unicodedata
import re
from typing import List
from sqlalchemy.orm import Session
from app.models.candidate import Candidate
from app.database.session import get_db
from app.logger import logger  # Use your central election_api logger

ELECTION_YEAR = 2079

# --- Helper functions ---
def normalize_text(text: str) -> str:
    """Normalize and clean Nepali text for matching"""
    if not isinstance(text, str):
        return text
    text = text.strip()
    return unicodedata.normalize("NFC", text)

# Load conversion mappings
with open("app/data/convertDistrict.json", "r", encoding="utf-8") as f:
    district_map = {normalize_text(item["nepali"]): item["english"] for item in json.load(f)}

with open("app/data/convertProvince.json", "r", encoding="utf-8") as f:
    province_map = {normalize_text(item["nepali"]): item["english"] for item in json.load(f)}

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
def process_hor_data_with_pandas(file_path_or_buffer) -> List[dict]:
    try:
        df = pd.read_excel(file_path_or_buffer, header=1)
        logger.info("Successfully loaded Excel file")
    except Exception as e:
        logger.error(f"Failed to read Excel file: {e}")
        raise e

    df.columns = [
        'cr_san', 'pradesh', 'jilla', 'constituency_hor',
        'party', 'name', 'gender', 'age'
    ]

    df['pradesh'] = df['pradesh'].apply(map_province)
    df['jilla'] = df['jilla'].apply(lambda x: district_map.get(normalize_text(x), x))

    candidates = df.apply(lambda row: {
        'election_id': 1,
        'name': row['name'],
        'age': int(row['age']),
        'province': row['pradesh'],
        'birthplace': row['jilla'],
        'nationality': 'Nepali',
        'election_year': ELECTION_YEAR,
        'party': row['party'],
        'constituency': row['constituency_hor'],
        'election_type': 'HOR',
        'election_level': 'Federal',
        'sources': 'ECN data 2079'
    }, axis=1).tolist()

    logger.info(f"Processed {len(candidates)} candidates successfully.")
    return candidates

# --- Insert into DB ---
def insert_candidates(file_path_or_buffer):
    candidates_data = process_hor_data_with_pandas(file_path_or_buffer)
    db: Session = next(get_db())
    inserted_count = 0

    for cand in candidates_data:
        province = db.query(Province).filter(Province.name == cand['province']).first()
        province_id = province.id if province else None

        district = db.query(District).filter(District.name == cand['birthplace']).first()
        district_id = district.id if district else None

        candidate = Candidate(
            election_id=cand['election_id'],
            name=cand['name'],
            age=cand['age'],
            province_id=province_id,
            district_id=district_id,
            nationality=cand['nationality'],
            election_year=cand['election_year'],
            party=cand['party'],
            constituency=cand['constituency'],
            election_type=cand['election_type'],
            election_level=cand['election_level'],
            sources=cand['sources']
        )

        db.add(candidate)
        inserted_count += 1

    db.commit()
    logger.info(f"Inserted {inserted_count} candidates into the database.")
    print(f"Inserted {inserted_count} candidates into the database.")

# --- Run script ---
if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python insert_candidates.py <path_to_excel_file>")
        sys.exit(1)

    excel_file = sys.argv[1]
    insert_candidates(excel_file)
