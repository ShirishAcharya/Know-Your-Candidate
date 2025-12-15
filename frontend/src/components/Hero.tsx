"use client";
import Image from "next/image";
import React, { useState, useEffect } from "react";

const stats = [
  { number: "3000+", label: "Registered Candidates" },
  { number: "495", label: "Constituencies" },
  { number: "18.1M", label: "Voters" },
];

const HeroSection: React.FC = () => {
  const [isVisible, setIsVisible] = useState(false);

  useEffect(() => {
    setIsVisible(true);
  }, []);

  return (
    <section
      aria-label="Hero section"
      className="relative min-h-screen flex items-center justify-center overflow-hidden bg-gradient-to-br from-slate-900 via-slate-800 to-blue-900/80"
    >
      {/* Background Elements */}
      <div aria-hidden className="pointer-events-none absolute inset-0">
        {/* Gradient Orbs */}
        <div className="absolute top-1/4 left-1/4 w-[28rem] h-[28rem] bg-gradient-to-r from-blue-500/20 to-cyan-400/15 rounded-full blur-3xl animate-float"></div>
        <div className="absolute bottom-1/3 right-1/4 w-[24rem] h-[24rem] bg-gradient-to-r from-slate-600/20 to-blue-600/15 rounded-full blur-3xl animate-float-delayed"></div>
      </div>

      <div className="container mx-auto px-4 md:px-8 py-16 md:py-24 flex flex-col lg:flex-row items-center gap-12 lg:gap-16 relative z-10">
        {/* Left - Text */}
        <div className="lg:w-1/2 text-center lg:text-left space-y-10">
          <div
            className={`inline-flex items-center gap-3 px-5 py-2 rounded-2xl bg-white/10 backdrop-blur-xl border border-white/20 shadow-lg transition-all duration-700 ${
              isVisible ? "opacity-100 translate-y-0" : "opacity-0 translate-y-2"
            }`}
            tabIndex={0}
            aria-label="Your Voice Matters"
          >
            <div className="w-3 h-3 bg-gradient-to-r from-cyan-400 to-blue-500 rounded-full animate-pulse shadow-cyan-400/30"></div>
            <span className="text-sm font-semibold bg-gradient-to-r from-white to-cyan-200 bg-clip-text text-transparent tracking-wide">
              Empower Your Vote • Know Your Candidate
            </span>
          </div>

          <div
            className={`space-y-6 transition-all duration-700 delay-200 ${
              isVisible ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
            }`}
          >
            <h1 className="text-4xl sm:text-5xl lg:text-6xl font-extrabold leading-tight tracking-tight">
              <span className="bg-gradient-to-r from-white via-cyan-100 to-blue-100 bg-clip-text text-transparent drop-shadow">
                Discover
              </span>
              <br />
              <span className="bg-gradient-to-r from-cyan-400 via-blue-500 to-indigo-500 bg-clip-text text-transparent animate-gradient-x drop-shadow">
                Your Candidate
              </span>
            </h1>
            <p className="text-base sm:text-lg lg:text-xl text-slate-300 leading-relaxed max-w-xl mx-auto lg:mx-0 font-light">
              Explore detailed profiles of candidates including their <strong>policies</strong>, <strong>achievements</strong>, and <strong>vision</strong>. Make an{" "}
              <span className="font-semibold bg-gradient-to-r from-cyan-400 to-blue-400 bg-clip-text text-transparent">
                informed decision
              </span>{" "}
              before casting your vote.
            </p>
          </div>

          <div
            className={`flex flex-col sm:flex-row gap-5 justify-center lg:justify-start transition-all duration-700 delay-400 ${
              isVisible ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
            }`}
          >
            <a
              href="/candidates"
              className="group relative bg-gradient-to-r from-cyan-500 to-blue-600 text-white font-bold px-8 py-4 rounded-2xl shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300 hover:scale-105 outline-none"
              aria-label="Explore Candidates"
            >
              Explore Candidates
            </a>
            <a
              href="#demo"
              className="group relative bg-white/10 backdrop-blur-xl text-white font-semibold px-8 py-4 rounded-2xl border border-white/20 shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300 hover:scale-105 outline-none"
              aria-label="Watch Demo"
            >
              Watch Demo
            </a>
          </div>

          <div
            className={`grid grid-cols-2 sm:grid-cols-3 gap-6 pt-6 transition-all duration-700 delay-600 ${
              isVisible ? "opacity-100 translate-y-0" : "opacity-0 translate-y-6"
            }`}
            aria-label="Platform statistics"
          >
            {stats.map((stat, index) => (
              <div key={index} className="text-center lg:text-left group">
                <div className="text-2xl sm:text-3xl font-bold bg-gradient-to-r from-cyan-400 to-blue-400 bg-clip-text text-transparent drop-shadow group-hover:scale-105 transition-transform duration-300">
                  {stat.number}
                </div>
                <div className="text-sm text-slate-400 font-medium tracking-wide group-hover:text-slate-300 transition-colors">
                  {stat.label}
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Right - Hero Image */}
        <div
          className={`lg:w-1/2 flex justify-center transition-all duration-1000 delay-300 ${
            isVisible ? "opacity-100 translate-y-0 scale-100" : "opacity-0 translate-y-12 scale-95"
          }`}
        >
          <div className="relative w-full max-w-2xl flex justify-center">
            <div className="relative rounded-3xl overflow-hidden shadow-2xl hover:shadow-3xl transform hover:-translate-y-2 transition-all duration-500 border-2 border-white/20 backdrop-blur-sm">
              <Image
                src="/knowyourcandidate.jpeg"
                alt="Group of candidates interacting with voters"
                width={1200}
                height={900}
                className="w-full h-auto object-cover transform hover:scale-105 transition-transform duration-700"
                priority
              />
              <div className="absolute inset-0 bg-gradient-to-t from-slate-900/40 via-transparent to-transparent"></div>
              <div className="absolute inset-0 bg-gradient-to-br from-cyan-500/10 to-blue-600/10 mix-blend-overlay"></div>
            </div>
          </div>
        </div>
      </div>

      <style jsx>{`
        @keyframes float {
          0%, 100% { transform: translateY(0px) rotate(0deg); }
          50% { transform: translateY(-25px) rotate(1deg); }
        }
        @keyframes float-delayed {
          0%, 100% { transform: translateY(0px) rotate(0deg); }
          50% { transform: translateY(-20px) rotate(-1deg); }
        }
        @keyframes pulse-slow {
          0%, 100% { opacity: 0.3; transform: scale(1); }
          50% { opacity: 0.6; transform: scale(1.05); }
        }
        @keyframes gradient-x {
          0%, 100% { background-position: 0% 50%; }
          50% { background-position: 100% 50%; }
        }
        .animate-float {
          animation: float 6s ease-in-out infinite;
        }
        .animate-float-delayed {
          animation: float-delayed 7s ease-in-out infinite;
        }
        .animate-pulse-slow {
          animation: pulse-slow 8s ease-in-out infinite;
        }
        .animate-gradient-x {
          background-size: 200% 200%;
          animation: gradient-x 4s ease infinite;
        }
      `}</style>
    </section>
  );
};

export default HeroSection;
