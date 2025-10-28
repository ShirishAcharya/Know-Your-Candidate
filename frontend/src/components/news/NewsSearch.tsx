interface NewsSearchProps {
  search: string;
  onSearchChange: (value: string) => void;
  category: string;
  onCategoryChange: (value: string) => void;
  categories: Array<{ id: string; name: string; count: number }>;
}

export default function NewsSearch({ 
  search, 
  onSearchChange, 
  category, 
  onCategoryChange, 
  categories 
}: NewsSearchProps) {
  return (
    <div className="max-w-6xl mx-auto mb-12">
      <div className="flex flex-col lg:flex-row gap-6 items-center justify-between">
        {/* Search Bar */}
        <div className="flex-1 w-full max-w-2xl">
          <div className="relative group">
            <input
              type="text"
              placeholder="Search news articles, authors, or topics..."
              value={search}
              onChange={(e) => onSearchChange(e.target.value)}
              className="w-full px-6 py-4 bg-slate-800/60 backdrop-blur-xl border border-slate-700/50 rounded-2xl text-white placeholder-slate-400 focus:outline-none focus:border-cyan-500/50 focus:ring-2 focus:ring-cyan-500/20 transition-all duration-300 shadow-2xl group-hover:border-slate-600/70"
            />
            <div className="absolute right-4 top-1/2 -translate-y-1/2">
              <svg className="w-5 h-5 text-slate-400 group-hover:text-cyan-400 transition-colors duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>
          </div>
        </div>

        {/* Category Filter */}
        <div className="flex-shrink-0">
          <select 
            value={category} 
            onChange={(e) => onCategoryChange(e.target.value)}
            className="px-6 py-4 bg-slate-800/60 backdrop-blur-xl border border-slate-700/50 rounded-2xl text-white focus:outline-none focus:border-cyan-500/50 focus:ring-2 focus:ring-cyan-500/20 transition-all duration-300 shadow-2xl appearance-none cursor-pointer"
          >
            {categories.map(cat => (
              <option key={cat.id} value={cat.id} className="bg-slate-800 text-white">
                {cat.name} {cat.id !== 'all' && `(${cat.count})`}
              </option>
            ))}
          </select>
        </div>
      </div>
    </div>
  );
}