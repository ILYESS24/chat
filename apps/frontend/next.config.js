/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'standalone',
  experimental: {
    outputFileTracingRoot: undefined,
  },
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || 'https://chat-i6z7.onrender.com',
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://otxxjczxwhtngcferckz.supabase.co',
    NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im90eHhKY3p4d2h0bmdjZmVyY2t6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY0MTE4NTIsImV4cCI6MjA1MTk4Nzg1Mn0.5VbjomjZucBNVqphxQ8D9gD52Iy5nFzgo7z85hoL5t8'
  }
};

module.exports = nextConfig;
