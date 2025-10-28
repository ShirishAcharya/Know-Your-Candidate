import Image from "next/image";

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

interface ArticleCardProps {
  article: NewsArticle;
}

export default function ArticleCard({ article }: ArticleCardProps) {
  return (
    <div className="group relative bg-slate-800/60 backdrop-blur-xl rounded-3xl shadow-xl hover:shadow-2xl border border-slate-700/50 overflow-hidden transform transition-all duration-500 hover:-translate-y-2 h-full flex flex-col">
      <div className="absolute inset-0 bg-gradient-to-br from-cyan-500/5 to-blue-500/5 opacity-0 group-hover:opacity-100 transition-opacity duration-500 -z-10"></div>
      
      <div className="relative h-48 overflow-hidden">
        <Image
          src={article.image}
          alt={article.title}
          fill
          className="object-cover transform group-hover:scale-110 transition-transform duration-700"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-slate-900/60 via-slate-900/10 to-transparent"></div>
        <div className="absolute top-3 left-3">
          <span className="px-2 py-1 bg-slate-800/80 backdrop-blur-sm text-slate-300 text-xs font-medium rounded-full border border-slate-700/50 capitalize">
            {article.category}
          </span>
        </div>
      </div>

      <div className="p-6 flex-1 flex flex-col">
        <div className="flex items-center justify-between mb-3">
          <span className="text-slate-400 text-sm">{article.readTime}</span>
          <span className="text-slate-400 text-sm">{new Date(article.date).toLocaleDateString()}</span>
        </div>

        <h3 className="text-lg font-bold text-white mb-3 group-hover:text-transparent group-hover:bg-gradient-to-r group-hover:from-cyan-400 group-hover:to-blue-400 group-hover:bg-clip-text transition-all duration-300 line-clamp-2">
          {article.title}
        </h3>

        <p className="text-slate-300 mb-4 line-clamp-3 flex-1">
          {article.excerpt}
        </p>

        <div className="flex items-center justify-between pt-4 border-t border-slate-700/50">
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 bg-gradient-to-br from-cyan-500 to-blue-500 rounded-full flex items-center justify-center text-white text-xs font-bold">
              {article.author.split(' ').map(n => n[0]).join('')}
            </div>
            <span className="text-sm text-slate-400">{article.author}</span>
          </div>
          
          <button className="group/btn p-2 bg-slate-700/50 hover:bg-cyan-500/20 text-slate-400 hover:text-cyan-300 rounded-lg border border-slate-600/50 hover:border-cyan-500/30 transition-all duration-300">
            <svg className="w-4 h-4 group-hover/btn:translate-x-0.5 transition-transform duration-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 7l5 5m0 0l-5 5m5-5H6" />
            </svg>
          </button>
        </div>
      </div>
    </div>
  );
}