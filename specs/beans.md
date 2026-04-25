# Beans — Field Specs

Canonical definitions for fields in the Notion Beans DB. Skills reference this file rather than embedding rules inline.

---

## Roast Profile

The `Roast Profile` property on bean pages is a single-select with three canonical values:

| Value | Meaning |
|---|---|
| `Filter` | Roasted for filter brewing methods only |
| `Espresso` | Roasted for espresso only |
| `Omni` | Roasted to work for both filter and espresso |

### Mapping rules

**From grind variant options (most reliable signal):**
- Filter grind only available → `Filter`
- Espresso grind only available → `Espresso`
- Both filter and espresso grind options available → `Omni`

**From explicit bag / page labels (English):**
- "Filter", "Filter Roast", "For Filter" → `Filter`
- "Espresso", "Espresso Roast", "For Espresso" → `Espresso`
- "Omni", "Omni-roast", "Omniroast", "All-purpose", "Universal" → `Omni`

**From explicit bag / page labels (Spanish):**
- "Filtro", "Para filtro", "Tostado para filtro" → `Filter`
- "Espresso", "Para espresso", "Tostado para espresso" → `Espresso`
- "Omni", "Omniroast" → `Omni`

**From brewer list (when the page lists compatible brewers instead of a profile name):**
- V60, Chemex, AeroPress, Kalita, Clever Dripper, Pour Over, Drip → `Filter`
- If both AeroPress and espresso machine appear in the list → `Omni`

**Fallback — when no label and no variant options:**
- Leave blank. Do not guess.

### Roasters DB — Roast Style field

The `Roast Style` field on roaster pages (same three values, multi-select) should hold the union of all `Roast Profile` values across the roaster's beans. It is populated manually or via `/sync-roaster` after beans are synced.

Note: the Notion MCP cannot set multiple multi-select values in a single API call — only one value can be written at a time. If a roaster has more than one profile (e.g. Filter + Omni), the additional values must be added manually in Notion.

---

## Page content — sourced data sections

Each bean page should preserve the original source data in its page body, even after values are mapped to canonical form. This ensures traceability and allows re-evaluation without going back to the source.

### Sections

**`## Info from web`** — populated by `/add-bean` on creation. Contains the raw text from the product page for fields that required interpretation or mapping:
- Roast profile label as it appears on the page (e.g. "Recomendado para filtros / V60 / AeroPress")
- Any other original text that was transformed or abbreviated to fit a property field

**`## Info from package`** — left blank on creation. Filled manually after receiving the physical bag. Contains what the actual packaging says — useful for comparing to what the website claims.

### Format

```
## Info from web
- **Roast profile (as listed):** "Recomendado para filtros / V60 / AeroPress" → mapped to Filter
- **Process (as listed):** "Lavado" → mapped to Washed

## Info from package
(to be filled after receiving the bag)
```

Only include lines for fields that needed interpretation. Leave out fields taken verbatim (e.g. farm name, altitude number).
