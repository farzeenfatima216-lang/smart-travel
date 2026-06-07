# Quick Reference Guide - Smart Travel Advisor

## 📋 Files to Read First

### 1. **COMPLETION_SUMMARY.md** ← START HERE! 🌟
   - Overview of what was created
   - Quick 2-minute setup
   - Key features and deployment options

### 2. **SETUP.md**
   - Complete installation guide
   - Running the application
   - Deployment to cloud platforms (Render, Railway, Docker, Heroku)
   - Troubleshooting

### 3. **API.md**
   - API endpoint documentation
   - Request/response examples
   - Testing with curl, Python, JavaScript
   - Budget calculation logic

### 4. **README.md**
   - Project overview
   - Features and architecture
   - Contributing guidelines
   - Roadmap for future features

---

## ⚡ Fastest Way to Get Started

### Option 1: Run Startup Script

**Mac/Linux:**
```bash
chmod +x start.sh
./start.sh
```

**Windows:**
```cmd
start.bat
```

### Option 2: Manual Setup (3 commands)

```bash
# 1. Install dependencies
cd backend
pip install -r requirements.txt

# 2. Run backend
python app.py

# 3. In another terminal, open frontend
cd frontend
open index.html  # Mac
# OR
start index.html  # Windows
# OR
python -m http.server 8000  # Then visit localhost:8000
```

---

## 🧪 Test the Application

### Using Your Browser
1. Open `frontend/index.html`
2. Fill in preferences:
   - Budget: Budget-friendly / Mid-range / Luxury
   - Interest: Culture / Nature / Adventure / Spiritual / Beach
   - Travel Type: Solo / Couple / Family / Friends
   - Season: Summer / Winter / Monsoon
3. Click "Get Recommendations"
4. See AI-powered destinations with match percentages
5. Click a destination to generate itinerary

### Using Command Line (curl)

```bash
# Get recommendations
curl -X POST http://localhost:5000/api/recommend \
  -H "Content-Type: application/json" \
  -d '{
    "budget": "mid",
    "interest": "nature",
    "travel_type": "family",
    "season": "winter"
  }'

# Generate itinerary
curl -X POST http://localhost:5000/api/itinerary \
  -H "Content-Type: application/json" \
  -d '{
    "place": "Kerala",
    "days": 5,
    "members": 2,
    "ages": "25,30",
    "budget": "mid"
  }'
```

### Using Postman
1. Download [Postman](https://www.postman.com)
2. Create POST request to `http://localhost:5000/api/recommend`
3. Set headers: `Content-Type: application/json`
4. Paste JSON from examples above
5. Send and see response!

---

## 📁 Project Structure

```
Smart-Travel-Advisor/
├── backend/
│   ├── app.py               ← Main Flask app
│   ├── inference.py         ← AI recommendation engine
│   ├── itinerary.py         ← Budget calculator
│   ├── requirements.txt      ← Python dependencies
│   ├── places.csv           ← Destination database
│   └── .env                 ← Configuration
├── frontend/
│   ├── index.html           ← Main page
│   ├── script.js            ← Frontend logic
│   └── style.css            ← Styling
├── Dockerfile               ← Docker setup
├── SETUP.md                 ← Setup guide
├── API.md                   ← API reference
├── COMPLETION_SUMMARY.md    ← What was done
└── README.md                ← Project overview
```

---

## 🛠️ Common Commands

### Development

```bash
# Run backend in debug mode
FLASK_DEBUG=True python backend/app.py

# Run with specific port
PORT=8000 python backend/app.py

# Install a new package
pip install package-name
```

### Testing

```bash
# Test API with curl
curl http://localhost:5000  # Health check

# Test with Python
python
>>> import requests
>>> r = requests.post('http://localhost:5000/api/recommend', json={'budget': 'mid', ...})
>>> print(r.json())
```

### Deployment

```bash
# Build Docker image
docker build -t smart-travel .

# Run Docker container
docker run -p 5000:5000 smart-travel

# Use Docker Compose
docker-compose up -d

# Deploy to cloud
# See SETUP.md for Render, Railway, Heroku guides
```

---

## 🔐 Environment Variables

Edit `backend/.env`:

```env
FLASK_ENV=production        # development or production
FLASK_DEBUG=False           # True for debug mode
PORT=5000                   # Server port
HOST=0.0.0.0               # Bind address
FRONTEND_URL=http://localhost:3000  # For CORS
```

---

## 🚀 Deploy to Cloud

### Render.com (Recommended - Free)

1. Push code to GitHub
2. Go to [render.com](https://render.com)
3. Click "New Web Service"
4. Connect your GitHub repo
5. Settings:
   - **Build Command:** `pip install -r backend/requirements.txt`
   - **Start Command:** `gunicorn -w 4 -b 0.0.0.0:$PORT backend.app:app`
6. Click "Deploy"

### Railway.app

1. Go to [railway.app](https://railway.app)
2. Click "New Project"
3. Connect GitHub repo
4. Add same build/start commands as Render
5. Deploy!

### Docker

```bash
docker build -t smart-travel .
docker run -e FLASK_ENV=production -p 5000:5000 smart-travel
```

---

## ❓ Frequently Asked Questions

### Q: Backend not connecting?
A: Make sure it's running on port 5000. Check: `curl http://localhost:5000`

### Q: Module not found error?
A: Activate venv and install requirements: `pip install -r backend/requirements.txt`

### Q: CORS errors in browser?
A: Verify Flask-CORS is installed and backend is on `localhost:5000`

### Q: Can I change the port?
A: Yes! Run: `PORT=5001 python app.py`

### Q: How do I deploy?
A: See SETUP.md for detailed guides. Render recommended (free tier available).

---

## 📞 Need Help?

1. **Check COMPLETION_SUMMARY.md** - Overview of setup
2. **Check SETUP.md** - Detailed installation guide
3. **Check API.md** - For API questions
4. **Check README.md** - For project info
5. **Look at script examples** - Use curl/Python examples

---

## ✅ Checklist

- [ ] Read COMPLETION_SUMMARY.md
- [ ] Run `pip install -r backend/requirements.txt`
- [ ] Run `python backend/app.py`
- [ ] Open `frontend/index.html`
- [ ] Test with sample input
- [ ] Try API with curl/Postman
- [ ] Read SETUP.md for deployment
- [ ] Deploy to cloud (Render recommended)

---

## 🎯 Project Summary

**What You Have:** A complete, production-ready travel recommendation web app

**What It Does:** 
- AI-powered destination recommendations based on preferences
- Day-wise itinerary generation
- Budget calculation with detailed breakdown
- Hotel search links
- Multi-language support (5 languages)

**How to Use:**
- Fill in preferences
- Get personalized recommendations
- Plan your trip with generated itinerary
- See realistic budget breakdown

**How to Deploy:**
- Render.com (easiest, free)
- Docker (consistent across machines)
- Railway, Heroku (alternative options)

---

## 🎉 You're Ready!

Everything is set up. Just run:

```bash
cd backend
pip install -r requirements.txt
python app.py
```

Then open `frontend/index.html` in your browser. **That's it!** 🚀

---

**Made with ❤️ for Travel Lovers**
**"Atithi Devo Bhava"** *(Guest is God)*
