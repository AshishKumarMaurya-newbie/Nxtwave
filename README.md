# NxtWave - WhatsApp College Assistant Bot

A FastAPI-based WhatsApp bot that uses Google Gemini AI and RAG (Retrieval-Augmented Generation) to answer college-related queries in multiple languages including Hinglish.

## Features

- **Multilingual Support**: English, Hindi, Hinglish, and other languages
- **Hinglish Processing**: Automatically detects and converts Hinglish (Hindi in Latin script)
- **RAG System**: Uses FAISS vector store with a knowledge base for accurate answers
- **WhatsApp Integration**: Direct communication via Twilio
- **Google Gemini AI**: Powers intelligent responses with `gemini-2.5-flash`

## Prerequisites

- Python 3.12+
- Twilio Account (with WhatsApp sandbox or business account)
- Google API Key (for Gemini and embeddings)
- Railway account (for deployment)

## Setup

### Local Development

1. Clone the repository:
```bash
git clone <your-repo-url>
cd Nxtwave-master
```

2. Install dependencies:
```bash
pip install -r requirements.txt
# Or using uv:
uv sync
```

3. Create `.env` file (copy from `.env.example`):
```bash
cp .env.example .env
```

4. Add your credentials to `.env`:
```
ACCOUNT_SID=your_twilio_account_sid
AUTH_TOKEN=your_twilio_auth_token
TWILIO_WHATSAPP_NUMBER=whatsapp:+1234567890
GOOGLE_API_KEY=your_google_api_key
```

5. Create `knowledge_base.txt` with your college information:
```
Your college information, policies, FAQs, etc.
```

6. Run the application:
```bash
python app.py
# Or using uvicorn directly:
uvicorn app:app --reload
```

The app will be available at `http://localhost:8000`

### Deploy to Railway

1. **Push to GitHub** (if not already done):
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin <your-github-repo>
git push -u origin main
```

2. **Connect to Railway**:
   - Go to [railway.app](https://railway.app)
   - Sign in with GitHub
   - Click "New Project" → "Deploy from GitHub repo"
   - Select your repository

3. **Configure Environment Variables**:
   - In Railway dashboard, go to "Variables"
   - Add the following:
     - `ACCOUNT_SID` - Your Twilio Account SID
     - `AUTH_TOKEN` - Your Twilio Auth Token
     - `TWILIO_WHATSAPP_NUMBER` - Your WhatsApp number (format: `whatsapp:+1234567890`)
     - `GOOGLE_API_KEY` - Your Google API key

4. **Add knowledge_base.txt**:
   - The `knowledge_base.txt` file must be in the root directory
   - Ensure it's committed to your GitHub repo (not in .gitignore)

5. **Configure Twilio Webhook**:
   - Get your Railway deployment URL from the dashboard
   - Go to Twilio Console → WhatsApp → Settings
   - Set Webhook URL to: `https://your-railway-url/webhook`
   - Method: POST

## API Endpoints

### GET `/`
Health check endpoint
```bash
curl http://localhost:8000/
# Returns: {"status": "ok"}
```

### POST `/webhook`
Receives and processes WhatsApp messages (called by Twilio)
- **Parameters**:
  - `Body` (string): Message content
  - `From` (string): Sender's WhatsApp number

## Architecture

```
NxtWave Bot
├── Language Detection (langdetect)
├── Language Translation (deep_translator)
├── Hinglish Conversion (indic_transliteration)
├── RAG System
│   ├── FAISS Vector Store
│   ├── Google Embeddings
│   └── Gemini LLM
└── Twilio Integration
```

## File Structure

```
.
├── app.py                  # Main FastAPI application
├── knowledge_base.txt      # College knowledge base (create this)
├── pyproject.toml         # Python dependencies
├── Dockerfile             # Docker configuration
├── railway.json           # Railway deployment config
├── .env.example           # Environment variables template
└── README.md              # This file
```

## Dependencies

- `fastapi` - Web framework
- `uvicorn` - ASGI server
- `twilio` - WhatsApp integration
- `langchain` - LLM orchestration
- `langchain-google-genai` - Google Gemini integration
- `faiss-cpu` - Vector similarity search
- `langdetect` - Language detection
- `deep-translator` - Translation service
- `indic-transliteration` - Hinglish/Hindi conversion

## Troubleshooting

### knowledge_base.txt not found
- Ensure the file exists in the project root
- Commit it to GitHub (check it's not in .gitignore)
- The RAG system will work without it, but won't have custom knowledge

### Twilio not receiving responses
- Verify the webhook URL in Twilio console is correct
- Check Railway logs for errors
- Ensure ACCOUNT_SID and AUTH_TOKEN are correct

### Language detection issues
- Hinglish detection is optimized for common Indian English words
- For other languages, ensure they're supported by langdetect

## License

MIT

## Support

For issues or questions, please open a GitHub issue.
