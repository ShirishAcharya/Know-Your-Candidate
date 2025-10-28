"use client";

import Hero from "../components/Hero";
import Image from "next/image";
import { useState, useEffect } from "react";

interface NewsArticle {
  id: string;
  title: string;
  excerpt: string;
  author?: string;
  date?: string;
  category: string;
  image: string;
  readTime?: string;
  featured?: boolean;
}

interface Category {
  id: string;
  name: string;
}

export default function Home() {
  const [isVisible, setIsVisible] = useState(false);
  const [articles, setArticles] = useState<NewsArticle[]>([]);
  const [categories, setCategories] = useState<Category[]>([{ id: "all", name: "All News" }]);
  const [selectedCategory, setSelectedCategory] = useState("all");
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setIsVisible(true);

    const fetchNews = async () => {
      try {
        const res = await fetch("/news");
        if (!res.ok) throw new Error("Failed to fetch news");
        const data = await res.json();
        setArticles(data.articles || []);
        setCategories(data.categories?.length ? data.categories : [{ id: "all", name: "All News" }]);
      } catch (err: any) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchNews();
  }, []);

  const filteredArticles =
    selectedCategory === "all"
      ? articles
      : articles.filter(a => a.category === selectedCategory);

  const featured = filteredArticles.filter(a => a.featured);
  const latest = filteredArticles.filter(a => !a.featured);

  const features = [
    {
      title: "Candidate Overview",
      description: "Get detailed profiles including background, policies, achievements, and track records.",
      icon: "/icons/overview.svg",
      gradient: "from-cyan-500 to-blue-500",
      bgGradient: "from-cyan-500/10 to-blue-500/10",
      stats: "500+ Profiles"
    },
    {
      title: "Policy Comparison",
      description: "Compare candidates side by side across key issues with intelligent tools.",
      icon: "/icons/policies.svg",
      gradient: "from-blue-500 to-indigo-500",
      bgGradient: "from-blue-500/10 to-indigo-500/10",
      stats: "50+ Categories"
    },
    {
      title: "Community Engagement",
      description: "Track candidate interactions and commitment to public service.",
      icon: "/icons/engage.svg",
      gradient: "from-indigo-500 to-purple-500",
      bgGradient: "from-indigo-500/10 to-purple-500/10",
      stats: "10K+ Interactions"
    }
  ];

  return (
    <div className="font-sans bg-gradient-to-br from-slate-900 via-slate-800 to-blue-900/50 min-h-screen text-white">
      {/* Hero Section */}
      <Hero />

      {/* Features Section */}
      <section className="relative py-20 lg:py-32">
        <div className="container mx-auto px-6 relative z-10">
          {/* Section Header */}
          <div className={`text-center max-w-3xl mx-auto mb-20 transition-all duration-700 ${
            isVisible ? "opacity-100 translate-y-0" : "opacity-0 translate-y-8"
          }`}>
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/10 backdrop-blur-xl border border-white/20 shadow-2xl mb-6">
              <div className="w-2 h-2 bg-gradient-to-r from-cyan-400 to-blue-500 rounded-full animate-pulse shadow-lg"></div>
              <span className="text-sm font-medium bg-gradient-to-r from-cyan-400 to-blue-400 bg-clip-text text-transparent tracking-wide">
                Why Choose Our Platform
              </span>
            </div>
            <h2 className="text-4xl md:text-5xl lg:text-6xl font-bold mb-6">
              <span className="bg-gradient-to-r from-white via-cyan-100 to-blue-100 bg-clip-text text-transparent drop-shadow-2xl">
                Everything You Need to
              </span>
              <br />
              <span className="bg-gradient-to-r from-cyan-400 via-blue-500 to-indigo-500 bg-clip-text text-transparent animate-gradient-x drop-shadow-2xl">
                Vote Confidently
              </span>
            </h2>
            <p className="text-xl text-slate-300 leading-relaxed">
              Comprehensive tools and insights to help you make informed voting decisions with confidence and clarity.
            </p>
          </div>

          {/* Features Grid */}
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-10">
            {features.map((feature, index) => (
              <div key={index} className="relative group transition-all duration-500 hover:scale-105">
                <div className={`p-8 rounded-3xl bg-slate-800/60 backdrop-blur-xl border border-slate-700/50 shadow-2xl flex flex-col h-full relative overflow-hidden`}>
                  <div className="flex-1">
                    <h3 className="text-2xl font-bold mb-4 text-white group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-cyan-400 group-hover:to-blue-400 group-hover:bg-clip-text transition-all duration-300">
                      {feature.title}
                    </h3>
                    <p className="text-slate-300 leading-relaxed mb-6">{feature.description}</p>
                    <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-slate-700/50 text-sm font-medium text-slate-300 border border-slate-600/50">
                      <div className={`w-1.5 h-1.5 rounded-full bg-gradient-to-r ${feature.gradient} shadow-lg`}></div>
                      {feature.stats}
                    </div>
                  </div>
                  <div className={`absolute inset-0 rounded-3xl bg-gradient-to-r ${feature.gradient} opacity-0 group-hover:opacity-10 transition-opacity duration-500 -z-10`}></div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* News Section */}
      <section className="container mx-auto px-6 py-20">
        <h2 className="text-3xl md:text-4xl font-bold mb-6 text-white">Latest News</h2>

        {/* Categories */}
        <div className="flex flex-wrap gap-3 mb-8">
          {categories.map((cat) => (
            <button
              key={cat.id}
              onClick={() => setSelectedCategory(cat.id)}
              className={`px-4 py-2 rounded-2xl text-sm font-medium transition-colors ${
                selectedCategory === cat.id
                  ? "bg-cyan-500/20 text-white"
                  : "bg-slate-800/40 text-slate-300 hover:bg-slate-700/50"
              }`}
            >
              {cat.name}
            </button>
          ))}
        </div>

        {/* Loading/Error */}
        {loading ? (
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            {[...Array(6)].map((_, i) => (
              <div key={i} className="h-56 rounded-2xl bg-slate-700/50 animate-pulse"></div>
            ))}
          </div>
        ) : error ? (
          <div className="text-red-400 text-center">{error}</div>
        ) : filteredArticles.length === 0 ? (
          <div className="text-center py-16 text-slate-300">No articles found</div>
        ) : (
          <>
            {featured.length > 0 && (
              <div className="mb-12">
                <h3 className="text-2xl font-bold mb-6 text-white">Featured</h3>
                <div className="grid lg:grid-cols-2 gap-8">
                  {featured.map((article) => (
                    <div key={article.id} className="relative h-56 rounded-2xl overflow-hidden shadow-xl bg-slate-800/60 backdrop-blur-xl transition-transform hover:scale-105">
                      <Image src={article.image} alt={article.title} fill className="object-cover" />
                      <div className="absolute inset-0 bg-gradient-to-t from-slate-900/80 to-transparent"></div>
                      <div className="absolute bottom-0 left-0 right-0 p-4">
                        <h4 className="text-white font-bold text-lg">{article.title}</h4>
                        <p className="text-slate-300 text-sm line-clamp-2">{article.excerpt}</p>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}

            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
              {latest.map((article) => (
                <div key={article.id} className="relative h-56 rounded-2xl overflow-hidden shadow-xl bg-slate-800/60 backdrop-blur-xl transition-transform hover:scale-105">
                  <Image src={article.image} alt={article.title} fill className="object-cover" />
                  <div className="absolute inset-0 bg-gradient-to-t from-slate-900/80 to-transparent"></div>
                  <div className="absolute bottom-0 left-0 right-0 p-4">
                    <h4 className="text-white font-bold text-lg">{article.title}</h4>
                    <p className="text-slate-300 text-sm line-clamp-2">{article.excerpt}</p>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </section>

      {/* Stats Section */}
      <section className="relative py-20 bg-gradient-to-r from-slate-900 to-blue-900/80 text-white overflow-hidden">
        <div className="container mx-auto px-6 relative z-10">
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-8 text-center">
            {[
              { number: "500+", label: "Candidates" },
              { number: "100+", label: "Constituencies" },
            ].map((stat, index) => (
              <div key={index} className="group">
                <div className="text-3xl lg:text-4xl font-bold mb-2 bg-gradient-to-r from-white to-slate-300 bg-clip-text text-transparent group-hover:from-cyan-300 group-hover:to-blue-300 transition-all duration-300 group-hover:scale-105">
                  {stat.number}
                </div>
                <div className="text-slate-300 group-hover:text-white transition-colors duration-300 font-medium">{stat.label}</div>
                <div className="w-0 h-0.5 bg-gradient-to-r from-cyan-400 to-blue-400 mx-auto mt-2 group-hover:w-8 transition-all duration-300"></div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Animations */}
      <style jsx>{`
        @keyframes pulse { 0%, 100% { opacity: 0.3; transform: scale(1); } 50% { opacity: 0.6; transform: scale(1.05); } }
        @keyframes gradient-x { 0%, 100% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } }
        .animate-pulse { animation: pulse 4s ease-in-out infinite; }
        .animate-gradient-x { background-size: 200% 200%; animation: gradient-x 4s ease infinite; }
      `}</style>
    </div>
  );
}
