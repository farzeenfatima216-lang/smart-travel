# Smart Travel Advisor - Complete Setup Guide

Welcome! This guide will help you set up and run the Smart Travel Advisor application locally and deploy it to the cloud.

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [Local Development Setup](#local-development-setup)
3. [Running the Application](#running-the-application)
4. [API Documentation](#api-documentation)
5. [Deployment Guide](#deployment-guide)
6. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before you begin, ensure you have the following installed:

- **Python 3.8+** - Download from [python.org](https://www.python.org/downloads/)
- **Git** - Download from [git-scm.com](https://git-scm.com/)
- **pip** - Usually comes with Python

Verify installations:
```bash
python --version
git --version
pip --version
```

---

## Local Development Setup

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/Smart-Travel-Advisor.git
cd Smart-Travel-Advisor
```

### Step 2: Create Python Virtual Environment

**On Windows:**
```bash
python -m venv venv
venv\Scripts\activate
```

**On macOS/Linux:**
```bash
python3 -m venv venv
source venv/bin/activate
```

### Step 3: Install Backend Dependencies

```bash
cd backend
pip install -r requirements.txt
```

### Step 4: Configure Environment Variables

```bash
# Copy the example env file
cp .env.example .env

# Edit .env and update values as needed
# For local development, default values are fine
```

### Step 5: Verify Data Files

Check that these files exist in the `backend/` directory:
- `places_enriched.csv` - Destination database
- `places.json` - JSON version of destinations

If missing, regenerate using:
```bash
python csv_to_json.py
```

---

## Running the Application

### Running Backend Only (API Server)

```bash
cd backend
python app.py
```

Expected output:
```
 * Running on http://0.0.0.0:5000
```

### Running the Full Application

#### **Option 1: Separate Terminal Windows**

**Terminal 1 - Backend:**
```bash
cd backend
python app.py
# Runs on http://localhost:5000
```

**Terminal 2 - Frontend:**
```bash
cd frontend
# Open index.html in a browser
# Or use a simple Python HTTP server:
python -m http.server 8000
# Access at http://localhost:8000
```

#### **Option 2: Using Docker (Recommended)**

```bash
# Build the Docker image
docker build -t smart-travel-advisor .

# Run the container
docker run -p 5000:5000 smart-travel-advisor
```

---

## API Documentation

### Base URL
```
http://localhost:5000
```

### 1. Health Check
```
GET /
```

**Response:**
```json
{
  "status": "OK",
  "service": "Yatri.in - AI Travel Recommendation Engine",
  "version": "1.0.0"
}
```

### 2. Get Destination Recommendations
```
POST /api/recommend
```

**Request Body:**
```json
{
  "budget": "mid",
  "interest": "nature",
  "travel_type": "family",
  "season": "winter"
}
```

**Valid Values:**
- `budget`: `budget` | `mid` | `luxury`
- `interest`: `culture` | `nature` | `adventure` | `spiritual` | `beach`
- `travel_type`: `solo` | `couple` | `family` | `friends`
- `season`: `summer` | `winter` | `monsoon`

**Response:**
```json
{
  "recommendations": [
    {
      "name": "Goa",
      "description": "Beautiful beaches and ancient forts · Goa",
      "match_percentage": 92.5,
      "why_recommended": ["Matches your interest perfectly", "Easy to travel"],
      "warnings": []
    }
  ],
  "explanation": "AI recommendations consider..."
}
```

### 3. Generate Itinerary & Budget
```
POST /api/itinerary
```

**Request Body:**
```json
{
  "place": "Goa",
  "days": 3,
  "members": 2,
  "ages": "25,30",
  "budget": "mid"
}
```

**Response:**
```json
{
  "place": "Goa",
  "members": 2,
  "ages": "25,30",
  "budget_type": "mid",
  "itinerary": [
    {
      "day": 1,
      "plan": "Arrival at Goa. Hotel check-in and evening walk.",
      "budget": {
        "day_type": "arrival",
        "hotel": 4000,
        "food": 3000,
        "travel": 2000,
        "activities": 1000,
        "total": 10000
      }
    }
  ]
}
```

### 4. Get AI Explanation
```
POST /api/explain
```

**Request Body:** (Same as /api/recommend)

**Response:** Includes detailed explanation of recommendations

---

## Deployment Guide

### Deploy to Render.com

1. **Create Account**: Visit [render.com](https://render.com) and sign up
2. **Connect Repository**: Link your GitHub repository
3. **Create Web Service**:
   - **Build Command**: `pip install -r backend/requirements.txt`
   - **Start Command**: `gunicorn -w 4 -b 0.0.0.0:$PORT backend.app:app`
   - **Environment Variables**: Add `.env` variables in Render dashboard

### Deploy to Railway.app

1. **Create Account**: Visit [railway.app](https://railway.app) and sign up
2. **Create Project**: New Project → GitHub
3. **Configure**:
   - **Build Command**: `pip install -r backend/requirements.txt`
   - **Start Command**: `gunicorn -w 4 -b 0.0.0.0:$PORT backend.app:app`
4. **Deploy**: Push to GitHub, Railway auto-deploys

### Deploy to Heroku (Legacy)

```bash
# Login to Heroku
heroku login

# Create app
heroku create your-app-name

# Deploy
git push heroku main

# View logs
heroku logs --tail
```

### Deploy with Docker

```bash
# Build image
docker build -t smart-travel:latest .

# Tag for Docker Hub
docker tag smart-travel:latest youruser/smart-travel:latest

# Push to Docker Hub
docker push youruser/smart-travel:latest

# Run
docker run -p 5000:5000 youruser/smart-travel:latest
```

---

## Troubleshooting

### Issue: "ModuleNotFoundError: No module named 'flask'"

**Solution:**
```bash
# Ensure virtual environment is activated
# Then reinstall requirements:
pip install -r backend/requirements.txt
```

### Issue: "Address already in use" on port 5000

**Solution:**
```bash
# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# macOS/Linux
lsof -ti:5000 | xargs kill -9

# Or use a different port:
PORT=5001 python app.py
```

### Issue: CORS errors in browser console

**Solution:**
- Ensure backend is running on http://localhost:5000
- Update frontend API calls if backend URL changes
- Check `flask_cors` is installed: `pip install flask-cors`

### Issue: CSV file not found error

**Solution:**
```bash
cd backend
python csv_to_json.py
# This regenerates the CSV if corrupted
```

### Issue: Frontend not connecting to backend

**Troubleshooting:**
1. Check backend is running: `curl http://localhost:5000`
2. Check network tab in browser DevTools for failed requests
3. Verify CORS is enabled in `app.py`
4. Try API endpoint directly using Postman or curl

---

## Project Structure

```
Smart-Travel-Advisor/
├── backend/
│   ├── app.py                 # Main Flask application
│   ├── inference.py           # AI recommendation engine
│   ├── itinerary.py           # Itinerary generation
│   ├── hotel_logic.py         # Hotel recommendation logic
│   ├── places_enriched.csv    # Destination database
│   ├── places.json            # JSON version of data
│   └── requirements.txt       # Python dependencies
├── frontend/
│   ├── index.html             # Main HTML
│   ├── style.css              # Styling
│   ├── script.js              # Frontend logic
│   └── assets/                # Images, icons
├── Dockerfile                 # Docker configuration
├── .gitignore                 # Git ignore rules
├── .env.example               # Example environment variables
├── README.md                  # Project overview
└── SETUP.md                   # This file
```

---

## Development Tips

### Running in Debug Mode

```bash
# Set Flask debug mode
export FLASK_DEBUG=True  # macOS/Linux
set FLASK_DEBUG=True     # Windows

python app.py
```

### Testing API Endpoints

Using curl:
```bash
curl -X POST http://localhost:5000/api/recommend \
  -H "Content-Type: application/json" \
  -d '{"budget":"mid","interest":"nature","travel_type":"family","season":"winter"}'
```

Using Python requests:
```python
import requests

response = requests.post('http://localhost:5000/api/recommend', json={
    'budget': 'mid',
    'interest': 'nature',
    'travel_type': 'family',
    'season': 'winter'
})
print(response.json())
```

### Updating Requirements

After installing new packages:
```bash
pip freeze > backend/requirements.txt
```

---

## Need Help?

- **Check Logs**: Backend logs show detailed error messages
- **API Testing**: Use Postman or Insomnia for API testing
- **Browser DevTools**: Check Network tab for request/response details
- **GitHub Issues**: Report bugs on GitHub

---

**Happy Travels! 🚀✈️**
