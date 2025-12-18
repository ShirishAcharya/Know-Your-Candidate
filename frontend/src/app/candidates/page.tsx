"use client";

import { useState, useMemo, useEffect, useCallback, Suspense } from "react";
import { useDispatch } from "react-redux";
import { useRouter, useSearchParams } from "next/navigation";
import { useCandidatesData, Candidate } from "./hooks/useCandidatesData";
import { usePagination } from "@/hooks/usePagination";
import { Pagination } from "@/components/ui/Pagination";
import GradientText from "@/components/ui/GradientText";
import Button from "@/components/ui/Button";
import Card from "@/components/ui/Card";
import { setCandidates, selectCandidate,  } from "@/store/candidatesSlice";

/* ---------------- types ---------------- */
interface FilterState {
  province: string;
  district: string;
  party: string;
  type: string;
  constituency: string;
}

export interface FilterOptions {
  provinces: Array<{ id: number; name: string; districts: any[] }>;
  districts: Array<{ id: number; name: string; province_id?: number }>;
  parties: string[];
  types: Array<{ election_id: number; election_type: string }>;
  constituencies: Array<{ id: string; name: string; districtId: number }>;
}

/* ---------------- ui states ---------------- */
const LoadingState = () => (
  <div className="flex justify-center items-center py-20">
    <div className="animate-spin h-12 w-12 border-b-2 border-blue-600 rounded-full" />
  </div>
);

const ErrorState = ({ message, onRetry }: { message: string; onRetry: () => void }) => (
  <div className="text-center py-20">
    <p className="text-red-600 mb-4">{message}</p>
    <Button onClick={onRetry}>Try again</Button>
  </div>
);

const EmptyState = ({ hasFilters }: { hasFilters: boolean }) => (
  <div className="text-center py-20 text-gray-500">
    {hasFilters
      ? "No candidates match your filters."
      : "No candidates available."}
  </div>
);

/* ---------------- filter section ---------------- */
const FilterSection = ({
  filter,
  filterOptions,
  candidates,
  onFilterChange,
  onElectionTypeChange,
  currentElectionId,
}: {
  filter: FilterState;
  filterOptions: FilterOptions;
  candidates: Candidate[];
  onFilterChange: (filter: FilterState) => void;
  onElectionTypeChange: (electionId: number, electionType: string) => void;
  currentElectionId: number;
}) => {
  const handleFilterChange = (key: keyof FilterState, value: string) => {
    const next = { ...filter, [key]: value };
    
    if (key === "type") {
      const selectedElection = filterOptions.types.find(t => t.election_type === value);
      if (selectedElection) {
        onElectionTypeChange(selectedElection.election_id, value);
      }
      next.province = next.district = next.constituency = next.party = "";
    } else if (key === "province") {
      next.district = next.constituency = next.party = "";
    } else if (key === "district") {
      next.constituency = next.party = "";
    } else if (key === "constituency") {
      next.party = "";
    }
    
    onFilterChange(next);
  };

  const filteredDistricts = filter.province
    ? filterOptions.districts.filter((d) => {
        const p = filterOptions.provinces.find((p) => p.name === filter.province);
        return p && d.province_id === p.id;
      })
    : filterOptions.districts;

  const filteredConstituencies = useMemo(() => {
    const allConstituencies = filterOptions.constituencies || [];
    const result = filter.district
      ? allConstituencies.filter((c) => {
          const district = filterOptions.districts.find(
            (d) => d.name === filter.district
          );
          return district && c.districtId === district.id;
        })
      : allConstituencies;

    return [...result].sort((a, b) =>
      (a.name ?? "").localeCompare(b.name ?? "", "en", { numeric: true })
    );
  }, [filter.district, filterOptions.constituencies, filterOptions.districts]);

  const filteredParties = useMemo(() => {
    const parties = candidates
      .filter((c) => {
        if (filter.type && c.election_type.election_type !== filter.type) return false;
        if (filter.province && c.province.name !== filter.province) return false;
        if (filter.district && c.district.name !== filter.district) return false;
        if (filter.constituency && c.constituency.constituency !== filter.constituency) return false;
        return true;
      })
      .map((c) => c.party);

    return Array.from(new Set(parties));
  }, [candidates, filter]);

  // Responsive & mobile-friendly select styles
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

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-4 mb-8">
      <select 
        className={selectClasses} 
        value={filter.type} 
        onChange={(e) => handleFilterChange("type", e.target.value)}
      >
        {filterOptions.types.map((t) => (
          <option key={t.election_id} value={t.election_type}>
            {t.election_type}
          </option>
        ))}
      </select>

      <select 
        className={selectClasses} 
        value={filter.province} 
        onChange={(e) => handleFilterChange("province", e.target.value)}
      >
        <option value="">All Provinces</option>
        {filterOptions.provinces.map((p) => (
          <option key={p.id} value={p.name}>{p.name}</option>
        ))}
      </select>

      <select 
        className={selectClasses} 
        value={filter.district} 
        onChange={(e) => handleFilterChange("district", e.target.value)}
      >
        <option value="">All Districts</option>
        {filteredDistricts.map((d) => (
          <option key={d.id} value={d.name}>{d.name}</option>
        ))}
      </select>

      <select
        className={`${selectClasses} ${
          !filter.district || currentElectionId === 2
            ? "bg-gray-100 text-gray-400 cursor-not-allowed"
            : ""
        }`}
        value={filter.constituency}
        onChange={(e) => handleFilterChange("constituency", e.target.value)}
        disabled={!filter.district || currentElectionId === 2}
      >
        {!filter.district ? (
          <option value="">Constituency</option>
        ) : (
          <option value="">All Constituencies</option>
        )}
        {filteredConstituencies.map((c) => (
          <option key={c.id} value={c.name}>
            {c.name}
          </option>
        ))}
      </select>

      <select 
        className={selectClasses} 
        value={filter.party} 
        onChange={(e) => handleFilterChange("party", e.target.value)}
      >
        <option value="">All Parties</option>
        {filteredParties.map((p) => (
          <option key={p} value={p}>{p}</option>
        ))}
      </select>
    </div>
  );
};

/* ---------------- main page ---------------- */
const PAGE_SIZE = 8;

function CandidatesPageContent() {
  const dispatch = useDispatch();
  const router = useRouter();
  const searchParams = useSearchParams();
  const { candidates, filterOptions, loading, error, electionId, setElectionId } = useCandidatesData();

  const [filter, setFilter] = useState<FilterState>({
    province: "",
    district: "",
    party: "",
    type: "",
    constituency: "",
  });

  useEffect(() => {
    const urlProvince = searchParams.get('province') || '';
    const urlDistrict = searchParams.get('district') || '';
    const urlParty = searchParams.get('party') || '';
    const urlType = searchParams.get('type') || '';
    const urlConstituency = searchParams.get('constituency') || '';

    setFilter({
      province: urlProvince,
      district: urlDistrict,
      party: urlParty,
      type: urlType,
      constituency: urlConstituency,
    });

    if (urlType && filterOptions.types.length > 0) {
      const selectedElection = filterOptions.types.find(t => t.election_type === urlType);
      if (selectedElection) {
        setElectionId(selectedElection.election_id);
      }
    }
  }, [searchParams, filterOptions.types, setElectionId]);

  useEffect(() => {
    if (candidates.length) dispatch(setCandidates(candidates));
  }, [candidates, dispatch]);

  const updateURL = useCallback((newFilter: FilterState) => {
    const params = new URLSearchParams();
    if (newFilter.type) params.set('type', newFilter.type);
    if (newFilter.province) params.set('province', newFilter.province);
    if (newFilter.district) params.set('district', newFilter.district);
    if (newFilter.constituency) params.set('constituency', newFilter.constituency);
    if (newFilter.party) params.set('party', newFilter.party);

    const queryString = params.toString();
    router.push(queryString ? `?${queryString}` : '/candidates', { scroll: false });
  }, [router]);

  const filteredCandidates = useMemo(() => {
    return candidates.filter((c) => {
      const matchesType = !filter.type || c.election_type.election_type.toLowerCase() === filter.type.toLowerCase();
      const matchesProvince = !filter.province || c.province.name.toLowerCase() === filter.province.toLowerCase();
      const matchesDistrict = !filter.district || c.district.name.toLowerCase() === filter.district.toLowerCase();
      const matchesConstituency = !filter.constituency || c.constituency.constituency.toLowerCase() === filter.constituency.toLowerCase();
      const matchesParty = !filter.party || c.party === filter.party;
      return matchesType && matchesProvince && matchesDistrict && matchesConstituency && matchesParty;
    });
  }, [candidates, filter]);

  const pagination = usePagination({ totalItems: filteredCandidates.length, pageSize: PAGE_SIZE });

  const handleFilterChange = useCallback((newFilter: FilterState) => {
    setFilter(newFilter);
    updateURL(newFilter);
    pagination.setPage(1); 
  }, [updateURL, pagination.setPage]);

  const handleElectionTypeChange = useCallback((newElectionId: number, electionType: string) => {
    setElectionId(newElectionId);
    const newFilter = { 
      ...filter, 
      type: electionType,
      province: "",
      district: "",
      constituency: "",
      party: ""
    };
    setFilter(newFilter);
    updateURL(newFilter);
  }, [setElectionId, filter, updateURL]);

  const paginatedCandidates = filteredCandidates.slice(
    pagination.offset,
    pagination.offset + pagination.pageSize
  );

  const handlePageChange = useCallback((page: number) => {
    pagination.setPage(page);
    window.scrollTo({ top: 0, behavior: "smooth" });
  }, [pagination.setPage]);

  if (loading) return <LoadingState />;
  if (error) return <ErrorState message={error} onRetry={() => window.location.reload()} />;

  const hasFilters = Object.values(filter).some(Boolean);

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 lg:py-12">
      <header className="text-center mb-12">
        <h1 className="text-3xl sm:text-4xl md:text-5xl font-bold mb-4">
          <GradientText>Meet the Candidates</GradientText>
        </h1>
        <p className="text-gray-600 text-lg max-w-2xl mx-auto leading-relaxed">
          Browse through the list of candidates. Filter by location, constituency and party to find who wants to represent you.<br></br>( Note: All the data below is from the 2079 elections)
        </p>
      </header>

      <FilterSection
        filter={filter}
        filterOptions={filterOptions}
        candidates={candidates}
        onFilterChange={handleFilterChange}
        onElectionTypeChange={handleElectionTypeChange}
        currentElectionId={electionId}
      />

      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 mb-6 text-gray-600">
        <span>
          Showing <strong>{filteredCandidates.length ? pagination.offset + 1 : 0}-{pagination.offset + paginatedCandidates.length}</strong> of{" "}
          <strong>{filteredCandidates.length}</strong>
        </span>

        {hasFilters && (
          <Button 
            variant="ghost" 
            onClick={() => {
              const clearedFilter = { province: "", district: "", party: "", type: "", constituency: "" };
              setFilter(clearedFilter);
              setElectionId(1);
              router.push('/candidates', { scroll: false });
            }}
          >
            Reset Filters
          </Button>
        )}
      </div>

      {filteredCandidates.length === 0 ? (
        <EmptyState hasFilters={hasFilters} />
      ) : (
        <>
          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {paginatedCandidates.map((c) => (
              <article
                key={c.id}
                tabIndex={0}
                className="cursor-pointer"
                onClick={() => {
                  dispatch(selectCandidate(c.id));
                  router.push(`/candidates/${c.id}`);
                }}
                onKeyDown={(e) => {
                  if (e.key === "Enter" || e.key === " ") {
                    dispatch(selectCandidate(c.id));
                    router.push(`/candidates/${c.id}`);
                  }
                }}
              >
                <Card
                  title={c.name}
                  subtitle={c.party}
                  footer={`District ${c.district.name} • Province ${c.province.name}`}
                  image = {c.image}
                />
              </article>
            ))}
          </div>

          {pagination.totalPages > 1 && (
            <Pagination
              currentPage={pagination.currentPage}
              totalPages={pagination.totalPages}
              onPageChange={handlePageChange}
              className="mt-10"
            />
          )}
        </>
      )}
    </div>
  );
}

export default function CandidatesPage() {
  return (
    <Suspense fallback={<div className="text-center py-20">Loading...</div>}>
      <CandidatesPageContent />
    </Suspense>
  );
}