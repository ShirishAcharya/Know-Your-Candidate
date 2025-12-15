"use client";

import { useState, useEffect } from "react";
import Image from "next/image";

// --- Types ---
interface NewsArticle {
  id: string;
  title: string;
  excerpt: string;
  author: string;
  date: string;
  category: string;
  image: string;
  readTime: string;
  featured: boolean;
}

interface Category {
  id: string;
  name: string;
  count?: number;
}

// --- NewsPage Component ---
export default function NewsPage() {
  const [articles, setArticles] = useState<NewsArticle[]>([]);
  const [filtered, setFiltered] = useState<NewsArticle[]>([]);
  const [category, setCategory] = useState<string>("all");
  const [search, setSearch] = useState<string>("");
  const [loading, setLoading] = useState<boolean>(true);

  const categories: Category[] = [
    { id: "all", name: "All News" },
    { id: "elections", name: "Elections" },
    { id: "policies", name: "Policies" },
    { id: "debates", name: "Debates" },
    { id: "campaign", name: "Campaign" },
    { id: "analysis", name: "Analysis" },
  ];

  const API_BASE_URL = process.env.NEXT_PUBLIC_API_BASE_URL || "/api";

  // --- Fetch Articles ---
  useEffect(() => {
    const fetchNews = async () => {
      try {
        setLoading(true);
        const res = await fetch(`${API_BASE_URL}/news/`);
        if (!res.ok) throw new Error("Failed to fetch news");
        const data: NewsArticle[] = await res.json();
        setArticles(data);
        setFiltered(data);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    };
    fetchNews();
  }, []);

  // --- Filter Articles ---
  useEffect(() => {
    let data = articles;
    if (category !== "all") data = data.filter(a => a.category === category);
    if (search) {
      data = data.filter(a =>
        a.title.toLowerCase().includes(search.toLowerCase()) ||
        a.excerpt.toLowerCase().includes(search.toLowerCase()) ||
        a.author.toLowerCase().includes(search.toLowerCase())
      );
    }
    setFiltered(data);
  }, [category, search, articles]);

  const featured = filtered.filter(a => a.featured);
  const latest = filtered.filter(a => !a.featured);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-blue-900/50 pt-24">
      <div className="container mx-auto px-6 lg:px-8 relative z-10">
        <h1 className="text-5xl font-bold text-white mb-6 text-center">Election News & Updates</h1>
        
        {/* Search */}
        <div className="flex flex-col md:flex-row gap-4 max-w-2xl mx-auto mb-8">
          <input
            type="text"
            placeholder="Search..."
            value={search}
            onChange={e => setSearch(e.target.value)}
            className="flex-1 px-4 py-2 rounded-2xl bg-slate-800/60 text-white placeholder-slate-400 focus:outline-none"
          />
          <select
            value={category}
            onChange={e => setCategory(e.target.value)}
            className="px-4 py-2 rounded-2xl bg-slate-800/60 text-white"
          >
            {categories.map(cat => (
              <option key={cat.id} value={cat.id}>{cat.name}</option>
            ))}
          </select>
        </div>

        {/* Featured Articles */}
        {featured.length > 0 && <FeaturedArticles articles={featured} />}

        {/* Latest Articles */}
        <LatestArticles articles={latest} loading={loading} />
      </div>
    </div>
  );
}

// --- Featured Articles Component ---
function FeaturedArticles({ articles }: { articles: NewsArticle[] }) {
  return (
    <div className="mb-16">
      <h2 className="text-3xl md:text-4xl font-bold mb-6 text-white">Featured Stories</h2>
      <div className="grid lg:grid-cols-2 gap-8">
        {articles.map(article => (
          <div
            key={article.id}
            className="relative h-64 rounded-2xl overflow-hidden shadow-xl bg-slate-800/60 backdrop-blur-xl transform transition-all hover:-translate-y-1 hover:scale-105"
          >
            <Image src={article.image} alt={article.title} fill className="object-cover" />
            <div className="absolute inset-0 bg-gradient-to-t from-slate-900/80 to-transparent"></div>
            <div className="absolute bottom-0 left-0 right-0 p-4">
              <h3 className="text-white font-bold text-lg">{article.title}</h3>
              <p className="text-slate-300 text-sm line-clamp-2">{article.excerpt}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// --- Latest Articles Component ---
function LatestArticles({ articles, loading }: { articles: NewsArticle[], loading: boolean }) {
  if (loading) {
    return (
      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
        {[...Array(6)].map((_, i) => <ArticleSkeleton key={i} />)}
      </div>
    );
  }

  if (articles.length === 0) {
    return (
      <div className="text-center py-16 text-white">No articles found</div>
    );
  }

  return (
    <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
      {articles.map(article => (
        <ArticleCard key={article.id} article={article} />
      ))}
    </div>
  );
}

// --- ArticleCard Component ---
function ArticleCard({ article }: { article: NewsArticle }) {
  return (
    <div className="relative h-56 rounded-2xl overflow-hidden shadow-xl bg-slate-800/60 backdrop-blur-xl transform transition-all hover:-translate-y-1 hover:scale-105">
      <Image src={article.image} alt={article.title} fill className="object-cover" />
      <div className="absolute inset-0 bg-gradient-to-t from-slate-900/80 to-transparent"></div>
      <div className="absolute bottom-0 left-0 right-0 p-4">
        <h3 className="text-white font-bold text-lg">{article.title}</h3>
        <p className="text-slate-300 text-sm line-clamp-2">{article.excerpt}</p>
      </div>
    </div>
  );
}

// --- ArticleSkeleton Component ---
function ArticleSkeleton() {
  return (
    <div className="h-56 rounded-2xl bg-slate-700/50 animate-pulse"></div>
  );
}
