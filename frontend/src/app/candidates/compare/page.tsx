"use client";

import React, { useMemo, useState, useEffect, useCallback } from "react";
import { useCandidatesData, Candidate } from "../hooks/useCandidatesData";
import Button from "@/components/ui/Button";
import { useRouter, useSearchParams } from "next/navigation";
import { useDispatch } from "react-redux";
import { selectCandidate, setCandidates } from "../../../store/candidatesSlice";

interface CompareFilter {
  type: string;
  province: string;
  district: string;
  constituency: string;
}

export default function CompareCandidatesPage() {
  const {
    candidates,
    filterOptions,
    loading,
    error,
    setElectionId,
  } = useCandidatesData();

  const router = useRouter();
  const searchParams = useSearchParams();
  const dispatch = useDispatch();

  const [filter, setFilter] = useState<CompareFilter>({
    type: "",
    province: "",
    district: "",
    constituency: "",
  });


  const [leftId, setLeftId] = useState<number | null>(null);
  const [rightId, setRightId] = useState<number | null>(null);

  useEffect(() => {
    if (!loading && candidates.length > 0) {
      dispatch(setCandidates(candidates));
    }
  }, [loading, candidates, dispatch]);

  useEffect(() => {
    const urlType = searchParams.get("type") || "";
    const urlProvince = searchParams.get("province") || "";
    const urlDistrict = searchParams.get("district") || "";
    const urlConstituency = searchParams.get("constituency") || "";
    const urlLeftId = searchParams.get("leftId");
    const urlRightId = searchParams.get("rightId");

    setFilter({
      type: urlType,
      province: urlProvince,
      district: urlDistrict,
      constituency: urlConstituency,
    });

    if (urlLeftId) setLeftId(Number(urlLeftId));
    if (urlRightId) setRightId(Number(urlRightId));

    if (urlType && filterOptions.types.length > 0) {
      const selectedElection = filterOptions.types.find(
        (t) => t.election_type === urlType
      );
      if (selectedElection) setElectionId(selectedElection.election_id);
    }
  }, [searchParams, filterOptions.types, setElectionId]);

  const updateURL = useCallback(
    (newFilter: CompareFilter, newLeftId: number | null, newRightId: number | null) => {
      const params = new URLSearchParams();
      if (newFilter.type) params.set("type", newFilter.type);
      if (newFilter.province) params.set("province", newFilter.province);
      if (newFilter.district) params.set("district", newFilter.district);
      if (newFilter.constituency) params.set("constituency", newFilter.constituency);
      if (newLeftId !== null) params.set("leftId", newLeftId.toString());
      if (newRightId !== null) params.set("rightId", newRightId.toString());

      const queryString = params.toString();
      router.push(queryString ? `?${queryString}` : "/candidates/compare", { scroll: false });
    },
    [router]
  );

  const constituencyCandidates = useMemo(() => {
    return candidates.filter((c) => {
      if (filter.type && c.election_type.election_type !== filter.type) return false;
      if (filter.province && c.province.name !== filter.province) return false;
      if (filter.district && c.district.name !== filter.district) return false;
      if (filter.constituency && c.constituency.constituency !== filter.constituency)
        return false;
      return true;
    });
  }, [candidates, filter]);

  const findCandidate = (id: number | null) =>
    constituencyCandidates.find((c) => c.id === id);

  const left = findCandidate(leftId);
  const right = findCandidate(rightId);

  if (loading)
    return (
      <div className="flex justify-center items-center py-20">
        <div className="animate-spin h-12 w-12 border-b-2 border-blue-600 rounded-full" />
      </div>
    );

  if (error)
    return (
      <div className="text-center py-20">
        <p className="text-red-600 mb-4">{error}</p>
        <Button onClick={() => window.location.reload()}>Try again</Button>
      </div>
    );

  const hasFilters = Object.values(filter).some(Boolean);

  // Mobile-first, full-width, touch-friendly selects
  const selectClasses = `
    w-full 
    px-4 py-3 
    text-base 
    appearance-none 
    bg-white 
    border border-gray-300 
    rounded-lg 
    shadow-sm 
    focus:ring-2 focus:ring-blue-500 
    focus:border-blue-500 
    outline-none 
    transition-all
  `;

  const candidateSelectClasses = `
    w-full 
    px-4 py-3 
    text-base 
    appearance-none 
    bg-white 
    border border-gray-300 
    rounded-lg 
    shadow-sm 
    focus:ring-2 focus:ring-blue-500 
    focus:border-blue-500 
    outline-none 
    transition-all
  `;

  return (
    <div className="min-h-screen bg-gray-50 p-4 sm:p-6">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-3xl sm:text-4xl font-bold mb-6 sm:mb-8 text-center">Compare Candidates</h1>

        {/* FILTER DROPDOWNS – Now perfectly responsive */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
          <select
            className={selectClasses}
            value={filter.type}
            onChange={(e) => {
              const type = e.target.value;
              const selected = filterOptions.types.find((t) => t.election_type === type);
              if (selected) setElectionId(selected.election_id);
              const newFilter = { type, province: "", district: "", constituency: "" };
              setFilter(newFilter);
              setLeftId(null);
              setRightId(null);
              updateURL(newFilter, null, null);
            }}
          >
            <option value="" disabled hidden>Election Type</option>
            {filterOptions.types
              .filter((t) => t.election_id !== 2)
              .map((t) => (
                <option key={t.election_id} value={t.election_type}>
                  {t.election_type}
                </option>
              ))}
          </select>

          <select
            className={selectClasses}
            value={filter.province}
            onChange={(e) => {
              const newFilter = { ...filter, province: e.target.value, district: "", constituency: "" };
              setFilter(newFilter);
              setLeftId(null);
              setRightId(null);
              updateURL(newFilter, null, null);
            }}
          >
            <option value="" disabled hidden>Province</option>
            {filterOptions.provinces.map((p) => (
              <option key={p.id} value={p.name}>{p.name}</option>
            ))}
          </select>

          <select
            className={selectClasses}
            value={filter.district}
            onChange={(e) => {
              const newFilter = { ...filter, district: e.target.value, constituency: "" };
              setFilter(newFilter);
              setLeftId(null);
              setRightId(null);
              updateURL(newFilter, null, null);
            }}
          >
            <option value="" disabled hidden>District</option>
            {filterOptions.districts
              .filter((d) => {
                const p = filterOptions.provinces.find((p) => p.name === filter.province);
                return !filter.province || d.province_id === p?.id;
              })
              .map((d) => (
                <option key={d.id} value={d.name}>{d.name}</option>
              ))}
          </select>

          <select
            className={selectClasses}
            value={filter.constituency}
            onChange={(e) => {
              const newFilter = { ...filter, constituency: e.target.value };
              setFilter(newFilter);
              setLeftId(null);
              setRightId(null);
              updateURL(newFilter, null, null);
            }}
            disabled={!filter.district}
          >
            <option value="" disabled hidden>Constituency</option>
            {filterOptions.constituencies
              .filter((c) => {
                const d = filterOptions.districts.find((d) => d.name === filter.district);
                return !filter.district || c.districtId === d?.id;
              })
              .sort((a, b) => {
                const parse = (name?: string | null) => {
                  if (!name) return { main: 0, sub: 0 };
                  const match = name.match(/^(\d+)\((\d+)\)$/);
                  if (match) return { main: Number(match[1]), sub: Number(match[2]) };
                  return { main: Number(name) || 0, sub: 0 };
                };
                const aNum = parse(a.name);
                const bNum = parse(b.name);
                return aNum.main !== bNum.main ? aNum.main - bNum.main : aNum.sub - bNum.sub;
              })
              .map((c) => (
                <option key={c.id} value={c.name}>
                  Constituency {c.name}
                </option>
              ))}
          </select>
        </div>

        {/* CANDIDATE SELECTION – Also fully responsive */}
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-6">
          <select
            value={leftId ?? ""}
            onChange={(e) => {
              const newLeftId = e.target.value ? Number(e.target.value) : null;
              setLeftId(newLeftId);
              updateURL(filter, newLeftId, rightId);
            }}
            className={candidateSelectClasses}
            disabled={constituencyCandidates.length === 0}
          >
            <option value="" disabled hidden>Left Candidate</option>
            {constituencyCandidates.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name} — {c.party}
              </option>
            ))}
          </select>

          <select
            value={rightId ?? ""}
            onChange={(e) => {
              const newRightId = e.target.value ? Number(e.target.value) : null;
              setRightId(newRightId);
              updateURL(filter, leftId, newRightId);
            }}
            className={candidateSelectClasses}
            disabled={constituencyCandidates.length === 0}
          >
            <option value="" disabled hidden>Right Candidate</option>
            {constituencyCandidates.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name} — {c.party}
              </option>
            ))}
          </select>
        </div>

        {hasFilters && (
          <div className="text-center mb-6">
            <Button
              variant="ghost"
              onClick={() => {
                const resetFilter = { type: "", province: "", district: "", constituency: "" };
                setFilter(resetFilter);
                setLeftId(null);
                setRightId(null);
                router.push('/candidates/compare', { scroll: false });
              }}
            >
              Reset Filters
            </Button>
          </div>
        )}

        {/* COMPARISON SECTION */}
        {left && right ? (
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-4 sm:gap-6">
            <div className="lg:col-span-3 bg-white rounded-2xl shadow-lg p-4 sm:p-6 h-auto lg:h-80">
              <CandidateCard candidate={left} />
            </div>
            <div className="lg:col-span-6 bg-white rounded-2xl shadow-lg overflow-hidden">
              <div className="bg-gray-100 px-4 sm:px-6 py-3 sm:py-4 text-center">
                <h2 className="text-lg sm:text-xl font-bold">Field-by-field Comparison</h2>
              </div>
              <div className="divide-y">
                <ComparisonRow label="Name" leftValue={left.name} rightValue={right.name} />
                <ComparisonRow label="Party" leftValue={left.party} rightValue={right.party} />
                <ComparisonRow label="District" leftValue={left.district.name} rightValue={right.district.name} />
                <ComparisonRow label="Constituency" leftValue={left.constituency.constituency} rightValue={right.constituency.constituency} />
                <ComparisonRow label="Age" leftValue={left.age?.toString()} rightValue={right.age?.toString()} />
                <ComparisonRow label="Campaign Focus" leftValue={left.campaignfocus} rightValue={right.campaignfocus} />
              </div>
            </div>
            <div className="lg:col-span-3 bg-white rounded-2xl shadow-lg p-4 sm:p-6 h-auto lg:h-80">
              <CandidateCard candidate={right} />
            </div>
          </div>
        ) : (
          <div className="bg-white rounded-2xl shadow-lg p-8 sm:p-12 text-center text-gray-500">
            <p className="text-base sm:text-lg">Please select location filters and two candidates to compare</p>
          </div>
        )}
      </div>
    </div>
  );
}

/* COMPONENTS – unchanged */
function ComparisonRow({ label, leftValue, rightValue }: { label: string; leftValue?: string; rightValue?: string }) {
  return (
    <div className="grid grid-cols-3 divide-x">
      <div className="p-3 sm:p-4 text-xs sm:text-sm text-center bg-gray-50">{leftValue || "—"}</div>
      <div className="p-3 sm:p-4 text-xs sm:text-sm font-semibold text-center bg-white">{label}</div>
      <div className="p-3 sm:p-4 text-xs sm:text-sm text-center bg-gray-50">{rightValue || "—"}</div>
    </div>
  );
}

function CandidateCard({ candidate }: { candidate: Candidate }) {
  const router = useRouter();
  const dispatch = useDispatch();

  const handleClick = (e: React.MouseEvent) => {
    e.preventDefault();
    dispatch(selectCandidate(candidate.id));
    router.push(`/candidates/${candidate.id}`);
  };

  return (
    <div className="flex flex-col items-center">
      <div className="w-20 h-20 sm:w-24 sm:h-24 rounded-full bg-gray-200 flex items-center justify-center mb-2 sm:mb-3 overflow-hidden">
        <img
          src={candidate.image || "/placeholder.png"}
          alt={candidate.name}
          className="w-full h-full object-cover"
        />
      </div>
      <h2 className="text-lg sm:text-xl font-bold mb-1 text-center">{candidate.name}</h2>
      <p className="text-gray-600 text-xs sm:text-sm text-center mb-2 sm:mb-3">{candidate.party}</p>
      {candidate.party_logo && <img src={candidate.party_logo} alt="Party logo" className="w-8 h-8 sm:w-10 sm:h-10 object-contain" />}
      <button
        onClick={handleClick}
        className="flex-gap-8 mt-3 sm:mt-4 px-3 sm:px-4 py-2 bg-blue-500 text-white rounded text-xs sm:text-sm hover:bg-blue-800 cursor-pointer"
      >
        Know More About <br /> {candidate.name}
      </button>
    </div>
  );
}