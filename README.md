# Cellar Notes — Wine Cellar MVP

A mobile-friendly browser app prepared for deployment with a private Supabase database. Features include account sign-in, shared cloud inventory across devices, adding/editing wines, adjusting remaining bottle counts, search and filters, CSV import/export, category breakdown, recorded purchase spend and average cost.

## Setup (about 15 minutes)
1. Create a project at https://supabase.com/.
2. Open the project's SQL Editor and run `supabase/schema.sql`.
3. Under Authentication, enable Email. Create your own account. After you have an account, disable public sign-ups if this will remain a personal cellar.
4. Open `index.html` in a browser. The first-run prompt asks for the Supabase project URL and publishable/anon key; those values are stored in that browser's local storage. Repeat on your other devices.
5. Import `data/starter-import.csv` using the Import CSV control if you are starting from an empty cellar.
6. If you already imported that starter list, use `data/garagiste-missing-only-import.csv` instead. It contains only records not matched to the starter CSV; the importer also skips exact duplicate producer + wine + vintage keys already in the live cellar.

## Cloud hosting
This is a static app and can be hosted on Vercel, Netlify, or Cloudflare Pages:
- Push the files to a private GitHub repository.
- Import the repository into the host as a static site; publish directory is the repository root.
- Add a custom domain if desired.
- For each browser/device, configure the same Supabase URL and publishable/anon key once.
- The data is in Supabase, so records synchronize when signed into the same account.

This package is **prepared for deployment, not already deployed**. No hosting or Supabase account has been connected in this chat. I cannot create accounts or publish to your accounts without an authorized connection.

## Data notes
`starter-import.csv` is the original starter file and is preserved unchanged. `garagiste-missing-only-import.csv` is an add-only extract reconciled against that starter file. `starter-import-reconciled-review.csv` is a combined review copy; do not import it into an already-populated cellar. `garagiste-reconciliation-audit.csv` shows which source records were treated as already present versus missing.
- The reconciliation extracted 180 unique wine identities from the supplied Garagiste purchase history, matched 36 to the original starter CSV, and put 144 unmatched records in the add-only import. Three non-wine purchases (a retail purchase without item detail, chocolate, and a decanter) were excluded.
- Scores, review counts, CellarTracker scores, market prices, verdicts, and drinking windows are blank where not independently verified. Do not treat the CSV as a completed ratings/drinking-window research pass.
- The app normalizes blank/invalid optional purchase dates to database `NULL`, keeps blank optional numeric fields as `NULL`, and skips exact duplicate producer + wine + vintage keys during CSV import.
- `unit_price` = pre-tax cost per bottle. `unit_price_with_tax` = tax-inclusive cost per bottle. `quantity_purchased` is historical quantity; `quantity_remaining` is a separate editable inventory quantity.
- `unit_price` = pre-tax cost per bottle.
- `unit_price_with_tax` = tax-inclusive cost per bottle.
- `quantity_purchased` is historical quantity; `quantity_remaining` is a separate editable inventory quantity.
- Unverified scores and market prices should remain blank rather than guessed.
- CSV import supports the column names in `data/starter-import.csv`.

## Security
The SQL schema enables row-level security so a signed-in user can only access their own records. Only use the public publishable/anon key in browser code. Never use a Supabase `service_role` key in this app. Restrict sign-ups after creating your account.
