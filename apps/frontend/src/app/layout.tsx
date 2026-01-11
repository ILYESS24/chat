import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Kortix AI - Plateforme d'agents IA",
  description: "CrÃ©ez et gÃ©rez vos agents IA intelligents",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="fr">
      <body>{children}</body>
    </html>
  );
}
