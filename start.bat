@echo off
REM Quick Start Script for Smart Travel Advisor (Windows)
REM Run this script to set up and start the application

echo.
echo 🚀 Smart Travel Advisor - Quick Start
echo ======================================
echo.

REM Check Python version
echo ✓ Checking Python installation...
python --version

REM Create virtual environment
echo ✓ Creating virtual environment...
python -m venv venv

REM Activate virtual environment
echo ✓ Activating virtual environment...
call venv\Scripts\activate.bat

REM Install dependencies
echo ✓ Installing dependencies...
cd backend
pip install -r requirements.txt

REM Run backend
echo ✓ Starting backend server...
echo.
echo 🎉 Backend is running on http://localhost:5000
echo 📖 API Documentation: SETUP.md and API.md
echo.
echo In another terminal, open:
echo   - frontend/index.html in your browser
echo   - OR run: cd frontend ^& python -m http.server 8000
echo.

python app.py
pause
