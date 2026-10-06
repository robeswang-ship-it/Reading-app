alter table public.user_system_document_states
  add column if not exists read_count bigint not null default 0
    check (read_count >= 0),
  add column if not exists last_opened_at timestamptz;

comment on column public.user_system_document_states.read_count is
  'Number of reading sessions opened by this user for this system document.';

comment on column public.user_system_document_states.last_opened_at is
  'Most recent time this user opened this system document.';
