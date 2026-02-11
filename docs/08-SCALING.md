# TaskTrakr AI Scaling Strategy

> Load when planning for growth beyond MVP

## Cost by Scale

| Users | AI Calls/Month | Gemini Free | Paid Cost |
|-------|---------------|-------------|-----------|
| 10K | 2K | ✅ Free | $0 |
| 50K | 10K | ✅ Free | $0 |
| 100K | 20K | ⚠️ Near limit | $20 |
| 500K | 100K | ❌ Over | $100 |
| 1M | 200K | ❌ Over | $200 |

---

## Scaling Phases

### Phase 1: MVP (0-50K users)
**Strategy:** Gemini Free Tier + 5 Templates

- Free tier: 1M tokens/month
- ~10K generations/month
- **Cost: $0**

### Phase 2: Growth (50K-200K users)
**Strategy:** Expand templates + Gemini paid if needed

- Add 20+ templates (cover 90% of goals)
- Gemini paid: ~$50-100/month
- **Cost: $50-100/month**

### Phase 3: Scale (200K-500K users)
**Strategy:** Evaluate serverless GPU

Options:
- Modal: ~$0.001/generation
- Replicate: ~$0.001/generation
- Dedicated GCP T4: $250/month fixed

**Cost: $100-300/month**

### Phase 4: High Scale (500K+ users)
**Strategy:** Self-host open source LLM

- GCP T4 + Llama 3 8B: $250/month fixed
- Handles unlimited generations
- **Cost: $250-500/month**

---

## Cost Comparison

```
Generations/month:  10K    50K    100K   500K
──────────────────────────────────────────────
Gemini API         $10    $50    $100   $500
Serverless GPU     $10    $50    $100   $500
Dedicated T4       $250   $250   $250   $250
                                  ↑
                          Break-even ~100K/month
```

---

## Template Strategy

Templates = Free AI calls

| Coverage | AI Calls Saved |
|----------|---------------|
| 80% | 80% |
| 90% | 90% |
| 95% | 95% |

**Recommendation:** Build 50+ templates covering common goals in all categories.

---

## Serverless GPU Options

| Provider | Price/sec | Cold Start |
|----------|-----------|------------|
| Modal | $0.0003 | 10-30s |
| Replicate | $0.0005 | 5-15s |
| RunPod | $0.0002 | 30-60s |
| Beam | $0.0003 | 15-30s |

**Cost at 100K generations:**
- 100K × 3 sec × $0.0003 = **$90/month**

---

## Self-Hosted Setup (Phase 4)

### GCP T4 Server
- Cost: ~$250/month (24/7)
- Model: Llama 3.1 8B Instruct
- Throughput: ~10-20 req/sec

### Stack
```
Load Balancer (Cloud Run)
       ↓
GCE Instance (T4 GPU)
       ↓
vLLM Server (Llama 3)
```

### When to Self-Host
- 250K+ generations/month
- Predictable, steady traffic
- Need full control

---

## Decision Tree

```
Monthly generations?
       ↓
< 10K → Gemini Free
       ↓
10K-100K → Gemini Paid or Templates
       ↓
100K-250K → Evaluate Serverless GPU
       ↓
> 250K → Consider Self-Hosting
```

---

## Recommendations by Phase

| Phase | Strategy |
|-------|----------|
| **MVP** | Gemini Free ($0) |
| **10K users** | Gemini Free + templates |
| **50K users** | Gemini Paid (~$50) |
| **200K users** | Serverless GPU (~$200) |
| **500K+ users** | Self-host Llama 3 (~$250) |

**Key Insight:** Don't over-engineer early. Start with Gemini free tier.
