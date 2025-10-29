import re, asyncio, httpx
from .common import post_money_event, create_stripe_link, send_sendgrid_email, BRAND_NAME

PUBLIC_FEEDS = [
    "https://hnrss.org/newest?points=5",
    "https://www.producthunt.com/feed",
    "https://remoteok.com/remote-dev+ai.rss",
]

def pick_offers_from_text(txt: str, limit=3):
    items = []
    for m in re.finditer(r"https?://\S+", txt):
        items.append({"url": m.group(0)})
        if len(items) >= limit: break
    return items

async def fetch_feed(url: str) -> str:
    try:
        async with httpx.AsyncClient(timeout=20) as client:
            r = await client.get(url, headers={"User-Agent":"IX1-Autopilot/1.0"})
            return r.text[:200000]
    except Exception as e:
        return f"ERR: {e}"

async def run_revenue_autopilot():
    blobs = await asyncio.gather(*[fetch_feed(u) for u in PUBLIC_FEEDS])
    candidates = []
    for b in blobs:
        if not b or b.startswith("ERR:"):
            continue
        candidates += pick_offers_from_text(b, limit=2)
    seen, uniq = set(), []
    for c in candidates:
        u = c["url"]
        if u not in seen:
            uniq.append(c); seen.add(u)

    pay_url = await create_stripe_link(qty=1)
    payload = {
        "loop": "revenue_autopilot",
        "candidates": uniq[:5],
        "offer": {
            "title": f"{BRAND_NAME}: AI Build + Growth Sprint",
            "price_link": pay_url,
            "cta": "Book now and we build + launch your AI growth loop in 48h.",
        }
    }
    resp = await post_money_event("lead_offer", payload)
    return {"ok": True, "sent": resp, "count": len(uniq[:5])}
