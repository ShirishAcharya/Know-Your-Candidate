import { useState, useEffect } from "react";
import { useDispatch} from "react-redux";
import { Candidate, CandidateDetails } from "@/types/candidate";
import { updateCandidateImage } from "@/store/candidatesSlice";

export function useCandidateDetails(candidateId: string, candidates: Candidate[]) {
  const [activeCandidate, setActiveCandidate] = useState<Candidate | null>(null);
  const [candidateDetails, setCandidateDetails] = useState<CandidateDetails | null>(null);
  const [reviewModal, setReviewModal] = useState(false);
  const [addModal, setAddModal] = useState({ isOpen: false, section: "" });
  const [imageModal, setImageModal] = useState(false);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [imageLoading, setImageLoading] = useState(false);

  const candidate = candidates.find((c: Candidate) => c.id.toString() === candidateId);
  const dispatch = useDispatch();

  let response : Response;
  
  useEffect(() => {
    setLoading(true);

    const id = Number(candidateId);

    const fromRedux = candidates.find(c => c.id === id);
    if (fromRedux) {
      setActiveCandidate(fromRedux);
    }

    fetch(`/api/candidates/${id}/personal`)
      .then(r => {
        if (!r.ok) throw new Error("Personal not found");
        return r.json();
      })
      .then(data => {
        setActiveCandidate(data);
      })
      .catch(err => {
        console.log("Personal fetch failed", err);
      });

    fetch(`/api/candidate-details/${id}`)
      .then(r => {
        if (!r.ok) {
          console.log("No details yet (normal for new candidates)");
          return null;
        }
        return r.json();
      })
      .then(data => {
        if (data) {
          console.log("Full details loaded:", data);
          setCandidateDetails(data);
        }
      })
      .catch(err => {
        console.log("Details fetch error:", err);
      })
      .finally(() => {
        setLoading(false);
      });

  }, [candidateId, candidates]);

  const handleSaveSection = async (section: string, data: any[] | object) => {
  if (!activeCandidate) return;

  try {
    setSaving(true);

    let endpoint = "";
    const payload: CandidateDetails = {
      candidate_id: activeCandidate.id,
      political_experiences: candidateDetails?.political_experiences || [],
      campaign_focuses: candidateDetails?.campaign_focuses || [],
      contributions: candidateDetails?.contributions || [],
      controversies: candidateDetails?.controversies || [],
      achievements: candidateDetails?.achievements || [],
      past_elections: candidateDetails?.past_elections || {},
      social_links: candidateDetails?.social_links || {},
      overall_rating: candidateDetails?.overall_rating || 0,
      total_ratings: candidateDetails?.total_ratings || 0, 
    };

    // Handle different sections
    switch (section) {
      case "Political Experience":
        endpoint = "political-experience";
        payload.political_experiences = data as any[];
        break;
      case "Campaign Focus":
        endpoint = "campaign-focus";
        payload.campaign_focuses = data as any[];
        break;
      case "Positive Contributions":
        endpoint = "contributions";
        payload.contributions = data as any[];
        break;
      case "Controversies":
        endpoint = "controversies";
        payload.controversies = data as any[];
        break;
      case "Achievements":
        endpoint = "achievements";
        payload.achievements = data as any[];
        break;
      case "Social Links":
        endpoint = "social-links"; 
        payload.social_links = data;
        break;
      case "Past Elections":
        endpoint = "past-elections";
        payload.past_elections = data;
        break;
      default:
        throw new Error("Invalid section");
    }

    if (section === "Social Links" || section === "Past Elections") {
      const field = section === "Social Links" ? "social_links" : "past_elections";
      const endpoint = `/api/candidate-details/${field.toLowerCase().replace('_', '-')}`;

      const minimalPayload = {
          candidate_id: activeCandidate.id,
          [field]: data,
        };

      response = await fetch(endpoint, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(minimalPayload),
      });

      if (response.status === 404) {
        response = await fetch("/api/candidate-details/", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
      }
    }

    if (response.ok) {
      const responseText = await response.text();
      
      try {
        const savedDetails = responseText ? JSON.parse(responseText) : null;
        
        if (savedDetails) {
          setCandidateDetails(savedDetails);
        } else {
          // If no response body, update state manually
          setCandidateDetails(payload);
        }
        
        setAddModal({ isOpen: false, section: "" });
        alert(`${section} saved successfully!`);
      } catch (parseError) {
        console.error("Failed to parse response:", parseError);
        console.error("Response text:", responseText);
        
        // Update state manually if parsing fails
        setCandidateDetails(payload);
        setAddModal({ isOpen: false, section: "" });
        alert(`${section} saved successfully!`);
      }
    } else {
      const errorText = await response.text();
      console.error("Save failed:", errorText);
      alert(`Failed to save ${section}: ${errorText || 'Unknown error'}`);
    }
  } catch (error) {
    console.error("Exception:", error);
    alert(`Error saving candidate details: ${error}`);
  } finally {
    setSaving(false);
  }
};

  const handleSaveImage = async (imageFile: File) => {
    if (!activeCandidate) return;

    try {
      setImageLoading(true);

      const formData = new FormData();
      formData.append("file", imageFile);
      formData.append("candidate_id", activeCandidate.id.toString());

      const response = await fetch("/api/candidates/upload-candidate-image", {
        method: "POST",
        body: formData,
        credentials: "include",
      });

      if (response.ok) {
        const result = await response.json();

        // THIS LINE UPDATES THE LIST PAGE INSTANTLY
        dispatch(updateCandidateImage({
          candidateId: activeCandidate.id,
          imageUrl: result.image_url
        }));

        // Update the details page too
        setActiveCandidate({ ...activeCandidate, image: result.image_url });

        alert("Image uploaded successfully!");
        setImageModal(false);
      } else {
        const errorData = await response.json();
        console.error("Failed to upload image:", errorData);
        alert(`Failed to upload image: ${errorData.detail || "Unknown error"}`);
      }
    } catch (error) {
      console.error("Error uploading image:", error);
      alert("Error uploading image");
    } finally {
      setImageLoading(false);
    }
  };


  const fetchCandidateImage = async (candidate_id: number) => {
    try {
      const response = await fetch(`/api/candidates/${candidate_id}/personal`,{
      // credentials: "include",
    });
      
      if (response.ok) {
        const candidateData = await response.json();
        
        if (candidateData.image) {
          setActiveCandidate(prev => ({
            ...prev!,
            image: candidateData.image
          }));
        }
      }
    } catch (error) {
      console.log("No image found or failed to fetch candidate for image");
    }
  };

  const handleRemoveImage = async () => {
    if (!activeCandidate || !activeCandidate.image) return;

    try {
      setImageLoading(true);

      const formData = new FormData();
      formData.append("candidate_id", activeCandidate.id.toString());

      const response = await fetch("/api/candidates/remove-candidate-image", {
        method: "DELETE",
        body: formData,
      });

      if (response.ok) {
        setActiveCandidate({ ...activeCandidate, image: undefined });
        alert("Image removed successfully!");
        setImageModal(false);
      } else {
        const errorData = await response.json();
        console.error("Failed to remove image:", errorData);
        alert(`Failed to remove image: ${errorData.detail || "Unknown error"}`);
      }
    } catch (error) {
      console.error("Error removing image:", error);
      alert("Error removing image");
    } finally {
      setImageLoading(false);
    }
  };

  const handleAddReview = async (review: { rating: number; comment?: string }) => {
    if (!activeCandidate) return;

    try {
      const response = await fetch(`/api/candidate-details/rate`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          candidate_id: activeCandidate.id,
          rating: review.rating,
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.detail || "Failed to submit rating");
      }

      const updated = await response.json();

      // Update UI instantly
      setCandidateDetails(prev => prev ? {
        ...prev,
        overall_rating: updated.overall_rating,
        total_ratings: updated.total_ratings,
      } : prev);

      alert("Thank you! Your rating has been submitted.");
      setReviewModal(false);
    } catch (error: any) {
      console.error(error);
      alert("Error: " + error.message);
    }
  };

  return {
    activeCandidate,
    candidateDetails,
    loading,
    saving,
    imageLoading,
    reviewModal,
    addModal,
    imageModal,
    setReviewModal,
    setAddModal,
    setImageModal,
    handleSaveSection,
    handleSaveImage,
    fetchCandidateImage,
    handleRemoveImage,
    handleAddReview,
  };
}