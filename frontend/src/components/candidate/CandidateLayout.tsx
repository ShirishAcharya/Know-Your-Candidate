import { useRouter } from "next/navigation";
import Card from "@/components/ui/Card";
import Button from "@/components/ui/Button";
import EditIcon from "@/layout/icons/EditIcon";
import CameraIcon from "@/layout/icons/CameraIcon";
import LocationIcon from "@/layout/icons/LocationIcon";
import QuickStats from "./QuickStats";
import CandidateBio from "./CandidateBio";
import InfoPanel from "./InfoPanel";

interface CandidateLayoutProps {
  candidate: any;
  candidateDetails: any;
  onOpenImageModal: () => void;
  onOpenReviewModal: () => void;
  onOpenAddModal: (section: string) => void;
}

export default function CandidateLayout({
  candidate,
  candidateDetails,
  onOpenImageModal,
  onOpenReviewModal,
  onOpenAddModal
}: CandidateLayoutProps) {
  const router = useRouter();

  return (
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-8 relative z-10">
      {/* Left: Candidate Card */}
      <div className="lg:col-span-2">
        <div className="relative group">
          <Card
            title={candidate.name}
            subtitle={candidate.party}
            image={candidate.image}
            footer={
              <div className="flex items-center justify-between">
                <span className="flex items-center text-gray-600 font-medium">
                  <LocationIcon className="w-4 h-4 mr-2" />
                  {candidate.birthplace || "N/A"},{" "}
                  {/* {candidate.constituency?.constituency || "N/A"} */}
                </span>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => router.push("/candidates")}
                >
                  Back to List
                </Button>
              </div>
            }
          />
          
          {/* Image Edit Overlay */}
          <div className="absolute top-4 right-4 opacity-0 group-hover:opacity-100 transition-opacity duration-300">
            <Button
              onClick={onOpenImageModal}
              size="sm"
              className="bg-white/90 backdrop-blur-sm border border-white/70 shadow-lg hover:shadow-xl hover:bg-white"
            >
              <EditIcon className="w-4 h-4 mr-1" />
              {candidate.image ? 'Edit Image' : 'Add Image'}
            </Button>
          </div>

          {/* Add Image Button (shown when no image exists) */}
          {!candidate.image && (
            <div className="absolute inset-0 flex items-center justify-center bg-black/20 rounded-2xl">
              <Button
                onClick={onOpenImageModal}
                className="bg-white/90 backdrop-blur-sm border border-white/70 shadow-lg hover:shadow-xl hover:bg-white"
              >
                <CameraIcon className="w-5 h-5 mr-2" />
                Add Candidate Image
              </Button>
            </div>
          )}
        </div>
        
        {/* Content below the card */}
        <div className="mt-8 space-y-8">
          <QuickStats candidateDetails={candidateDetails} />
          <CandidateBio 
            candidate={candidate}
            candidateDetails={candidateDetails}
            onOpenReviewModal={onOpenReviewModal}
            onOpenAddModal={onOpenAddModal}
          />
        </div>
      </div>

      {/* Right: Info Panel */}
      <InfoPanel 
        candidate={candidate}
        candidateDetails={candidateDetails}
        onOpenReviewModal={onOpenReviewModal}
      />
    </div>
  );
}