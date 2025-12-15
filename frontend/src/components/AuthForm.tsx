"use client";

import { useState } from "react";
import LoadingSpinner from "@/components/ui/LoadingSpinner";
import Button from "@/components/ui/Button";
import { div } from "framer-motion/client";

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

interface AuthFormProps {
  mode: "login" | "register";
  onSubmit: (formData: { name?: string; email: string; password: string }) => Promise<boolean>;
}

export default function AuthForm({ mode, onSubmit }: AuthFormProps) {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
  });
  const [loading, setLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (mode === "register" && formData.password !== formData.confirmPassword) {
      alert("Passwords do not match!");
      return;
    }

    setLoading(true);
    try {
      const success = await onSubmit(formData);

      // Reset fields only if submission was successful
      if (success) {
        setFormData({
          name: "",
          email: "",
          password: "",
          confirmPassword: "",
        });
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-rose-50 via-white to-pink-100 p-4">
      <div className="max-w-md w-full mx-auto">
        {/* Card Container */}
        <div className="bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl shadow-rose-100/50 border border-white/60 p-8">
          {/* Header */}
          <div className="text-center mb-8">
            <div className="w-16 h-16 bg-gradient-to-r from-rose-400 to-pink-600 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
              <svg
                className="w-8 h-8 text-white"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
                />
              </svg>
            </div>
            <h2 className="text-3xl font-bold bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent">
              {mode === "login" ? "Welcome Back" : "Create Account"}
            </h2>
            <p className="text-gray-500 mt-2">
              {mode === "login" ? "Sign in to your account" : "Join us today"}
            </p>
          </div>

          {/* Form */}
          <form onSubmit={handleSubmit} className="space-y-6">
            {mode === "register" && (
              <div className="space-y-2">
                <label className="block text-sm font-semibold text-gray-700">
                  Full Name
                </label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  required
                  className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
                  placeholder="Enter your full name"
                />
              </div>
            )}

            <div className="space-y-2">
              <label className="block text-sm font-semibold text-gray-700">
                Email Address
              </label>
              <input
                type="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                required
                className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
                placeholder="Enter your email"
              />
            </div>

            <div className="space-y-2">
              <label className="block text-sm font-semibold text-gray-700">
                Password
              </label>
              <input
                type="password"
                name="password"
                value={formData.password}
                onChange={handleChange}
                required
                className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
                placeholder="Enter your password"
              />
            </div>

            {mode === "register" && (
              <div className="space-y-2">
                <label className="block text-sm font-semibold text-gray-700">
                  Confirm Password
                </label>
                <input
                  type="password"
                  name="confirmPassword"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  required
                  className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
                  placeholder="Confirm your password"
                />
              </div>
            )}
            
            {mode == "login" && (
              <div className="text-center mt-4">
                <button
                  type="button"
                  onClick={() => {
                    window.location.href = `/auth/forgot-password`;
                  }}
                  className="text-sm text-rose-600 font-medium hover:text-rose-700 underline underline-offset-4 transition-colors"
                >
                  Forgot Password?
                </button>
              </div>
            )}

            {/* Submit Button */}
            <div className="pt-4">
              <Button
                type="submit"
                variant="primary"
                size="lg"
                loading={loading}
                disabled={loading}
                className="w-full text-lg font-semibold shadow-lg shadow-rose-200/60 hover:shadow-xl hover:shadow-rose-300/50 transition-all duration-300"
              >
                {loading ? (
                  <div className="flex items-center justify-center gap-2">
                    <LoadingSpinner />
                    <span>
                      {mode === "login" ? "Signing in..." : "Creating account..."}
                    </span>
                  </div>
                ) : mode === "login" ? (
                  "Sign In"
                ) : (
                  "Create Account"
                )}
              </Button>
            </div>

            {/* Additional Links */}
            <div className="text-center pt-4">
              <p className="text-gray-600">
                {mode === "login" ? "Don't have an account?" : "Already have an account?"}{" "}
                <a
                  href="/register"
                  className="font-semibold text-rose-500 hover:text-rose-600 transition-colors duration-200 underline-offset-2 hover:underline"
                >
                  {mode === "login" ? "Sign up" : "Sign in"}
                </a>
              </p>
            </div>

            <button
              type="button"
              onClick={() => {
                window.location.href = `${API_BASE_URL}/users/auth/google/login`;
              }}
              className="w-full bg-red-500 text-white py-2 rounded-md"
            >
              Continue with Google
            </button>

          </form>

          {/* Footer */}
          <div className="mt-8 pt-6 border-t border-gray-100 text-center">
            <p className="text-xs text-gray-400">
              By continuing, you agree to our{" "}
              <a href="#" className="text-gray-500 hover:text-gray-700 underline">
                Terms
              </a>{" "}
              and{" "}
              <a href="#" className="text-gray-500 hover:text-gray-700 underline">
                Privacy Policy
              </a>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
