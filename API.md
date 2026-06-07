# Smart Travel Advisor - API Documentation

## Base URL

```
Development: http://localhost:5000
Production: https://your-domain.com
```

## Authentication

Currently, no authentication is required. All endpoints are public.

---

## Endpoints

### 1. Health Check

**Endpoint:** `GET /`

**Description:** Health check endpoint used by deployment platforms and monitoring services.

**Response:**
```json
{
  "status": "OK",
  "service": "Yatri.in - AI Travel Recommendation Engine",
  "version": "1.0.0",
  "timestamp": "2024-01-15T10:30:45.123456"
}
```

---

### 2. Get Destination Recommendations

**Endpoint:** `POST /api/recommend`

**Description:** Returns the top 5 AI-curated destinations based on user preferences.

**Request Headers:**
```
Content-Type: application/json
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

**Parameters:**
| Field | Type | Required | Values | Description |
|-------|------|----------|--------|-------------|
| `budget` | string | Yes | `budget`, `mid`, `luxury` | User's budget level |
| `interest` | string | Yes | `culture`, `nature`, `adventure`, `spiritual`, `beach` | Primary interest |
| `travel_type` | string | Yes | `solo`, `couple`, `family`, `friends` | Type of travelers |
| `season` | string | Yes | `summer`, `winter`, `monsoon` | Current/preferred season |

**Response (200 OK):**
```json
{
  "recommendations": [
    {
      "name": "Kerala",
      "description": "Backwaters and beaches · Kerala",
      "match_percentage": 94.5,
      "why_recommended": [
        "Matches your interest perfectly",
        "Family-friendly destination",
        "Easy to travel and well-connected"
      ],
      "warnings": []
    },
    {
      "name": "Goa",
      "description": "Beaches and heritage · Goa",
      "match_percentage": 89.3,
      "why_recommended": [
        "Beach destination",
        "Suitable for family travel"
      ],
      "warnings": [
        "High temperature expected during summer"
      ]
    }
  ],
  "explanation": "AI recommendations consider budget realism, season safety, travel difficulty, personal preferences and destination diversity."
}
```

**Error Response (400 Bad Request):**
```json
{
  "error": "Validation failed",
  "message": "Invalid budget. Must be one of: budget, mid, luxury"
}
```

**Error Response (500 Internal Server Error):**
```json
{
  "error": "Recommendation engine failed",
  "message": "An error occurred while processing your request"
}
```

---

### 3. Generate Itinerary & Budget

**Endpoint:** `POST /api/itinerary`

**Description:** Generates a detailed day-wise itinerary with budget breakdown for a specific destination.

**Request Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
  "place": "Kerala",
  "days": 5,
  "members": 2,
  "ages": "25,30",
  "budget": "mid"
}
```

**Parameters:**
| Field | Type | Required | Constraints | Description |
|-------|------|----------|-------------|-------------|
| `place` | string | Yes | Max 50 chars | Destination name |
| `days` | integer | Yes | 1-30 | Number of days |
| `members` | integer | Yes | 1-20 | Group size |
| `ages` | string | No | Comma-separated | Ages of travelers (e.g., "25,30,60") |
| `budget` | string | Yes | `budget`, `mid`, `luxury` | Budget type |

**Response (200 OK):**
```json
{
  "place": "Kerala",
  "members": 2,
  "ages": "25,30",
  "budget_type": "mid",
  "itinerary": [
    {
      "day": 1,
      "plan": "Arrival at Kerala. Hotel check-in and evening walk. Visit Kochi Port.",
      "budget": {
        "day_type": "arrival",
        "hotel": 4000,
        "food": 3000,
        "travel": 2000,
        "activities": 1000,
        "total": 10000
      }
    },
    {
      "day": 2,
      "plan": "Heavy sightseeing at Backwaters, Alleppey, Munnar.",
      "budget": {
        "day_type": "heavy",
        "hotel": 4600,
        "food": 3450,
        "travel": 2300,
        "activities": 1150,
        "total": 11500
      }
    },
    {
      "day": 3,
      "plan": "Light activity day at local markets and cafes.",
      "budget": {
        "day_type": "light",
        "hotel": 3080,
        "food": 2310,
        "travel": 1540,
        "activities": 770,
        "total": 7700
      }
    },
    {
      "day": 4,
      "plan": "Adventure activities and sightseeing at Periyar.",
      "budget": {
        "day_type": "heavy",
        "hotel": 4600,
        "food": 3450,
        "travel": 2300,
        "activities": 1150,
        "total": 11500
      }
    },
    {
      "day": 5,
      "plan": "Shopping, leisure time and departure.",
      "budget": {
        "day_type": "last",
        "hotel": 3680,
        "food": 2760,
        "travel": 1840,
        "activities": 920,
        "total": 9200
      }
    }
  ]
}
```

**Error Response (400 Bad Request):**
```json
{
  "error": "Validation failed",
  "message": "Days must be between 1 and 30"
}
```

**Error Response (500 Internal Server Error):**
```json
{
  "error": "Itinerary generation failed",
  "message": "An error occurred while generating itinerary"
}
```

---

### 4. Get AI Explanation

**Endpoint:** `POST /api/explain`

**Description:** Returns detailed explanation of why specific destinations were recommended.

**Request Headers:**
```
Content-Type: application/json
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

**Response (200 OK):**
```json
{
  "explanation": "AI recommendations consider budget realism, season safety, travel difficulty, personal preferences and destination diversity.",
  "recommendations": [
    {
      "name": "Kerala",
      "description": "Backwaters and beaches · Kerala",
      "match_percentage": 94.5,
      "why_recommended": [
        "Matches your interest perfectly",
        "Family-friendly destination",
        "Easy to travel and well-connected"
      ],
      "warnings": []
    }
  ],
  "note": "Transparent & explainable AI-powered recommendations"
}
```

---

## Legacy Endpoints (Backwards Compatibility)

The following legacy endpoints are still supported but deprecated:

- `POST /recommend` → Use `POST /api/recommend`
- `POST /itinerary` → Use `POST /api/itinerary`
- `POST /explain` → Use `POST /api/explain`

---

## Error Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | OK | Request successful |
| 400 | Bad Request | Invalid input or validation failed |
| 500 | Internal Server Error | Server error occurred |

---

## Budget Calculation Logic

### Base Daily Costs (per person)
- **Budget**: ₹1,800/day
- **Mid-range**: ₹3,200/day
- **Luxury**: ₹7,000/day

### Day Type Multipliers
- **Arrival**: 1.30x (travel + check-in)
- **Heavy Sightseeing**: 1.15x (full day activities)
- **Normal**: 1.00x (standard day)
- **Light**: 0.75x (rest/cafes)
- **Last Day**: 0.90x (checkout + shopping)

### Expense Distribution
- Hotel: 40%
- Food: 30%
- Travel: 20%
- Activities: 10%

### Example Calculation
```
Base Cost: ₹3,200 (mid-budget)
Day Type: heavy (1.15x multiplier)
Members: 2
Travelers: 2

Adjusted Cost: 3,200 × 1.15 = ₹3,680 per person

Expenses:
- Hotel: 3,680 × 0.40 × 2 = ₹2,944
- Food: 3,680 × 0.30 × 2 = ₹2,208
- Travel: 3,680 × 0.20 × 2 = ₹1,472
- Activities: 3,680 × 0.10 × 2 = ₹736

Total: ₹7,360 per day
```

---

## Rate Limiting

Currently, no rate limiting is implemented. For production use, consider implementing:
- 100 requests per minute per IP
- 1000 requests per day per user

---

## CORS Policy

The API includes CORS headers to allow requests from any origin:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: POST, GET, OPTIONS
Access-Control-Allow-Headers: Content-Type
```

---

## Response Headers

All successful responses include:
```
Content-Type: application/json
X-API-Version: 1.0.0
```

---

## Example Requests

### Using curl
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

### Using Python
```python
import requests

# Get recommendations
response = requests.post(
    'http://localhost:5000/api/recommend',
    json={
        'budget': 'mid',
        'interest': 'nature',
        'travel_type': 'family',
        'season': 'winter'
    }
)
print(response.json())

# Generate itinerary
response = requests.post(
    'http://localhost:5000/api/itinerary',
    json={
        'place': 'Kerala',
        'days': 5,
        'members': 2,
        'ages': '25,30',
        'budget': 'mid'
    }
)
print(response.json())
```

### Using JavaScript/Fetch
```javascript
// Get recommendations
fetch('http://localhost:5000/api/recommend', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    budget: 'mid',
    interest: 'nature',
    travel_type: 'family',
    season: 'winter'
  })
})
  .then(res => res.json())
  .then(data => console.log(data))
  .catch(err => console.error(err));
```

---

## API Testing Tools

Recommended tools for testing the API:

- **Postman**: [getpostman.com](https://www.getpostman.com)
- **Insomnia**: [insomnia.rest](https://insomnia.rest)
- **curl**: Command-line tool
- **Thunder Client**: VS Code extension
- **Rest Client**: VS Code extension

---

## Versioning

Current API Version: **1.0.0**

Future versions will maintain backwards compatibility with v1.0 endpoints.

---

## Support

For API issues or questions:
- Check [SETUP.md](./SETUP.md) for troubleshooting
- Review this documentation for endpoint details
- Check GitHub Issues for known problems
- Contact: your-email@example.com

---

Last Updated: January 2024
