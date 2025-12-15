import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { usePathname } from "next/navigation";

interface User {
  id: number;
  name: string;
  email: string;
}

interface AuthContextType {
  user: User | null;
  setUser: (user: User | null) => void;
  refetchUser: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const pathname = usePathname();

  const fetchUser = async () => {
    try {
      console.log("Fetching user from /users/me");
      const res = await fetch(`/api/users/me`, {
      method: "GET",
      credentials: "include", // This is correct
      });
      console.log("Response status:", res.status);
      if (!res.ok) {
        console.log("Response not OK, setting user to null");
        setUser(null);
        return;
      }
      const data: User = await res.json();
      console.log("User data received:", data);
      setUser(data);
    } catch (error) {
      console.error("Error fetching user:", error);
      setUser(null);
    }
  };

  // Check login status on app load AND when pathname changes
  useEffect(() => {
    fetchUser();
  }, [pathname]); // Added pathname dependency

  return (
    <AuthContext.Provider value={{ user, setUser, refetchUser: fetchUser }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuth must be used within AuthProvider");
  return context;
};