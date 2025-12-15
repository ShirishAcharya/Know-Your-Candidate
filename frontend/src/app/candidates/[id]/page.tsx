"use client";

import { useEffect } from "react";
import { useParams, useRouter } from "next/navigation";
import { useSelector } from "react-redux";
import { selectCandidates } from "@/store/candidatesSlice";
import LoadingSpinner from "@/components/ui/LoadingSpinner";
import ReviewModal from "@/components/candidate/modals/ReviewModal";
import AddSectionModal from "@/components/candidate/modals/AddSectionModal";
import ImageUploadModal from "@/components/candidate/modals/ImageUploadModal";
import CandidateHeader from "@/components/candidate/CandidateHeader";
import CandidateLayout from "@/components/candidate/CandidateLayout";
import ExpandedSections from "@/components/candidate/ExpandedSections";
import { useCandidateDetails } from "@/hooks/candidate/useCandidateDetails";
import SocialLinksModal from "@/components/candidate/modals/SocialLinksModal";
import PastElectionsModal from "@/components/candidate/modals/PastElectionsModal";

export default function CandidateDetailsPage() {
  const router = useRouter();
  const params = useParams();
  const candidateId = params.id as string;
  const candidates = useSelector(selectCandidates);

  const {
    activeCandidate,
    candidateDetails,
    loading,
    reviewModal,
    addModal,
    imageModal,
    setReviewModal,
    setAddModal,
    setImageModal,
    handleSaveSection,
    handleSaveImage,
    handleRemoveImage,
    handleAddReview
  } = useCandidateDetails(candidateId, candidates);

  useEffect(() => {
    if (!loading && !activeCandidate) {
      router.push("/candidates");
    }
  }, [loading, activeCandidate, router]);

  if (loading) {
    return <LoadingState />;
  }

  if (!activeCandidate) {
    return null;
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#e0eafc] via-[#cfdef3] to-[#f9e4f7] py-10 animate-backgroundFade">
      <Modals 
        reviewModal={reviewModal}
        addModal={addModal}
        imageModal={imageModal}
        activeCandidate={activeCandidate}
        candidateDetails={candidateDetails}
        onCloseReview={() => setReviewModal(false)}
        onCloseAdd={() => setAddModal({ isOpen: false, section: "" })}
        onCloseImage={() => setImageModal(false)}
        onSaveSection={handleSaveSection}
        onSaveImage={handleSaveImage}
        onRemoveImage={handleRemoveImage}
        onAddReview={handleAddReview}
      />

      <AnimatedBackground />
      
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <CandidateHeader 
          candidate={activeCandidate} 
          onBack={() => router.push("/candidates")}
        />
        
        <CandidateLayout
          candidate={activeCandidate}
          candidateDetails={candidateDetails}
          onOpenImageModal={() => setImageModal(true)}
          onOpenReviewModal={() => setReviewModal(true)}
          onOpenAddModal={(section) => setAddModal({ isOpen: true, section })}
        />

        <ExpandedSections
          candidate={activeCandidate}
          candidateDetails={candidateDetails}
          onOpenAddModal={(section) => setAddModal({ isOpen: true, section })}
        />
      </div>

      <BackgroundStyles />
    </div>
  );
}

const LoadingState = () => (
  <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#e0eafc] via-[#cfdef3] to-[#f9e4f7] animate-backgroundFade">
    <div className="text-center w-16 h-16">
      <LoadingSpinner/>
      <p className="mt-4 text-gray-600">Loading candidate details...</p>
    </div>
  </div>
);

const Modals = ({ 
  reviewModal, 
  addModal, 
  imageModal, 
  activeCandidate,
  candidateDetails, 
  onCloseReview, 
  onCloseAdd, 
  onCloseImage, 
  onSaveSection, 
  onSaveImage, 
  onRemoveImage, 
  onAddReview 
}: any) => (
  <>
    <ReviewModal
      isOpen={reviewModal}
      onClose={onCloseReview}
      onReview={onAddReview}
    />
    
     {addModal.section !== "Social Links" && addModal.section !== "Past Elections" && (
      <AddSectionModal
        isOpen={addModal.isOpen}
        onClose={onCloseAdd}
        onSave={(data) => onSaveSection(addModal.section, data)}
        section={addModal.section}
      />
    )}

    {addModal.section === "Social Links" && (
      <SocialLinksModal
        isOpen={addModal.isOpen}
        onClose={onCloseAdd}
        onSave={(data) => onSaveSection("Social Links", data)}
        currentLinks={candidateDetails?.social_links || {}}
      />
    )}

    {addModal.section === "Past Elections" && (
      <PastElectionsModal
        isOpen={addModal.isOpen}
        onClose={onCloseAdd}
        onSave={(data) => onSaveSection("Past Elections", data)}
        currentElections={candidateDetails?.past_elections || {}}
      />
    )}

    <ImageUploadModal
      isOpen={imageModal}
      onClose={onCloseImage}
      onSave={onSaveImage}
      onRemove={onRemoveImage}
      currentImage={activeCandidate.image}
    />
  </>
);

const AnimatedBackground = () => (
  <div className="absolute inset-0 -z-10 pointer-events-none overflow-hidden">
    <span className="absolute right-0 top-0 w-72 h-72 bg-pink-200 rounded-full mix-blend-multiply filter blur-3xl opacity-40 animate-pulse" />
    <span className="absolute left-0 bottom-0 w-72 h-72 bg-blue-200 rounded-full mix-blend-multiply filter blur-3xl opacity-40 animate-pulse delay-200" />
    <span className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-purple-200 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-pulse delay-1000" />
  </div>
);

const BackgroundStyles = () => (
  <style jsx global>{`
    @keyframes backgroundFade {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }
    
    @keyframes gradient {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }
    
    .animate-backgroundFade {
      animation: backgroundFade 15s ease infinite;
      background-size: 200% 200%;
    }
    
    .animate-gradient {
      animation: gradient 3s ease infinite;
      background-size: 200% 200%;
    }
  `}</style>
);