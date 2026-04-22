# Coffee Club — Project Plan

---

## End Goal

A shared, live resource for the office coffee club — populated enough to guide sourcing decisions, track what's been tried, and give members something useful to browse. The Tuesday morning vision stays: freshly roasted beans, AeroPress brews for 5–6 people, side-by-side comparisons, natural conversation around the cup. But it runs on the data.

---

## The Problems to Solve

**Memory** — a lot of beans tried over time, but no record to compare or build on. Each new bag starts from scratch.

**Brewing** — need reliable AeroPress recipes for different roast levels, including the medium-dark non-specialty beans that friends bring in. Also need a decaf option for later hours.

**Sourcing** — need a trusted, rotating supply of fresh beans (specialty and decaf) in Malaga, knowing which roasters to rely on and which to avoid.

---

## The Social Goal

Let people taste the difference themselves rather than explaining it. Create contrast moments — two brews side by side, different beans, let the cup do the talking.

---

## Success Definition

> A perfect Tuesday morning: freshly roasted beans, AeroPress brews for 5–6 people, 2–3 bags of different beans, small portions from each brew, talking about life and coffee.

This is the measure. Everything in this project either makes that morning better or it doesn't.

---

## Tasks

| Goal | Status |
|---|---|
| Data & Infrastructure | 🔄 In progress |
| Club | 🔄 In progress |
| Sourcing | 🔄 In progress |
| Skills & Tooling | 🔄 In progress |
| Brewing | ⬜ Not started |
| Going Deeper | 🔄 In progress |

---

### Data & Infrastructure

| Task | Status |
|---|---|
| Set up Roasters DB, Beans DB, and Tries DB in Notion | ✅ Done |
| Publish Coffee Club landing page with inline views of all three databases | ✅ Done |
| Build `/add-bean` and `/update-roaster` skills for syncing offerings | ✅ Done |
| Sync Mountain Coffee offerings (10 beans) | ✅ Done |
| Sync Artisan Coffee offerings via `/update-roaster` | ✅ Done |
| Sync Kima Coffee offerings via `/update-roaster` | ✅ Done |
| Sync Bertani Café offerings via `/update-roaster` | ✅ Done |
| Sync Brewing Dealers offerings via `/update-roaster` | ✅ Done |
| Add La Hacienda offerings manually (site blocked by bot protection) | ⬜ To do |
| Fill in quality and logistics fields for Artisan, Kima, Bertani, La Hacienda | ✅ Done |
| Design and implement Recipes DB — structured brew parameters, referenced from Tries as base recipe with per-session adjustments | ✅ Done |
| Design and implement Cafes DB — track specialty cafes in Málaga with quality signals, location, and what they serve | ⬜ To do |
| Research Málaga-area roasters headquartered elsewhere but roasting in Málaga (Syra Coffee, Hola Coffee, Nomad Coffee, others) | ⬜ To do |

---

### Club

| Task | Status |
|---|---|
| Publish Coffee Club landing page and share with members | ✅ Done |
| Set up tasting log — Tries DB with enough structure to capture impressions without friction | ✅ Done |
| Create an easy way to log brew sessions — record the bean, recipe used, and any adjustments | ⬜ To do |
| Build a tasting rating format — a lightweight way to score the brew and describe the taste in the session | ⬜ To do |

---

### Initiatives

#### Side-by-side comparison
Introduce contrast moments during office brews — two beans, two cups at once, let the cup do the talking.

| Sub-task | Status |
|---|---|
| Formulate the idea clearly | ⬜ To do |
| Present to the club and see if it lands | ⬜ To do |
| Get the equipment (wide shallow glasses — rocks glasses or small bistro glasses) | ⬜ To do |
| Set up the practice | ⬜ To do |

---

### Skills & Tooling

| Task | Status |
|---|---|
| Add `/fetch-db` skill — queries Notion with filters rather than fetching all entries; reduces empty-filter calls when looking up a specific roaster or bean | ✅ Done |
| Document how to set the Location (place) field — required sub-fields (name, address, latitude, longitude), geocoding approach; referenced by `/add-roaster` and future `/add-cafe` | ⬜ To do |

---

### Sourcing

| Task | Status |
|---|---|
| Have an honest, documented picture of each Malaga roaster — quality, offerings, how to buy | 🔄 In progress |
| Have a confirmed decaf source — tried and logged, not just tracked | ⬜ To do |
| Know the freshness window — when coffee is too fresh (under-rested) and when it has expired | ⬜ To do |
| Know what to do when a roast date is recent but beans have no smell | ⬜ To do |
| Know which Spanish and Canarian roasters are worth ordering from and ship reliably to Malaga | ⬜ To do |
| Know which Malaga cafes genuinely understand what they serve | ⬜ To do |

---

### Brewing

| Task | Status |
|---|---|
| Have reliable, tested AeroPress recipes for light/filter roasts — bringing out the best of specialty | ⬜ To do |
| Have reliable, tested AeroPress recipes for medium-dark non-specialty roasts — making the most of what's already in the office | ⬜ To do |
| Understand omni roast vs light/filter roast — which works better on AeroPress and why | ⬜ To do |
| Know what water to use in Malaga, why tap water is unsuitable, and which bottled or filtered option works best | ⬜ To do |

---

### Going Deeper

Statuses: ⬜ To do · 📄 Draft (AI draft in repo) · 🔄 Writing (personally researching/writing) · ✅ Published (personally elaborated, live in Notion)

| Task | Status |
|---|---|
| Know what qualifies coffee as specialty and whether SCA scoring is required or if good roasters skip it | 📄 Draft |
| Be able to read a bag label confidently — roast date, origin depth, processing, score, roast profile | 📄 Draft |
| Know why coffee in Malaga is so bitter — torrefacto, mezcla, dark commercial, dirty machines | 📄 Draft |
| Be able to identify mezcla and torrefacto visually and by smell before buying | 📄 Draft |
| Know what non-specialty can work for filter brewing and which brands are accessible in Malaga | 📄 Draft |
| Understand how coffee taste preferences differ by region across Spain, Portugal, France, and Italy | 📄 Draft |
| Understand the full chain from origin to cup — where quality is built or lost at each stage | ⬜ To do |
| Understand the cost breakdown — why specialty is priced the way it is, and at what price point claims become implausible | ⬜ To do |
| Know how to evaluate decaf — what processing methods matter and what to look for | ⬜ To do |
| Understand what SCA and ECBC are and why they matter as references | ⬜ To do |
| Know what cuppings, workshops, and courses exist in Malaga and Spain | ⬜ To do |
| Understand direct trade — whether farms are contactable and what that relationship looks like | ⬜ To do |

---

## What This Is Not

- Not a review site
- Not a ranking or award system
- Not aimed at industry insiders
