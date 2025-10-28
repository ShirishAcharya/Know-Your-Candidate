"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import Button from "./ui/Button";

import PeopleIcon from "@/layout/icons/PeopleIcon";
import CompareIcon from "@/layout/icons/CompareIcon";
import NewsIcon from "@/layout/icons/NewsIcon";

const navItems = [
  { name: "Candidates", href: "/candidates", icon: PeopleIcon },
  { name: "Compare", href: "/candidates/compare", icon: CompareIcon },
  { name: "News", href: "/news", icon: NewsIcon },
];

export default function Header() {
  const [menuOpen, setMenuOpen] = useState(false);
  const [isScrolled, setIsScrolled] = useState(false);
  const [activeItem, setActiveItem] = useState("");
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  useEffect(() => {
    const checkLogin = () => setIsLoggedIn(!!localStorage.getItem("access_token"));
    checkLogin();

    window.addEventListener("storage", checkLogin);
    window.addEventListener("scroll", () => setIsScrolled(window.scrollY > 10));

    return () => {
      window.removeEventListener("storage", checkLogin);
      window.removeEventListener("scroll", () => setIsScrolled(window.scrollY > 10));
    };
  }, []);

  const handleLogout = () => {
    localStorage.removeItem("access_token");
    localStorage.removeItem("refresh_token");
    setIsLoggedIn(false);
    setMenuOpen(false);
    window.dispatchEvent(new Event("storage"));
  };

  return (
    <header
      className={`fixed top-0 left-0 right-0 z-50 backdrop-blur-xl transition-all duration-500 ${
        isScrolled
          ? "bg-slate-900/95 shadow-2xl shadow-cyan-500/10 py-3 border-b border-slate-700/30"
          : "bg-gradient-to-b from-slate-900/100 to-slate-900/90 shadow-sm py-5"
      }`}
    >
      <div className="max-w-8xl mx-auto px-6 sm:px-8 lg:px-12 flex items-center justify-between">
        {/* Logo */}
        <Link href="/" className="flex items-center space-x-3 group">
          <div className="relative">
            <div className="w-10 h-10 bg-gradient-to-br from-white-500 to-blue-600 rounded-xl flex items-center justify-center shadow-lg group-hover:shadow-xl group-hover:shadow-cyan-500/20 transition-all duration-300 group-hover:scale-110">
              <span className="text-gray  font-bold text-lg">K</span>
            </div>
            <div className="absolute inset-0 bg-gradient-to-br from-white/20 to-transparent rounded-xl" />
            <div className="absolute -inset-1 bg-gradient-to-br from-cyan-500/20 to-blue-600/20 rounded-xl blur-sm group-hover:blur-md transition-all duration-300 opacity-0 group-hover:opacity-100" />
          </div>
          <div className="flex flex-col">
            <span className="font-bold text-xl bg-gradient-to-r from-cyan-400 to-blue-400 bg-clip-text text-transparent">
              now Your
            </span>
            <span className="text-xs text-slate-400 -mt-1">Candidate</span>
          </div>
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden lg:flex items-center space-x-2">
          {navItems.map((item) => {
            const Icon = item.icon;
            const isActive = activeItem === item.name;

            return (
              <Link
                key={item.name}
                href={item.href}
                className="relative group"
                onMouseEnter={() => setActiveItem(item.name)}
                onMouseLeave={() => setActiveItem("")}
              >
                <div
                  className={`flex items-center gap-3 font-medium px-5 py-3 rounded-2xl transition-all duration-300 ${
                    isActive
                      ? "text-white bg-slate-800/80 shadow-2xl shadow-cyan-500/20 border border-slate-700/50"
                      : "text-slate-300 hover:text-white hover:bg-slate-800/50 backdrop-blur-sm"
                  }`}
                >
                  {Icon && <Icon className={`w-5 h-5 ${isActive ? "text-cyan-400" : "text-slate-400 group-hover:text-cyan-300"}`} />}
                  <span className="relative">
                    {item.name}
                    <span className={`absolute -bottom-1 left-0 w-0 h-0.5 bg-gradient-to-r from-cyan-400 to-blue-400 transition-all duration-300 ${
                      isActive ? "w-full" : "group-hover:w-full"
                    }`} />
                  </span>
                </div>
                
                {/* Hover Glow Effect */}
                <div className={`absolute inset-0 bg-gradient-to-r from-cyan-500/10 to-blue-500/10 rounded-2xl blur-md transition-all duration-300 ${
                  isActive ? "opacity-100" : "opacity-0 group-hover:opacity-100"
                }`} />
              </Link>
            );
          })}

          <div className="ml-4 pl-4 border-l border-slate-700/50">
  {isLoggedIn ? (
    <Button
      onClick={handleLogout}
      className="relative overflow-hidden group bg-white text-slate-900 font-semibold shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105 transform px-6 py-3 rounded-2xl"
    >
      <span className="relative z-10">Logout</span>
      <div className="absolute inset-0 bg-slate-100 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
      <div className="absolute inset-0 bg-white/10 transform -skew-x-12 -translate-x-full group-hover:translate-x-full transition-transform duration-1000" />
    </Button>
  ) : (
    <Link href="/login">
      <Button className="relative overflow-hidden group bg-white text-slate-900 font-semibold shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105 transform px-6 py-3 rounded-2xl">
        <span className="relative z-10">Login</span>
        <div className="absolute inset-0 bg-slate-100 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
        <div className="absolute inset-0 bg-white/10 transform -skew-x-12 -translate-x-full group-hover:translate-x-full transition-transform duration-1000" />
      </Button>
    </Link>
  )}
</div>

        </nav>

        {/* Mobile Hamburger */}
        <div className="lg:hidden flex items-center">
          <button
            onClick={() => setMenuOpen(!menuOpen)}
            className="p-3 rounded-xl bg-slate-800/50 backdrop-blur-sm border border-slate-700/50 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:ring-offset-2 focus:ring-offset-slate-900 transition-all duration-300"
            aria-label="Toggle menu"
          >
            <div className="space-y-1.5">
              <span className={`block w-6 h-0.5 bg-slate-300 transition-all duration-300 ${menuOpen ? "rotate-45 translate-y-2" : ""}`}></span>
              <span className={`block w-6 h-0.5 bg-slate-300 transition-all duration-300 ${menuOpen ? "opacity-0" : "opacity-100"}`}></span>
              <span className={`block w-6 h-0.5 bg-slate-300 transition-all duration-300 ${menuOpen ? "-rotate-45 -translate-y-2" : ""}`}></span>
            </div>
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {menuOpen && (
        <div className="lg:hidden mt-2 px-6 pb-6 space-y-3 bg-slate-800/95 backdrop-blur-xl shadow-2xl border-t border-slate-700/50">
          {navItems.map((item) => {
            const Icon = item.icon;
            return (
              <Link
                key={item.name}
                href={item.href}
                onClick={() => setMenuOpen(false)}
                className="flex items-center gap-3 px-4 py-3 rounded-xl hover:bg-slate-700/50 text-slate-300 font-medium transition-all duration-300 hover:text-white group border border-transparent hover:border-slate-600/50"
              >
                {Icon && <Icon className="w-5 h-5 text-cyan-400 group-hover:text-cyan-300" />}
                <span>{item.name}</span>
              </Link>
            );
          })}
<div className="ml-4 pl-4 border-l border-slate-700/50">
  {isLoggedIn ? (
    <Button
      onClick={handleLogout}
      className="relative overflow-hidden group bg-white text-slate-800 font-semibold shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105 transform px-6 py-3 rounded-2xl border border-slate-200"
      variant="ghost"
    >
      <span className="relative z-10">Logout</span>
      {/* Optional hover highlight */}
      <div className="absolute inset-0 bg-white opacity-0 group-hover:opacity-10 transition-opacity duration-300 rounded-2xl" />
    </Button>
  ) : (
    <Link href="/login">
      <Button
        className="relative overflow-hidden group bg-white text-slate-800 font-semibold shadow-lg hover:shadow-xl transition-all duration-300 hover:scale-105 transform px-6 py-3 rounded-2xl border border-slate-200"
        variant="ghost"
      >
        <span className="relative z-10">Login</span>
        {/* Optional hover highlight */}
        <div className="absolute inset-0 bg-white opacity-0 group-hover:opacity-10 transition-opacity duration-300 rounded-2xl" />
      </Button>
    </Link>
  )}
</div>



        </div>
      )}
    </header>
  );
}