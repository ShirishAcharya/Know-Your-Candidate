import { createSlice, PayloadAction } from "@reduxjs/toolkit";

export interface Candidate {
  id: number;
  name: string;
  party: string;
  province?: { name: string };
  district?: { name: string };
  image?: string;
}

interface CandidatesState {
  list: Candidate[];
  selectedCandidate?: Candidate;
}

const initialState: CandidatesState = {
  list: [],
  selectedCandidate: undefined,
};

export const candidatesSlice = createSlice({
  name: "candidates",
  initialState,
  reducers: {
    setCandidates: (state, action: PayloadAction<Candidate[]>) => {
      state.list = action.payload;
    },
    selectCandidate: (state, action: PayloadAction<number>) => {
      state.selectedCandidate = state.list.find(c => c.id === action.payload);
    },
    updateCandidateImage: (state, action: PayloadAction<{ candidateId: number; imageUrl: string }>) => {
      const candidate = state.list.find((c: Candidate) => c.id === action.payload.candidateId);
      if (candidate) {
        candidate.image = action.payload.imageUrl;
      }
    },
  },
});

export const { setCandidates, selectCandidate, updateCandidateImage } = candidatesSlice.actions;

// Selectors
export const selectCandidates = (state: { candidates: CandidatesState }) => state.candidates.list;
export const selectSelectedCandidate = (state: { candidates: CandidatesState }) =>
  state.candidates.selectedCandidate;

export default candidatesSlice.reducer;