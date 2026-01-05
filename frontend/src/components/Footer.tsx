export default function Footer() {
    const version = process.env.NEXT_PUBLIC_APP_VERSION || "Dev Mode";

    return (
        <footer className="w-full py-6 mt-auto text-center border-t border-white/5">
            <p className="text-sm text-slate-500">
                © 2026 CHEONGAN. All rights reserved.
                <span className="ml-2 px-2 py-0.5 rounded-full bg-slate-800 text-xs font-mono text-slate-400">
                    v{version}
                </span>
            </p>
        </footer>
    );
}
