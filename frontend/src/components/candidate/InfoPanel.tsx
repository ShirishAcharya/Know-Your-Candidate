import Button from "@/components/ui/Button";
import ReviewIcon from "@/layout/icons/ReviewIcon";
import LocationIcon from "@/layout/icons/LocationIcon";
import UserGroupIcon from "@/layout/icons/UserGroupIcon";
import CalendarIcon from "@/layout/icons/CalendarIcon";
import PeopleIcon from "@/layout/icons/PeopleIcon";
import FlagIcon from "@/layout/icons/FlagIcon";
import InfoItem from "./ui/InfoItem";

interface InfoPanelProps {
  candidate: any;
  candidateDetails: any;
  onOpenReviewModal: () => void;
}

export default function InfoPanel({ candidate, candidateDetails, onOpenReviewModal }: InfoPanelProps) {
  const averageRating = candidateDetails?.overall_rating || 0;
  const totalRatings = candidateDetails?.total_ratings || 0;

  return (
    <div className="space-y-6">
      {/* Candidate Information */}
      <div className="bg-white/80 rounded-2xl shadow-xl p-6 border border-white/60 backdrop-blur-md hover:shadow-2xl transition-all duration-500">
        <h3 className="text-xl font-bold text-violet-900 mb-5 flex items-center">
          <PeopleIcon className="w-6 h-6 mr-3 text-violet-700" />
          Candidate Information
        </h3>
        <div className="space-y-4">
          <InfoItem
            icon={LocationIcon}
            label="Location"
            value={[candidate.birthplace, candidate.constituency]
                    .filter(Boolean)
                    .join(", ")}
          />
          <InfoItem
            icon={UserGroupIcon}
            label="Political Party"
            value={candidate.party}
          />
          <InfoItem
            icon={CalendarIcon}
            label="Age"
            value={candidate.age ? `${candidate.age} years` : "N/A"}
          />
          <InfoItem
            icon={PeopleIcon}
            label="Gender"
            value={candidate.gender || "N/A"}
          />
          <InfoItem
            icon={FlagIcon}
            label="Nationality"
            value={candidate.nationality || "N/A"}
          />
        </div>
      </div>

      {/* Rating Summary */}
      <div className="bg-white/80 rounded-2xl shadow-xl p-6 border border-white/60 backdrop-blur-md hover:shadow-2xl transition-all duration-500">
        <h3 className="text-xl font-bold text-violet-900 mb-4 flex items-center">
          <ReviewIcon className="w-6 h-6 mr-3 text-violet-700" />
          Candidate Rating
        </h3>
        <div className="text-center">
          <div className="text-4xl font-bold text-violet-900 mb-2">
            {averageRating.toFixed(1)}/5
          </div>
          <div className="text-2xl mb-3">
            {"⭐".repeat(Math.round(averageRating))}
            {"☆".repeat(5 - Math.round(averageRating))}
          </div>
          <p className="text-gray-600 text-sm mb-4">
            Based on {totalRatings} ratings
          </p>
          <Button
            onClick={onOpenReviewModal}
            className="w-full"
          >
            <ReviewIcon className="w-4 h-4 mr-2" />
            Rate This Candidate
          </Button>
        </div>
      </div>
    </div>
  );
}