export default function ArticleSkeleton() {
  return (
    <div className="group relative bg-slate-800/40 backdrop-blur-xl rounded-3xl shadow-xl border border-slate-700/50 overflow-hidden animate-pulse">
      <div className="h-48 bg-slate-700/50"></div>
      <div className="p-6 space-y-4">
        <div className="flex justify-between">
          <div className="h-4 bg-slate-700/50 rounded w-20"></div>
          <div className="h-4 bg-slate-700/50 rounded w-16"></div>
        </div>
        <div className="space-y-2">
          <div className="h-6 bg-slate-700/50 rounded w-full"></div>
          <div className="h-6 bg-slate-700/50 rounded w-3/4"></div>
        </div>
        <div className="space-y-2">
          <div className="h-4 bg-slate-700/50 rounded w-full"></div>
          <div className="h-4 bg-slate-700/50 rounded w-5/6"></div>
          <div className="h-4 bg-slate-700/50 rounded w-4/6"></div>
        </div>
        <div className="flex items-center justify-between pt-4">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-slate-700/50 rounded-full"></div>
            <div className="h-4 bg-slate-700/50 rounded w-16"></div>
          </div>
          <div className="w-8 h-8 bg-slate-700/50 rounded-lg"></div>
        </div>
      </div>
    </div>
  );
}