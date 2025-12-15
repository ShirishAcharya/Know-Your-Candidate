'use client';

import { useState } from 'react';
import Button from '@/components/ui/Button';

interface SocialLinksModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSave: (data: { facebook?: string; X?: string; instagram?: string }) => void;
  currentLinks: { facebook?: string; X?: string; instagram?: string };
}

export default function SocialLinksModal({ isOpen, onClose, onSave, currentLinks }: SocialLinksModalProps) {
  const [formData, setFormData] = useState(currentLinks);

  const handleSave = () => {
    onSave(formData);
    onClose();
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl p-8 max-w-md w-full">
        <h3 className="text-2xl font-bold mb-6">Edit Social Links</h3>
        <div className="space-y-4">
          <input
            type="url"
            placeholder="Facebook URL"
            value={formData.facebook || ""}
            onChange={(e) => setFormData({ ...formData, facebook: e.target.value })}
            className="w-full p-3 border rounded-lg"
          />
          <input
            type="url"
            placeholder="X (Twitter) URL"
            value={formData.X || ""}
            onChange={(e) => setFormData({ ...formData, X: e.target.value })}
            className="w-full p-3 border rounded-lg"
          />
          <input
            type="url"
            placeholder="Instagram URL"
            value={formData.instagram || ""}
            onChange={(e) => setFormData({ ...formData, instagram: e.target.value })}
            className="w-full p-3 border rounded-lg"
          />
        </div>
        <div className="flex gap-3 mt-6">
          <Button onClick={handleSave} className="flex-1">Save</Button>
          <Button variant="outline" onClick={onClose} className="flex-1">Cancel</Button>
        </div>
      </div>
    </div>
  );
}