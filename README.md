# Cellar Notes — Wine Cellar MVP

A mobile-friendly browser app prepared for deployment with a private Supabase database. Features include account sign-in, shared cloud inventory across devices, adding/editing wines, adjusting remaining bottle counts, search and filters, CSV import/export, category breakdown, recorded purchase spend and average cost.

## Setup (about 15 minutes)
1. Create a project at https://supabase.com/.
2. Open the project's SQL Editor and run `supabase/schema.sql`.
3. Under Authentication, enable Email. Create your own account. After you have an account, disable public sign-ups if this will remain a personal cellar.
4. Open `index.html` in a browser. The first-run prompt asks for the Supabase project URL and publishable/anon key; those values are stored in that browser's local storage. Repeat on your other devices.
5. Import `data/starter-import.csv` using the Import CSV control.

## Cloud hosting
This is a static app and can be hosted on Vercel, Netlify, or Cloudflare Pages:
- Push the files to a private GitHub repository.
- Import the repository into the host as a static site; publish directory is the repository root.
- Add a custom domain if desired.
- For each browser/device, configure the same Supabase URL and publishable/anon key once.
- The data is in Supabase, so records synchronize when signed into the same account.

This package is **prepared for deployment, not already deployed**. No hosting or Supabase account has been connected in this chat. I cannot create accounts or publish to your accounts without an authorized connection.

## Data notes
`starter-import.csv` is a partial seed from purchase details already discussed, not the complete six-year Garagiste history. It has 29 rows; some purchase dates are approximate or blank, and ratings/market prices are intentionally blank unless previously user-supplied. Review the CSV before import. The app warns that re-importing a CSV can create duplicates; import each file once unless you intend duplicate lots.
- `unit_price` = pre-tax cost per bottle.
- `unit_price_with_tax` = tax-inclusive cost per bottle.
- `quantity_purchased` is historical quantity; `quantity_remaining` is a separate editable inventory quantity.
- Unverified scores and market prices should remain blank rather than guessed.
- CSV import supports the column names in `data/starter-import.csv`.

## Security
The SQL schema enables row-level security so a signed-in user can only access their own records. Only use the public publishable/anon key in browser code. Never use a Supabase `service_role` key in this app. Restrict sign-ups after creating your account.
