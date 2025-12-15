import Button from "@/components/ui/Button";
import PlusIcon from "@/layout/icons/PlusIcon";
import TargetIcon from "@/layout/icons/TargetIcon";

interface CampaignFocusProps {
  focuses: any[];
  onAddFocus: () => void;
}

export default function CampaignFocus({ focuses, onAddFocus }: CampaignFocusProps) {
  return (
    <div className="bg-white/90 rounded-2xl shadow-xl p-7 border border-white/70 backdrop-blur-md hover:shadow-2xl transition-all duration-500 group">
      <div className="flex justify-between items-center mb-5">
        <h3 className="text-xl font-bold text-violet-900 flex items-center group-hover:scale-105 transition-transform duration-300">
          <TargetIcon className="w-6 h-6 mr-3 text-violet-700" />
          Campaign Focus
        </h3>
        <Button onClick={onAddFocus} size="sm">
          <PlusIcon className="w-4 h-4 mr-1" />
          Add Focus Area
        </Button>
      </div>
      {focuses?.length ? (
        <ul className="space-y-3">
          {focuses.map((focus, index) => (
            <li 
              key={index} 
              className="p-4 bg-gradient-to-r from-green-50/80 to-emerald-50/80 rounded-xl border border-white/60 shadow-sm hover:shadow-md hover:bg-white/90 transition-all duration-300 flex items-start"
            >
              <span className="w-2 h-2 bg-emerald-600 rounded-full mt-2 mr-3 flex-shrink-0"></span>
              <div>
                <span className="text-violet-800 font-medium block">{focus.title}</span>
                {focus.description && (
                  <p className="text-gray-600 text-sm mt-1">{focus.description}</p>
                )}
                {/* {focus.priority && (
                  <p className="text-gray-500 text-xs mt-1">Priority: {focus.priority}</p>
                )} */}
              </div>
            </li>
          ))}
        </ul>
      ) : (
        <div className="text-center py-8">
          <TargetIcon className="w-12 h-12 text-gray-300 mx-auto mb-3" />
          <p className="text-gray-400 italic">No campaign focus areas added yet.</p>
          <Button
            onClick={onAddFocus}
            variant="outline"
            size="sm"
            className="mt-3"
          >
            <PlusIcon className="w-4 h-4 mr-1" />
            Add First Focus Area
          </Button>
        </div>
      )}
    </div>
  );
}