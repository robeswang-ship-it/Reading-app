create table if not exists public.system_collections (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  description text,
  sort_order integer not null default 0,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.system_documents (
  id uuid primary key default gen_random_uuid(),
  collection_id uuid not null
    references public.system_collections(id) on delete cascade,
  title text not null,
  source_text text not null,
  document_data jsonb not null,
  sort_order integer not null default 0,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists system_documents_collection_order_idx
  on public.system_documents(collection_id, sort_order, created_at);

create table if not exists public.user_system_document_states (
  user_id uuid not null references auth.users(id) on delete cascade,
  document_id uuid not null
    references public.system_documents(id) on delete cascade,
  current_sentence_index integer not null default 0
    check (current_sentence_index >= 0),
  sentence_notes jsonb not null default jsonb_build_object(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, document_id)
);

alter table public.system_collections enable row level security;
alter table public.system_documents enable row level security;
alter table public.user_system_document_states enable row level security;

drop policy if exists "Authenticated users can read published collections"
  on public.system_collections;
create policy "Authenticated users can read published collections"
  on public.system_collections
  for select
  to authenticated
  using (is_published);

drop policy if exists "Authenticated users can read published system documents"
  on public.system_documents;
create policy "Authenticated users can read published system documents"
  on public.system_documents
  for select
  to authenticated
  using (
    is_published
    and exists (
      select 1
      from public.system_collections
      where system_collections.id = system_documents.collection_id
        and system_collections.is_published
    )
  );

drop policy if exists "Users can read their own system document states"
  on public.user_system_document_states;
create policy "Users can read their own system document states"
  on public.user_system_document_states
  for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own system document states"
  on public.user_system_document_states;
create policy "Users can create their own system document states"
  on public.user_system_document_states
  for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own system document states"
  on public.user_system_document_states;
create policy "Users can update their own system document states"
  on public.user_system_document_states
  for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own system document states"
  on public.user_system_document_states;
create policy "Users can delete their own system document states"
  on public.user_system_document_states
  for delete
  to authenticated
  using ((select auth.uid()) = user_id);

create or replace function public.set_system_library_updated_at()
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

drop trigger if exists set_system_collections_updated_at
  on public.system_collections;
create trigger set_system_collections_updated_at
before update on public.system_collections
for each row execute function public.set_system_library_updated_at();

drop trigger if exists set_system_documents_updated_at
  on public.system_documents;
create trigger set_system_documents_updated_at
before update on public.system_documents
for each row execute function public.set_system_library_updated_at();

drop trigger if exists set_user_system_document_states_updated_at
  on public.user_system_document_states;
create trigger set_user_system_document_states_updated_at
before update on public.user_system_document_states
for each row execute function public.set_system_library_updated_at();

revoke all on public.system_collections from anon, authenticated;
revoke all on public.system_documents from anon, authenticated;
revoke all on public.user_system_document_states from anon;

grant select on public.system_collections to authenticated;
grant select on public.system_documents to authenticated;
grant select, insert, update, delete
  on public.user_system_document_states
  to authenticated;
