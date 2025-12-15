'use client';

import { useState, useEffect } from 'react';
import Button from '@/components/ui/Button';

interface PastElection {
  position: string;
  result: string;
  votes?: string;
}

interface PastElectionsModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSave: (data: Record<string, PastElection>) => void;
  currentElections: Record<string, PastElection>;
}

export default function PastElectionsModal({
  isOpen,
  onClose,
  onSave,
  currentElections,
}: PastElectionsModalProps) {
  const [elections, setElections] = useState<Record<string, PastElection>>(currentElections);

  // Pre-fill with existing data when modal opens
  useEffect(() => {
    if (isOpen) {
      setElections(currentElections);
    }
  }, [isOpen, currentElections]);

  const addElection = () => {
    const newYear = prompt("Enter election year (e.g. 2079)");
    if (!newYear || isNaN(Number(newYear))) {
      alert("Please enter a valid year");
      return;
    }
    if (elections[newYear]) {
      alert("Election for this year already exists");
      return;
    }
    setElections({
      ...elections,
      [newYear]: { position: "", result: "Won", votes: "" },
    });
  };

  const updateElection = (year: string, field: keyof PastElection, value: string) => {
    setElections({
      ...elections,
      [year]: { ...elections[year], [field]: value },
    });
  };

  const removeElection = (year: string) => {
    const { [year]: _, ...rest } = elections;
    setElections(rest);
  };

  const handleSave = () => {
    // Filter out incomplete entries
    const cleaned = Object.fromEntries(
      Object.entries(elections).filter(
        ([_, election]) => election.position.trim() !== ""
      )
    );
    onSave(cleaned);
    onClose();
  };

  if (!isOpen) return null;

  const sortedYears = Object.keys(elections).sort((a, b) => Number(b) - Number(a));

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-2xl p-8 w-full max-w-3xl max-h-[90vh] overflow-y-auto shadow-2xl">
        <h3 className="text-2xl font-bold text-violet-900 mb-6">Edit Past Elections</h3>

        <div className="space-y-6">
          {sortedYears.length === 0 ? (
            <p className="text-center text-gray-500 py-8">No past elections added yet</p>
          ) : (
            sortedYears.map((year) => (
              <div key={year} className="p-5 border border-gray-200 rounded-xl space-y-4">
                <div className="flex justify-between items-center">
                  <h4 className="text-lg font-semibold text-violet-800">Year {year}</h4>
                  <Button
                    variant="ghost"
                    size="sm"
                    onClick={() => removeElection(year)}
                    className="text-red-600 hover:text-red-800"
                  >
                    Remove
                  </Button>
                </div>
                <input
                  type="text"
                  placeholder="Position Contested"
                  value={elections[year].position}
                  onChange={(e) => updateElection(year, "position", e.target.value)}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-violet-500"
                />
                <select
                  value={elections[year].result}
                  onChange={(e) => updateElection(year, "result", e.target.value)}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-violet-500"
                >
                  <option>Won</option>
                  <option>Lost</option>
                  <option>Runner-up</option>
                  <option>Other</option>
                </select>
                <input
                  type="text"
                  placeholder="Votes received (optional)"
                  value={elections[year].votes || ""}
                  onChange={(e) => updateElection(year, "votes", e.target.value)}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-violet-500"
                />
              </div>
            ))
          )}

          <Button onClick={addElection} variant="outline" className="w-full">
            + Add Election Year
          </Button>
        </div>

        <div className="flex gap-3 mt-8">
          <Button onClick={handleSave} className="flex-1">
            Save Elections
          </Button>
          <Button variant="outline" onClick={onClose} className="flex-1">
            Cancel
          </Button>
        </div>
      </div>
    </div>
  );
}