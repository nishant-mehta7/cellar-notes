create extension if not exists pgcrypto;
create table if not exists public.wines (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 producer text not null default '', wine_name text not null,
 vintage text not null default '', region text not null default '', country text not null default '',
 category text not null default 'Red', grape text not null default '', merchant text not null default '',
 purchase_date date, quantity_purchased integer not null default 1 check(quantity_purchased>=0),
 quantity_remaining integer not null default 1 check(quantity_remaining>=0),
 unit_price numeric(10,2) not null default 0 check(unit_price>=0), unit_price_with_tax numeric(10,2),
 currency text not null default 'USD', vivino_score numeric(3,2), vivino_reviews integer,
 cellartracker_score numeric(5,2), market_price numeric(10,2),
 verdict text not null default 'Unrated', drink_from integer, drink_until integer,
 storage_location text not null default '', notes text not null default '',
 source text not null default 'manual', confidence text not null default 'unverified',
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create index if not exists wines_user_id_idx on public.wines(user_id);
alter table public.wines enable row level security;
drop policy if exists "Users can view their own wines" on public.wines;
create policy "Users can view their own wines" on public.wines for select using(auth.uid()=user_id);
drop policy if exists "Users can insert their own wines" on public.wines;
create policy "Users can insert their own wines" on public.wines for insert with check(auth.uid()=user_id);
drop policy if exists "Users can update their own wines" on public.wines;
create policy "Users can update their own wines" on public.wines for update using(auth.uid()=user_id) with check(auth.uid()=user_id);
drop policy if exists "Users can delete their own wines" on public.wines;
create policy "Users can delete their own wines" on public.wines for delete using(auth.uid()=user_id);
