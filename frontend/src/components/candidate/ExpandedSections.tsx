import PoliticalExperience from "./sections/PoliticalExperience";
import CampaignFocus from "./sections/CampaignFocus";
import PositiveContributions from "./sections/PositiveContributions";
import Controversies from "./sections/Controversies";
import Achievements from "./sections/Achievements";
import SocialMedia from "./sections/SocialMedia";
import PastElections from "./sections/PastElections";

interface ExpandedSectionsProps {
  candidate: any;
  candidateDetails: any;
  onOpenAddModal: (section: string) => void;
}

export default function ExpandedSections({ 
  candidate, 
  candidateDetails, 
  onOpenAddModal 
}: ExpandedSectionsProps) {
  return (
    <div className="mt-12 grid grid-cols-1 md:grid-cols-2 gap-8">
      <PoliticalExperience
        experiences={candidateDetails?.political_experiences || []}
        onAddExperience={() => onOpenAddModal("Political Experience")}
      />

      <CampaignFocus
        focuses={candidateDetails?.campaign_focuses || []}
        onAddFocus={() => onOpenAddModal("Campaign Focus")}
      />

      <PositiveContributions
        contributions={candidateDetails?.contributions || []}
        onAddContribution={() => onOpenAddModal("Positive Contributions")}
      />

      <Controversies
        controversies={candidateDetails?.controversies || []}
        onAddControversy={() => onOpenAddModal("Controversies")}
      />

      <SocialMedia
        candidate={candidate}
        socialLinks={candidateDetails?.social_links || {}}
        onAddSocialLinks={() => onOpenAddModal("Social Links")}
      />

      <PastElections
        pastElections={candidateDetails?.past_elections || {}}
        onAddElection={() => onOpenAddModal("Past Elections")}
      />

      <Achievements
        achievements={candidateDetails?.achievements || []}
        onAddAchievement={() => onOpenAddModal("Achievements")}
      />
    </div>
  );
}