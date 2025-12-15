import LinkIcon from "@/layout/icons/LinkIcon";
import FacebookIcon from "@/layout/icons/FacebookIcon";
import InstagramIcon from "@/layout/icons/InstagramIcon";
import XIcon from "@/layout/icons/XIcon";
import SocialLink from "../ui/SocialLink";
import Button from "@/components/ui/Button";
import PlusIcon from "@/layout/icons/PlusIcon";

interface SocialMediaProps {
  candidate: any;
  socialLinks: any;
  onAddSocialLinks: () => void;
}

export default function SocialMedia({ candidate, socialLinks, onAddSocialLinks }: SocialMediaProps) {
  const hasLinks = socialLinks.facebook || socialLinks.X || socialLinks.instagram;

  return (
    <div className="bg-white/80 rounded-2xl shadow-xl p-7 border border-white/70 backdrop-blur-md hover:shadow-2xl transition-all duration-500">
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-xl font-bold text-violet-900 flex items-center">
          <LinkIcon className="w-6 h-6 mr-3 text-violet-700" />
          Connect with {candidate.name.split(" ")[0]}
        </h3>
        <Button
          onClick={onAddSocialLinks}
          size="sm"
          variant={hasLinks ? "outline" : "primary"}
        >
          <PlusIcon className="w-4 h-4 mr-1" />
          {hasLinks ? "Edit Links" : "Add Links"}
        </Button>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        {socialLinks.facebook && (
          <SocialLink
            href={socialLinks.facebook}
            icon={FacebookIcon}
            label="Facebook"
            color="hover:text-blue-600"
          />
        )}
        {socialLinks.X && (
          <SocialLink
            href={socialLinks.X}
            icon={XIcon}
            label="X"
            color="hover:text-blue-400"
          />
        )}
        {socialLinks.instagram && (
          <SocialLink
            href={socialLinks.instagram}
            icon={InstagramIcon}
            label="Instagram"
            color="hover:text-pink-600"
          />
        )}
        {!hasLinks && (
          <div className="col-span-3 text-center py-8">
            <LinkIcon className="w-12 h-12 text-gray-300 mx-auto mb-3" />
            <p className="text-gray-400 italic">No social media links yet</p>
            <Button
              onClick={onAddSocialLinks}
              variant="outline"
              size="sm"
              className="mt-4"
            >
              <PlusIcon className="w-4 h-4 mr-1" />
              Add Social Links
            </Button>
          </div>
        )}
      </div>
    </div>
  );
}