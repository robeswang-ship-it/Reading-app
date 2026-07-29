create table if not exists public.reading_libraries (
  user_id uuid primary key references auth.users(id) on delete cascade,
  library_data jsonb not null default jsonb_build_object(
    'version', 3,
    'exportedAt', '',
    'documents', jsonb_build_array(),
    'folders', jsonb_build_array(),
    'vocabularyItems', jsonb_build_array(),
    'favoriteSentences', jsonb_build_array()
  ),
  revision bigint not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.reading_libraries enable row level security;

drop policy if exists "Users can read their own reading library"
  on public.reading_libraries;
create policy "Users can read their own reading library"
  on public.reading_libraries
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own reading library"
  on public.reading_libraries;
create policy "Users can create their own reading library"
  on public.reading_libraries
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own reading library"
  on public.reading_libraries;
create policy "Users can update their own reading library"
  on public.reading_libraries
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own reading library"
  on public.reading_libraries;
create policy "Users can delete their own reading library"
  on public.reading_libraries
  for delete
  to authenticated
  using ((select auth.uid()) = user_id);

create or replace function public.set_reading_library_updated_at()
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

drop trigger if exists set_reading_library_updated_at
  on public.reading_libraries;
create trigger set_reading_library_updated_at
before update on public.reading_libraries
for each row
execute function public.set_reading_library_updated_at();

revoke all on public.reading_libraries from anon;
grant select, insert, update, delete
  on public.reading_libraries
  to authenticated;

