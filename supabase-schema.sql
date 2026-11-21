create table if not exists public.shared_calendar_entries (
  id text primary key,
  entry_date date not null,
  title text not null,
  type text not null check (type in ('income', 'expense')),
  amount bigint check (amount is null or amount between 1 and 999999999999),
  notes text not null default '',
  created_at timestamptz not null default now()
);

create index if not exists shared_calendar_entries_date_idx
  on public.shared_calendar_entries (entry_date);

alter table public.shared_calendar_entries enable row level security;

drop policy if exists "Anyone can manage shared calendar entries"
  on public.shared_calendar_entries;
create policy "Anyone can manage shared calendar entries"
  on public.shared_calendar_entries for all to anon, authenticated
  using (true)
  with check (true);

create table if not exists public.shared_calendar_rooms (
  room_number text primary key check (room_number in (
    '201호', '202호', '203호', '204호', '205호',
    '301호', '302호', '303호', '304호', '305호',
    '401호', '402호', '403호', '404호', '405호'
  )),
  resident_name text not null default '' check (char_length(resident_name) <= 80),
  move_in_date date,
  deposit_amount bigint check (deposit_amount is null or deposit_amount between 0 and 999999999999),
  monthly_rent bigint check (monthly_rent is null or monthly_rent between 0 and 999999999999),
  updated_at timestamptz not null default now()
);

insert into public.shared_calendar_rooms (room_number)
values
  ('201호'), ('202호'), ('203호'), ('204호'), ('205호'),
  ('301호'), ('302호'), ('303호'), ('304호'), ('305호'),
  ('401호'), ('402호'), ('403호'), ('404호'), ('405호')
on conflict (room_number) do nothing;

alter table public.shared_calendar_rooms enable row level security;

drop policy if exists "Anyone can manage shared calendar rooms"
  on public.shared_calendar_rooms;
create policy "Anyone can manage shared calendar rooms"
  on public.shared_calendar_rooms for all to anon, authenticated
  using (true)
  with check (true);

grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on public.shared_calendar_entries to anon, authenticated;
grant select, insert, update on public.shared_calendar_rooms to anon, authenticated;

do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime'
        and schemaname = 'public'
        and tablename = 'shared_calendar_entries'
    ) then
      alter publication supabase_realtime add table public.shared_calendar_entries;
    end if;
    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime'
        and schemaname = 'public'
        and tablename = 'shared_calendar_rooms'
    ) then
      alter publication supabase_realtime add table public.shared_calendar_rooms;
    end if;
  end if;
end
$$;
