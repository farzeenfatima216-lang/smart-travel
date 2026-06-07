@echo off
echo.
echo 🚀 Smart Travel Advisor - Starting...
echo.

cd /d "%~dp0frontend"

echo Opening Smart Travel Advisor in your browser...
echo.

timeout /t 2

start http://localhost:8888

python -m http.server 8888

pause
