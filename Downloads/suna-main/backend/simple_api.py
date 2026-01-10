#!/usr/bin/env python3
"""
Simplified API for stable deployment on Render
"""

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from contextlib import asynccontextmanager
import asyncio
import os

@asynccontextmanager
async def lifespan(app: FastAPI):
    print("🚀 Starting AI Worker API...")
    yield
    print("🛑 Shutting down AI Worker API...")

app = FastAPI(
    title="AI Worker API",
    description="Simple API for AI Worker interface",
    version="1.0.0",
    lifespan=lifespan
)

# API Routes
@app.get("/api")
async def api_root():
    """API root endpoint."""
    return {
        "message": "AI Worker API",
        "version": "1.0.0",
        "status": "operational",
        "frontend": "/",
        "endpoints": {
            "health": "/v1/health",
            "agents": "/v1/agents",
            "test": "/test"
        }
    }

@app.get("/test")
async def test_endpoint():
    """Simple test endpoint."""
    return {
        "status": "ok",
        "message": "AI Worker API is working!",
        "timestamp": "2025-01-09"
    }

@app.get("/v1/health")
async def health_check():
    """Health check endpoint."""
    return {
        "status": "healthy",
        "service": "AI Worker Backend",
        "version": "1.0.0"
    }

@app.get("/v1/agents")
async def get_agents():
    """Get available AI agents."""
    return {
        "agents": [
            {
                "id": "data-analyst",
                "name": "Data Analyst",
                "description": "Analyzes data and creates reports",
                "avatar": "🧠",
                "status": "active"
            },
            {
                "id": "code-assistant",
                "name": "Code Assistant",
                "description": "Helps with programming and development",
                "avatar": "💻",
                "status": "active"
            },
            {
                "id": "content-writer",
                "name": "Content Writer",
                "description": "Creates content and marketing materials",
                "avatar": "📝",
                "status": "active"
            }
        ],
        "total": 3,
        "status": "success"
    }

# Mount static files for the frontend
static_dir = os.path.join(os.path.dirname(__file__), "static")
if os.path.exists(static_dir):
    app.mount("/", StaticFiles(directory=static_dir, html=True), name="static")
    print(f"📁 Static files mounted from: {static_dir}")
else:
    print(f"⚠️  Static directory not found: {static_dir}")

if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
