"use client";

import { useState, useEffect } from "react";
import Button from "@/components/ui/Button";
import LoadingSpinner from "@/components/ui/LoadingSpinner";
import CameraIcon from "@/layout/icons/CameraIcon";
import SaveIcon from "@/layout/icons/SaveIcon";
import DeleteIcon from "@/layout/icons/DeleteIcon";

interface ImageUploadModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSave: (imageFile: File) => void;
  onRemove: () => void;
  currentImage?: string;
  loading?: boolean;
}

export default function ImageUploadModal({ 
  isOpen, 
  onClose, 
  onSave, 
  onRemove, 
  currentImage, 
  loading 
}: ImageUploadModalProps) {
  const [previewUrl, setPreviewUrl] = useState<string>(currentImage || "");
  const [selectedFile, setSelectedFile] = useState<File | null>(null);

  // Reset state when modal opens or currentImage changes
  useEffect(() => {
    if (isOpen) {
      setSelectedFile(null);
      setPreviewUrl(currentImage || "");
    }
  }, [isOpen, currentImage]);

  // Cleanup object URLs on unmount
  useEffect(() => {
    return () => {
      if (previewUrl.startsWith('blob:')) {
        URL.revokeObjectURL(previewUrl);
      }
    };
  }, [previewUrl]);

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      // Check if file is an image
      if (!file.type.startsWith('image/')) {
        alert('Please select an image file');
        return;
      }

      // Check file size (max 5MB)
      if (file.size > 5 * 1024 * 1024) {
        alert('Image size should be less than 5MB');
        return;
      }

      // Clean up previous blob URL if it exists
      if (previewUrl.startsWith('blob:')) {
        URL.revokeObjectURL(previewUrl);
      }

      setSelectedFile(file);
      const objectUrl = URL.createObjectURL(file);
      setPreviewUrl(objectUrl);
    }
  };

  const handleSave = () => {
    if (selectedFile) {
      onSave(selectedFile);
    } else {
      alert('Please select an image first');
    }
  };

  // const handleRemoveImage = () => {
  //   // Clean up blob URL if it exists
  //   if (previewUrl.startsWith('blob:')) {
  //     URL.revokeObjectURL(previewUrl);
  //   }
    
  //   onRemove();
  //   setSelectedFile(null);
  //   setPreviewUrl("");
  // };

  const handleClose = () => {
    // Clean up object URL if created
    if (previewUrl.startsWith('blob:')) {
      URL.revokeObjectURL(previewUrl);
    }
    
    setSelectedFile(null);
    setPreviewUrl(currentImage || "");
    onClose();
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl p-6 w-96 shadow-2xl">
        <h3 className="text-xl font-bold text-violet-900 mb-4">
          {currentImage ? 'Edit Candidate Image' : 'Add Candidate Image'}
        </h3>
        
        <div className="space-y-4">
          {/* Image Preview */}
          <div className="flex justify-center">
            <div className="w-48 h-48 border-2 border-dashed border-gray-300 rounded-2xl overflow-hidden bg-gray-50 flex items-center justify-center">
              {previewUrl ? (
                <img 
                  src={previewUrl} 
                  alt="Preview" 
                  className="w-full h-full object-cover"
                />
              ) : (
                <div className="text-center text-gray-400">
                  <CameraIcon className="w-12 h-12 mx-auto mb-2" />
                  <p className="text-sm">No image selected</p>
                </div>
              )}
            </div>
          </div>

          {/* File Input */}
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Choose Image
            </label>
            <input
              type="file"
              accept="image/*"
              onChange={handleFileSelect}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-violet-500 focus:border-transparent"
              disabled={loading}
            />
            <p className="text-xs text-gray-500 mt-1">
              Supported formats: JPG, PNG, WebP. Max size: 5MB
            </p>
          </div>

          {/* Show selected file info */}
          {selectedFile && (
            <div className="text-sm text-green-600 bg-green-50 p-2 rounded-lg">
              ✓ Selected: {selectedFile.name} ({(selectedFile.size / 1024).toFixed(2)} KB)
            </div>
          )}

          {/* Action Buttons */}
          <div className="flex space-x-3 pt-4">
            <Button
              onClick={handleSave}
              disabled={!selectedFile || loading}
              className="flex-1"
            >
              {loading ? (
                <LoadingSpinner size="sm" className="mr-2" />
              ) : (
                <SaveIcon className="w-4 h-4 mr-2" />
              )}
              {loading ? 'Uploading...' : 'Save Image'}
            </Button>
            {/* {currentImage && (
              <Button
                type="button"
                variant="outline"
                onClick={handleRemoveImage}
                disabled={loading}
                className="flex-1"
              >
                <DeleteIcon className="w-4 h-4 mr-2" />
                Remove
              </Button>
            )} */}
            <Button
              type="button"
              variant="ghost"
              onClick={handleClose}
              disabled={loading}
              className="flex-1"
            >
              Cancel
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}