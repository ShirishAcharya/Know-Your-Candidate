"use client";
import React from "react";

interface GradientTextProps {
  children: React.ReactNode;
  className?: string;
}

export default function GradientText({ 
  children, 
  className = "" 
}: GradientTextProps) {
  return (
    <span
      className="p-1 font-serif font-bold text-1xl sm:text-3xl tracking-wide
                 bg-clip-text text-transparent bg-gradient-to-r from-rose-500 via-rose-400 to-rose-500
                 drop-shadow-md
                 transition-all duration-500 ease-in-out hover:scale-105 hover:drop-shadow-lg"
    >
      {children}
    </span>
  );
}
