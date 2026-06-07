#!/bin/bash
# Quick Start Script for Smart Travel Advisor
# Run this script to set up and start the application

echo "🚀 Smart Travel Advisor - Quick Start"
echo "======================================"

# Check Python version
echo "✓ Checking Python installation..."
python --version || python3 --version

# Create virtual environment
echo "✓ Creating virtual environment..."
python -m venv venv || python3 -m venv venv

# Activate virtual environment
echo "✓ Activating virtual environment..."
source venv/bin/activate 2>/dev/null || . venv/Scripts/activate 2>/dev/null

# Install dependencies
echo "✓ Installing dependencies..."
cd backend
pip install -r requirements.txt

# Run backend
echo "✓ Starting backend server..."
echo ""
echo "🎉 Backend is running on http://localhost:5000"
echo "📖 API Documentation: SETUP.md and API.md"
echo ""
echo "In another terminal, open:"
echo "  - frontend/index.html in your browser"
echo "  - OR run: cd frontend && python -m http.server 8000"
echo ""

python app.py
