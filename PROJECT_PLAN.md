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

## Todo

| Section | Status |
|---|---|
| Data & Infrastructure | 🔄 In progress |
| Club | 🔄 In progress |
| Initiatives | ⬜ Not started |
| Skills & Tooling | ✅ Done |
| Sourcing | 🔄 In progress |
| Brewing | ⬜ Not started |
| Going Deeper | 🔄 In progress |

---

### Data & Infrastructure

| ID | Task | Status |
|---|---|---|
| 1.1 | Set up Roasters DB, Beans DB, and Tries DB in Notion | ✅ Done |
| 1.2 | Publish Coffee Club landing page with inline views of all three databases | ✅ Done |
| 1.3 | Build `/add-bean` and `/update-roaster` skills for syncing offerings | ✅ Done |
| 1.4 | Sync Mountain Coffee offerings (10 beans) | ✅ Done |
| 1.5 | Sync Artisan Coffee offerings via `/update-roaster` | ✅ Done |
| 1.6 | Sync Kima Coffee offerings via `/update-roaster` | ✅ Done |
| 1.7 | Sync Bertani Café offerings via `/update-roaster` | ✅ Done |
| 1.8 | Sync Brewing Dealers offerings via `/update-roaster` | ✅ Done |
| 1.9 | Add La Hacienda offerings manually (site blocked by bot protection) | ✅ Done |
| 1.10 | Fill in quality and logistics fields for Artisan, Kima, Bertani, La Hacienda | ✅ Done |
| 1.11 | Design and implement Recipes DB — structured brew parameters, referenced from Tries as base recipe with per-session adjustments | ✅ Done |
| 1.12 | Design and implement Cafes DB — track specialty cafes in Málaga with quality signals, location, and what they serve | ⬜ To do |
| 1.13 | Add "Co-fermented" field to Beans DB — boolean flag; currently buried in descriptions or process names | ⬜ To do |
| 1.14 | Add packaging/format field to Beans DB — single bag vs. multi-pack vs. tasting set; affects price comparison | ⬜ To do |
| 1.15 | Research Málaga-area roasters headquartered elsewhere but roasting in Málaga (Syra Coffee, Hola Coffee, Nomad Coffee, others) | ⬜ To do |
| 1.16 | Make Roast Profile in Roasters DB a multi-select — already multi-select in Notion; should hold all profiles offered by the roaster's beans (e.g. Filter + Omni if they carry both) | ✅ Done |
| 1.17 | Move Bertani Café from Roasters DB to Cafes DB — it is a cafe, not a roaster; the actual roaster behind its beans is "Café de Finca" | ⬜ To do |
| 1.18 | Add "Café de Finca" as a roaster entry and re-map all Bertani beans to it in the Roaster relation field | ⬜ To do |
| 1.19 | Define a canonical Roast Profile mapping in `specs/beans.md` — standardise the values (Filter / Espresso / Omni) and document how to map bag labels to them: brewer lists (V60, Chemex, AeroPress, Kalita → Filter), Spanish terms (Filtro, Espresso, Omni), mixed labels, etc. Update `/add-bean` to use that mapping | ✅ Done |

---

### Club

| ID | Task | Status |
|---|---|---|
| 2.1 | Publish Coffee Club landing page and share with members | ✅ Done |
| 2.2 | Set up tasting log — Tries DB with enough structure to capture impressions without friction | ✅ Done |
| 2.3 | Create an easy way to log brew sessions — record the bean, recipe used, and any adjustments | ⬜ To do |
| 2.4 | Build a tasting rating format — a lightweight way to score the brew and describe the taste in the session | ⬜ To do |

---

### Initiatives

#### Side-by-side comparison
Introduce contrast moments during office brews — two beans, two cups at once, let the cup do the talking.

| ID | Sub-task | Status |
|---|---|---|
| 3.1 | Formulate the idea clearly | ⬜ To do |
| 3.2 | Present to the club and see if it lands | ⬜ To do |
| 3.3 | Get the equipment (wide shallow glasses — rocks glasses or small bistro glasses) | ⬜ To do |
| 3.4 | Set up the practice | ⬜ To do |

---

### Skills & Tooling

| ID | Task | Status |
|---|---|---|
| 4.1 | Add `/fetch-db` skill — queries Notion with filters rather than fetching all entries; reduces empty-filter calls when looking up a specific roaster or bean | ✅ Done |
| 4.2 | Document how to set the Location (place) field — required sub-fields (name, address, latitude, longitude), geocoding approach; referenced by `/add-roaster` and future `/add-cafe` | ✅ Done |
| 4.3 | Investigate caching Notion DB results locally — reduce redundant fetches, speed up skills like `/fetch-db` and `/update-roaster` | ✅ Done |

---

### Sourcing

| ID | Task | Status |
|---|---|---|
| 5.1 | Have an honest, documented picture of each Malaga roaster — quality, offerings, how to buy | 🔄 In progress |
| 5.2 | Have a confirmed decaf source — tried and logged, not just tracked | ⬜ To do |
| 5.3 | Know the freshness window — when coffee is too fresh (under-rested) and when it has expired | ⬜ To do |
| 5.4 | Know what to do when a roast date is recent but beans have no smell | ⬜ To do |
| 5.5 | Know which Spanish and Canarian roasters are worth ordering from and ship reliably to Malaga | ⬜ To do |
| 5.6 | Know which Malaga cafes genuinely understand what they serve | ⬜ To do |

---

### Brewing

| ID | Task | Status |
|---|---|---|
| 6.1 | Have reliable, tested AeroPress recipes for light/filter roasts — bringing out the best of specialty | ⬜ To do |
| 6.2 | Have reliable, tested AeroPress recipes for medium-dark non-specialty roasts — making the most of what's already in the office | ⬜ To do |
| 6.3 | Understand omni roast vs light/filter roast — which works better on AeroPress and why | ⬜ To do |
| 6.4 | Know what water to use in Malaga, why tap water is unsuitable, and which bottled or filtered option works best | ⬜ To do |

---

### Going Deeper

Statuses: ⬜ To do · 📄 Draft (AI draft in repo) · 🔄 Writing (personally researching/writing) · ✅ Published (personally elaborated, live in Notion)

| ID | Task | Status |
|---|---|---|
| 7.1 | Know what qualifies coffee as specialty and whether SCA scoring is required or if good roasters skip it | 📄 Draft |
| 7.2 | Be able to read a bag label confidently — roast date, origin depth, processing, score, roast profile | 📄 Draft |
| 7.3 | Know why coffee in Malaga is so bitter — torrefacto, mezcla, dark commercial, dirty machines | 📄 Draft |
| 7.4 | Be able to identify mezcla and torrefacto visually and by smell before buying | 📄 Draft |
| 7.5 | Know what non-specialty can work for filter brewing and which brands are accessible in Malaga | 📄 Draft |
| 7.6 | Understand how coffee taste preferences differ by region across Spain, Portugal, France, and Italy | 📄 Draft |
| 7.7 | Understand the full chain from origin to cup — where quality is built or lost at each stage | ⬜ To do |
| 7.8 | Understand the cost breakdown — why specialty is priced the way it is, and at what price point claims become implausible | ⬜ To do |
| 7.9 | Know how to evaluate decaf — what processing methods matter and what to look for | ⬜ To do |
| 7.10 | Understand what SCA and ECBC are and why they matter as references | ⬜ To do |
| 7.11 | Know what cuppings, workshops, and courses exist in Malaga and Spain | ⬜ To do |
| 7.12 | Understand direct trade — whether farms are contactable and what that relationship looks like | ⬜ To do |

---

## What This Is Not

- Not a review site
- Not a ranking or award system
- Not aimed at industry insiders
