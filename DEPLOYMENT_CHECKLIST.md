- [ ] Create Supabase project
- [ ] Run supabase/schema.sql
- [ ] Enable email authentication and create your account
- [ ] Disable public sign-ups after account creation
- [ ] Open index.html and configure the Supabase URL and publishable/anon key
- [ ] Import data/starter-import.csv once; review any questionable vintage/cost details
- [ ] Deploy static files to Vercel, Netlify, or Cloudflare Pages
- [ ] Configure same Supabase connection on iPhone and computer
- [ ] Import remaining Garagiste history, then Wine Spies, Last Bottle, WTSO and K&L Wines
- [ ] Reconcile duplicates and bottles consumed before treating counts/spend as final


## Import safety update
- Blank optional dates and optional numeric fields are normalized to database NULL; year-only or malformed purchase dates are ignored as unknown rather than sent as invalid dates.
- CSV import checks the current inventory and skips exact normalized producer + wine name + vintage duplicates.
- For an existing cellar, import `data/garagiste-missing-only-import.csv`, not the full reconciled review CSV.
- Vivino/CellarTracker/market-price/drinking-window enrichment remains pending wherever those fields are blank.
