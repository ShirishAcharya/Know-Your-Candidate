'use client';

import { useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { Suspense } from 'react';
import Button from '@/components/ui/Button';
import LoadingSpinner from '@/components/ui/LoadingSpinner';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

// Separate component that uses useSearchParams()
function ResetPasswordContent() {
  const searchParams = useSearchParams(); 
  const router = useRouter();
  const email = searchParams.get('email');

  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      alert("Passwords don't match!");
      return;
    }
    if (!email) {
      alert("Invalid link");
      return;
    }

    setLoading(true);
    try {
      const res = await fetch(`${API_BASE_URL}/auth/reset-password`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          email: email,
          new_password: password
        }),
      });

      if (res.ok) {
        setSuccess(true);
        setTimeout(() => router.push('/login'), 2000);
      } else {
        const data = await res.json();
        alert(data.detail || "Failed to reset password");
      }
    } catch (err) {
      alert("Something went wrong");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-rose-50 via-white to-pink-100 p-4">
      <div className="max-w-md w-full mx-auto">
        <div className="bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl shadow-rose-100/50 border border-white/60 p-8">
          {/* ... your existing JSX ... */}
          <div className="text-center mb-8">
            <div className="w-16 h-16 bg-gradient-to-r from-rose-400 to-pink-600 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
              <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                  d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
              </svg>
            </div>
            <h2 className="text-3xl font-bold bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent">
              Set New Password
            </h2>
            <p className="text-gray-500 mt-2">
              Enter a strong new password
            </p>
          </div>

          {!success ? (
            <form onSubmit={handleSubmit} className="space-y-6">
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="New password"
                required
                className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
              />
              <input
                type="password"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                placeholder="Confirm new password"
                required
                className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
              />

              <Button
                type="submit"
                variant="primary"
                size="lg"
                loading={loading}
                disabled={loading || !password || password !== confirmPassword}
                className="w-full text-lg font-semibold shadow-lg shadow-rose-200/60 hover:shadow-xl hover:shadow-rose-300/50"
              >
                {loading ? (
                  <div className="flex items-center justify-center gap-2">
                    <LoadingSpinner />
                    <span>Updating...</span>
                  </div>
                ) : (
                  "Reset Password"
                )}
              </Button>
            </form>
          ) : (
            <div className="text-center py-8">
              <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <svg className="w-10 h-10 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                </svg>
              </div>
              <p className="text-lg font-medium text-gray-800">Password Updated!</p>
              <p className="text-gray-600 mt-2">Redirecting to login...</p>
            </div>
          )}

          <div className="text-center mt-6">
            <a href="/auth/login" className="text-sm text-rose-600 hover:text-rose-700 font-medium">
              ← Back to Login
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}

// Main page component — only renders Suspense
export default function ResetPasswordPage() {
  return (
    <Suspense fallback={<div className="text-center py-20">Loading...</div>}>
      <ResetPasswordContent />
    </Suspense>
  );
}