'use client';

import React from "react";
import Link from "next/link";

interface ButtonProps {
  href?: string;
  onClick?: () => void;
  children: React.ReactNode;
  className?: string;
  variant?: "primary" | "secondary" | "outline" | "ghost" | "white"; // Added "white"
  size?: "sm" | "md" | "lg";
  disabled?: boolean;
  loading?: boolean;
}

export default function Button({
  href,
  onClick,
  children,
  className,
  variant = "primary",
  size = "md",
  disabled = false,
  loading = false,
}: ButtonProps) {
  const baseClasses = `
    inline-flex items-center justify-center font-semibold
    rounded-xl transition-all duration-200 ease-out
    focus:outline-none focus:ring-3 focus:ring-offset-2 focus:ring-offset-slate-900
    disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none
    active:scale-95 hover:scale-105
    backdrop-blur-sm border border-transparent
    relative overflow-hidden group
  `;

  const variantClasses = {
    primary: `
      bg-gradient-to-r from-cyan-500 to-blue-600
      text-white shadow-lg hover:shadow-cyan-500/30
      hover:from-cyan-400 hover:to-blue-500
      active:from-cyan-600 active:to-blue-700
      focus:ring-cyan-400
      border border-cyan-400/30
    `,
    secondary: `
      bg-slate-800/60 text-slate-200 border border-slate-600/50
      hover:bg-slate-700/70 hover:text-white
      hover:shadow-lg hover:shadow-cyan-500/20
      focus:ring-cyan-500
    `,
    outline: `
      border-2 border-cyan-500/40 bg-transparent
      text-cyan-300 hover:text-white
      hover:bg-cyan-500/10
      focus:ring-cyan-400
    `,
    ghost: `
      bg-transparent text-slate-300
      hover:bg-slate-800/60 hover:text-white
      focus:ring-slate-500
    `,
    white: `
      bg-white text-slate-800 border border-slate-200
      shadow-lg hover:shadow-xl hover:shadow-slate-400/30
      focus:ring-slate-300
    `, // ✅ White variant added
  };

  const sizeClasses = {
    sm: "px-2 py-1 text-sm min-h-[36px] gap-1",
    md: "px-3 py-2 text-base min-h-[44px] gap-2",
    lg: "px-5 py-3 text-lg min-h-[52px] gap-2",
  };

  const LoadingSpinner = () => (
    <div className="absolute inset-0 flex items-center justify-center bg-inherit rounded-xl">
      <div className="w-4 h-4 border-2 border-current border-t-transparent rounded-full animate-spin" />
    </div>
  );

  const RippleEffect = () => (
    <span className="absolute inset-0 overflow-hidden rounded-xl">
      <span className="absolute inset-0 bg-gradient-to-r from-white/10 to-transparent 
        transform -translate-x-full group-hover:translate-x-full transition-transform duration-1000" />
    </span>
  );

  const combinedClasses = `
    ${baseClasses}
    ${variantClasses[variant]}
    ${sizeClasses[size]}
    ${disabled ? "opacity-50 cursor-not-allowed" : "cursor-pointer"}
    ${className || ""}
  `.replace(/\s+/g, " ").trim();

  const content = (
    <>
      <RippleEffect />
      {loading && <LoadingSpinner />}
      <span
        className={`inline-flex items-center justify-center gap-2 
        ${loading ? "opacity-0" : "opacity-100"} transition-opacity`}
      >
        {children}
      </span>
    </>
  );

  if (href && !disabled) {
    return (
      <Link href={href} className={combinedClasses} onClick={onClick}>
        {content}
      </Link>
    );
  }

  return (
    <button onClick={onClick} className={combinedClasses} disabled={disabled || loading}>
      {content}
    </button>
  );
}
