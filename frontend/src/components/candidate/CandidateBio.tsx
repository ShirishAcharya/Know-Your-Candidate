import Button from "@/components/ui/Button";
import UserGroupIcon from "@/layout/icons/UserGroupIcon";
import ReviewIcon from "@/layout/icons/ReviewIcon";
import Link from "next/link"

interface CandidateBioProps {
  candidate: any;
  candidateDetails: any;
  onOpenReviewModal: () => void;
  onOpenAddModal: (section: string) => void;
}

export default function CandidateBio({ 
  candidate, 
  candidateDetails, 
  onOpenReviewModal,
  onOpenAddModal 
}: CandidateBioProps) {
  return (
    <div className="bg-white/80 rounded-2xl shadow-xl p-6 border border-white/60 backdrop-blur-md hover:shadow-2xl transition-all duration-500">
      <h3 className="text-xl font-bold text-violet-900 mb-4 flex items-center">
        <UserGroupIcon className="w-5 h-5 mr-2" />
        About the Candidate
      </h3>
      <div className="space-y-4 text-gray-700">
        <p className="leading-relaxed">
          {candidate.name} is a {candidate.party} candidate running for office in{" "}
          {candidate.district?.name || "the district"}, {candidate.province?.name || "the province"}.
          {candidate.age && ` At ${candidate.age} years old,`} they bring{" "}
          {candidateDetails?.political_experiences?.length ? 
            `extensive political experience with ${candidateDetails.political_experiences.length} key roles` : 
            "fresh perspective to the political landscape"
          }.
        </p>
        
        {candidateDetails?.campaign_focuses?.length > 0 && (
          <p className="leading-relaxed">
            Their campaign focuses on key issues including{" "}
            {candidateDetails.campaign_focuses.slice(0, 3).map((focus: any, index: number) => (
              <span key={index}>
                <strong>{focus.title.toLowerCase()}</strong>
                {index < Math.min(2, candidateDetails.campaign_focuses.length - 1) ? ", " : ""}
                {index === 2 && candidateDetails.campaign_focuses.length > 3 ? " and more..." : ""}
              </span>
            ))}
            .
          </p>
        )}

        <div className="flex space-x-4 pt-2">
          <Button
            onClick={onOpenReviewModal}
            size="sm"
          >
            <ReviewIcon className="w-4 h-4 mr-1" />
            Rate Candidate
          </Button>
          <Link href = "/candidates/compare">
            <Button
              variant="primary"
              size="sm"
            >
              Compare with Others
            </Button>
          </Link>
        </div>
      </div>
    </div>
  );
}