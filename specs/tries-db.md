# Spec: Tries Database (Notion)

## Intent

A log of every tasting session — one entry each time a specific coffee is brewed and tasted. The goal is to answer:

1. What did this coffee taste like on a given day?
2. How many days off roast was it?
3. What recipe was used, and would I use it again?

This DB captures what changes across sessions: flavor impressions, brew variables, freshness. Facts about the coffee itself (origin, process, price) belong in the Beans DB.

---

## Scope

One entry per tasting session. The same bag can generate multiple entries over time — this is intentional. Comparing entries for the same bean reveals how taste evolves as beans age.

Not in scope:

- Coffee product facts (Beans DB)
- Roaster information (Roasters DB)
- Brewing recipes themselves (pages/brewing/)

---

## Fields

### Identity

| Field | Type | Depth |
|---|---|---|
| Name | Title | Descriptive label, e.g. "Kima Bette Buna — 2026-04-19". Manual or auto-composed. |
| Bean | Relation → Beans DB | Which coffee was tasted. Two-way: Beans DB shows all tries for that bean. |
| Date Tried | Date | When the session happened |

### Freshness

| Field | Type | Depth |
|---|---|---|
| Roast Date | Date | From the bag. Combined with Date Tried, shows days off roast. |

### Brew

| Field | Type | Depth |
|---|---|---|
| Brew Method | Select | AeroPress / Clever Dripper |
| Recipe | Relation → Recipes DB | Which recipe was used. Two-way: Recipes DB shows all tries for that recipe. |
| Adjustments | Text | Per-session deviations from the base recipe, e.g. "coarser grind, +10s after boil". Leave blank when recipe was followed exactly. |

### Tasting

| Field | Type | Depth |
|---|---|---|
| Flavor Notes | Text | What you tasted — informal, no required vocabulary |
| Overall Score | Number | 1–10 |

### Notes

| Field | Type | Depth |
|---|---|---|
| Notes | Text | Anything else: who was present, context, equipment observations |

---

## Implementation reference

**Notion database URL:** https://www.notion.so/9d514be0aa5b4f1fad77973add43e294
**Data source ID:** 953ef057-359b-4d7f-860e-1aa25acf0bc0

Column order and types as implemented (do not reorder):

| # | Field | Notion type | Values |
|---|---|---|---|
| 1 | Name | title | |
| 2 | Bean | relation | → Beans DB, two-way |
| 3 | Date Tried | date | |
| 4 | Roast Date | date | |
| 5 | Brew Method | select | AeroPress / Clever Dripper |
| 6 | Recipe | relation | → Recipes DB, two-way |
| 6a | Adjustments | text | per-session deviations; blank if recipe followed exactly |
| 7 | Flavor Notes | text | |
| 8 | Overall Score | number | 1–10, blank until scored |
| 9 | Notes | text | |

---

## Open questions

None.
