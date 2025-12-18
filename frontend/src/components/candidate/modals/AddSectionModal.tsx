"use client";

import { useState } from "react";
import Button from "@/components/ui/Button";
import LoadingSpinner from "@/components/ui/LoadingSpinner";
import PlusIcon from "@/layout/icons/PlusIcon";
import SaveIcon from "@/layout/icons/SaveIcon";
import { getEmptyItemForSection, getFieldLabels } from "@/utils/candidate/sectionHelpers";

interface AddSectionModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSave: (data: any) => void;
  section: string;
}

export default function AddSectionModal({ isOpen, onClose, onSave, section }: AddSectionModalProps) {
  const [items, setItems] = useState<any[]>([getEmptyItemForSection(section)]);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const addEmptyItem = () => {
    const emptyItem = getEmptyItemForSection(section);
    setItems([...items, emptyItem]);
  };

  const updateItem = (index: number, field: string, value: string) => {
    const updatedItems = [...items];
    updatedItems[index] = { ...updatedItems[index], [field]: value };
    setItems(updatedItems);
  };

  const removeItem = (index: number) => {
    const updatedItems = items.filter((_, i) => i !== index);
    setItems(updatedItems);
  };

  // const handleSubmit = async (e: React.FormEvent) => {
    // e.preventDefault();
    // e.stopPropagation(); // Prevent event bubbling

  const handleSubmit = async () => {   
    // Filter out empty items before saving
    const nonEmptyItems = items.filter(item => 
      Object.values(item).some(val => val && val.toString().trim() !== '')
    );

    if (nonEmptyItems.length === 0) {
      alert("Please add at least one item before saving.");
      return;
    }

    setIsSubmitting(true);
    try {
      await onSave(nonEmptyItems);
      // Reset form after successful save
      setItems([getEmptyItemForSection(section)]);
    } catch (error) {
      console.error("Error saving items:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleClose = () => {
    // Reset form when closing without saving
    setItems([getEmptyItemForSection(section)]);
    onClose();
  };

  // Handle click outside to close
  const handleBackdropClick = (e: React.MouseEvent) => {
    if (e.target === e.currentTarget) {
      handleClose();
    }
  };

  if (!isOpen) return null;

  const fieldLabels = getFieldLabels(section);

  return (
    <div 
      className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4"
      onClick={handleBackdropClick}
    >
      <div 
        className="bg-white rounded-2xl p-6 w-full max-w-2xl max-h-[90vh] overflow-y-auto shadow-2xl"
        onClick={(e) => e.stopPropagation()} // Prevent closing when clicking inside
      >
        <h3 className="text-xl font-bold text-violet-900 mb-4">
          Add {section}
        </h3>
        
        {/* Remove the form wrapper and handle submission manually */}
        <div className="space-y-4">
          <div className="space-y-4 max-h-96 overflow-y-auto">
            {items.map((item, index) => (
              <div key={index} className="p-4 border border-gray-200 rounded-lg space-y-3">
                <div className="flex justify-between items-center">
                  <h4 className="font-semibold text-gray-700">Item {index + 1}</h4>
                  {items.length > 1 && (
                    <Button
                      type="button"
                      variant="ghost"
                      size="sm"
                      onClick={() => removeItem(index)}
                      className="text-red-600 hover:text-red-800"
                    >
                      Remove
                    </Button>
                  )}
                </div>
                
                {fieldLabels.map((field) => (
                  <div key={field}>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      {field}
                    </label>
                    {field === "Description" ? (
                      <textarea
                        value={item[field.toLowerCase()] || ""}
                        onChange={(e) => updateItem(index, field.toLowerCase(), e.target.value)}
                        placeholder={`Enter ${field.toLowerCase()}...`}
                        rows={3}
                        className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-violet-500 focus:border-transparent"
                      />
                    ) : (
                      <input
                        type={field === "Year" || field === "Priority" ? "number" : "text"}
                        value={item[field.toLowerCase()] || ""}
                        onChange={(e) => updateItem(index, field.toLowerCase(), e.target.value)}
                        placeholder={`Enter ${field.toLowerCase()}...`}
                        className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-violet-500 focus:border-transparent"
                      />
                    )}
                  </div>
                ))}
              </div>
            ))}
          </div>

          <Button
            type="button"
            variant="outline"
            onClick={addEmptyItem}
            className="w-full"
            disabled={isSubmitting}
          >
            <PlusIcon className="w-4 h-4 mr-2" />
            Add Another Item
          </Button>

          <div className="flex space-x-3 pt-4">
            <Button
              type="button" // Change to button and handle click manually
              onClick={handleSubmit}
              className="flex-1"
              disabled={isSubmitting}
            >
              {isSubmitting ? (
                <LoadingSpinner size="sm" className="mr-2" />
              ) : (
                <SaveIcon className="w-4 h-4 mr-2" />
              )}
              {isSubmitting ? 'Saving...' : `Save ${section}`}
            </Button>
            <Button
              type="button"
              variant="outline"
              onClick={handleClose}
              className="flex-1"
              disabled={isSubmitting}
            >
              Cancel
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}