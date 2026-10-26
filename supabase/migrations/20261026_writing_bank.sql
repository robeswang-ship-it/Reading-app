create table if not exists public.system_writing_items (
  id uuid primary key,
  item_type text not null
    check (item_type in ('phrase', 'sentence_pattern', 'example_sentence')),
  item_data jsonb not null,
  sort_order integer not null default 0,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  check (item_data ->> 'id' = id::text),
  check (item_data ->> 'type' = item_type)
);

create index if not exists system_writing_items_type_order_idx
  on public.system_writing_items(item_type, sort_order);

create table if not exists public.user_system_writing_item_states (
  user_id uuid not null references auth.users(id) on delete cascade,
  item_id uuid not null
    references public.system_writing_items(id) on delete cascade,
  in_focus_list boolean not null default false,
  note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, item_id)
);

alter table public.system_writing_items enable row level security;
alter table public.user_system_writing_item_states enable row level security;

drop policy if exists "Authenticated users can read published writing items"
  on public.system_writing_items;
create policy "Authenticated users can read published writing items"
  on public.system_writing_items
  for select
  to authenticated
  using (is_published);

drop policy if exists "Users can read their own writing item states"
  on public.user_system_writing_item_states;
create policy "Users can read their own writing item states"
  on public.user_system_writing_item_states
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own writing item states"
  on public.user_system_writing_item_states;
create policy "Users can create their own writing item states"
  on public.user_system_writing_item_states
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own writing item states"
  on public.user_system_writing_item_states;
create policy "Users can update their own writing item states"
  on public.user_system_writing_item_states
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own writing item states"
  on public.user_system_writing_item_states;
create policy "Users can delete their own writing item states"
  on public.user_system_writing_item_states
  for delete
  to authenticated
  using ((select auth.uid()) = user_id);

create or replace function public.set_writing_bank_updated_at()
returns trigger
language plpgsql
security invoker
set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_system_writing_items_updated_at
  on public.system_writing_items;
create trigger set_system_writing_items_updated_at
before update on public.system_writing_items
for each row execute function public.set_writing_bank_updated_at();

drop trigger if exists set_user_system_writing_item_states_updated_at
  on public.user_system_writing_item_states;
create trigger set_user_system_writing_item_states_updated_at
before update on public.user_system_writing_item_states
for each row execute function public.set_writing_bank_updated_at();

revoke all on public.system_writing_items from anon, authenticated;
revoke all on public.user_system_writing_item_states from anon, authenticated;

grant select on public.system_writing_items to authenticated;
grant select, insert, update, delete
  on public.user_system_writing_item_states
  to authenticated;
