import asyncio, httpx, re
from .common import post_money_event, BRAND_NAME

STARTER_PDP = [
    "https://www.apple.com/iphone/",
    "https://store.google.com/product/pixel_phone",
]

async def fetch_head(url: str):
    try:
        async with httpx.AsyncClient(timeout=20) as client:
            r = await client.get(url, follow_redirects=True, headers={"User-Agent":"IX1-Growth/1.0"})
            return url, r.status_code, r.text[:200000]
    except Exception as e:
        return url, 0, f"ERR:{e}"

def simple_heuristics(html: str):
    imgs = len(re.findall(r"<img\b", html, re.I))
    h1 = bool(re.search(r"<h1\b", html, re.I))
    desc_len = len(re.findall(r"[A-Za-z0-9]{3,}", html))
    return {"images": imgs, "has_h1": h1, "desc_score": desc_len}

async def run_ecom_growth():
    results = await asyncio.gather(*[fetch_head(u) for u in STARTER_PDP])
    tests = []
    for url, code, body in results:
        if code != 200 or body.startswith("ERR:"): continue
        heur = simple_heuristics(body)
        suggestion = []
        if not heur["has_h1"]: suggestion.append("Add a strong <h1> with 7-12 word benefit")
        if heur["images"] < 3: suggestion.append("Add more product images above the fold")
        if heur["desc_score"] < 2000: suggestion.append("Expand description with social proof and specs")
        tests.append({"url": url, "ideas": suggestion or ["Run price-parity CTR test (A/B)"]})

    resp = await post_money_event("ecom_ab_queue", {
        "loop": "ecom_growth_studio",
        "tests": tests[:5],
        "note": f"{BRAND_NAME} recommends 1-2 tiny changes per PDP and measures uplift."
    })
    return {"ok": True, "queued": len(tests[:5]), "sent": resp}
