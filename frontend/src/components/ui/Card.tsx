// src/components/ui/Card.tsx
"use client";
import React from "react";

interface CardProps {
  title: string;
  subtitle?: string;
  image?: string;
  footer?: string | React.ReactNode;
  extra?: React.ReactNode; // for buttons, badges, etc.
  onClick?: () => void;
  className?: string;
}

export default function Card({
  title,
  subtitle,
  image,
  footer,
  extra,
  onClick,
  className = "",
}: CardProps) {
  return (
    <div
      onClick={onClick}
      className={`group relative bg-white rounded-2xl border border-gray-100 shadow-sm hover:shadow-2xl 
        transition-all duration-500 ease-out hover:-translate-y-2 overflow-hidden
        ${onClick ? "cursor-pointer hover:border-gray-200" : ""} ${className}`}
    >
      {/* Background gradient effect on hover */}
      <div className="absolute inset-0 bg-gradient-to-br from-white via-white to-gray-50 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />

      {/* Image Section */}
      <div className="relative overflow-hidden rounded-xl mb-6 bg-gradient-to-br from-gray-50 to-gray-100">
        {image ? (
          <img
            src={image}
            alt={title}
            className="w-full h-48 object-contain transition-transform duration-700 group-hover:scale-105"
          />
        ) : (
          <div className="w-full h-48 flex flex-col items-center justify-center bg-gradient-to-br from-gray-50 to-gray-100 text-gray-400">
            <svg className="w-12 h-12 mb-3 opacity-60" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>
            <span className="text-sm font-medium">No Image Available</span>
          </div>
        )}
        
        {/* Overlay gradient on image hover */}
        <div className="absolute inset-0 bg-gradient-to-t from-black/10 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
      </div>
      
      {/* Content Section */}
      <div className="relative px-6 pb-6">
        {/* Title with elegant underline effect */}
        <div className="mb-3">
          <h3 className="font-bold text-xl text-gray-900 line-clamp-2 leading-tight mb-2">
            {title}
          </h3>
          <div className="w-12 h-1 bg-gradient-to-r from-blue-500 to-purple-500 rounded-full opacity-80 group-hover:w-16 transition-all duration-500" />
        </div>

        {/* Subtitle with icon */}
        {subtitle && (
          <div className="flex items-center mb-4">

            <p className="text-blue-600 font-semibold text-sm">{subtitle}</p>
          </div>
        )}

        {/* Footer with subtle styling */}
        {footer && (
          <div className="text-gray-500 text-sm border-t border-gray-100 pt-4 mt-4">
            {footer}
          </div>
        )}

        {/* Extra content area */}
        {extra && (
          <div className="mt-5 pt-4 border-t border-gray-100">
            {extra}
          </div>
        )}
      </div>

      {/* Hover border effect */}
      <div className="absolute inset-0 rounded-2xl border-2 border-transparent group-hover:border-gradient-to-r group-hover:from-blue-500/10 group-hover:to-purple-500/10 transition-all duration-500 pointer-events-none" />
    </div>
  );
}