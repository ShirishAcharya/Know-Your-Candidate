from sqlalchemy.orm import Session
from app.models.country import Country
from app.models.province import Province
from app.models.district import District        
from app.models.municipality import Municipality, MunicipalityCategoryEnum
from app.models.ward import Ward

from typing import Dict, List, Any
import logging
from app.logger import logger


class DataPopulationService:
    def __init__(self, db: Session):
        self.db = db
    
    def populate_nepal_data(self, nepal_data: List[Dict[str, Any]]) -> Dict[str, int]:
        """Populate all Nepal administrative data"""
        try:
            # Create Nepal country
            nepal = self._create_country()
            
            stats = {
                'provinces': 0,
                'districts': 0,
                'municipalities': 0,
                'wards': 0
            }
            
            # Process each province
            for province_data in nepal_data:
                stats['provinces'] += 1
                province = self._create_province(province_data, nepal.id)
                
                # Process districts
                districts = province_data.get('districts', [])
                if isinstance(districts, dict):
                    districts = list(districts.values())
                
                for district_data in districts:
                    stats['districts'] += 1
                    district = self._create_district(district_data, province.id)
                    
                    # Process municipalities
                    municipalities = district_data.get('municipalities', {})
                    if isinstance(municipalities, list):
                        for municipality_data in municipalities:
                            stats['municipalities'] += 1
                            municipality = self._create_municipality(municipality_data, district.id)
                            stats['wards'] += self._create_wards(municipality_data.get('wards', []), municipality.id)
                    elif isinstance(municipalities, dict):
                        for municipality_key, municipality_data in municipalities.items():
                            stats['municipalities'] += 1
                            municipality = self._create_municipality(municipality_data, district.id)
                            stats['wards'] += self._create_wards(municipality_data.get('wards', []), municipality.id)
            
            self.db.commit()
            logger.info(f"Data population completed: {stats}")
            return stats
            
        except Exception as e:
            self.db.rollback()
            logger.error(f"Error populating data: {str(e)}")
            raise
    
    def _create_country(self) -> Country:
        """Create Nepal country record"""
        country = self.db.query(Country).filter(Country.name == "Nepal").first()
        if not country:
            country = Country(
                name="Nepal",
                code="NP"
            )
            self.db.add(country)
            self.db.flush()
        return country
    
    def _create_province(self, province_data: Dict, country_id: int) -> Province:
        """Create province record"""
        province = self.db.query(Province).filter(Province.id == province_data['id']).first()
        if not province:
            province = Province(
                id=province_data['id'],
                name=province_data['name'],
                area_sq_km=province_data.get('area_sq_km'),
                website=province_data.get('website'),
                headquarter=province_data.get('headquarter'),
                country_id=country_id
            )
            self.db.add(province)
            self.db.flush()
        return province
    
    def _create_district(self, district_data: Dict, province_id: int) -> District:
        """Create district record"""
        district = self.db.query(District).filter(District.id == district_data['id']).first()
        if not district:
            district = District(
                id=district_data['id'],
                name=district_data['name'],
                area_sq_km=district_data.get('area_sq_km'),
                website=district_data.get('website'),
                headquarter=district_data.get('headquarter'),
                province_id=province_id
            )
            self.db.add(district)
            self.db.flush()
        return district
    
    def _create_municipality(self, municipality_data: Dict, district_id: int) -> Municipality:
        """Create municipality record"""
        municipality = self.db.query(Municipality).filter(Municipality.id == municipality_data['id']).first()
        if not municipality:
            # Determine category based on category_id
            category = self._get_municipality_category(municipality_data.get('category_id'))
            
            municipality = Municipality(
                id=municipality_data['id'],
                name=municipality_data['name'],
                district_id=district_id,
                category=category,
                area_sq_km=municipality_data.get('area_sq_km'),
                website=municipality_data.get('website')
            )
            self.db.add(municipality)
            self.db.flush()
        return municipality
    
    def _create_wards(self, wards_data: List[int], municipality_id: int) -> int:
        """Create ward records for a municipality"""
        ward_count = 0
        for ward_number in wards_data:
            ward = self.db.query(Ward).filter(
                Ward.municipality_id == municipality_id,
                Ward.number == ward_number
            ).first()
            
            if not ward:
                ward = Ward(
                    name=f"Ward {ward_number}",
                    number=ward_number,
                    municipality_id=municipality_id
                )
                self.db.add(ward)
                ward_count += 1
        
        self.db.flush()
        return ward_count
    
    def _get_municipality_category(self, category_id: int) -> MunicipalityCategoryEnum:
        """Map category_id to MunicipalityCategoryEnum"""
        category_map = {
            1: MunicipalityCategoryEnum.METROPOLITAN,
            2: MunicipalityCategoryEnum.SUB_METROPOLITAN,
            3: MunicipalityCategoryEnum.MUNICIPALITY,
            4: MunicipalityCategoryEnum.RURAL_MUNICIPALITY
        }
        return category_map.get(category_id, MunicipalityCategoryEnum.MUNICIPALITY)