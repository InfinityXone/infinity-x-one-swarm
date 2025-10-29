import os, json, time, httpx

MONEY_WEBHOOK_URL = os.getenv("MONEY_WEBHOOK_URL", "").strip()
STRIPE_API_KEY = os.getenv("STRIPE_API_KEY", "").strip()
STRIPE_PRICE_ID = os.getenv("STRIPE_PRICE_ID", "").strip()
SENDGRID_API_KEY = os.getenv("SENDGRID_API_KEY", "").strip()
BRAND_NAME = os.getenv("BRAND_NAME", "Infinity X One")
OUTBOUND_FROM_EMAIL = os.getenv("OUTBOUND_FROM_EMAIL", "")
OUTBOUND_REPLY_TO = os.getenv("OUTBOUND_REPLY_TO", OUTBOUND_FROM_EMAIL)

def now_iso():
    return time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())

async def post_money_event(event_type: str, payload: dict):
    if not MONEY_WEBHOOK_URL:
        return {"ok": False, "skipped": "MONEY_WEBHOOK_URL not set"}
    async with httpx.AsyncClient(timeout=30) as client:
        r = await client.post(MONEY_WEBHOOK_URL, json={
            "type": event_type,
            "brand": BRAND_NAME,
            "ts": now_iso(),
            "payload": payload,
        })
        return {"ok": r.status_code < 300, "status": r.status_code, "resp": r.text[:400]}

async def create_stripe_link(qty=1):
    if not STRIPE_API_KEY or not STRIPE_PRICE_ID:
        return None
    headers = {"Authorization": f"Bearer {STRIPE_API_KEY}"}
    data = {
        "line_items[0][price]": STRIPE_PRICE_ID,
        "line_items[0][quantity]": str(qty),
        "mode": "payment",
        "allow_promotion_codes": "true",
    }
    async with httpx.AsyncClient(timeout=30) as client:
        r = await client.post("https://api.stripe.com/v1/checkout/sessions", headers=headers, data=data)
        if r.status_code >= 300:
            return None
        sess = r.json()
        return sess.get("url")

async def send_sendgrid_email(to_email: str, subject: str, html: str):
    if not SENDGRID_API_KEY or not OUTBOUND_FROM_EMAIL:
        return {"ok": False, "skipped": "SENDGRID/OUTBOUND vars not set"}
    payload = {
        "personalizations": [{"to": [{"email": to_email}]}],
        "from": {"email": OUTBOUND_FROM_EMAIL, "name": BRAND_NAME},
        "reply_to": {"email": OUTBOUND_REPLY_TO or OUTBOUND_FROM_EMAIL},
        "subject": subject,
        "content": [{"type":"text/html","value": html}],
    }
    headers = {
        "Authorization": f"Bearer {SENDGRID_API_KEY}",
        "Content-Type": "application/json"
    }
    async with httpx.AsyncClient(timeout=30) as client:
        r = await client.post("https://api.sendgrid.com/v3/mail/send", headers=headers, json=payload)
        return {"ok": r.status_code in (200, 202), "status": r.status_code, "resp": r.text[:400]}
