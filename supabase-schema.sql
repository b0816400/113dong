create table public.shared_calendar_entries (
  id text primary key,
  entry_date date not null,
  title text not null,
  type text not null check (type in ('income', 'expense')),
  amount bigint check (amount is null or amount between 1 and 999999999999),
  notes text not null default '',
  created_at timestamptz not null default now()
);

create index shared_calendar_entries_date_idx
  on public.shared_calendar_entries (entry_date);

alter table public.shared_calendar_entries enable row level security;

create policy "Anyone can manage shared calendar entries"
  on public.shared_calendar_entries for all to anon, authenticated
  using (true)
  with check (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.shared_calendar_entries to anon, authenticated;

alter publication supabase_realtime add table public.shared_calendar_entries;
