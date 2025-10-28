interface NewsFiltersProps {
  categories: Array<{ id: string; name: string; count: number }>;
  selectedCategory: string;
  onCategoryChange: (category: string) => void;
}

export default function NewsFilters({ 
  categories, 
  selectedCategory, 
  onCategoryChange 
}: NewsFiltersProps) {
  return (
    <div className="flex flex-wrap justify-center gap-3 mb-12">
      {categories.map((cat) => (
        <button
          key={cat.id}
          onClick={() => onCategoryChange(cat.id)}
          className={`group relative px-5 py-3 rounded-2xl font-medium transition-all duration-300 backdrop-blur-sm border ${
            selectedCategory === cat.id
              ? "bg-cyan-500/20 text-white border-cyan-500/50 shadow-lg shadow-cyan-500/20"
              : "bg-slate-800/40 text-slate-300 border-slate-700/50 hover:bg-slate-700/60 hover:border-slate-600/70"
          }`}
        >
          <span className="relative z-10 flex items-center gap-2">
            {cat.name}
            {cat.id !== 'all' && (
              <span className={`text-xs px-2 py-1 rounded-full ${
                selectedCategory === cat.id
                  ? "bg-cyan-500/30 text-cyan-200"
                  : "bg-slate-700/50 text-slate-400"
              }`}>
                {cat.count}
              </span>
            )}
          </span>
          {selectedCategory === cat.id && (
            <div className="absolute inset-0 bg-gradient-to-r from-cyan-500/10 to-blue-500/10 rounded-2xl blur-sm -z-10"></div>
          )}
        </button>
      ))}
    </div>
  );
}