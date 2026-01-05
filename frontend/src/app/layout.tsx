import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Cheongan - The Precision Dashboard",
  description: "Advanced financial analytics platform",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ko">
      <body className="antialiased min-h-dvh flex flex-col">
        {children}
      </body>
    </html>
  );
}
