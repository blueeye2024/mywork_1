import type { Config } from "tailwindcss";

const config: Config = {
    content: [
        "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
        "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
        "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
    ],
    theme: {
        extend: {
            colors: {
                background: "#020617", // Deep Dark Slate
                foreground: "#f8fafc",
                card: "rgba(255, 255, 255, 0.05)",
                "card-border": "rgba(255, 255, 255, 0.1)",
            },
            backdropBlur: {
                xs: '2px',
            },
            borderRadius: {
                '4xl': '2rem',
            }
        },
    },
    plugins: [],
};
export default config;
