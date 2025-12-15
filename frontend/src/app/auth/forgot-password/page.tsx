'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Button from '@/components/ui/Button';
import LoadingSpinner from '@/components/ui/LoadingSpinner';

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) return;

    setLoading(true);
    try {
      const res = await fetch(`${API_BASE_URL}/auth/forgot-password`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email }),
      });

      if (res.ok) {
        setSent(true);
        // Auto-redirect to OTP page after 1.5s
        setTimeout(() => {
          router.push(`/auth/verify-otp?email=${encodeURIComponent(email)}&purpose=reset_password`);
        }, 1500);
      } else {
        alert('If this email exists, an OTP has been sent.');
        setTimeout(() => {
          router.push(`/auth/verify-otp?email=${encodeURIComponent(email)}&purpose=reset_password`);
        }, 1000);
      }
    } catch (err) {
      alert('Something went wrong. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-rose-50 via-white to-pink-100 p-4">
      <div className="max-w-md w-full mx-auto">
        <div className="bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl shadow-rose-100/50 border border-white/60 p-8">

          <div className="text-center mb-8">
            <div className="w-16 h-16 bg-gradient-to-r from-rose-400 to-pink-600 rounded-2xl flex items-center justify-center mx-auto mb-4 shadow-lg">
              <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                  d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" />
              </svg>
            </div>
            <h2 className="text-3xl font-bold bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent">
              Reset Password
            </h2>
            <p className="text-gray-500 mt-2">
              Enter your email and we’ll send you an OTP
            </p>
          </div>

          {!sent ? (
            <form onSubmit={handleSubmit} className="space-y-6">
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="your@email.com"
                required
                className="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white/50 focus:bg-white focus:border-rose-300 focus:ring-3 focus:ring-rose-100 transition-all duration-200 outline-none placeholder-gray-400"
              />

              <Button
                type="submit"
                variant="primary"
                size="lg"
                loading={loading}
                disabled={loading || !email}
                className="w-full text-lg font-semibold shadow-lg shadow-rose-200/60 hover:shadow-xl hover:shadow-rose-300/50"
              >
                {loading ? (
                  <div className="flex items-center justify-center gap-2">
                    <LoadingSpinner />
                    <span>Sending OTP...</span>
                  </div>
                ) : (
                  "Send OTP"
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
              <p className="text-lg font-medium text-gray-800">OTP Sent!</p>
              <p className="text-gray-600 mt-2">Redirecting you to verify...</p>
            </div>
          )}

          <div className="text-center mt-6">
            <a href="/login" className="text-sm text-rose-600 hover:text-rose-700 font-medium">
              ← Back to Login
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}