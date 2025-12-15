// next.config.ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // This is the only thing we need to add — everything else stays exactly as before
  async rewrites() {
    return [
      {
        source: "/api/:path*",
        destination: "http://localhost:8000/:path*",
      },
    ];
  },
};

export default nextConfig;