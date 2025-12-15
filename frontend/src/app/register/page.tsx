'use client';
import AuthForm from "@/components/AuthForm";
import { useRouter } from "next/navigation";

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

export default function RegisterPage() {
  const router = useRouter();

  const handleSubmit = async (formData: { name?: string; email: string; password: string }): Promise<boolean> => {
    try {
      const res = await fetch(`${API_BASE_URL}/auth/register`, {  
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: formData.name,
          email: formData.email,
          password: formData.password,
        }),
      });

      const data = await res.json();

      if (res.ok) {
        router.push(`/auth/verify-otp?email=${encodeURIComponent(formData.email)}&purpose=register`);
        return true;
      } else {
        alert(data.detail || "Registration failed");
        return false;
      }
    } catch (err) {
      console.error("Registration error:", err);
      alert("Something went wrong. Please try again.");
      return false;
    }
  };

  return <AuthForm mode="register" onSubmit={handleSubmit} />;
}