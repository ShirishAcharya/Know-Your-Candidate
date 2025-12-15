'use client';

import { useSearchParams, useRouter } from 'next/navigation';
import { useState, useEffect } from 'react';

export default function VerifyOTPPage() {
  const searchParams = useSearchParams();
  const router = useRouter();
  const email = searchParams.get('email');
  const purpose = searchParams.get('purpose') as 'register' | 'reset_password';
  const [otp, setOtp] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [seconds, setSeconds] = useState(purpose === 'register' ? 180 : 60);

  useEffect(() => {
    const timer = setInterval(() => {
      setSeconds(s => s > 0 ? s - 1 : 0);
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  const handleSubmit = async () => {
    if (!email || !purpose || seconds === 0) return;

    setLoading(true);
    setError('');

    const res = await fetch('/api/auth/verify-otp', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, otp, purpose }),
    });

    if (res.ok) {
      if (purpose === 'register') {
        router.push('/login?registered=1');
      } else {
        router.push(`/auth/reset-password?email=${encodeURIComponent(email!)}`);
      }
    } else {
      setError('Invalid or expired OTP');
    }
    setLoading(false);
  };

  if (!email || !purpose) {
    return <div className="text-center mt-20">Invalid link</div>;
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-rose-50 via-white to-pink-100 p-4">
      <div className="max-w-md w-full mx-auto">
        <div className="bg-white/80 backdrop-blur-xl rounded-3xl shadow-2xl p-8">
          <h2 className="text-3xl font-bold text-center mb-6">Verify OTP</h2>
          <p className="text-center text-gray-600 mb-6">
            We sent a code to <strong>{email}</strong>
          </p>

          <div className="text-center text-4xl font-mono mb-8 tracking-widest">
            {Math.floor(seconds / 60)}:{(seconds % 60).toString().padStart(2, '0')}
          </div>

          <input
            type="text"
            inputMode="numeric"
            maxLength={6}
            value={otp}
            onChange={(e) => setOtp(e.target.value.replace(/\D/g, '').slice(0, 6))}
            placeholder="Enter 6-digit code"
            className="w-full text-center text-2xl p-4 border rounded-xl mb-6 tracking-widest"
            autoComplete="one-time-code"
            disabled={loading || seconds === 0}
          />

          {error && <p className="text-red-600 text-center mb-4">{error}</p>}

          <button
            onClick={handleSubmit}
            disabled={loading || otp.length !== 6 || seconds === 0}
            className="w-full bg-rose-500 text-white py-4 rounded-xl font-bold text-lg hover:bg-rose-600 disabled:bg-gray-400 transition"
          >
            {loading ? 'Verifying...' : 'Verify OTP'}
          </button>

          {seconds === 0 && (
            <p className="text-center mt-4 text-red-600">
              OTP expired. Please request a new one.
            </p>
          )}
        </div>
      </div>
    </div>
  );
}