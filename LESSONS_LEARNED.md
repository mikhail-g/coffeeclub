# Lessons Learned — Working with AI on a Real Project

Notes for a presentation on what actually works (and what doesn't) when building with Claude Code on a non-trivial personal project.

---

## Structuring the work

## Prompting and instruction

## Skills and automation

## Data and integrations (Notion)

- **`notion-search` treats keywords as OR, not AND.** Searching for "Kima Coffee" returns Kima Coffee first — but also Artisan Coffee, Mountain Coffee, Santa Coffee, and Bertani Café, because each of them contains the word "coffee". Any keyword match is enough to include a result; both words matching just scores higher. This means multi-word queries intended to narrow results actually broaden them. Searching for a specific roaster by name when other roasters share common words (like "coffee" or "café") will reliably return the wrong pages. Wrapping the query in quotes (`"Kima Coffee"`) narrows results to pages that *contain* the exact phrase — it returned only Kima Coffee because no other roaster name contains the substring "Kima Coffee". But it is still a *contains* match, not an *is* match: `"Mountain Water"` returns "Descafeinado Mountain Water – Chiapas" because the title contains those words, not because the title equals the query. This means quoted search only works reliably when the phrase is unique enough to not appear as a substring of something else. The reliable fix: store the Notion page URL in a local reference file the first time a roaster is added, then read it directly on every subsequent call — no search needed.

- **Relation fields are invisible to `notion-search`.** Searching the Beans DB for "Mountain Coffee" returns zero Mountain Coffee beans — because "Mountain Coffee" only exists in each bean's Roaster relation field, which points to the roaster page but is not indexed as text. Instead it returned a bean called "Descafeinado Mountain Water" (the word "mountain" appeared in the title for unrelated reasons) and other fuzzy noise. To get all beans for a roaster, you must: fetch the roaster's own Notion page and follow the `Beans` relation links. There is no shortcut through search.

## What surprised me

## What I'd do differently
