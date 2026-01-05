import Footer from "@/components/Footer";

export default function Home() {
  return (
    <main className="flex-1 w-full max-w-7xl mx-auto px-4 py-6 md:py-10 flex flex-col gap-6">
      {/* Header */}
      <header className="flex justify-between items-center mb-4">
        <div>
          <h1 className="text-3xl md:text-5xl font-bold tracking-tight text-white mb-2">
            CHEONGAN <span className="text-blue-500">.</span>
          </h1>
          <p className="text-slate-400 text-sm md:text-base">
            The Precision Dashboard & Analytics
          </p>
        </div>
        <div className="hidden md:flex items-center gap-4">
          <div className="flex items-center gap-2 px-4 py-2 rounded-full bg-white/5 border border-white/10">
            <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse"></div>
            <span className="text-xs font-medium text-emerald-400">System Normal</span>
          </div>
        </div>
      </header>

      {/* Bento Grid Layout */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 md:gap-6 auto-rows-max">

        {/* Card 1: SOXL (Glance) */}
        <div className="glass-panel p-6 flex flex-col justify-between h-48 md:col-span-1">
          <div className="flex justify-between items-start">
            <span className="text-slate-400 font-medium">SOXL</span>
            <span className="text-emerald-400 bg-emerald-500/10 px-2 py-1 rounded text-xs">+4.2%</span>
          </div>
          <div>
            <span className="text-3xl font-bold text-white">$42.85</span>
            <p className="text-xs text-slate-500 mt-1">Direxion Daily Semi Bull 3X</p>
          </div>
        </div>

        {/* Card 2: SOXS (Glance) */}
        <div className="glass-panel p-6 flex flex-col justify-between h-48 md:col-span-1">
          <div className="flex justify-between items-start">
            <span className="text-slate-400 font-medium">SOXS</span>
            <span className="text-rose-400 bg-rose-500/10 px-2 py-1 rounded text-xs">-12.1%</span>
          </div>
          <div>
            <span className="text-3xl font-bold text-white">$2.15</span>
            <p className="text-xs text-slate-500 mt-1">Direxion Daily Semi Bear 3X</p>
          </div>
        </div>

        {/* Card 3: Main Chart Area */}
        <div className="glass-panel p-6 md:col-span-2 md:row-span-2 min-h-[300px] flex flex-col">
          <div className="flex justify-between items-center mb-6">
            <h3 className="text-lg font-semibold text-white">Real-time Trends</h3>
            <div className="flex gap-2">
              {['1H', '1D', '1W', '1M'].map((t) => (
                <button key={t} className="px-3 py-1 rounded-lg text-xs hover:bg-white/10 text-slate-400 transition-colors">
                  {t}
                </button>
              ))}
            </div>
          </div>
          <div className="flex-1 flex items-center justify-center border border-dashed border-white/10 rounded-xl bg-black/20">
            <p className="text-slate-500 text-sm">Interactive Chart Module</p>
          </div>
        </div>

        {/* Card 4: Market Status */}
        <div className="glass-panel p-6 md:col-span-2 h-48">
          <h3 className="text-slate-400 text-sm font-medium mb-4">Market Sentiment</h3>
          <div className="flex items-center gap-4 mt-2">
            <div className="flex-1">
              <div className="flex justify-between text-xs mb-2">
                <span className="text-emerald-400">Greed</span>
                <span className="text-white font-bold">78</span>
              </div>
              <div className="h-2 bg-slate-800 rounded-full overflow-hidden">
                <div className="h-full bg-gradient-to-r from-blue-500 to-emerald-500 w-[78%]"></div>
              </div>
            </div>
          </div>
          <p className="text-xs text-slate-500 mt-4">
            AI analysis indicates a strong buying signal based on recent volume spikes.
          </p>
        </div>

      </div>

      <Footer />
    </main>
  );
}
