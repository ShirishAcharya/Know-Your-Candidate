"use client";

import { useState, useEffect } from "react";
import axios from "axios";
import { FilterOptions } from "../page";

/* Flat row returned by getalldata */
export interface CandidateRow {
  id:number;
  election_id: number;
  election_type: string;
  province_id: number;
  district_id: number;
  constituency: string;
  party: string;
  name: string;
  image?:string;
  age:number;
  campaignfocus?:string;
  gender?: string;
  nationality?: string;
  birthplace?:string;
}

interface Province {
  id: number;
  name: string;
  area_sq_km: string;
  website: string;
  headquarter: string;
  districts: {
    id: number;
    name: string;
  }[];
}

/* Election type from the first API */
export interface ElectionType {
  election_id: number;
  election_type: string;
}

/* MAPPED CANDIDATE TYPE */
export interface Candidate {
  id: number;
  name: string;
  party: string;
  election_type: {
    election_id: number;
    election_type: string;
  };
  province: {
    id: number;
    name: string;
  };
  district: {
    id: number;
    name: string;
  };
  constituency: {
    constituency: string;
  };
  image?: string;
  age?:number;
  party_logo?:string;
  campaignfocus?:string;
  gender?:string;
  nationality?:string;
  birthplace?:string;
}

export const useCandidatesData = () => {
  const [candidates, setCandidates] = useState<Candidate[]>([]);
  const [electionId, setElectionId] = useState<number>(1);
  const [allElectionTypes, setAllElectionTypes] = useState<ElectionType[]>([]);
  const [filterOptions, setFilterOptions] = useState<FilterOptions>({
    provinces: [],
    districts: [],
    parties: [],
    constituencies: [],
    types: [],
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const API_BASE_URL =
    process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

  const mapCandidateRowToCandidate = (
    row: CandidateRow,
    provinces: Province[]
    ): Candidate => {
      const province = provinces.find((p) =>
        p.districts.some((d) => d.id === row.district_id)
      );
      const district = province?.districts.find(
        (d) => d.id === row.district_id
      );

    return {
      id: row.id,
      name: row.name,
      party: row.party,
      age:row.age,
      gender: row.gender,
      nationality: row.nationality,
      birthplace:row.birthplace,
      image: row.image,
      election_type: {
        election_id: row.election_id,
        election_type: row.election_type,
      },
      province: {
        id: province?.id ?? 0,
        name: province?.name ?? "",
      },
      district: {
        id: district?.id ?? 0,
        name: district?.name ?? "",
      },
      constituency: {
        constituency: row.constituency,
      },
    };
  };

  // Fetch all election types on mount (only once)
  useEffect(() => {
    const fetchElectionTypes = async () => {
      try {
        const response = await axios.get<ElectionType[]>(
          `${API_BASE_URL}/candidates/types`
        );
        setAllElectionTypes(response.data);
      } catch (err) {
        console.error("Failed to fetch election types:", err);
      }
    };

    fetchElectionTypes();
  }, [API_BASE_URL]);

  // Fetch candidate data whenever electionId changes
  useEffect(() => {
    const fetchAllData = async () => {
      try {
        console.log("Fetching data for election_id:", electionId);
        setLoading(true);
        setError(null);

        const [rowsRes, provincesRes] = await Promise.all([
          axios.get<CandidateRow[]>(
            `${API_BASE_URL}/candidates/getalldata?election_id=${electionId}`
          ),
          axios.get<Province[]>(`${API_BASE_URL}/provinces`),
        ]);

        const rows = rowsRes.data;
        const provinces = provincesRes.data;

        const mappedCandidates = rows.map((r) =>
          mapCandidateRowToCandidate(r, provinces)
        );

        const districts = provinces.flatMap((p) =>
          p.districts.map((d) => ({
            id: d.id,
            name: d.name,
            province_id: p.id,
          }))
        );

        const constituencies = Array.from(
          new Map(
            rows.map((r) => [
              `${r.district_id}-${r.constituency}`,
              {
                id: `${r.district_id}-${r.constituency}`,
                name: r.constituency,
                districtId: r.district_id,
              },
            ])
          ).values()
        );

        const parties = Array.from(new Set(rows.map((r) => r.party)));

        setCandidates(mappedCandidates);
        setFilterOptions({
          provinces,
          districts,
          // Use allElectionTypes if available, otherwise fall back to types from current data
          types: allElectionTypes.length > 0 ? allElectionTypes : Array.from(
            new Map(
              rows.map((r) => [
                r.election_id,
                { election_id: r.election_id, election_type: r.election_type },
              ])
            ).values()
          ),
          constituencies,
          parties,
        });
      } catch (err) {
        console.error(err);
        setError("Failed to load candidate data");
      } finally {
        setLoading(false);
      }
    };

    fetchAllData();
  }, [API_BASE_URL, electionId, allElectionTypes]);

  return {
    candidates,
    filterOptions,
    loading,
    error,
    electionId,
    setElectionId,
  };
};