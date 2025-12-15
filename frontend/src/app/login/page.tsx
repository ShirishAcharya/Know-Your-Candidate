'use client';
import AuthForm from "@/components/AuthForm";
import { useRouter } from "next/navigation";

const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

export default function LoginPage() {
  const router = useRouter();

  const handleSubmit = async (formData: { email: string; password: string }):
  Promise<boolean> => {
    try {
      const res = await fetch(`${API_BASE_URL}/users/token`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
          grant_type: "password",
          username: formData.email,
          password: formData.password,
        }),
        credentials: "include", // required if you want cookies
      });

      let data;
      try {
        data = await res.json();
      } catch {
        data = { detail: "No response body" };
      }

     if (res.ok) {
  localStorage.setItem("access_token", data.access_token);
  localStorage.setItem("refresh_token", data.refresh_token);

  // Dispatch event to notify other tabs/components
  window.dispatchEvent(new Event("storage"));

  router.push("/"); // redirect
  return true;
}else {
        alert(data.detail || "Login failed");
        return false;
      }
    } catch (err) {
      console.error(err);
      alert("Something went wrong!");
      return false;
    }
  };

  return <AuthForm mode="login" onSubmit={handleSubmit} />;
}
