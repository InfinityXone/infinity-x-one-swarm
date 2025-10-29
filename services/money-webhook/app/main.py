from fastapi import FastAPI
import os, asyncio, time
from .jobs.revenue_autopilot import run_revenue_autopilot
from .jobs.ecom_growth_studio import run_ecom_growth

app = FastAPI()
START = int(time.time())

@app.get("/")
def root():
    return {"ok": True, "service": "money-webhook", "uptime_s": int(time.time())-START}

@app.get("/healthz")
def health():
    return {"ok": True}

@app.post("/")
async def webhook(event: dict):
    # Accepts posted money events from swarm runners or external hooks;
    # for now, just echo/ack; add routing to Sheets/DB later.
    return {"ok": True, "received": event}

@app.get("/jobs/tick")
async def tick():
    # Optional internal monetization tick (reuses same loops).
    results = await asyncio.gather(
        run_revenue_autopilot(),
        run_ecom_growth(),
        return_exceptions=True
    )
    out = []
    for r in results:
        if isinstance(r, Exception):
            out.append({"ok": False, "error": str(r)})
        else:
            out.append(r)
    return {"ok": True, "results": out}
