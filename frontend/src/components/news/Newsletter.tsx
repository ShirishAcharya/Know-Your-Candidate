export default function Newsletter() {
  return (
    <div className="bg-slate-800/40 backdrop-blur-xl rounded-3xl p-8 md:p-12 border border-slate-700/50 shadow-2xl max-w-4xl mx-auto mb-16">
      <div className="text-center max-w-2xl mx-auto">
        <h3 className="text-3xl font-bold text-white mb-4">Stay Informed</h3>
        <p className="text-slate-300 mb-8">
          Get the latest election news and analysis delivered to your inbox. Never miss important updates.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 max-w-md mx-auto">
          <input
            type="email"
            placeholder="Enter your email"
            className="flex-1 px-4 py-3 bg-slate-700/50 border border-slate-600/50 rounded-2xl text-white placeholder-slate-400 focus:outline-none focus:border-cyan-500/50 focus:ring-2 focus:ring-cyan-500/20 transition-all duration-300"
          />
          <button className="px-6 py-3 bg-gradient-to-r from-cyan-500 to-blue-600 text-white font-semibold rounded-2xl shadow-lg hover:shadow-xl transform hover:-translate-y-1 transition-all duration-300 hover:scale-105">
            Subscribe
          </button>
        </div>
      </div>
    </div>
  );
}