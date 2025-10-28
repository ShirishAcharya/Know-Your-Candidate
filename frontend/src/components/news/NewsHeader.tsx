export default function NewsHeader() {
  return (
    <div className="text-center max-w-4xl mx-auto mb-16">
      <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-white/10 backdrop-blur-xl border border-white/20 shadow-2xl mb-6">
        <div className="w-2 h-2 bg-gradient-to-r from-cyan-400 to-blue-500 rounded-full animate-pulse shadow-lg shadow-cyan-400/30"></div>
        <span className="text-sm font-medium bg-gradient-to-r from-cyan-400 to-blue-400 bg-clip-text text-transparent tracking-wide">
          Latest Updates & Insights
        </span>
      </div>
      <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold mb-6">
        <span className="bg-gradient-to-r from-white via-cyan-100 to-blue-100 bg-clip-text text-transparent drop-shadow-2xl">
          Election
        </span>
        <br />
        <span className="bg-gradient-to-r from-cyan-400 via-blue-500 to-indigo-500 bg-clip-text text-transparent animate-gradient-x drop-shadow-2xl">
          News & Updates
        </span>
      </h1>
      <p className="text-xl text-slate-300 leading-relaxed max-w-2xl mx-auto">
        Stay informed with comprehensive election coverage, candidate updates, policy analysis, and political insights from trusted sources.
      </p>
    </div>
  );
}