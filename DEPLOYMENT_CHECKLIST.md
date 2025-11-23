# Render Deployment Checklist

## Before Deployment

- [ ] Code pushed to GitHub repository
- [ ] `knowledge_base.txt` file exists and is committed
- [ ] `.env` variables are NOT committed (only `.env.example`)

## Render Setup

- [ ] Account created at render.com (sign in with GitHub)
- [ ] Repository connected to Render
- [ ] Docker environment selected
- [ ] Free plan chosen

## Environment Variables in Render

Add these in Render dashboard → Environment:
- [ ] `ACCOUNT_SID` = (from Twilio)
- [ ] `AUTH_TOKEN` = (from Twilio)
- [ ] `TWILIO_WHATSAPP_NUMBER` = whatsapp:+XXXXXXXXXXXX
- [ ] `GOOGLE_API_KEY` = (from Google Cloud)

## Twilio Configuration

- [ ] Go to Twilio Console
- [ ] Get your Render deployment URL
- [ ] Navigate to WhatsApp → Sandbox (or business account)
- [ ] Set Webhook URL to: `https://your-render-url/webhook`
- [ ] Set Method to: POST
- [ ] Save settings

## Testing

- [ ] Send test message to Twilio WhatsApp number
- [ ] Check Render logs for successful processing
- [ ] Verify response received

## Notes

- First deployment takes 3-5 minutes
- Free tier spins down after 15 minutes of inactivity
- For production use, upgrade to paid tier ($12/month)
- Render logs are available in the dashboard for debugging
