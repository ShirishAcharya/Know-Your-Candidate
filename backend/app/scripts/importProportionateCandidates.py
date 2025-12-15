import pdfplumber
from io import BytesIO
import sys
from sqlalchemy.orm import Session
from app.data.correctionMapping import gender_mapping, party_mapping , address_mapping , name_mapping
from typing import List,Dict, Union, Tuple
from app.logger import logger
from app.database.session import get_db
from app.models.candidate import Candidate
from app.models.province import Province
from app.models.district import District

def extract_from_pdf(pdf_bytes: bytes) -> List[Dict]:
    """Extract candidate data from PDF bytes"""
    candidates = []
    
    with pdfplumber.open(BytesIO(pdf_bytes)) as pdf:
        for page in pdf.pages:
            # Extract party name from page text
            current_party = extract_party_from_page(page)
            
            # Process tables on the page
            tables = page.extract_tables()
            for table in tables:
                if not table or len(table) < 2:
                    continue
                
                # Process table data
                page_candidates = process_table(table, current_party)
                candidates.extend(page_candidates)
    
    return candidates


def extract_party_from_page(page) -> str:
    """Extract political party name from page text"""
    text = page.extract_text()
    if not text:
        return ""
    
    for line in text.split('\n'):
        line = line.strip()
        if line.startswith('राजनीतिक दलको नाम:-'):
            party = line.split(':-')[1].strip()
            return party_mapping(party)
    
    return ""


def process_table(table: List[List], current_party: str) -> List[Dict]:
    """Process a single table and extract candidate data"""
    if not table or len(table) < 2:
        return []
    
    headers = table[0]
    column_map = create_column_mapping(headers)
    
    candidates = []
    for row in table[1:]:
        if not any(row):
            continue
        
        candidate = extract_candidate_data(row, column_map, current_party)
        if candidate and candidate['name']:
            candidates.append(candidate)
    
    return candidates


def create_column_mapping(headers: List) -> Dict[str, int]:
    """Create mapping from column headers to field names"""
    column_map = {}
    
    for i, header in enumerate(headers):
        header = str(header).strip() if header else ""
        
        if 'पूरा नाम थर' in header:
            column_map['name'] = i
        elif 'तलङ' in header:
            column_map['gender'] = i
        elif 'उमे' in header:
            column_map['age'] = i
        elif 'क्र.सं.' in header:
            column_map['serial'] = i
        elif 'मिदािा भएको प्रदेश' in header:
            column_map['address'] = i
    
    return column_map


def extract_candidate_data(row: List, column_map: Dict[str, int], current_party: str) -> Dict:
    """Extract and clean candidate data from a table row"""
    # Extract basic fields
    raw_name = get_row_value(row, column_map, 'name')
    if not raw_name:
        return None
    
    name = name_mapping(raw_name)

    age = get_row_value(row, column_map, 'age')
    
    # Process gender
    raw_gender = get_row_value(row, column_map, 'gender')
    gender = gender_mapping(raw_gender)
    
    # Process address
    raw_address = get_row_value(row, column_map, 'address')
    province, district = parse_address(raw_address)
    
    # Create candidate dictionary
    candidate = {
        'election_id': 2,
        'name': name.strip(),
        'age': age.strip() if age and isinstance(age, str) else age,
        'gender': gender,
        'party': current_party,
        'province': province,
        'birthplace': district,
        'nationality': 'Nepali',
        'election_year': 2079,
        'election_type': 'Proportionate',
        'election_level': "Federal",
        'sources': 'ECN data 2079',
    }
    
    return candidate


def get_row_value(row: List, column_map: Dict[str, int], field: str) -> str:
    """Safely get value from row using column mapping"""
    if field not in column_map:
        return ""
    
    col_index = column_map[field]
    if col_index < len(row):
        value = row[col_index]
        return str(value).strip() if value and isinstance(value, str) else value
    
    return ""


def parse_address(raw_address: str) -> Tuple[str, str]:
    """Parse address into province and district"""
    corrected_address = address_mapping(raw_address)
    
    # Default values
    province = ""
    district = ""
    
    if corrected_address and '(' in corrected_address and ')' in corrected_address:
        try:
            province = corrected_address.split('(')[0].strip()
            district = corrected_address.split('(')[1].split(')')[0].strip()
        except (IndexError, AttributeError):
            pass
    
    return province, district

def process_pdf_file(pdf_file: str):
    """Convenience function to process a PDF file"""
    logger.info(f"Starting candidate insertion for file: {pdf_file}")
    
    # Validate file exists
    try:
        with open(pdf_file, 'rb') as f:
            # Quick validation that it's a PDF
            header = f.read(4)
            if header != b'%PDF':
                logger.error(f"File {pdf_file} does not appear to be a valid PDF")
                print(f"Error: File {pdf_file} does not appear to be a valid PDF")
                return
    except FileNotFoundError:
        logger.error(f"File not found: {pdf_file}")
        print(f"Error: File not found: {pdf_file}")
        return
    except Exception as e:
        logger.error(f"Error reading file {pdf_file}: {e}")
        print(f"Error reading file {pdf_file}: {e}")
        return
    
    insert_candidates(pdf_file)
    logger.info("Candidate insertion completed.")


def insert_candidates(file_path_or_buffer: Union[str, bytes]):
    """
    Extract candidates from PDF and insert into database
    Accepts either file path or PDF bytes
    """
    # Determine if input is file path or bytes
    if isinstance(file_path_or_buffer, bytes):
        pdf_bytes = file_path_or_buffer
    else:
        # Read PDF file as bytes
        with open(file_path_or_buffer, 'rb') as f:
            pdf_bytes = f.read()
    
    # Extract candidate data from PDF
    candidates_data = extract_from_pdf(pdf_bytes)
    
    if not candidates_data:
        logger.warning("No candidate data extracted from PDF")
        print("No candidate data extracted from PDF")
        return
    
    db: Session = next(get_db())
    inserted_count = 0
    skipped_count = 0

    for cand in candidates_data:
        try:
            # Look up province ID
            province_id = None
            if cand['province']:
                province = db.query(Province).filter(Province.name == cand['province']).first()
                province_id = province.id if province else None
                if not province_id:
                    logger.warning(f"Province not found in DB: {cand['province']}")

            # Look up district ID (using birthplace field)
            district_id = None
            if cand['birthplace']:
                district = db.query(District).filter(District.name == cand['birthplace']).first()
                district_id = district.id if district else None
                if not district_id:
                    logger.warning(f"District not found in DB: {cand['birthplace']}")

            # Create candidate object
            candidate = Candidate(
                election_id=cand['election_id'],
                name=cand['name'],
                age=cand['age'],
                gender=cand['gender'],
                province_id=province_id,
                district_id=district_id,
                birthplace = cand['birthplace'],
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
            
        except Exception as e:
            logger.exception(f"Failed to insert candidate {cand.get('name', 'Unknown')}: {e}")
            skipped_count += 1

    try:
        db.commit()
        logger.info(f"Successfully inserted {inserted_count} candidates into the database. Skipped: {skipped_count}")
        print(f"Successfully inserted {inserted_count} candidates into the database. Skipped: {skipped_count}")
    except Exception as e:
        db.rollback()
        logger.error(f"Database commit failed: {e}")
        print(f"Database commit failed: {e}")

# --- Run script ---
if __name__ == "__main__":
    if len(sys.argv) != 2:
        logger.error("Usage: python insert_candidates.py <path_to_pdf_file>")
        print("Usage: python insert_candidates.py <path_to_pdf_file>")
        sys.exit(1)

    pdf_file = sys.argv[1]
    process_pdf_file(pdf_file)