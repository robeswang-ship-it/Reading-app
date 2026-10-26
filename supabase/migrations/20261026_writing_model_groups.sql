update public.system_documents
set document_data = jsonb_set(
  document_data,
  '{systemGroup}',
  to_jsonb('mock-small'::text),
  true
)
where id in (
  'f0d0b9fd-98a5-45a0-a3c0-975d19c157c3'::uuid,
  '6ffa395b-fa36-4f0f-bdd7-94fed6aad69e'::uuid,
  '3bc4eb7a-23f5-414b-834b-fd401d2c998f'::uuid,
  'a88f5192-a71f-476f-9489-167c8f5e6a77'::uuid,
  'fc9add84-5993-49c7-818b-5e0d0f47fd1c'::uuid,
  '9249c547-0b6a-41c9-a5db-623a0d74d889'::uuid
);

update public.system_documents
set document_data = jsonb_set(
  document_data,
  '{systemGroup}',
  to_jsonb('mock-large'::text),
  true
)
where id in (
  'bc901145-82a5-4138-8975-70015d8f3a35'::uuid,
  'f850c265-1c5d-4508-b90b-4da0bff2406a'::uuid,
  'c42827eb-d0a1-4b40-85ed-b010a2a056e6'::uuid,
  'f78915da-57e5-4dbe-a103-7dab0b654f96'::uuid,
  '015a7c73-e695-455e-91f2-614330c31d4c'::uuid,
  '94930d76-65b4-4990-9abc-895b541b4f53'::uuid,
  '46d1cf0d-aca3-4777-8752-fc928fa8a615'::uuid,
  '55f5ba9e-8e81-4bfd-9432-e82ed8b4304f'::uuid,
  '8703cbe6-ec03-4368-8967-1c45b1ca5703'::uuid,
  '4ab57fd9-5d91-43a1-a5e4-a8af331a4a32'::uuid
);
