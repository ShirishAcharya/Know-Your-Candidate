import CalendarIcon from "@/layout/icons/CalendarIcon";
import Button from "@/components/ui/Button";
import PlusIcon from "@/layout/icons/PlusIcon";

interface PastElectionsProps {
  pastElections: any;
  onAddElection: () => void;  // ← NEW: opens the modal
}

export default function PastElections({ pastElections, onAddElection }: PastElectionsProps) {
  const hasElections = pastElections && Object.keys(pastElections).length > 0;

  return (
    <div className="bg-white/80 rounded-2xl shadow-xl p-7 border border-white/70 backdrop-blur-md hover:shadow-2xl transition-all duration-500">
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-xl font-bold text-violet-900 flex items-center">
          <CalendarIcon className="w-6 h-6 mr-3 text-violet-700" />
          Past Elections Contested
        </h3>
        <Button
          onClick={onAddElection}
          size="sm"
          variant={hasElections ? "outline" : "primary"}
        >
          <PlusIcon className="w-4 h-4 mr-1" />
          {hasElections ? "Edit Elections" : "Add Election"}
        </Button>
      </div>

      {hasElections ? (
        <ul className="space-y-4">
          {Object.entries(pastElections).map(([year, election]: [string, any]) => (
            <li 
              key={year} 
              className="p-4 bg-gradient-to-r from-orange-50/80 to-amber-50/80 rounded-xl border border-white/60 shadow-sm hover:shadow-md transition-all duration-300"
            >
              <p className="font-bold text-violet-800 text-lg">
                {year} — {election.position || "Unknown Position"}
              </p>
              <p className="text-sm text-gray-600 mt-1 font-medium">
                Result: <span className={`font-bold ${
                  election.result?.toLowerCase().includes('won') ? 'text-green-600' : 
                  election.result?.toLowerCase().includes('lost') ? 'text-red-600' : 
                  'text-blue-600'
                }`}>
                  {election.result || "Unknown"}
                </span>
              </p>
            </li>
          ))}
        </ul>
      ) : (
        <div className="text-center py-8">
          <CalendarIcon className="w-12 h-12 text-gray-300 mx-auto mb-3" />
          <p className="text-gray-400 italic">No past election data available.</p>
          <Button
            onClick={onAddElection}
            variant="outline"
            size="sm"
            className="mt-4"
          >
            <PlusIcon className="w-4 h-4 mr-1" />
            Add First Election
          </Button>
        </div>
      )}
    </div>
  );
}