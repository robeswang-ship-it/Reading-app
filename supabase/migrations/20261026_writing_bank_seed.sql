begin;

with collection as (
  insert into public.system_collections (
    slug,
    title,
    description,
    sort_order,
    is_published
  )
  values (
    'writing-model-essays',
    '作文范文',
    '考研英语作文真题与模拟范文，共享给所有用户。',
    20,
    true
  )
  on conflict (slug) do update set
    title = excluded.title,
    description = excluded.description,
    sort_order = excluded.sort_order,
    is_published = excluded.is_published
  returning id
)
insert into public.system_documents (
  id,
  collection_id,
  title,
  source_text,
  document_data,
  sort_order,
  is_published
)
select *
from (
  values
(
    '783dd39f-2c9e-5006-9447-d405de6fbf8e'::uuid,
    (select id from collection),
    '2010年英语二·感谢接待与欢迎访华',
    'Dear Alex,

Now that I am back in China, I would like to thank you for making my visit so rewarding. Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange.

I particularly enjoyed our conversations about everyday life. They brought American culture to life in a way that books never could. I hope you will visit China when time permits. It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food.

Such a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness. Do keep in touch.

Yours sincerely,
Zhang Wei',
    '{"id":"783dd39f-2c9e-5006-9447-d405de6fbf8e","title":"2010年英语二·感谢接待与欢迎访华","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Alex,\n\nNow that I am back in China, I would like to thank you for making my visit so rewarding. Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange.\n\nI particularly enjoyed our conversations about everyday life. They brought American culture to life in a way that books never could. I hope you will visit China when time permits. It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food.\n\nSuch a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness. Do keep in touch.\n\nYours sincerely,\nZhang Wei","paragraphs":[{"id":"ac7c7726-4ab8-5276-8692-c678b5f186b9","sentences":[{"id":"e1dc4326-8766-5b12-8daf-ad99ba348705","text":"Dear Alex,"}]},{"id":"072757ff-b4ae-5d46-beef-74620db63fd9","sentences":[{"id":"addd9f97-e893-5912-8d90-69133360f124","text":"Now that I am back in China, I would like to thank you for making my visit so rewarding."},{"id":"62e71405-aeef-51a9-8eca-e0c0fda97284","text":"Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange."}]},{"id":"931be9ef-932a-5938-864b-982b7a275cb7","sentences":[{"id":"c5f72ec8-fac4-51a6-953e-04787e43948b","text":"I particularly enjoyed our conversations about everyday life."},{"id":"55067b35-a6b9-5bd0-b1a5-f8cbaa077275","text":"They brought American culture to life in a way that books never could."},{"id":"1e55b317-6a9c-5113-81dc-7c55e7fa0a88","text":"I hope you will visit China when time permits."},{"id":"1dfa0010-3213-5f59-a6ce-cd2cffd88def","text":"It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food."}]},{"id":"f756cc56-4b51-5d60-b657-5df53baab927","sentences":[{"id":"93266ab7-f9cd-581e-ab55-14bc726fdaa1","text":"Such a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness."},{"id":"c0da20ae-3b41-565c-b52a-a194616eadc3","text":"Do keep in touch."}]},{"id":"f50e5b2f-299c-5367-830f-eb9b43df31af","sentences":[{"id":"e813d92a-3baa-55f5-9673-c63278e5ee79","text":"Yours sincerely,\nZhang Wei"}]}],"sentences":[{"id":"e1dc4326-8766-5b12-8daf-ad99ba348705","text":"Dear Alex,"},{"id":"addd9f97-e893-5912-8d90-69133360f124","text":"Now that I am back in China, I would like to thank you for making my visit so rewarding."},{"id":"62e71405-aeef-51a9-8eca-e0c0fda97284","text":"Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange."},{"id":"c5f72ec8-fac4-51a6-953e-04787e43948b","text":"I particularly enjoyed our conversations about everyday life."},{"id":"55067b35-a6b9-5bd0-b1a5-f8cbaa077275","text":"They brought American culture to life in a way that books never could."},{"id":"1e55b317-6a9c-5113-81dc-7c55e7fa0a88","text":"I hope you will visit China when time permits."},{"id":"1dfa0010-3213-5f59-a6ce-cd2cffd88def","text":"It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food."},{"id":"93266ab7-f9cd-581e-ab55-14bc726fdaa1","text":"Such a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness."},{"id":"c0da20ae-3b41-565c-b52a-a194616eadc3","text":"Do keep in touch."},{"id":"e813d92a-3baa-55f5-9673-c63278e5ee79","text":"Yours sincerely,\nZhang Wei"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    0,
    true
  ),
(
    '775003e2-3ef6-5b71-b9c6-1cecfdc6212a'::uuid,
    (select id from collection),
    '2011年英语二·祝贺入学与准备建议',
    'Dear Li Ming,

Congratulations on being admitted to university! I know how much effort you have put into this goal, and I am delighted that it has paid off.

Before the term begins, look through your course descriptions and make a flexible study plan. University learning calls for greater independence, so getting used to organizing your own time will help. I also suggest learning to manage a monthly budget and do basic household tasks. These practical skills will leave you better prepared for living away from home.

Enjoy the summer, too. You have earned a break, and I wish you a wonderful new beginning.

Yours sincerely,
Zhang Wei',
    '{"id":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","title":"2011年英语二·祝贺入学与准备建议","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Li Ming,\n\nCongratulations on being admitted to university! I know how much effort you have put into this goal, and I am delighted that it has paid off.\n\nBefore the term begins, look through your course descriptions and make a flexible study plan. University learning calls for greater independence, so getting used to organizing your own time will help. I also suggest learning to manage a monthly budget and do basic household tasks. These practical skills will leave you better prepared for living away from home.\n\nEnjoy the summer, too. You have earned a break, and I wish you a wonderful new beginning.\n\nYours sincerely,\nZhang Wei","paragraphs":[{"id":"4cb2e3c7-59ba-5300-b26d-574f40fe696a","sentences":[{"id":"7a794c3d-8845-5c62-a5af-07a0e834b291","text":"Dear Li Ming,"}]},{"id":"2e8a1722-2aea-5e05-a3a8-029eb7f03839","sentences":[{"id":"7acc0be6-8f8c-50b2-af2f-285aaa677a7e","text":"Congratulations on being admitted to university!"},{"id":"b22ba0f0-c781-5bfd-8b9a-4d7f437874c7","text":"I know how much effort you have put into this goal, and I am delighted that it has paid off."}]},{"id":"f0616e84-2183-57dc-9e42-5ca380fc0b49","sentences":[{"id":"c4498233-a2ae-5df7-8e66-7a9ba296ca9c","text":"Before the term begins, look through your course descriptions and make a flexible study plan."},{"id":"c10ad929-e081-5f86-ab38-6f7873bf8c06","text":"University learning calls for greater independence, so getting used to organizing your own time will help."},{"id":"c18c9d44-dbbe-5095-ad42-c1e583a22881","text":"I also suggest learning to manage a monthly budget and do basic household tasks."},{"id":"1e881408-035c-5c92-9d0b-32c3278796e9","text":"These practical skills will leave you better prepared for living away from home."}]},{"id":"84209b9e-9c21-505d-8147-9cf640876e65","sentences":[{"id":"10bc2fe8-6b95-5c32-bc86-89d7224ec07d","text":"Enjoy the summer, too."},{"id":"32410fb8-420d-551b-959c-3a4eb9fd894f","text":"You have earned a break, and I wish you a wonderful new beginning."}]},{"id":"b032eee6-1942-5520-8502-840cb3f81520","sentences":[{"id":"e3d910cd-f1fb-5ded-ab82-1b04be32c4f5","text":"Yours sincerely,\nZhang Wei"}]}],"sentences":[{"id":"7a794c3d-8845-5c62-a5af-07a0e834b291","text":"Dear Li Ming,"},{"id":"7acc0be6-8f8c-50b2-af2f-285aaa677a7e","text":"Congratulations on being admitted to university!"},{"id":"b22ba0f0-c781-5bfd-8b9a-4d7f437874c7","text":"I know how much effort you have put into this goal, and I am delighted that it has paid off."},{"id":"c4498233-a2ae-5df7-8e66-7a9ba296ca9c","text":"Before the term begins, look through your course descriptions and make a flexible study plan."},{"id":"c10ad929-e081-5f86-ab38-6f7873bf8c06","text":"University learning calls for greater independence, so getting used to organizing your own time will help."},{"id":"c18c9d44-dbbe-5095-ad42-c1e583a22881","text":"I also suggest learning to manage a monthly budget and do basic household tasks."},{"id":"1e881408-035c-5c92-9d0b-32c3278796e9","text":"These practical skills will leave you better prepared for living away from home."},{"id":"10bc2fe8-6b95-5c32-bc86-89d7224ec07d","text":"Enjoy the summer, too."},{"id":"32410fb8-420d-551b-959c-3a4eb9fd894f","text":"You have earned a break, and I wish you a wonderful new beginning."},{"id":"e3d910cd-f1fb-5ded-ab82-1b04be32c4f5","text":"Yours sincerely,\nZhang Wei"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    1,
    true
  ),
(
    'd1a0fe70-d3b9-556f-91e7-3afdbd49f0dd'::uuid,
    (select id from collection),
    '2012年英语二·投诉电子词典',
    'Dear Sir or Madam,

I am writing about an electronic dictionary purchased from your online store three days ago. Unfortunately, it has not worked properly since delivery.

The screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies. I would therefore appreciate a replacement at no additional cost. If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item. I have retained the receipt and can provide photographs if required.

Please let me know how you intend to resolve this matter. I look forward to your prompt reply.

Yours sincerely,
Zhang Wei',
    '{"id":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","title":"2012年英语二·投诉电子词典","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Sir or Madam,\n\nI am writing about an electronic dictionary purchased from your online store three days ago. Unfortunately, it has not worked properly since delivery.\n\nThe screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies. I would therefore appreciate a replacement at no additional cost. If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item. I have retained the receipt and can provide photographs if required.\n\nPlease let me know how you intend to resolve this matter. I look forward to your prompt reply.\n\nYours sincerely,\nZhang Wei","paragraphs":[{"id":"45d89aa5-60b4-50f4-867b-23991a0e6eb5","sentences":[{"id":"03ad0dd3-b3df-5e8c-b56c-2bb487a13e25","text":"Dear Sir or Madam,"}]},{"id":"59c66ba6-fb5a-5b4a-9f55-edc551579f13","sentences":[{"id":"bf68b45a-416e-575b-9ab2-4673508c4a8c","text":"I am writing about an electronic dictionary purchased from your online store three days ago."},{"id":"9d21ec99-2636-59db-857a-62b4d342da4d","text":"Unfortunately, it has not worked properly since delivery."}]},{"id":"aeec638f-3815-59e9-ae49-467d50750b0c","sentences":[{"id":"01e0ee39-97a0-5b8a-89ee-934d0b967582","text":"The screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies."},{"id":"950e19e2-d257-585a-b37b-1c21132551dd","text":"I would therefore appreciate a replacement at no additional cost."},{"id":"0f5a7269-e1fb-5cea-9775-be597d3cc390","text":"If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item."},{"id":"c7e01761-e989-503e-82d7-2e9d069a8b50","text":"I have retained the receipt and can provide photographs if required."}]},{"id":"c979e718-37f5-5fa7-a74a-d2cfe85b7851","sentences":[{"id":"47017027-c32d-5f95-8250-22a268b50c5f","text":"Please let me know how you intend to resolve this matter."},{"id":"feb510a7-64f6-5d43-9ae9-0024e154b962","text":"I look forward to your prompt reply."}]},{"id":"2ee65e0e-70fd-5bd8-905e-be4627c1fb9e","sentences":[{"id":"9ef0c038-b0ec-5131-966d-2a6994d3ce39","text":"Yours sincerely,\nZhang Wei"}]}],"sentences":[{"id":"03ad0dd3-b3df-5e8c-b56c-2bb487a13e25","text":"Dear Sir or Madam,"},{"id":"bf68b45a-416e-575b-9ab2-4673508c4a8c","text":"I am writing about an electronic dictionary purchased from your online store three days ago."},{"id":"9d21ec99-2636-59db-857a-62b4d342da4d","text":"Unfortunately, it has not worked properly since delivery."},{"id":"01e0ee39-97a0-5b8a-89ee-934d0b967582","text":"The screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies."},{"id":"950e19e2-d257-585a-b37b-1c21132551dd","text":"I would therefore appreciate a replacement at no additional cost."},{"id":"0f5a7269-e1fb-5cea-9775-be597d3cc390","text":"If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item."},{"id":"c7e01761-e989-503e-82d7-2e9d069a8b50","text":"I have retained the receipt and can provide photographs if required."},{"id":"47017027-c32d-5f95-8250-22a268b50c5f","text":"Please let me know how you intend to resolve this matter."},{"id":"feb510a7-64f6-5d43-9ae9-0024e154b962","text":"I look forward to your prompt reply."},{"id":"9ef0c038-b0ec-5131-966d-2a6994d3ce39","text":"Yours sincerely,\nZhang Wei"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    2,
    true
  ),
(
    '62a45036-d5ec-5bc9-a8a7-f8484bba7b13'::uuid,
    (select id from collection),
    '2013年英语二·慈善义卖通知邮件',
    'Dear classmates,

Our class is holding a charity sale to support children in need, and I warmly invite you to take part in the event. The sale will take place on the playground from 2 to 5 p.m. this Saturday.

Please bring books, toys or other items in good condition that you no longer use. All proceeds will go towards school supplies for the children. If you have nothing to donate, you can still help by setting up stalls or serving customers. Every contribution, whether of goods or time, will be appreciated.

Let us give unused items a new purpose and give these children a better start.

Yours sincerely,
Li Ming',
    '{"id":"62a45036-d5ec-5bc9-a8a7-f8484bba7b13","title":"2013年英语二·慈善义卖通知邮件","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear classmates,\n\nOur class is holding a charity sale to support children in need, and I warmly invite you to take part in the event. The sale will take place on the playground from 2 to 5 p.m. this Saturday.\n\nPlease bring books, toys or other items in good condition that you no longer use. All proceeds will go towards school supplies for the children. If you have nothing to donate, you can still help by setting up stalls or serving customers. Every contribution, whether of goods or time, will be appreciated.\n\nLet us give unused items a new purpose and give these children a better start.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"6c2847c5-a976-5d24-a942-fc9050141f0e","sentences":[{"id":"76efb8f6-a83e-5775-bccf-ca636899a554","text":"Dear classmates,"}]},{"id":"007c32d1-b5dc-56ef-bcde-362543f75961","sentences":[{"id":"da7e0a7a-1159-57a6-b198-f3ccb74caf08","text":"Our class is holding a charity sale to support children in need, and I warmly invite you to take part in the event."},{"id":"4f1c9733-fddf-573b-b06a-3556bdf5a515","text":"The sale will take place on the playground from 2 to 5 p.m. this Saturday."}]},{"id":"7e123d5c-3da3-5df9-8f1a-02c65538ccbc","sentences":[{"id":"2a2df677-8289-572c-b486-a0c24ccf1371","text":"Please bring books, toys or other items in good condition that you no longer use."},{"id":"9413fab0-fa7d-502b-b13e-7d51c1899c2a","text":"All proceeds will go towards school supplies for the children."},{"id":"e2da30bb-a3b0-565d-a729-0fa2fdbc6fb3","text":"If you have nothing to donate, you can still help by setting up stalls or serving customers."},{"id":"58dca0ea-5b89-5f91-a233-eb4f9c6ae78f","text":"Every contribution, whether of goods or time, will be appreciated."}]},{"id":"15710cf2-b9f4-5af6-950f-d3da2ce19934","sentences":[{"id":"4a13d036-a9d3-5bab-b7ea-1511ec9007d9","text":"Let us give unused items a new purpose and give these children a better start."}]},{"id":"725d5cfc-44b5-55a7-a31c-1ad388e4afcc","sentences":[{"id":"4ba40f1b-98b3-5a43-803e-5ae65d8b5111","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"76efb8f6-a83e-5775-bccf-ca636899a554","text":"Dear classmates,"},{"id":"da7e0a7a-1159-57a6-b198-f3ccb74caf08","text":"Our class is holding a charity sale to support children in need, and I warmly invite you to take part in the event."},{"id":"4f1c9733-fddf-573b-b06a-3556bdf5a515","text":"The sale will take place on the playground from 2 to 5 p.m. this Saturday."},{"id":"2a2df677-8289-572c-b486-a0c24ccf1371","text":"Please bring books, toys or other items in good condition that you no longer use."},{"id":"9413fab0-fa7d-502b-b13e-7d51c1899c2a","text":"All proceeds will go towards school supplies for the children."},{"id":"e2da30bb-a3b0-565d-a729-0fa2fdbc6fb3","text":"If you have nothing to donate, you can still help by setting up stalls or serving customers."},{"id":"58dca0ea-5b89-5f91-a233-eb4f9c6ae78f","text":"Every contribution, whether of goods or time, will be appreciated."},{"id":"4a13d036-a9d3-5bab-b7ea-1511ec9007d9","text":"Let us give unused items a new purpose and give these children a better start."},{"id":"4ba40f1b-98b3-5a43-803e-5ae65d8b5111","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    3,
    true
  ),
(
    '4fc8d915-6628-58cf-bf99-ab8fc56c586b'::uuid,
    (select id from collection),
    '2014年英语二·生活习惯与合租询问',
    'Dear John,

I am looking forward to sharing an apartment with you. To help us feel at home, I thought I would introduce my daily habits.

I usually get up around seven and turn in before eleven. I prefer a quiet study environment, keep shared spaces tidy and am happy to share responsibilities for the housework. I also enjoy cooking and would love to share some Chinese dishes with you. Could you suggest affordable places to shop and the easiest way to get to campus?

Please also let me know about any household routines I should follow. I hope we will make good flatmates.

Best wishes,
Li Ming',
    '{"id":"4fc8d915-6628-58cf-bf99-ab8fc56c586b","title":"2014年英语二·生活习惯与合租询问","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear John,\n\nI am looking forward to sharing an apartment with you. To help us feel at home, I thought I would introduce my daily habits.\n\nI usually get up around seven and turn in before eleven. I prefer a quiet study environment, keep shared spaces tidy and am happy to share responsibilities for the housework. I also enjoy cooking and would love to share some Chinese dishes with you. Could you suggest affordable places to shop and the easiest way to get to campus?\n\nPlease also let me know about any household routines I should follow. I hope we will make good flatmates.\n\nBest wishes,\nLi Ming","paragraphs":[{"id":"2a6dca00-857a-5705-b307-6f912902ae1a","sentences":[{"id":"acf8276f-868b-54c6-be64-5a7eabd3ef27","text":"Dear John,"}]},{"id":"af80ba6e-476c-5215-ad8f-e0b50e6f95c3","sentences":[{"id":"f82a2b10-4c09-5b38-b3e7-4ec73275a83e","text":"I am looking forward to sharing an apartment with you."},{"id":"692a27e6-aaab-5211-8fba-21d6e1703718","text":"To help us feel at home, I thought I would introduce my daily habits."}]},{"id":"b9460992-ce17-56fa-930b-9d07afa9b3e1","sentences":[{"id":"c7ccb8fb-c831-50f5-9dfe-40995c98aeda","text":"I usually get up around seven and turn in before eleven."},{"id":"42a397fd-7b0e-589c-bee0-84eb104902ae","text":"I prefer a quiet study environment, keep shared spaces tidy and am happy to share responsibilities for the housework."},{"id":"feaebce0-dae3-50bb-ab64-464fa77cfc92","text":"I also enjoy cooking and would love to share some Chinese dishes with you."},{"id":"ecfe30be-aa76-586e-8a70-633547d34d07","text":"Could you suggest affordable places to shop and the easiest way to get to campus?"}]},{"id":"85b691ff-86f0-5276-aac1-4b735c6eaa99","sentences":[{"id":"eb1b6d4e-3b7c-59b8-b36a-6636879f5a8e","text":"Please also let me know about any household routines I should follow."},{"id":"f19a40f8-d022-52d4-800c-538117ef8175","text":"I hope we will make good flatmates."}]},{"id":"01bc7cd4-0a39-5cbf-9653-37d049ef6092","sentences":[{"id":"e6bc21a4-1a96-5d96-b17f-037a1b1bdf60","text":"Best wishes,\nLi Ming"}]}],"sentences":[{"id":"acf8276f-868b-54c6-be64-5a7eabd3ef27","text":"Dear John,"},{"id":"f82a2b10-4c09-5b38-b3e7-4ec73275a83e","text":"I am looking forward to sharing an apartment with you."},{"id":"692a27e6-aaab-5211-8fba-21d6e1703718","text":"To help us feel at home, I thought I would introduce my daily habits."},{"id":"c7ccb8fb-c831-50f5-9dfe-40995c98aeda","text":"I usually get up around seven and turn in before eleven."},{"id":"42a397fd-7b0e-589c-bee0-84eb104902ae","text":"I prefer a quiet study environment, keep shared spaces tidy and am happy to share responsibilities for the housework."},{"id":"feaebce0-dae3-50bb-ab64-464fa77cfc92","text":"I also enjoy cooking and would love to share some Chinese dishes with you."},{"id":"ecfe30be-aa76-586e-8a70-633547d34d07","text":"Could you suggest affordable places to shop and the easiest way to get to campus?"},{"id":"eb1b6d4e-3b7c-59b8-b36a-6636879f5a8e","text":"Please also let me know about any household routines I should follow."},{"id":"f19a40f8-d022-52d4-800c-538117ef8175","text":"I hope we will make good flatmates."},{"id":"e6bc21a4-1a96-5d96-b17f-037a1b1bdf60","text":"Best wishes,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    4,
    true
  ),
(
    '86a1454d-7ea6-50ee-a9f9-11987ad1638d'::uuid,
    (select id from collection),
    '2015年英语二·夏令营志愿者招募通知',
    'NOTICE

Volunteers Needed

Our university will host a summer camp for high school students in July. Through campus tours, introductory lectures and group projects, participants will explore university life and discover their academic interests.

Volunteer duties will include welcoming students, leading tours and assisting with activities. Applicants should be responsible, approachable and available throughout the camp. Experience working with teenagers would be helpful, but training will be provided for all successful applicants.

Please submit an application with a brief introduction and your contact details to the Students’ Union by June 10. Join us in giving these students a welcoming introduction to university life.

The Students’ Union',
    '{"id":"86a1454d-7ea6-50ee-a9f9-11987ad1638d","title":"2015年英语二·夏令营志愿者招募通知","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"NOTICE\n\nVolunteers Needed\n\nOur university will host a summer camp for high school students in July. Through campus tours, introductory lectures and group projects, participants will explore university life and discover their academic interests.\n\nVolunteer duties will include welcoming students, leading tours and assisting with activities. Applicants should be responsible, approachable and available throughout the camp. Experience working with teenagers would be helpful, but training will be provided for all successful applicants.\n\nPlease submit an application with a brief introduction and your contact details to the Students’ Union by June 10. Join us in giving these students a welcoming introduction to university life.\n\nThe Students’ Union","paragraphs":[{"id":"3411ca85-8c09-5980-a881-4fa63db54510","sentences":[{"id":"3feb43d5-c881-577b-a4cb-57cf45c92ec5","text":"NOTICE"}]},{"id":"035ea6c7-f0a5-5c92-97c3-77881e335fa8","sentences":[{"id":"0f2d6cd3-3e01-5632-8400-17c7a2284687","text":"Volunteers Needed"}]},{"id":"1e922639-5117-5ab8-b85a-718fe8579b85","sentences":[{"id":"113befd9-d789-5dd2-9ef5-b55ddeb37d56","text":"Our university will host a summer camp for high school students in July."},{"id":"b366063c-08d7-55bf-8e50-5d5449201e30","text":"Through campus tours, introductory lectures and group projects, participants will explore university life and discover their academic interests."}]},{"id":"e1f4e153-1cf0-5da7-aeca-95d5c7174a6e","sentences":[{"id":"6f72159c-3c46-5d2a-90e7-1aade4bb0429","text":"Volunteer duties will include welcoming students, leading tours and assisting with activities."},{"id":"e51a8333-2c0c-5fb2-80a5-7d3efcee6228","text":"Applicants should be responsible, approachable and available throughout the camp."},{"id":"096185b8-7d7e-5a24-8c76-70dc5a21c336","text":"Experience working with teenagers would be helpful, but training will be provided for all successful applicants."}]},{"id":"db8c2ec9-fe4a-564b-8639-1a5143a56327","sentences":[{"id":"f560fe9c-6794-5bf1-b468-7fc691d4f5ec","text":"Please submit an application with a brief introduction and your contact details to the Students’ Union by June 10."},{"id":"4d540007-f30b-5f8d-ba3b-a0bcafff024e","text":"Join us in giving these students a welcoming introduction to university life."}]},{"id":"2459c3a9-681f-5c4b-b27b-b40e94d2dfb3","sentences":[{"id":"8fea9baa-b102-5cc6-80da-7b5fe159da97","text":"The Students’ Union"}]}],"sentences":[{"id":"3feb43d5-c881-577b-a4cb-57cf45c92ec5","text":"NOTICE"},{"id":"0f2d6cd3-3e01-5632-8400-17c7a2284687","text":"Volunteers Needed"},{"id":"113befd9-d789-5dd2-9ef5-b55ddeb37d56","text":"Our university will host a summer camp for high school students in July."},{"id":"b366063c-08d7-55bf-8e50-5d5449201e30","text":"Through campus tours, introductory lectures and group projects, participants will explore university life and discover their academic interests."},{"id":"6f72159c-3c46-5d2a-90e7-1aade4bb0429","text":"Volunteer duties will include welcoming students, leading tours and assisting with activities."},{"id":"e51a8333-2c0c-5fb2-80a5-7d3efcee6228","text":"Applicants should be responsible, approachable and available throughout the camp."},{"id":"096185b8-7d7e-5a24-8c76-70dc5a21c336","text":"Experience working with teenagers would be helpful, but training will be provided for all successful applicants."},{"id":"f560fe9c-6794-5bf1-b468-7fc691d4f5ec","text":"Please submit an application with a brief introduction and your contact details to the Students’ Union by June 10."},{"id":"4d540007-f30b-5f8d-ba3b-a0bcafff024e","text":"Join us in giving these students a welcoming introduction to university life."},{"id":"8fea9baa-b102-5cc6-80da-7b5fe159da97","text":"The Students’ Union"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    5,
    true
  ),
(
    '5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4'::uuid,
    (select id from collection),
    '2016年英语二·感谢祝贺与翻译建议',
    'Dear Jack,

Thank you for your congratulations. I am delighted that you share my interest in translation and would gladly offer a few suggestions.

First, develop a good command of both languages through regular reading. A translation must sound natural as well as convey the original meaning. Before drafting, identify the writer’s main point and the links between sentences rather than translate word for word. Then compare your version with a reliable translation, paying attention to differences in phrasing. Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding.

I hope these suggestions help. I would love to discuss your translations sometime.

Best wishes,
Li Ming',
    '{"id":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","title":"2016年英语二·感谢祝贺与翻译建议","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Jack,\n\nThank you for your congratulations. I am delighted that you share my interest in translation and would gladly offer a few suggestions.\n\nFirst, develop a good command of both languages through regular reading. A translation must sound natural as well as convey the original meaning. Before drafting, identify the writer’s main point and the links between sentences rather than translate word for word. Then compare your version with a reliable translation, paying attention to differences in phrasing. Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding.\n\nI hope these suggestions help. I would love to discuss your translations sometime.\n\nBest wishes,\nLi Ming","paragraphs":[{"id":"d108eb47-233e-5f9b-a713-f089dd583054","sentences":[{"id":"be684e06-6a04-579b-a591-31ecc4bc304a","text":"Dear Jack,"}]},{"id":"bc5e9d21-c2a2-58ce-b574-6dd799f5a91b","sentences":[{"id":"78b94e2c-a506-5a6a-b08f-76bc3f3a005b","text":"Thank you for your congratulations."},{"id":"94552fab-fa68-5726-8c73-602fe253cbf1","text":"I am delighted that you share my interest in translation and would gladly offer a few suggestions."}]},{"id":"1eb4ebd7-eb7a-5cbe-94b0-480c3acd15df","sentences":[{"id":"07cdf405-cb94-5325-bf99-658f26bcfa77","text":"First, develop a good command of both languages through regular reading."},{"id":"e187730e-5644-5c68-b3fb-79c0ab89550f","text":"A translation must sound natural as well as convey the original meaning."},{"id":"ba2dea57-62c8-57cd-9c48-122975e1aa03","text":"Before drafting, identify the writer’s main point and the links between sentences rather than translate word for word."},{"id":"77087d09-acb8-5112-b10d-0af922a187df","text":"Then compare your version with a reliable translation, paying attention to differences in phrasing."},{"id":"28737ac6-9c4e-52da-b636-2a7fc394845a","text":"Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding."}]},{"id":"63353aa7-fe01-56e5-998f-1594a02b6979","sentences":[{"id":"ba0763d7-dee5-5eb0-9c2e-1cacc1bcdb74","text":"I hope these suggestions help."},{"id":"7132978b-a04d-57d0-ad29-851edb2f3104","text":"I would love to discuss your translations sometime."}]},{"id":"5240d331-a87d-51e1-af41-aabe0cddb680","sentences":[{"id":"ef1c11ae-5190-5064-9bc2-50e65eb0cbc9","text":"Best wishes,\nLi Ming"}]}],"sentences":[{"id":"be684e06-6a04-579b-a591-31ecc4bc304a","text":"Dear Jack,"},{"id":"78b94e2c-a506-5a6a-b08f-76bc3f3a005b","text":"Thank you for your congratulations."},{"id":"94552fab-fa68-5726-8c73-602fe253cbf1","text":"I am delighted that you share my interest in translation and would gladly offer a few suggestions."},{"id":"07cdf405-cb94-5325-bf99-658f26bcfa77","text":"First, develop a good command of both languages through regular reading."},{"id":"e187730e-5644-5c68-b3fb-79c0ab89550f","text":"A translation must sound natural as well as convey the original meaning."},{"id":"ba2dea57-62c8-57cd-9c48-122975e1aa03","text":"Before drafting, identify the writer’s main point and the links between sentences rather than translate word for word."},{"id":"77087d09-acb8-5112-b10d-0af922a187df","text":"Then compare your version with a reliable translation, paying attention to differences in phrasing."},{"id":"28737ac6-9c4e-52da-b636-2a7fc394845a","text":"Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding."},{"id":"ba0763d7-dee5-5eb0-9c2e-1cacc1bcdb74","text":"I hope these suggestions help."},{"id":"7132978b-a04d-57d0-ad29-851edb2f3104","text":"I would love to discuss your translations sometime."},{"id":"ef1c11ae-5190-5064-9bc2-50e65eb0cbc9","text":"Best wishes,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    6,
    true
  ),
(
    '0ceed670-f0a3-5673-915a-6dafabdfc0b1'::uuid,
    (select id from collection),
    '2017年英语二·接受中国文化演讲邀请',
    'Dear Professor Williams,

Thank you for your invitation. I would be delighted to speak to your international students about Chinese culture.

My presentation will focus on the Spring Festival and the meaning of family reunion. I will begin with preparations such as cleaning homes and decorating doors, then explain how the reunion dinner brings generations together. Photographs and a short story from my own family will help illustrate the meaning behind these customs. I would also like to invite students to compare them with celebrations in their own countries.

Please let me know the time available for the talk so that I can adjust the presentation accordingly.

Yours sincerely,
Li Ming',
    '{"id":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","title":"2017年英语二·接受中国文化演讲邀请","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Professor Williams,\n\nThank you for your invitation. I would be delighted to speak to your international students about Chinese culture.\n\nMy presentation will focus on the Spring Festival and the meaning of family reunion. I will begin with preparations such as cleaning homes and decorating doors, then explain how the reunion dinner brings generations together. Photographs and a short story from my own family will help illustrate the meaning behind these customs. I would also like to invite students to compare them with celebrations in their own countries.\n\nPlease let me know the time available for the talk so that I can adjust the presentation accordingly.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"df71787b-e467-5cb9-a34a-9bd7b9b2b74f","sentences":[{"id":"b9a04179-6efe-51fa-8b7e-7cd50c9b0bef","text":"Dear Professor Williams,"}]},{"id":"0ed3eff4-228d-54ab-9c1a-ee724af62ce3","sentences":[{"id":"3c01cbcd-4d7e-5bae-a1ee-81053a2fd11e","text":"Thank you for your invitation."},{"id":"e68a3350-8dff-5bb7-b8d8-5b78eda48713","text":"I would be delighted to speak to your international students about Chinese culture."}]},{"id":"629060d5-06ff-525b-b5fa-5e2c545dba10","sentences":[{"id":"92cd6d91-5f4c-5f02-a1fc-0cdc8d7860c2","text":"My presentation will focus on the Spring Festival and the meaning of family reunion."},{"id":"5bb7775a-70e4-50eb-93a7-4299b3b32ffd","text":"I will begin with preparations such as cleaning homes and decorating doors, then explain how the reunion dinner brings generations together."},{"id":"8c7db39c-5863-5a89-9838-2c36af4afa59","text":"Photographs and a short story from my own family will help illustrate the meaning behind these customs."},{"id":"8a93c1e2-7d64-5561-8a1e-f054b2269496","text":"I would also like to invite students to compare them with celebrations in their own countries."}]},{"id":"9d780a4f-a511-53c4-b3cf-31c6e2b03594","sentences":[{"id":"93c28518-2cf9-50dd-9ff6-b591dec630eb","text":"Please let me know the time available for the talk so that I can adjust the presentation accordingly."}]},{"id":"aca66652-2579-578e-8075-f413d7db6bec","sentences":[{"id":"fe5e7139-367a-5ee1-b869-af6c6000d55c","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"b9a04179-6efe-51fa-8b7e-7cd50c9b0bef","text":"Dear Professor Williams,"},{"id":"3c01cbcd-4d7e-5bae-a1ee-81053a2fd11e","text":"Thank you for your invitation."},{"id":"e68a3350-8dff-5bb7-b8d8-5b78eda48713","text":"I would be delighted to speak to your international students about Chinese culture."},{"id":"92cd6d91-5f4c-5f02-a1fc-0cdc8d7860c2","text":"My presentation will focus on the Spring Festival and the meaning of family reunion."},{"id":"5bb7775a-70e4-50eb-93a7-4299b3b32ffd","text":"I will begin with preparations such as cleaning homes and decorating doors, then explain how the reunion dinner brings generations together."},{"id":"8c7db39c-5863-5a89-9838-2c36af4afa59","text":"Photographs and a short story from my own family will help illustrate the meaning behind these customs."},{"id":"8a93c1e2-7d64-5561-8a1e-f054b2269496","text":"I would also like to invite students to compare them with celebrations in their own countries."},{"id":"93c28518-2cf9-50dd-9ff6-b591dec630eb","text":"Please let me know the time available for the talk so that I can adjust the presentation accordingly."},{"id":"fe5e7139-367a-5ee1-b869-af6c6000d55c","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    7,
    true
  ),
(
    '099273ef-e157-5d5f-97b3-02c14f1d606a'::uuid,
    (select id from collection),
    '2018年英语二·取消拜访与重新约见',
    'Dear Professor Smith,

I am very sorry that I cannot visit you as planned. A compulsory examination has been rescheduled for the day of my departure, so I can no longer make the trip.

Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements. Would it be convenient for me to visit on the first Friday of next month instead? If another date would suit you better, I will gladly adjust my plans. I would still greatly value the opportunity to discuss my studies with you.

Thank you for your understanding. I look forward to your reply.

Yours sincerely,
Li Ming',
    '{"id":"099273ef-e157-5d5f-97b3-02c14f1d606a","title":"2018年英语二·取消拜访与重新约见","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Professor Smith,\n\nI am very sorry that I cannot visit you as planned. A compulsory examination has been rescheduled for the day of my departure, so I can no longer make the trip.\n\nKnowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements. Would it be convenient for me to visit on the first Friday of next month instead? If another date would suit you better, I will gladly adjust my plans. I would still greatly value the opportunity to discuss my studies with you.\n\nThank you for your understanding. I look forward to your reply.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"a87b25de-4f62-58bb-b82c-d0a7241453a5","sentences":[{"id":"7e53bacd-b344-5e44-9b22-b8c1a54bb198","text":"Dear Professor Smith,"}]},{"id":"2f789662-9a41-5a77-a935-7c87cb491db2","sentences":[{"id":"f045d61c-3efd-555b-8937-4ec9df7c73d0","text":"I am very sorry that I cannot visit you as planned."},{"id":"f92db6ed-b529-5612-9e75-0b7097148e83","text":"A compulsory examination has been rescheduled for the day of my departure, so I can no longer make the trip."}]},{"id":"14bfd726-61c7-5d79-9c6b-67cfd6da9159","sentences":[{"id":"7d67f59d-6b4d-507e-b956-4036742c09b9","text":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements."},{"id":"5747034a-0f94-5cf4-93ac-6bb11e56c4c4","text":"Would it be convenient for me to visit on the first Friday of next month instead?"},{"id":"2beef8e3-9288-5ef0-9d5f-bc1902c4d002","text":"If another date would suit you better, I will gladly adjust my plans."},{"id":"e9830f6e-6bac-5393-85f7-1f65e8864984","text":"I would still greatly value the opportunity to discuss my studies with you."}]},{"id":"1cef0bc8-410c-5821-954c-c3185a9cd07d","sentences":[{"id":"76171eec-1aaa-5bdc-a0ca-137086837a01","text":"Thank you for your understanding."},{"id":"7b037ee4-f489-5050-b2b8-ebc8a08bd7dc","text":"I look forward to your reply."}]},{"id":"624134a8-5604-5ab1-9b0c-fde5dae16fa5","sentences":[{"id":"5843dca6-00e0-5c25-9b03-f2cc5c38cef2","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"7e53bacd-b344-5e44-9b22-b8c1a54bb198","text":"Dear Professor Smith,"},{"id":"f045d61c-3efd-555b-8937-4ec9df7c73d0","text":"I am very sorry that I cannot visit you as planned."},{"id":"f92db6ed-b529-5612-9e75-0b7097148e83","text":"A compulsory examination has been rescheduled for the day of my departure, so I can no longer make the trip."},{"id":"7d67f59d-6b4d-507e-b956-4036742c09b9","text":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements."},{"id":"5747034a-0f94-5cf4-93ac-6bb11e56c4c4","text":"Would it be convenient for me to visit on the first Friday of next month instead?"},{"id":"2beef8e3-9288-5ef0-9d5f-bc1902c4d002","text":"If another date would suit you better, I will gladly adjust my plans."},{"id":"e9830f6e-6bac-5393-85f7-1f65e8864984","text":"I would still greatly value the opportunity to discuss my studies with you."},{"id":"76171eec-1aaa-5bdc-a0ca-137086837a01","text":"Thank you for your understanding."},{"id":"7b037ee4-f489-5050-b2b8-ebc8a08bd7dc","text":"I look forward to your reply."},{"id":"5843dca6-00e0-5c25-9b03-f2cc5c38cef2","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    8,
    true
  ),
(
    'e6733e88-fa3c-51e0-aef7-b4d7f873ebca'::uuid,
    (select id from collection),
    '2019年英语二·交通辩题与活动安排',
    'Dear Professor Smith,

For the debate on city traffic, I propose “Should private cars be restricted in city centres?” The topic balances concerns about congestion and pollution against people’s need for convenient transport, giving both sides substantial arguments.

I suggest holding the debate in Room 201 at 3 p.m. next Friday. Two teams of four students will present opposing views, exchange questions and give closing statements. Each team will have equal speaking time, and the audience will vote after hearing both sides. I can prepare the schedule and invite a student to chair the discussion.

I would welcome your suggestions on the topic and arrangements.

Yours sincerely,
Li Ming',
    '{"id":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","title":"2019年英语二·交通辩题与活动安排","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Professor Smith,\n\nFor the debate on city traffic, I propose “Should private cars be restricted in city centres?” The topic balances concerns about congestion and pollution against people’s need for convenient transport, giving both sides substantial arguments.\n\nI suggest holding the debate in Room 201 at 3 p.m. next Friday. Two teams of four students will present opposing views, exchange questions and give closing statements. Each team will have equal speaking time, and the audience will vote after hearing both sides. I can prepare the schedule and invite a student to chair the discussion.\n\nI would welcome your suggestions on the topic and arrangements.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"541a0a53-7561-5484-ae43-cd62e5a9d61a","sentences":[{"id":"95a91650-4a35-5dfa-8db4-f67e18afab03","text":"Dear Professor Smith,"}]},{"id":"06ce516f-4908-51db-a94d-4bab5d72f78e","sentences":[{"id":"1e71d763-3fc1-5d43-a18f-d114d75a79fc","text":"For the debate on city traffic, I propose “Should private cars be restricted in city centres?”"},{"id":"b9301c6f-ebc8-5152-9f29-4b074ee85648","text":"The topic balances concerns about congestion and pollution against people’s need for convenient transport, giving both sides substantial arguments."}]},{"id":"9c6c0eaa-07d0-5551-ac62-be3b178ace68","sentences":[{"id":"22ca6fea-001e-5bd0-8215-9bc012047cad","text":"I suggest holding the debate in Room 201 at 3 p.m. next Friday."},{"id":"d7483016-4270-5a5e-8a7f-259a3fa2fc06","text":"Two teams of four students will present opposing views, exchange questions and give closing statements."},{"id":"84012285-afcb-5c16-9935-e14bde43b780","text":"Each team will have equal speaking time, and the audience will vote after hearing both sides."},{"id":"850051a6-308a-5a01-a6b2-277e477d8cbe","text":"I can prepare the schedule and invite a student to chair the discussion."}]},{"id":"6b20ceff-ec59-56a6-9404-f8c4895625ed","sentences":[{"id":"3ab2a030-a750-593f-b255-88b1fa34771a","text":"I would welcome your suggestions on the topic and arrangements."}]},{"id":"10fffb00-b986-5d86-bbe1-11bc28221f2d","sentences":[{"id":"f315b1cd-daf3-5bb3-b55b-fc929371b17f","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"95a91650-4a35-5dfa-8db4-f67e18afab03","text":"Dear Professor Smith,"},{"id":"1e71d763-3fc1-5d43-a18f-d114d75a79fc","text":"For the debate on city traffic, I propose “Should private cars be restricted in city centres?”"},{"id":"b9301c6f-ebc8-5152-9f29-4b074ee85648","text":"The topic balances concerns about congestion and pollution against people’s need for convenient transport, giving both sides substantial arguments."},{"id":"22ca6fea-001e-5bd0-8215-9bc012047cad","text":"I suggest holding the debate in Room 201 at 3 p.m. next Friday."},{"id":"d7483016-4270-5a5e-8a7f-259a3fa2fc06","text":"Two teams of four students will present opposing views, exchange questions and give closing statements."},{"id":"84012285-afcb-5c16-9935-e14bde43b780","text":"Each team will have equal speaking time, and the audience will vote after hearing both sides."},{"id":"850051a6-308a-5a01-a6b2-277e477d8cbe","text":"I can prepare the schedule and invite a student to chair the discussion."},{"id":"3ab2a030-a750-593f-b255-88b1fa34771a","text":"I would welcome your suggestions on the topic and arrangements."},{"id":"f315b1cd-daf3-5bb3-b55b-fc929371b17f","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    9,
    true
  ),
(
    'd3511bd1-6016-5a5b-9069-15a50765c276'::uuid,
    (select id from collection),
    '2020年英语二·历史景点与参观提示',
    'Dear international students,

Our forthcoming tour will take us to the Forbidden City in Beijing, once home to China’s emperors. Its grand halls and courtyards offer a fascinating introduction to traditional architecture and imperial life.

We will explore how the buildings were arranged and what their design reveals about the past. To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask. Comfortable shoes and drinking water are advisable, as we will spend considerable time walking. Please also respect the visitor rules and keep the group together.

I look forward to exploring this remarkable site with you.

Yours sincerely,
Li Ming',
    '{"id":"d3511bd1-6016-5a5b-9069-15a50765c276","title":"2020年英语二·历史景点与参观提示","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear international students,\n\nOur forthcoming tour will take us to the Forbidden City in Beijing, once home to China’s emperors. Its grand halls and courtyards offer a fascinating introduction to traditional architecture and imperial life.\n\nWe will explore how the buildings were arranged and what their design reveals about the past. To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask. Comfortable shoes and drinking water are advisable, as we will spend considerable time walking. Please also respect the visitor rules and keep the group together.\n\nI look forward to exploring this remarkable site with you.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"4accdf4b-1a0a-59a2-829b-e33cae206958","sentences":[{"id":"38d7f011-a27c-584e-a2da-6466dee63be9","text":"Dear international students,"}]},{"id":"58a35929-4f03-58d9-8ab7-f4b31efb1465","sentences":[{"id":"91508ff1-6298-53f5-aae7-77e5ce72cbb4","text":"Our forthcoming tour will take us to the Forbidden City in Beijing, once home to China’s emperors."},{"id":"df6305ad-2e8b-550f-b2f3-99b22d6133b9","text":"Its grand halls and courtyards offer a fascinating introduction to traditional architecture and imperial life."}]},{"id":"0bf2f6dd-bdd8-5d9e-9e3d-9ae6bae7f78e","sentences":[{"id":"0e405a1a-e754-5c88-a437-05a84b86c96a","text":"We will explore how the buildings were arranged and what their design reveals about the past."},{"id":"86da657e-7f92-5fc6-b512-7aaedcd724c2","text":"To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask."},{"id":"592f31fb-3017-5788-9cc8-327e31bcfabd","text":"Comfortable shoes and drinking water are advisable, as we will spend considerable time walking."},{"id":"b8382e50-f64e-59da-8dbf-9c133bbdb41a","text":"Please also respect the visitor rules and keep the group together."}]},{"id":"9181bdd5-92a7-5b0a-92f3-1d83bb2ab094","sentences":[{"id":"1995ddc6-a79a-5c57-a5f8-b02870fd31cc","text":"I look forward to exploring this remarkable site with you."}]},{"id":"484eb24a-7318-532d-aa58-bc18a4424910","sentences":[{"id":"3ffe6942-d7ce-50e8-ba53-634d3f9a8eb9","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"38d7f011-a27c-584e-a2da-6466dee63be9","text":"Dear international students,"},{"id":"91508ff1-6298-53f5-aae7-77e5ce72cbb4","text":"Our forthcoming tour will take us to the Forbidden City in Beijing, once home to China’s emperors."},{"id":"df6305ad-2e8b-550f-b2f3-99b22d6133b9","text":"Its grand halls and courtyards offer a fascinating introduction to traditional architecture and imperial life."},{"id":"0e405a1a-e754-5c88-a437-05a84b86c96a","text":"We will explore how the buildings were arranged and what their design reveals about the past."},{"id":"86da657e-7f92-5fc6-b512-7aaedcd724c2","text":"To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask."},{"id":"592f31fb-3017-5788-9cc8-327e31bcfabd","text":"Comfortable shoes and drinking water are advisable, as we will spend considerable time walking."},{"id":"b8382e50-f64e-59da-8dbf-9c133bbdb41a","text":"Please also respect the visitor rules and keep the group together."},{"id":"1995ddc6-a79a-5c57-a5f8-b02870fd31cc","text":"I look forward to exploring this remarkable site with you."},{"id":"3ffe6942-d7ce-50e8-ba53-634d3f9a8eb9","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    10,
    true
  ),
(
    '6a38af24-c7e7-5bb5-8488-d2b48d76ab9e'::uuid,
    (select id from collection),
    '2021年英语二·线上会议邀请',
    'Dear Jack,

I would like to invite you to an online meeting on adapting to university life, scheduled for 3 p.m. next Saturday. The discussion will bring together local and international students to share experiences and practical advice.

We will begin with brief introductions, followed by a discussion of study habits, friendships and campus activities. It would be wonderful if you could share one challenge you encountered and how you dealt with it. The meeting will last about an hour, and I will email you the link beforehand. Please test your microphone before joining.

I hope you can make it. Please confirm your attendance by Thursday.

Best wishes,
Li Ming',
    '{"id":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","title":"2021年英语二·线上会议邀请","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Jack,\n\nI would like to invite you to an online meeting on adapting to university life, scheduled for 3 p.m. next Saturday. The discussion will bring together local and international students to share experiences and practical advice.\n\nWe will begin with brief introductions, followed by a discussion of study habits, friendships and campus activities. It would be wonderful if you could share one challenge you encountered and how you dealt with it. The meeting will last about an hour, and I will email you the link beforehand. Please test your microphone before joining.\n\nI hope you can make it. Please confirm your attendance by Thursday.\n\nBest wishes,\nLi Ming","paragraphs":[{"id":"4fa4fb53-c58b-5f8c-af59-31fff619a48d","sentences":[{"id":"ff6c496a-92d4-59e8-b117-8f7ebbf3b512","text":"Dear Jack,"}]},{"id":"61889908-ffa4-506e-97d9-4f2517de7cf9","sentences":[{"id":"44653e67-eb34-5c3f-8ad3-bc8f5a0ea7ad","text":"I would like to invite you to an online meeting on adapting to university life, scheduled for 3 p.m. next Saturday."},{"id":"7c03cc31-f104-52fc-a09f-214a60407c64","text":"The discussion will bring together local and international students to share experiences and practical advice."}]},{"id":"efa850cf-7094-583a-b77a-e0f1b4ff1591","sentences":[{"id":"d73b5039-9d98-5658-a9c4-934980d07dbd","text":"We will begin with brief introductions, followed by a discussion of study habits, friendships and campus activities."},{"id":"e93a6f4e-5977-5df2-962d-f1f680ba23ba","text":"It would be wonderful if you could share one challenge you encountered and how you dealt with it."},{"id":"5424b5a8-3c95-575e-839f-5f6ee28d54b4","text":"The meeting will last about an hour, and I will email you the link beforehand."},{"id":"9f1b8669-7611-535d-af36-56262cd656bb","text":"Please test your microphone before joining."}]},{"id":"4f8e8aeb-449c-594b-8f85-c83374678459","sentences":[{"id":"4e32255e-9442-5947-b166-268c004f5af8","text":"I hope you can make it."},{"id":"ee50b616-82de-5bbb-8780-8f430a1d0f71","text":"Please confirm your attendance by Thursday."}]},{"id":"55e70769-3fad-5024-91c1-953587627b6e","sentences":[{"id":"533283cd-3a38-5f64-9f9f-59ecf0beb9ce","text":"Best wishes,\nLi Ming"}]}],"sentences":[{"id":"ff6c496a-92d4-59e8-b117-8f7ebbf3b512","text":"Dear Jack,"},{"id":"44653e67-eb34-5c3f-8ad3-bc8f5a0ea7ad","text":"I would like to invite you to an online meeting on adapting to university life, scheduled for 3 p.m. next Saturday."},{"id":"7c03cc31-f104-52fc-a09f-214a60407c64","text":"The discussion will bring together local and international students to share experiences and practical advice."},{"id":"d73b5039-9d98-5658-a9c4-934980d07dbd","text":"We will begin with brief introductions, followed by a discussion of study habits, friendships and campus activities."},{"id":"e93a6f4e-5977-5df2-962d-f1f680ba23ba","text":"It would be wonderful if you could share one challenge you encountered and how you dealt with it."},{"id":"5424b5a8-3c95-575e-839f-5f6ee28d54b4","text":"The meeting will last about an hour, and I will email you the link beforehand."},{"id":"9f1b8669-7611-535d-af36-56262cd656bb","text":"Please test your microphone before joining."},{"id":"4e32255e-9442-5947-b166-268c004f5af8","text":"I hope you can make it."},{"id":"ee50b616-82de-5bbb-8780-8f430a1d0f71","text":"Please confirm your attendance by Thursday."},{"id":"533283cd-3a38-5f64-9f9f-59ecf0beb9ce","text":"Best wishes,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    11,
    true
  ),
(
    '45e8079a-3dfa-5a72-8e7c-718cf9283b2f'::uuid,
    (select id from collection),
    '2022年英语二·校园美食节邀请',
    'Dear international students,

You are warmly invited to our campus food festival in the main dining hall next Saturday, from 11 a.m. to 3 p.m. It will celebrate the variety of food and cultures represented at our university.

You can sample regional dishes, hear the stories behind them and watch a dumpling-making demonstration. It would be wonderful if you could introduce a favourite dish from your own country. Whether you enjoy cooking or simply trying something new, you will find plenty to share and discover.

Please let me know by Thursday if you would like to contribute a dish. I look forward to seeing you there.

Yours sincerely,
Li Ming',
    '{"id":"45e8079a-3dfa-5a72-8e7c-718cf9283b2f","title":"2022年英语二·校园美食节邀请","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear international students,\n\nYou are warmly invited to our campus food festival in the main dining hall next Saturday, from 11 a.m. to 3 p.m. It will celebrate the variety of food and cultures represented at our university.\n\nYou can sample regional dishes, hear the stories behind them and watch a dumpling-making demonstration. It would be wonderful if you could introduce a favourite dish from your own country. Whether you enjoy cooking or simply trying something new, you will find plenty to share and discover.\n\nPlease let me know by Thursday if you would like to contribute a dish. I look forward to seeing you there.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"4261d75f-2161-5289-85b4-98ee1533605c","sentences":[{"id":"53f6fac5-a278-5a73-bf14-622e10acce10","text":"Dear international students,"}]},{"id":"75040872-4cd7-51f1-af40-37fe0a0d2c93","sentences":[{"id":"38b20700-7f02-5f6b-8787-abcb7662f69e","text":"You are warmly invited to our campus food festival in the main dining hall next Saturday, from 11 a.m. to 3 p.m."},{"id":"a1d44531-93fe-5f0c-9c58-17133658c757","text":"It will celebrate the variety of food and cultures represented at our university."}]},{"id":"b6015754-d4c0-5428-bee6-cbebd7f0bb49","sentences":[{"id":"a9858830-a126-58c9-93bd-6b96cf820bd5","text":"You can sample regional dishes, hear the stories behind them and watch a dumpling-making demonstration."},{"id":"21ce44e3-337b-58f3-beca-53c4dfa88740","text":"It would be wonderful if you could introduce a favourite dish from your own country."},{"id":"9d6483ef-b51b-537d-95aa-9e25e2e6793d","text":"Whether you enjoy cooking or simply trying something new, you will find plenty to share and discover."}]},{"id":"35bf81cd-146f-5eae-b593-15f374ce30dc","sentences":[{"id":"959b5cb2-ad7b-5c05-b716-493d14d22820","text":"Please let me know by Thursday if you would like to contribute a dish."},{"id":"d7e5b44f-9c0c-5cfe-82eb-838dd8398148","text":"I look forward to seeing you there."}]},{"id":"cfdf6740-e5e8-556f-be78-e9ddb353bd1f","sentences":[{"id":"57fe2651-870f-5c14-8864-9508a5c6dfa2","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"53f6fac5-a278-5a73-bf14-622e10acce10","text":"Dear international students,"},{"id":"38b20700-7f02-5f6b-8787-abcb7662f69e","text":"You are warmly invited to our campus food festival in the main dining hall next Saturday, from 11 a.m. to 3 p.m."},{"id":"a1d44531-93fe-5f0c-9c58-17133658c757","text":"It will celebrate the variety of food and cultures represented at our university."},{"id":"a9858830-a126-58c9-93bd-6b96cf820bd5","text":"You can sample regional dishes, hear the stories behind them and watch a dumpling-making demonstration."},{"id":"21ce44e3-337b-58f3-beca-53c4dfa88740","text":"It would be wonderful if you could introduce a favourite dish from your own country."},{"id":"9d6483ef-b51b-537d-95aa-9e25e2e6793d","text":"Whether you enjoy cooking or simply trying something new, you will find plenty to share and discover."},{"id":"959b5cb2-ad7b-5c05-b716-493d14d22820","text":"Please let me know by Thursday if you would like to contribute a dish."},{"id":"d7e5b44f-9c0c-5cfe-82eb-838dd8398148","text":"I look forward to seeing you there."},{"id":"57fe2651-870f-5c14-8864-9508a5c6dfa2","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    12,
    true
  ),
(
    'db0ac466-ee60-57bf-82aa-0ac19f6484e2'::uuid,
    (select id from collection),
    '2023年英语二·展览推荐与理由',
    'Dear David,

Given the choice, I would recommend the robot show this Sunday. It offers a chance to see technology in action rather than simply read about it.

Watching machines perform practical tasks could make ideas about automation much easier to grasp. You could also ask questions about how the robots work and consider where human judgement is still needed. That combination of demonstration and discussion would make the visit both entertaining and thought-provoking. While the art exhibition is certainly appealing, the robot show seems the better choice for an afternoon of discovery.

I hope this helps you decide. I would be interested to hear what you learn.

Best wishes,
Li Ming',
    '{"id":"db0ac466-ee60-57bf-82aa-0ac19f6484e2","title":"2023年英语二·展览推荐与理由","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear David,\n\nGiven the choice, I would recommend the robot show this Sunday. It offers a chance to see technology in action rather than simply read about it.\n\nWatching machines perform practical tasks could make ideas about automation much easier to grasp. You could also ask questions about how the robots work and consider where human judgement is still needed. That combination of demonstration and discussion would make the visit both entertaining and thought-provoking. While the art exhibition is certainly appealing, the robot show seems the better choice for an afternoon of discovery.\n\nI hope this helps you decide. I would be interested to hear what you learn.\n\nBest wishes,\nLi Ming","paragraphs":[{"id":"1e050c38-7843-59ce-8bec-7e780c3775c0","sentences":[{"id":"742ee403-e4e2-584d-b360-38d7edee3db9","text":"Dear David,"}]},{"id":"379f9177-d34d-5bc6-b9ab-0919a3cb06da","sentences":[{"id":"d27b4fd5-3acf-50e8-929a-ec18cd442a69","text":"Given the choice, I would recommend the robot show this Sunday."},{"id":"4126d075-64a4-575c-89eb-999aad5563a3","text":"It offers a chance to see technology in action rather than simply read about it."}]},{"id":"c406cb40-926e-53b0-b9fd-1e6b70ac08bd","sentences":[{"id":"820e70e7-57ab-5a84-aa61-aa42281c00e0","text":"Watching machines perform practical tasks could make ideas about automation much easier to grasp."},{"id":"754c5863-4045-5eca-b424-33c25acc30a3","text":"You could also ask questions about how the robots work and consider where human judgement is still needed."},{"id":"78c24c4f-4618-59e7-a24c-d3f4d67965af","text":"That combination of demonstration and discussion would make the visit both entertaining and thought-provoking."},{"id":"4744740a-0ce6-5b76-b189-994bc3c5522f","text":"While the art exhibition is certainly appealing, the robot show seems the better choice for an afternoon of discovery."}]},{"id":"c2d20252-4ccc-5c8c-88b0-f6697ba51287","sentences":[{"id":"2ebec6dd-8626-5dd5-9cfa-011cf35be01a","text":"I hope this helps you decide."},{"id":"a7593c3a-dedf-5f8e-98be-8c32395cda00","text":"I would be interested to hear what you learn."}]},{"id":"63a3543f-5bef-559e-aa2c-da911d3c8683","sentences":[{"id":"7fe4df4e-e533-5d48-bc9f-e6835ed552d2","text":"Best wishes,\nLi Ming"}]}],"sentences":[{"id":"742ee403-e4e2-584d-b360-38d7edee3db9","text":"Dear David,"},{"id":"d27b4fd5-3acf-50e8-929a-ec18cd442a69","text":"Given the choice, I would recommend the robot show this Sunday."},{"id":"4126d075-64a4-575c-89eb-999aad5563a3","text":"It offers a chance to see technology in action rather than simply read about it."},{"id":"820e70e7-57ab-5a84-aa61-aa42281c00e0","text":"Watching machines perform practical tasks could make ideas about automation much easier to grasp."},{"id":"754c5863-4045-5eca-b424-33c25acc30a3","text":"You could also ask questions about how the robots work and consider where human judgement is still needed."},{"id":"78c24c4f-4618-59e7-a24c-d3f4d67965af","text":"That combination of demonstration and discussion would make the visit both entertaining and thought-provoking."},{"id":"4744740a-0ce6-5b76-b189-994bc3c5522f","text":"While the art exhibition is certainly appealing, the robot show seems the better choice for an afternoon of discovery."},{"id":"2ebec6dd-8626-5dd5-9cfa-011cf35be01a","text":"I hope this helps you decide."},{"id":"a7593c3a-dedf-5f8e-98be-8c32395cda00","text":"I would be interested to hear what you learn."},{"id":"7fe4df4e-e533-5d48-bc9f-e6835ed552d2","text":"Best wishes,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    13,
    true
  ),
(
    '147a5c42-b17d-5e0f-8181-da7e0d0f8285'::uuid,
    (select id from collection),
    '2024年英语二·老屋保护调查计划',
    'Dear Jack,

For our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns.

We could first select several streets and keep a record of signs of damage or restoration, taking photographs with permission. Then we could conduct interviews with residents about maintenance costs, everyday needs and their views on preservation. A short conversation with local officials would help us learn about existing policies. I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings.

Does this approach sound workable to you? I would welcome any changes you suggest.

Yours sincerely,
Li Ming',
    '{"id":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","title":"2024年英语二·老屋保护调查计划","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Jack,\n\nFor our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns.\n\nWe could first select several streets and keep a record of signs of damage or restoration, taking photographs with permission. Then we could conduct interviews with residents about maintenance costs, everyday needs and their views on preservation. A short conversation with local officials would help us learn about existing policies. I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings.\n\nDoes this approach sound workable to you? I would welcome any changes you suggest.\n\nYours sincerely,\nLi Ming","paragraphs":[{"id":"9fc1f261-80ad-590d-9399-dae187deffbf","sentences":[{"id":"5695d387-0d8b-56e1-87f7-7dd7680d1844","text":"Dear Jack,"}]},{"id":"60a9c302-f4d9-52c4-80ea-58dc5f8ce1c1","sentences":[{"id":"e019c065-b5f7-5720-a4b8-0c8e837fbae3","text":"For our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns."}]},{"id":"a3519242-c307-523a-a67f-7e7876466520","sentences":[{"id":"ee3f95a8-05f8-507c-b207-b765ef09ab02","text":"We could first select several streets and keep a record of signs of damage or restoration, taking photographs with permission."},{"id":"f78528cd-b015-5bbc-a2f1-0478f2e349c1","text":"Then we could conduct interviews with residents about maintenance costs, everyday needs and their views on preservation."},{"id":"f185e5ae-34d4-5677-84cc-cb4f7785a426","text":"A short conversation with local officials would help us learn about existing policies."},{"id":"f5cdb8ca-4df8-5fc4-9a1e-ec699835a16a","text":"I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings."}]},{"id":"2d6a8827-a568-598a-bfa7-6dfe07c82e28","sentences":[{"id":"7f595850-0cde-5be4-8d87-dead2e0d84bf","text":"Does this approach sound workable to you?"},{"id":"cb170f1b-7edf-583c-9655-220530b52206","text":"I would welcome any changes you suggest."}]},{"id":"2b7d4e98-45d4-5252-b02c-ce412523153e","sentences":[{"id":"88823578-f7a7-53f3-96e1-8e5426f8d76d","text":"Yours sincerely,\nLi Ming"}]}],"sentences":[{"id":"5695d387-0d8b-56e1-87f7-7dd7680d1844","text":"Dear Jack,"},{"id":"e019c065-b5f7-5720-a4b8-0c8e837fbae3","text":"For our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns."},{"id":"ee3f95a8-05f8-507c-b207-b765ef09ab02","text":"We could first select several streets and keep a record of signs of damage or restoration, taking photographs with permission."},{"id":"f78528cd-b015-5bbc-a2f1-0478f2e349c1","text":"Then we could conduct interviews with residents about maintenance costs, everyday needs and their views on preservation."},{"id":"f185e5ae-34d4-5677-84cc-cb4f7785a426","text":"A short conversation with local officials would help us learn about existing policies."},{"id":"f5cdb8ca-4df8-5fc4-9a1e-ec699835a16a","text":"I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings."},{"id":"7f595850-0cde-5be4-8d87-dead2e0d84bf","text":"Does this approach sound workable to you?"},{"id":"cb170f1b-7edf-583c-9655-220530b52206","text":"I would welcome any changes you suggest."},{"id":"88823578-f7a7-53f3-96e1-8e5426f8d76d","text":"Yours sincerely,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    14,
    true
  ),
(
    '13f9db2f-1791-596a-a299-06df76f0239d'::uuid,
    (select id from collection),
    '2025年英语二·经典小说短剧邀请',
    'Dear John,

I am putting together a short play based on Journey to the West and would love you to join the cast.

Our adaptation follows the Monkey King and his companions as they overcome a challenge on their journey. Through their disagreements and eventual cooperation, the story explores what it means to be a good teammate. I think you would enjoy playing the lively Monkey King. The dialogue will be in simple English, and we will rehearse twice a week. I will explain the cultural references and help everyone learn their lines.

Would you be interested? I hope we can bring this story to life together.

Best wishes,
Li Ming',
    '{"id":"13f9db2f-1791-596a-a299-06df76f0239d","title":"2025年英语二·经典小说短剧邀请","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear John,\n\nI am putting together a short play based on Journey to the West and would love you to join the cast.\n\nOur adaptation follows the Monkey King and his companions as they overcome a challenge on their journey. Through their disagreements and eventual cooperation, the story explores what it means to be a good teammate. I think you would enjoy playing the lively Monkey King. The dialogue will be in simple English, and we will rehearse twice a week. I will explain the cultural references and help everyone learn their lines.\n\nWould you be interested? I hope we can bring this story to life together.\n\nBest wishes,\nLi Ming","paragraphs":[{"id":"c82ec3be-54ed-5558-926e-8da30c9cf06c","sentences":[{"id":"bb4da8af-2186-55cc-9470-76208122a223","text":"Dear John,"}]},{"id":"4e7adc9f-fb02-5adb-a64b-66650bc03042","sentences":[{"id":"3a888f5b-e082-5c2c-a360-4d4c65068f8b","text":"I am putting together a short play based on Journey to the West and would love you to join the cast."}]},{"id":"da09fc71-558c-552f-81ff-afa1c2b89e43","sentences":[{"id":"a7d66987-cf75-54fa-808f-bc6fb5c8cdb1","text":"Our adaptation follows the Monkey King and his companions as they overcome a challenge on their journey."},{"id":"e361d0b0-48ed-51d2-88f3-4b1b85db5649","text":"Through their disagreements and eventual cooperation, the story explores what it means to be a good teammate."},{"id":"b5a39534-a150-5245-adad-3d6d41ea57f6","text":"I think you would enjoy playing the lively Monkey King."},{"id":"a9a916de-5fd6-5ac8-8a89-a72f1c224124","text":"The dialogue will be in simple English, and we will rehearse twice a week."},{"id":"29b8cfc1-ad38-570d-9ad2-fcee8f4c5f97","text":"I will explain the cultural references and help everyone learn their lines."}]},{"id":"93696efc-b3fd-5cd0-9322-447685d20f63","sentences":[{"id":"b6ed8e4a-2010-5341-ba42-7a365a7acd6c","text":"Would you be interested?"},{"id":"49d71a88-631d-51ef-839c-c6eb7ef8c9e6","text":"I hope we can bring this story to life together."}]},{"id":"e757f795-d4a0-5cae-bad3-5593018ef871","sentences":[{"id":"1dfc935e-078b-5e35-8dd8-bbee255baa36","text":"Best wishes,\nLi Ming"}]}],"sentences":[{"id":"bb4da8af-2186-55cc-9470-76208122a223","text":"Dear John,"},{"id":"3a888f5b-e082-5c2c-a360-4d4c65068f8b","text":"I am putting together a short play based on Journey to the West and would love you to join the cast."},{"id":"a7d66987-cf75-54fa-808f-bc6fb5c8cdb1","text":"Our adaptation follows the Monkey King and his companions as they overcome a challenge on their journey."},{"id":"e361d0b0-48ed-51d2-88f3-4b1b85db5649","text":"Through their disagreements and eventual cooperation, the story explores what it means to be a good teammate."},{"id":"b5a39534-a150-5245-adad-3d6d41ea57f6","text":"I think you would enjoy playing the lively Monkey King."},{"id":"a9a916de-5fd6-5ac8-8a89-a72f1c224124","text":"The dialogue will be in simple English, and we will rehearse twice a week."},{"id":"29b8cfc1-ad38-570d-9ad2-fcee8f4c5f97","text":"I will explain the cultural references and help everyone learn their lines."},{"id":"b6ed8e4a-2010-5341-ba42-7a365a7acd6c","text":"Would you be interested?"},{"id":"49d71a88-631d-51ef-839c-c6eb7ef8c9e6","text":"I hope we can bring this story to life together."},{"id":"1dfc935e-078b-5e35-8dd8-bbee255baa36","text":"Best wishes,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    15,
    true
  ),
(
    'dfc938b0-c3bc-58ce-a182-763abd6760fa'::uuid,
    (select id from collection),
    '2026年英语二·旅行视频感受与追问',
    'Dear Jack,

Thank you for sharing the video of your family’s trip to China. I thoroughly enjoyed it: seeing the journey through your eyes made familiar surroundings feel fresh again. It was lovely to see your family exploring together.

I would love to hear more about the experiences behind the video. Which place left the strongest impression on you, and why? Were there any local customs or dishes that surprised your family? I am also curious about the moments you chose not to film, since they can sometimes become the most memorable parts of a journey.

Do write when you have time. I look forward to hearing your stories.

Best wishes,
Li Ming',
    '{"id":"dfc938b0-c3bc-58ce-a182-763abd6760fa","title":"2026年英语二·旅行视频感受与追问","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Jack,\n\nThank you for sharing the video of your family’s trip to China. I thoroughly enjoyed it: seeing the journey through your eyes made familiar surroundings feel fresh again. It was lovely to see your family exploring together.\n\nI would love to hear more about the experiences behind the video. Which place left the strongest impression on you, and why? Were there any local customs or dishes that surprised your family? I am also curious about the moments you chose not to film, since they can sometimes become the most memorable parts of a journey.\n\nDo write when you have time. I look forward to hearing your stories.\n\nBest wishes,\nLi Ming","paragraphs":[{"id":"08c48669-a063-562f-a812-d9e45883eb74","sentences":[{"id":"05490f11-6c5c-548c-8e19-c816260ec025","text":"Dear Jack,"}]},{"id":"39c41861-e694-5414-8425-0584568d743a","sentences":[{"id":"a8288ccb-4c76-5712-baa6-ba90d3e09b7f","text":"Thank you for sharing the video of your family’s trip to China."},{"id":"f5b213bc-bd82-5a70-8270-504dd5f583fc","text":"I thoroughly enjoyed it: seeing the journey through your eyes made familiar surroundings feel fresh again."},{"id":"50347984-7730-573a-9ad6-8357d2779844","text":"It was lovely to see your family exploring together."}]},{"id":"671e5b4f-4133-5af8-9d39-4db24f9c490c","sentences":[{"id":"bccebbbf-9d12-5772-ba77-8374846c1ed4","text":"I would love to hear more about the experiences behind the video."},{"id":"39cf3f7f-015a-528e-ac67-16d12c94552d","text":"Which place left the strongest impression on you, and why?"},{"id":"c4b4c197-e13c-5ba6-9aca-c507cc255e1d","text":"Were there any local customs or dishes that surprised your family?"},{"id":"348c14b4-949f-52d7-accb-2c5fffa4337e","text":"I am also curious about the moments you chose not to film, since they can sometimes become the most memorable parts of a journey."}]},{"id":"e8fb815e-4e91-57f6-8660-f311587641d1","sentences":[{"id":"205a6080-69c8-5ca0-b1f8-87b0bf4249f2","text":"Do write when you have time."},{"id":"2a42bcba-be63-55bb-9986-64672663114e","text":"I look forward to hearing your stories."}]},{"id":"41815fee-b9e4-5f2b-8274-096c71b80c34","sentences":[{"id":"c1519cbc-fe8f-5d01-b936-20a1a24e325d","text":"Best wishes,\nLi Ming"}]}],"sentences":[{"id":"05490f11-6c5c-548c-8e19-c816260ec025","text":"Dear Jack,"},{"id":"a8288ccb-4c76-5712-baa6-ba90d3e09b7f","text":"Thank you for sharing the video of your family’s trip to China."},{"id":"f5b213bc-bd82-5a70-8270-504dd5f583fc","text":"I thoroughly enjoyed it: seeing the journey through your eyes made familiar surroundings feel fresh again."},{"id":"50347984-7730-573a-9ad6-8357d2779844","text":"It was lovely to see your family exploring together."},{"id":"bccebbbf-9d12-5772-ba77-8374846c1ed4","text":"I would love to hear more about the experiences behind the video."},{"id":"39cf3f7f-015a-528e-ac67-16d12c94552d","text":"Which place left the strongest impression on you, and why?"},{"id":"c4b4c197-e13c-5ba6-9aca-c507cc255e1d","text":"Were there any local customs or dishes that surprised your family?"},{"id":"348c14b4-949f-52d7-accb-2c5fffa4337e","text":"I am also curious about the moments you chose not to film, since they can sometimes become the most memorable parts of a journey."},{"id":"205a6080-69c8-5ca0-b1f8-87b0bf4249f2","text":"Do write when you have time."},{"id":"2a42bcba-be63-55bb-9986-64672663114e","text":"I look forward to hearing your stories."},{"id":"c1519cbc-fe8f-5d01-b936-20a1a24e325d","text":"Best wishes,\nLi Ming"}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    16,
    true
  ),
(
    'c958bdb2-5cbd-54c5-be85-883bf531bc73'::uuid,
    (select id from collection),
    '2010年英语二·手机用户量的不同增长',
    'The chart reveals contrasting growth in mobile phone subscriptions between 2000 and 2008. In developing countries, subscriptions showed a sharp increase from well below 1 billion to 4 billion, whereas developed countries recorded a much gentler rise to approximately 1 billion. Particularly striking is the rapid expansion of the developing market from 2000 to 2008.

This contrast is understandable. One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries. Mobile phones also offer practical value: people can contact distant relatives, obtain information and conduct business without travelling. In developed countries, where subscriptions are already widespread, there is naturally less scope for similarly dramatic growth.

The expansion therefore represents more than a larger consumer market; it can mean wider access to opportunities. The next challenge is to make connections affordable and dependable, particularly in remote communities. When access is matched by useful services, mobile communication can become an everyday resource for learning, work and social contact.',
    '{"id":"c958bdb2-5cbd-54c5-be85-883bf531bc73","title":"2010年英语二·手机用户量的不同增长","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart reveals contrasting growth in mobile phone subscriptions between 2000 and 2008. In developing countries, subscriptions showed a sharp increase from well below 1 billion to 4 billion, whereas developed countries recorded a much gentler rise to approximately 1 billion. Particularly striking is the rapid expansion of the developing market from 2000 to 2008.\n\nThis contrast is understandable. One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries. Mobile phones also offer practical value: people can contact distant relatives, obtain information and conduct business without travelling. In developed countries, where subscriptions are already widespread, there is naturally less scope for similarly dramatic growth.\n\nThe expansion therefore represents more than a larger consumer market; it can mean wider access to opportunities. The next challenge is to make connections affordable and dependable, particularly in remote communities. When access is matched by useful services, mobile communication can become an everyday resource for learning, work and social contact.","paragraphs":[{"id":"19fd2b76-31f7-53d7-83a9-4230bb77ab96","sentences":[{"id":"857f3357-e5f1-51b7-994b-fd394ec1f4ff","text":"The chart reveals contrasting growth in mobile phone subscriptions between 2000 and 2008."},{"id":"33b5fe39-5c88-5669-820c-4e1054ed1c79","text":"In developing countries, subscriptions showed a sharp increase from well below 1 billion to 4 billion, whereas developed countries recorded a much gentler rise to approximately 1 billion."},{"id":"21d11f83-d1d7-5375-a794-df45d55be494","text":"Particularly striking is the rapid expansion of the developing market from 2000 to 2008."}]},{"id":"311c4c4f-bb78-581f-8435-1f961049090d","sentences":[{"id":"7b1faa6c-3896-52fe-835e-ee358c1ba945","text":"This contrast is understandable."},{"id":"834feef5-ed1b-5898-b2d9-684a11d51b9c","text":"One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries."},{"id":"464e5f72-3ae6-5995-845d-5d5558d985bd","text":"Mobile phones also offer practical value: people can contact distant relatives, obtain information and conduct business without travelling."},{"id":"1db9aa95-1280-57a9-bed8-a18eeee2fd77","text":"In developed countries, where subscriptions are already widespread, there is naturally less scope for similarly dramatic growth."}]},{"id":"6708933e-7b3a-5e61-88dd-d343dbe85ad2","sentences":[{"id":"b2df2443-0542-5d7c-be24-ab6b2302d3f2","text":"The expansion therefore represents more than a larger consumer market; it can mean wider access to opportunities."},{"id":"b8070ead-5ce4-56ef-a055-a38a0467e146","text":"The next challenge is to make connections affordable and dependable, particularly in remote communities."},{"id":"cee6a5fe-a3ae-5a8a-8e54-9ca9a054619c","text":"When access is matched by useful services, mobile communication can become an everyday resource for learning, work and social contact."}]}],"sentences":[{"id":"857f3357-e5f1-51b7-994b-fd394ec1f4ff","text":"The chart reveals contrasting growth in mobile phone subscriptions between 2000 and 2008."},{"id":"33b5fe39-5c88-5669-820c-4e1054ed1c79","text":"In developing countries, subscriptions showed a sharp increase from well below 1 billion to 4 billion, whereas developed countries recorded a much gentler rise to approximately 1 billion."},{"id":"21d11f83-d1d7-5375-a794-df45d55be494","text":"Particularly striking is the rapid expansion of the developing market from 2000 to 2008."},{"id":"7b1faa6c-3896-52fe-835e-ee358c1ba945","text":"This contrast is understandable."},{"id":"834feef5-ed1b-5898-b2d9-684a11d51b9c","text":"One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries."},{"id":"464e5f72-3ae6-5995-845d-5d5558d985bd","text":"Mobile phones also offer practical value: people can contact distant relatives, obtain information and conduct business without travelling."},{"id":"1db9aa95-1280-57a9-bed8-a18eeee2fd77","text":"In developed countries, where subscriptions are already widespread, there is naturally less scope for similarly dramatic growth."},{"id":"b2df2443-0542-5d7c-be24-ab6b2302d3f2","text":"The expansion therefore represents more than a larger consumer market; it can mean wider access to opportunities."},{"id":"b8070ead-5ce4-56ef-a055-a38a0467e146","text":"The next challenge is to make connections affordable and dependable, particularly in remote communities."},{"id":"cee6a5fe-a3ae-5a8a-8e54-9ca9a054619c","text":"When access is matched by useful services, mobile communication can become an everyday resource for learning, work and social contact."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    17,
    true
  ),
(
    '72dddc6a-fb4e-5a68-a9d8-44ebcddd9731'::uuid,
    (select id from collection),
    '2011年英语二·汽车品牌市场份额变化',
    'The chart shows a reversal in ranking between Chinese and Japanese car brands from 2008 to 2009. Chinese brands expanded their market share from about a quarter to nearly a third, overtaking Japanese brands, whose share fell from roughly 35% to 25%. American brands remained relatively stable at around 12% to 13%.

The shift suggests that market leadership is not permanent. Competitive pricing and improvements in design and quality may have made Chinese cars a more attractive choice. A better understanding of local buyers’ preferences can also help manufacturers offer the features customers actually need. When alternatives become more appealing, established brands must work harder to justify their prices and preserve customer loyalty.

For manufacturers, the lesson is to earn rather than assume consumers’ trust. Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return. Chinese brands should therefore treat their advance as a reason to keep improving, not as a guarantee of lasting success.',
    '{"id":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","title":"2011年英语二·汽车品牌市场份额变化","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows a reversal in ranking between Chinese and Japanese car brands from 2008 to 2009. Chinese brands expanded their market share from about a quarter to nearly a third, overtaking Japanese brands, whose share fell from roughly 35% to 25%. American brands remained relatively stable at around 12% to 13%.\n\nThe shift suggests that market leadership is not permanent. Competitive pricing and improvements in design and quality may have made Chinese cars a more attractive choice. A better understanding of local buyers’ preferences can also help manufacturers offer the features customers actually need. When alternatives become more appealing, established brands must work harder to justify their prices and preserve customer loyalty.\n\nFor manufacturers, the lesson is to earn rather than assume consumers’ trust. Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return. Chinese brands should therefore treat their advance as a reason to keep improving, not as a guarantee of lasting success.","paragraphs":[{"id":"e7f2f074-8773-5e4c-8cd5-b5096a0be816","sentences":[{"id":"a1cdd944-4ba5-5674-8abb-df0c75beb18f","text":"The chart shows a reversal in ranking between Chinese and Japanese car brands from 2008 to 2009."},{"id":"3a6bee9c-a4f8-5230-ab8a-ee0de097df54","text":"Chinese brands expanded their market share from about a quarter to nearly a third, overtaking Japanese brands, whose share fell from roughly 35% to 25%."},{"id":"4f39dbdf-e190-5cae-ae52-4e79097e9e28","text":"American brands remained relatively stable at around 12% to 13%."}]},{"id":"3eef4c28-e52b-5e83-a2dc-e187b1b0df58","sentences":[{"id":"0d37ee12-de86-503c-9e76-5b555637cf56","text":"The shift suggests that market leadership is not permanent."},{"id":"c907f979-b8c1-5161-aebf-f9e7a78c7adf","text":"Competitive pricing and improvements in design and quality may have made Chinese cars a more attractive choice."},{"id":"891b4496-2460-5825-935f-dff0614047ba","text":"A better understanding of local buyers’ preferences can also help manufacturers offer the features customers actually need."},{"id":"236ce762-a637-5090-88e8-e6c8800b010b","text":"When alternatives become more appealing, established brands must work harder to justify their prices and preserve customer loyalty."}]},{"id":"fa2e6f15-7286-52ed-86f4-199693771cab","sentences":[{"id":"a055726d-d932-5895-82e1-200fac595731","text":"For manufacturers, the lesson is to earn rather than assume consumers’ trust."},{"id":"4bcacad3-e83b-57e3-9257-b621b9d598fa","text":"Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return."},{"id":"9e5d2761-fa4b-5850-b98c-86e1c422b77a","text":"Chinese brands should therefore treat their advance as a reason to keep improving, not as a guarantee of lasting success."}]}],"sentences":[{"id":"a1cdd944-4ba5-5674-8abb-df0c75beb18f","text":"The chart shows a reversal in ranking between Chinese and Japanese car brands from 2008 to 2009."},{"id":"3a6bee9c-a4f8-5230-ab8a-ee0de097df54","text":"Chinese brands expanded their market share from about a quarter to nearly a third, overtaking Japanese brands, whose share fell from roughly 35% to 25%."},{"id":"4f39dbdf-e190-5cae-ae52-4e79097e9e28","text":"American brands remained relatively stable at around 12% to 13%."},{"id":"0d37ee12-de86-503c-9e76-5b555637cf56","text":"The shift suggests that market leadership is not permanent."},{"id":"c907f979-b8c1-5161-aebf-f9e7a78c7adf","text":"Competitive pricing and improvements in design and quality may have made Chinese cars a more attractive choice."},{"id":"891b4496-2460-5825-935f-dff0614047ba","text":"A better understanding of local buyers’ preferences can also help manufacturers offer the features customers actually need."},{"id":"236ce762-a637-5090-88e8-e6c8800b010b","text":"When alternatives become more appealing, established brands must work harder to justify their prices and preserve customer loyalty."},{"id":"a055726d-d932-5895-82e1-200fac595731","text":"For manufacturers, the lesson is to earn rather than assume consumers’ trust."},{"id":"4bcacad3-e83b-57e3-9257-b621b9d598fa","text":"Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return."},{"id":"9e5d2761-fa4b-5850-b98c-86e1c422b77a","text":"Chinese brands should therefore treat their advance as a reason to keep improving, not as a guarantee of lasting success."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    18,
    true
  ),
(
    '989d1b46-48f3-51a9-b788-c26e8ac1d042'::uuid,
    (select id from collection),
    '2012年英语二·不同年龄员工的工作满意度',
    'The table reveals a pronounced age difference in job satisfaction at a company. Among employees aged 41 to 50, 64% are dissatisfied and none are satisfied. By contrast, satisfaction reaches 40% among those over 50, whose dissatisfaction rate is just 10%. Employees aged 40 or below fall between these extremes, with 16.7% satisfied and 33.3% dissatisfied.

The middle group’s discontent deserves particular attention. At this career stage, expectations of promotion may collide with limited opportunities, while family responsibilities make financial security especially important. Older employees may have more settled positions and expectations. These differences suggest that the same workplace can be experienced quite differently according to employees’ circumstances.

Management should therefore look beyond an overall satisfaction figure. Confidential feedback could identify the pressures facing each group, allowing the company to offer clearer promotion paths, appropriate training and practical support. Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need.',
    '{"id":"989d1b46-48f3-51a9-b788-c26e8ac1d042","title":"2012年英语二·不同年龄员工的工作满意度","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The table reveals a pronounced age difference in job satisfaction at a company. Among employees aged 41 to 50, 64% are dissatisfied and none are satisfied. By contrast, satisfaction reaches 40% among those over 50, whose dissatisfaction rate is just 10%. Employees aged 40 or below fall between these extremes, with 16.7% satisfied and 33.3% dissatisfied.\n\nThe middle group’s discontent deserves particular attention. At this career stage, expectations of promotion may collide with limited opportunities, while family responsibilities make financial security especially important. Older employees may have more settled positions and expectations. These differences suggest that the same workplace can be experienced quite differently according to employees’ circumstances.\n\nManagement should therefore look beyond an overall satisfaction figure. Confidential feedback could identify the pressures facing each group, allowing the company to offer clearer promotion paths, appropriate training and practical support. Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need.","paragraphs":[{"id":"51666ebc-2789-5903-9b92-6cef34d151c6","sentences":[{"id":"c0e97cf5-f921-5df1-a0e2-c158ea9d8813","text":"The table reveals a pronounced age difference in job satisfaction at a company."},{"id":"2aa5641d-7933-5a7f-a0a6-df4f349b2dc4","text":"Among employees aged 41 to 50, 64% are dissatisfied and none are satisfied."},{"id":"c8ec3097-1cec-5d41-aa3c-a0d3a7080453","text":"By contrast, satisfaction reaches 40% among those over 50, whose dissatisfaction rate is just 10%."},{"id":"a58931d4-e317-5935-8d26-76836a74e024","text":"Employees aged 40 or below fall between these extremes, with 16.7% satisfied and 33.3% dissatisfied."}]},{"id":"a6d18e29-e3fd-5920-a562-3515d8e7582f","sentences":[{"id":"6eb53682-ec6f-50d3-8c47-a266f9639de8","text":"The middle group’s discontent deserves particular attention."},{"id":"e240bdce-65af-5d2e-b9ae-294b8ea247f3","text":"At this career stage, expectations of promotion may collide with limited opportunities, while family responsibilities make financial security especially important."},{"id":"ab3177ae-2427-5886-9f56-2bfc1eb1c961","text":"Older employees may have more settled positions and expectations."},{"id":"d15f402c-525d-59dc-8ad1-8543f20fca75","text":"These differences suggest that the same workplace can be experienced quite differently according to employees’ circumstances."}]},{"id":"1106f868-aea6-5128-a2ae-ba9a8667c008","sentences":[{"id":"f504b040-997a-560e-b7e8-f2286aaac04c","text":"Management should therefore look beyond an overall satisfaction figure."},{"id":"8a3e480f-522b-5211-9421-b3dac7895d03","text":"Confidential feedback could identify the pressures facing each group, allowing the company to offer clearer promotion paths, appropriate training and practical support."},{"id":"11d91b06-f0e4-50f1-b824-e3368f5af064","text":"Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need."}]}],"sentences":[{"id":"c0e97cf5-f921-5df1-a0e2-c158ea9d8813","text":"The table reveals a pronounced age difference in job satisfaction at a company."},{"id":"2aa5641d-7933-5a7f-a0a6-df4f349b2dc4","text":"Among employees aged 41 to 50, 64% are dissatisfied and none are satisfied."},{"id":"c8ec3097-1cec-5d41-aa3c-a0d3a7080453","text":"By contrast, satisfaction reaches 40% among those over 50, whose dissatisfaction rate is just 10%."},{"id":"a58931d4-e317-5935-8d26-76836a74e024","text":"Employees aged 40 or below fall between these extremes, with 16.7% satisfied and 33.3% dissatisfied."},{"id":"6eb53682-ec6f-50d3-8c47-a266f9639de8","text":"The middle group’s discontent deserves particular attention."},{"id":"e240bdce-65af-5d2e-b9ae-294b8ea247f3","text":"At this career stage, expectations of promotion may collide with limited opportunities, while family responsibilities make financial security especially important."},{"id":"ab3177ae-2427-5886-9f56-2bfc1eb1c961","text":"Older employees may have more settled positions and expectations."},{"id":"d15f402c-525d-59dc-8ad1-8543f20fca75","text":"These differences suggest that the same workplace can be experienced quite differently according to employees’ circumstances."},{"id":"f504b040-997a-560e-b7e8-f2286aaac04c","text":"Management should therefore look beyond an overall satisfaction figure."},{"id":"8a3e480f-522b-5211-9421-b3dac7895d03","text":"Confidential feedback could identify the pressures facing each group, allowing the company to offer clearer promotion paths, appropriate training and practical support."},{"id":"11d91b06-f0e4-50f1-b824-e3368f5af064","text":"Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    19,
    true
  ),
(
    'ec008595-49f7-5f74-8ff6-ad3f85ebe245'::uuid,
    (select id from collection),
    '2013年英语二·不同年级大学生兼职比例',
    'The chart compares part-time employment across four year groups at a university. The proportion is 67.77% among first-year students and just over 71% among both second-year and third-year students. It reaches 88.24% in the final year, making graduating students the most active participants by a considerable margin.

The contrast is closely connected with the transition from university to employment. As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers. Part-time work can provide these opportunities while helping with living expenses. The particularly high final-year figure thus reflects how strongly employment concerns may shape students’ choices.

Such work is most beneficial when it complements rather than displaces education. Universities should help students find trustworthy employers and positions with genuine learning value. Students, in turn, should consider what a job teaches them as well as what it pays. A carefully chosen position can help students prepare for employment.',
    '{"id":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","title":"2013年英语二·不同年级大学生兼职比例","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart compares part-time employment across four year groups at a university. The proportion is 67.77% among first-year students and just over 71% among both second-year and third-year students. It reaches 88.24% in the final year, making graduating students the most active participants by a considerable margin.\n\nThe contrast is closely connected with the transition from university to employment. As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers. Part-time work can provide these opportunities while helping with living expenses. The particularly high final-year figure thus reflects how strongly employment concerns may shape students’ choices.\n\nSuch work is most beneficial when it complements rather than displaces education. Universities should help students find trustworthy employers and positions with genuine learning value. Students, in turn, should consider what a job teaches them as well as what it pays. A carefully chosen position can help students prepare for employment.","paragraphs":[{"id":"ef016b10-1761-5418-b258-2d40b223ae83","sentences":[{"id":"8fd1544b-e6c5-5c3a-8279-3745890c5b73","text":"The chart compares part-time employment across four year groups at a university."},{"id":"561bef65-979c-5954-b452-e2f459c98286","text":"The proportion is 67.77% among first-year students and just over 71% among both second-year and third-year students."},{"id":"7b0ef93c-82d9-52a6-8656-1dc29e2de8d8","text":"It reaches 88.24% in the final year, making graduating students the most active participants by a considerable margin."}]},{"id":"e6979b23-fe98-5772-96f7-b3a53756941c","sentences":[{"id":"a6edee41-dd77-5a8e-9e7d-632ddc2e9233","text":"The contrast is closely connected with the transition from university to employment."},{"id":"72764995-94a4-54db-a234-d10627667919","text":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers."},{"id":"e01de04e-d85a-5a4e-81e1-cf354768ea04","text":"Part-time work can provide these opportunities while helping with living expenses."},{"id":"6250bd7b-e94e-50df-a7a0-7d70f5d402cb","text":"The particularly high final-year figure thus reflects how strongly employment concerns may shape students’ choices."}]},{"id":"c4971b61-5f0a-5daf-b5f7-05537f731980","sentences":[{"id":"df65c393-0841-5833-bec0-3b9f215bc6d5","text":"Such work is most beneficial when it complements rather than displaces education."},{"id":"165e8381-44d7-58cc-9ed1-ccd20a8e9f5b","text":"Universities should help students find trustworthy employers and positions with genuine learning value."},{"id":"017a588b-5db2-59a6-8d05-2be155a37c21","text":"Students, in turn, should consider what a job teaches them as well as what it pays."},{"id":"12058a17-dbc4-5808-96cb-da22270bfede","text":"A carefully chosen position can help students prepare for employment."}]}],"sentences":[{"id":"8fd1544b-e6c5-5c3a-8279-3745890c5b73","text":"The chart compares part-time employment across four year groups at a university."},{"id":"561bef65-979c-5954-b452-e2f459c98286","text":"The proportion is 67.77% among first-year students and just over 71% among both second-year and third-year students."},{"id":"7b0ef93c-82d9-52a6-8656-1dc29e2de8d8","text":"It reaches 88.24% in the final year, making graduating students the most active participants by a considerable margin."},{"id":"a6edee41-dd77-5a8e-9e7d-632ddc2e9233","text":"The contrast is closely connected with the transition from university to employment."},{"id":"72764995-94a4-54db-a234-d10627667919","text":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers."},{"id":"e01de04e-d85a-5a4e-81e1-cf354768ea04","text":"Part-time work can provide these opportunities while helping with living expenses."},{"id":"6250bd7b-e94e-50df-a7a0-7d70f5d402cb","text":"The particularly high final-year figure thus reflects how strongly employment concerns may shape students’ choices."},{"id":"df65c393-0841-5833-bec0-3b9f215bc6d5","text":"Such work is most beneficial when it complements rather than displaces education."},{"id":"165e8381-44d7-58cc-9ed1-ccd20a8e9f5b","text":"Universities should help students find trustworthy employers and positions with genuine learning value."},{"id":"017a588b-5db2-59a6-8d05-2be155a37c21","text":"Students, in turn, should consider what a job teaches them as well as what it pays."},{"id":"12058a17-dbc4-5808-96cb-da22270bfede","text":"A carefully chosen position can help students prepare for employment."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    20,
    true
  ),
(
    '487c4ff9-9d73-5a24-9760-85628aa33f9d'::uuid,
    (select id from collection),
    '2014年英语二·城乡人口变化',
    'The chart illustrates a major redistribution of China’s population between 1990 and 2010. The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million. By 2010, the two population figures were almost equal.

This movement is closely associated with urbanization. Expanding industries and services create jobs that attract rural workers, while access to education, healthcare and other facilities can make city life appealing to their families. As more people settle in cities, growing demand can put pressure on housing and public services, further reshaping everyday life.

The central task is therefore to make urban growth improve people’s lives. Affordable housing, accessible schools and dependable transport must develop alongside population increases. Rural areas also need investment so that migration remains a choice rather than a necessity. Successful urbanization should be measured not simply by how many people live in cities, but by the opportunities available to residents in both settings.',
    '{"id":"487c4ff9-9d73-5a24-9760-85628aa33f9d","title":"2014年英语二·城乡人口变化","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart illustrates a major redistribution of China’s population between 1990 and 2010. The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million. By 2010, the two population figures were almost equal.\n\nThis movement is closely associated with urbanization. Expanding industries and services create jobs that attract rural workers, while access to education, healthcare and other facilities can make city life appealing to their families. As more people settle in cities, growing demand can put pressure on housing and public services, further reshaping everyday life.\n\nThe central task is therefore to make urban growth improve people’s lives. Affordable housing, accessible schools and dependable transport must develop alongside population increases. Rural areas also need investment so that migration remains a choice rather than a necessity. Successful urbanization should be measured not simply by how many people live in cities, but by the opportunities available to residents in both settings.","paragraphs":[{"id":"42234819-6dda-54cf-a12f-7f08d9fcc185","sentences":[{"id":"fa645861-8abd-5a57-b4aa-410af5341f68","text":"The chart illustrates a major redistribution of China’s population between 1990 and 2010."},{"id":"d5e738ae-56c2-5957-986a-db4e07b99fee","text":"The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million."},{"id":"8aab1db4-8270-5714-ae18-51ff58b39862","text":"By 2010, the two population figures were almost equal."}]},{"id":"d4f3f721-3e0e-5865-bca7-9ac4c37469f5","sentences":[{"id":"250f961f-2aa2-53df-b0f2-a153ac6ccaa7","text":"This movement is closely associated with urbanization."},{"id":"675e6c3d-91e5-57ef-85a8-025a603f6800","text":"Expanding industries and services create jobs that attract rural workers, while access to education, healthcare and other facilities can make city life appealing to their families."},{"id":"329254f4-2a37-5bd0-8082-ad23a94f6937","text":"As more people settle in cities, growing demand can put pressure on housing and public services, further reshaping everyday life."}]},{"id":"772453d5-b609-574c-a658-772cd5818d73","sentences":[{"id":"1b3e81ed-3a93-57e2-a96a-9a62ee3c7f7f","text":"The central task is therefore to make urban growth improve people’s lives."},{"id":"481e2670-5f95-5f34-a8d2-82cba2f12f9c","text":"Affordable housing, accessible schools and dependable transport must develop alongside population increases."},{"id":"ee52aae1-e93d-5ade-b7d9-84f56928e148","text":"Rural areas also need investment so that migration remains a choice rather than a necessity."},{"id":"08a43295-9526-58ca-83e2-ffa5d0287463","text":"Successful urbanization should be measured not simply by how many people live in cities, but by the opportunities available to residents in both settings."}]}],"sentences":[{"id":"fa645861-8abd-5a57-b4aa-410af5341f68","text":"The chart illustrates a major redistribution of China’s population between 1990 and 2010."},{"id":"d5e738ae-56c2-5957-986a-db4e07b99fee","text":"The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million."},{"id":"8aab1db4-8270-5714-ae18-51ff58b39862","text":"By 2010, the two population figures were almost equal."},{"id":"250f961f-2aa2-53df-b0f2-a153ac6ccaa7","text":"This movement is closely associated with urbanization."},{"id":"675e6c3d-91e5-57ef-85a8-025a603f6800","text":"Expanding industries and services create jobs that attract rural workers, while access to education, healthcare and other facilities can make city life appealing to their families."},{"id":"329254f4-2a37-5bd0-8082-ad23a94f6937","text":"As more people settle in cities, growing demand can put pressure on housing and public services, further reshaping everyday life."},{"id":"1b3e81ed-3a93-57e2-a96a-9a62ee3c7f7f","text":"The central task is therefore to make urban growth improve people’s lives."},{"id":"481e2670-5f95-5f34-a8d2-82cba2f12f9c","text":"Affordable housing, accessible schools and dependable transport must develop alongside population increases."},{"id":"ee52aae1-e93d-5ade-b7d9-84f56928e148","text":"Rural areas also need investment so that migration remains a choice rather than a necessity."},{"id":"08a43295-9526-58ca-83e2-ffa5d0287463","text":"Successful urbanization should be measured not simply by how many people live in cities, but by the opportunities available to residents in both settings."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    21,
    true
  ),
(
    '2969d0a9-2d30-59ca-be57-be58fe68d70d'::uuid,
    (select id from collection),
    '2015年英语二·春节花销构成',
    'The pie chart presents Spring Festival spending in a Chinese city. Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%. Together, transport and meals account for 40% of spending.

The pattern reflects the festival’s role in sustaining personal relationships. Presents convey affection and good wishes, travel enables reunions, and shared meals give relatives time to reconnect. Much of this expenditure buys not merely goods or services but occasions for expressing care. Nevertheless, the prominence of gifts also raises a question: does their price always reflect their meaning?

In my view, festive spending is worthwhile when it strengthens relationships without creating financial strain. A thoughtful, affordable present can communicate more than an expensive purchase made out of obligation. By budgeting sensibly and giving time as generously as money, people can preserve the warmth of the celebration while avoiding unnecessary competition over spending.',
    '{"id":"2969d0a9-2d30-59ca-be57-be58fe68d70d","title":"2015年英语二·春节花销构成","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The pie chart presents Spring Festival spending in a Chinese city. Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%. Together, transport and meals account for 40% of spending.\n\nThe pattern reflects the festival’s role in sustaining personal relationships. Presents convey affection and good wishes, travel enables reunions, and shared meals give relatives time to reconnect. Much of this expenditure buys not merely goods or services but occasions for expressing care. Nevertheless, the prominence of gifts also raises a question: does their price always reflect their meaning?\n\nIn my view, festive spending is worthwhile when it strengthens relationships without creating financial strain. A thoughtful, affordable present can communicate more than an expensive purchase made out of obligation. By budgeting sensibly and giving time as generously as money, people can preserve the warmth of the celebration while avoiding unnecessary competition over spending.","paragraphs":[{"id":"b2d6e93e-f9db-547b-88ee-ff103944faf0","sentences":[{"id":"978bd99b-c6e4-5948-8d5d-326094c18c11","text":"The pie chart presents Spring Festival spending in a Chinese city."},{"id":"17a19865-ea2e-5629-b248-70198c7aead9","text":"Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%."},{"id":"3626a02f-0730-59b4-971d-1b5049e633a5","text":"Together, transport and meals account for 40% of spending."}]},{"id":"1b5734c7-22f1-5326-b93f-3a6310ea24b1","sentences":[{"id":"55104ee5-9fa9-5790-8538-78924e213653","text":"The pattern reflects the festival’s role in sustaining personal relationships."},{"id":"84c661ed-c1d1-5ccb-b693-a756a42cea19","text":"Presents convey affection and good wishes, travel enables reunions, and shared meals give relatives time to reconnect."},{"id":"35471f91-574d-537e-bd64-79eeea2631c6","text":"Much of this expenditure buys not merely goods or services but occasions for expressing care."},{"id":"239758ef-f9e0-5a42-9603-29c9b94eef33","text":"Nevertheless, the prominence of gifts also raises a question: does their price always reflect their meaning?"}]},{"id":"50c7c15d-4905-5806-8a32-5982ebe607b6","sentences":[{"id":"e87d515f-c823-5495-8d9f-c8f7d1a5fcf9","text":"In my view, festive spending is worthwhile when it strengthens relationships without creating financial strain."},{"id":"9d5a9132-05d5-5ead-9689-a9ef61530302","text":"A thoughtful, affordable present can communicate more than an expensive purchase made out of obligation."},{"id":"45ed0b6c-3a2d-5799-a1a5-c7f8c0f297aa","text":"By budgeting sensibly and giving time as generously as money, people can preserve the warmth of the celebration while avoiding unnecessary competition over spending."}]}],"sentences":[{"id":"978bd99b-c6e4-5948-8d5d-326094c18c11","text":"The pie chart presents Spring Festival spending in a Chinese city."},{"id":"17a19865-ea2e-5629-b248-70198c7aead9","text":"Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%."},{"id":"3626a02f-0730-59b4-971d-1b5049e633a5","text":"Together, transport and meals account for 40% of spending."},{"id":"55104ee5-9fa9-5790-8538-78924e213653","text":"The pattern reflects the festival’s role in sustaining personal relationships."},{"id":"84c661ed-c1d1-5ccb-b693-a756a42cea19","text":"Presents convey affection and good wishes, travel enables reunions, and shared meals give relatives time to reconnect."},{"id":"35471f91-574d-537e-bd64-79eeea2631c6","text":"Much of this expenditure buys not merely goods or services but occasions for expressing care."},{"id":"239758ef-f9e0-5a42-9603-29c9b94eef33","text":"Nevertheless, the prominence of gifts also raises a question: does their price always reflect their meaning?"},{"id":"e87d515f-c823-5495-8d9f-c8f7d1a5fcf9","text":"In my view, festive spending is worthwhile when it strengthens relationships without creating financial strain."},{"id":"9d5a9132-05d5-5ead-9689-a9ef61530302","text":"A thoughtful, affordable present can communicate more than an expensive purchase made out of obligation."},{"id":"45ed0b6c-3a2d-5799-a1a5-c7f8c0f297aa","text":"By budgeting sensibly and giving time as generously as money, people can preserve the warmth of the celebration while avoiding unnecessary competition over spending."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    22,
    true
  ),
(
    '85ce14b0-544b-5591-bd91-58ed66b38d3a'::uuid,
    (select id from collection),
    '2016年英语二·大学生旅游目的',
    'The pie chart shows why students at a university travel. Enjoying scenery and relieving stress dominate, accounting for 37% and 33% respectively. Making friends represents 9%, developing independence 6%, and other purposes the remaining 15%. Together, sightseeing and relaxation account for seven out of every ten responses.

These priorities are understandable in the context of university life. Academic deadlines and uncertainty about the future can make students eager for a change of scene. Travel offers a temporary escape from familiar pressures, while natural surroundings provide pleasure that everyday routines may lack. The two leading purposes therefore reinforce each other: enjoying a different environment can itself be a way of recovering energy.

Travel need not be justified solely by measurable achievements. Rest and enjoyment have value, provided that a trip suits a student’s time and budget. By planning sensibly and engaging with the places they visit, students can return refreshed, with a broader perspective as well as pleasant memories.',
    '{"id":"85ce14b0-544b-5591-bd91-58ed66b38d3a","title":"2016年英语二·大学生旅游目的","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The pie chart shows why students at a university travel. Enjoying scenery and relieving stress dominate, accounting for 37% and 33% respectively. Making friends represents 9%, developing independence 6%, and other purposes the remaining 15%. Together, sightseeing and relaxation account for seven out of every ten responses.\n\nThese priorities are understandable in the context of university life. Academic deadlines and uncertainty about the future can make students eager for a change of scene. Travel offers a temporary escape from familiar pressures, while natural surroundings provide pleasure that everyday routines may lack. The two leading purposes therefore reinforce each other: enjoying a different environment can itself be a way of recovering energy.\n\nTravel need not be justified solely by measurable achievements. Rest and enjoyment have value, provided that a trip suits a student’s time and budget. By planning sensibly and engaging with the places they visit, students can return refreshed, with a broader perspective as well as pleasant memories.","paragraphs":[{"id":"62b34398-5d5e-506f-a36d-c8450b7e40b7","sentences":[{"id":"011105f4-f828-528b-8508-df409fdd8ccd","text":"The pie chart shows why students at a university travel."},{"id":"cf385388-4cb3-57c5-aa8b-5d479be471f1","text":"Enjoying scenery and relieving stress dominate, accounting for 37% and 33% respectively."},{"id":"8f6a11f6-f8e6-5080-943d-cea40507271b","text":"Making friends represents 9%, developing independence 6%, and other purposes the remaining 15%."},{"id":"924aed35-54ba-550d-a4d4-3057f2134b30","text":"Together, sightseeing and relaxation account for seven out of every ten responses."}]},{"id":"357a71de-2a1e-56f7-af2b-745903326619","sentences":[{"id":"7f3c5c76-c2db-548e-b544-09329a64f418","text":"These priorities are understandable in the context of university life."},{"id":"3657e887-c38b-553a-8eb0-797ed2de7e2c","text":"Academic deadlines and uncertainty about the future can make students eager for a change of scene."},{"id":"9e504b34-807c-562c-aa9d-cac9d7556023","text":"Travel offers a temporary escape from familiar pressures, while natural surroundings provide pleasure that everyday routines may lack."},{"id":"12177767-b20c-5e49-bdec-6986f9c3c663","text":"The two leading purposes therefore reinforce each other: enjoying a different environment can itself be a way of recovering energy."}]},{"id":"227af4e3-a7dc-52a3-b07a-60790a915640","sentences":[{"id":"7f20a287-356a-55cf-ac76-5699357daa59","text":"Travel need not be justified solely by measurable achievements."},{"id":"fc4a1cd1-4d6a-5b29-a716-ff578172a983","text":"Rest and enjoyment have value, provided that a trip suits a student’s time and budget."},{"id":"79bcec68-2800-52e8-9d91-d5cb6f45ddf4","text":"By planning sensibly and engaging with the places they visit, students can return refreshed, with a broader perspective as well as pleasant memories."}]}],"sentences":[{"id":"011105f4-f828-528b-8508-df409fdd8ccd","text":"The pie chart shows why students at a university travel."},{"id":"cf385388-4cb3-57c5-aa8b-5d479be471f1","text":"Enjoying scenery and relieving stress dominate, accounting for 37% and 33% respectively."},{"id":"8f6a11f6-f8e6-5080-943d-cea40507271b","text":"Making friends represents 9%, developing independence 6%, and other purposes the remaining 15%."},{"id":"924aed35-54ba-550d-a4d4-3057f2134b30","text":"Together, sightseeing and relaxation account for seven out of every ten responses."},{"id":"7f3c5c76-c2db-548e-b544-09329a64f418","text":"These priorities are understandable in the context of university life."},{"id":"3657e887-c38b-553a-8eb0-797ed2de7e2c","text":"Academic deadlines and uncertainty about the future can make students eager for a change of scene."},{"id":"9e504b34-807c-562c-aa9d-cac9d7556023","text":"Travel offers a temporary escape from familiar pressures, while natural surroundings provide pleasure that everyday routines may lack."},{"id":"12177767-b20c-5e49-bdec-6986f9c3c663","text":"The two leading purposes therefore reinforce each other: enjoying a different environment can itself be a way of recovering energy."},{"id":"7f20a287-356a-55cf-ac76-5699357daa59","text":"Travel need not be justified solely by measurable achievements."},{"id":"fc4a1cd1-4d6a-5b29-a716-ff578172a983","text":"Rest and enjoyment have value, provided that a trip suits a student’s time and budget."},{"id":"79bcec68-2800-52e8-9d91-d5cb6f45ddf4","text":"By planning sensibly and engaging with the places they visit, students can return refreshed, with a broader perspective as well as pleasant memories."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    23,
    true
  ),
(
    '37f0273c-086e-5f3d-929d-9bd309d9598b'::uuid,
    (select id from collection),
    '2017年英语二·博物馆数量与参观人次',
    'The chart records growth in both museum provision and attendance in China from 2013 to 2015. Museum numbers rose from about 4,200 to 4,700, while annual visits increased from approximately 640 million to 780 million. Attendance grew faster proportionally, indicating more visits per museum on average.

The two trends can reinforce each other. More museums bring cultural resources within reach of a wider public, while engaging exhibitions give people reasons to visit. Schools and families can also use museums to make history and culture tangible. As interest grows, demand encourages institutions to improve their collections, explanations and services, making museums more valuable places for learning.

Continued progress should therefore concern the quality of encounters, not visitor totals alone. Clear labels, knowledgeable guides and activities for different ages can turn a brief visit into lasting curiosity. By helping visitors understand what they see, museums can ensure that wider access leads to deeper cultural engagement rather than simply larger crowds.',
    '{"id":"37f0273c-086e-5f3d-929d-9bd309d9598b","title":"2017年英语二·博物馆数量与参观人次","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart records growth in both museum provision and attendance in China from 2013 to 2015. Museum numbers rose from about 4,200 to 4,700, while annual visits increased from approximately 640 million to 780 million. Attendance grew faster proportionally, indicating more visits per museum on average.\n\nThe two trends can reinforce each other. More museums bring cultural resources within reach of a wider public, while engaging exhibitions give people reasons to visit. Schools and families can also use museums to make history and culture tangible. As interest grows, demand encourages institutions to improve their collections, explanations and services, making museums more valuable places for learning.\n\nContinued progress should therefore concern the quality of encounters, not visitor totals alone. Clear labels, knowledgeable guides and activities for different ages can turn a brief visit into lasting curiosity. By helping visitors understand what they see, museums can ensure that wider access leads to deeper cultural engagement rather than simply larger crowds.","paragraphs":[{"id":"31711d7e-46f3-5b46-991e-f3ebcd4cbcb4","sentences":[{"id":"730eea87-aed9-53ae-8283-4623c1354885","text":"The chart records growth in both museum provision and attendance in China from 2013 to 2015."},{"id":"1d3bc84d-8dd8-5489-8032-c99499c84580","text":"Museum numbers rose from about 4,200 to 4,700, while annual visits increased from approximately 640 million to 780 million."},{"id":"10cf6856-f5e4-5552-adc8-b30f99994aee","text":"Attendance grew faster proportionally, indicating more visits per museum on average."}]},{"id":"c14f1e2e-660b-5dfd-9667-fbee95b85ff2","sentences":[{"id":"00c8ec84-eefb-5a42-9299-e9687e9a2dc7","text":"The two trends can reinforce each other."},{"id":"0e332192-3677-5593-9432-5301cbae9ae7","text":"More museums bring cultural resources within reach of a wider public, while engaging exhibitions give people reasons to visit."},{"id":"fbdf0a7b-dc23-5ed9-9d8f-d10ddcf2f73f","text":"Schools and families can also use museums to make history and culture tangible."},{"id":"7b4535a4-80c9-53ec-bbee-fde8392ebb78","text":"As interest grows, demand encourages institutions to improve their collections, explanations and services, making museums more valuable places for learning."}]},{"id":"3cf9910b-1446-5294-9fae-71f24b5a8cfe","sentences":[{"id":"fcc9d096-6a8c-506a-b6fe-14c06682c7e0","text":"Continued progress should therefore concern the quality of encounters, not visitor totals alone."},{"id":"8d1886e1-c119-52ad-9c5a-d1e6b7a44e8a","text":"Clear labels, knowledgeable guides and activities for different ages can turn a brief visit into lasting curiosity."},{"id":"b1625c5d-f0bc-5280-a75a-d1141bc498e5","text":"By helping visitors understand what they see, museums can ensure that wider access leads to deeper cultural engagement rather than simply larger crowds."}]}],"sentences":[{"id":"730eea87-aed9-53ae-8283-4623c1354885","text":"The chart records growth in both museum provision and attendance in China from 2013 to 2015."},{"id":"1d3bc84d-8dd8-5489-8032-c99499c84580","text":"Museum numbers rose from about 4,200 to 4,700, while annual visits increased from approximately 640 million to 780 million."},{"id":"10cf6856-f5e4-5552-adc8-b30f99994aee","text":"Attendance grew faster proportionally, indicating more visits per museum on average."},{"id":"00c8ec84-eefb-5a42-9299-e9687e9a2dc7","text":"The two trends can reinforce each other."},{"id":"0e332192-3677-5593-9432-5301cbae9ae7","text":"More museums bring cultural resources within reach of a wider public, while engaging exhibitions give people reasons to visit."},{"id":"fbdf0a7b-dc23-5ed9-9d8f-d10ddcf2f73f","text":"Schools and families can also use museums to make history and culture tangible."},{"id":"7b4535a4-80c9-53ec-bbee-fde8392ebb78","text":"As interest grows, demand encourages institutions to improve their collections, explanations and services, making museums more valuable places for learning."},{"id":"fcc9d096-6a8c-506a-b6fe-14c06682c7e0","text":"Continued progress should therefore concern the quality of encounters, not visitor totals alone."},{"id":"8d1886e1-c119-52ad-9c5a-d1e6b7a44e8a","text":"Clear labels, knowledgeable guides and activities for different ages can turn a brief visit into lasting curiosity."},{"id":"b1625c5d-f0bc-5280-a75a-d1141bc498e5","text":"By helping visitors understand what they see, museums can ensure that wider access leads to deeper cultural engagement rather than simply larger crowds."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    24,
    true
  ),
(
    'e40f3792-90b1-5de2-b6c7-ca2f0f783b14'::uuid,
    (select id from collection),
    '2018年英语二·选择餐厅的关注因素',
    'The pie chart shows what consumers consider when choosing restaurants in a city. Distinctive features rank first at 36.3%, followed by service at 26.8% and the dining environment at 23.8%. Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%. Experience clearly carries considerable weight in these choices.

Dining out serves purposes beyond satisfying hunger. A distinctive menu can make a meal memorable, attentive service makes guests feel valued, and a comfortable setting allows conversation to flow. These benefits matter particularly when people eat together to celebrate or maintain relationships. A lower price may offer savings, but it cannot by itself provide the experience customers seek.

Restaurant owners should therefore build a recognizable identity without neglecting everyday standards. Creative dishes will attract attention only briefly if food quality or service disappoints. Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone. The aim should be to give customers a reason to return, rather than merely a reason to enter.',
    '{"id":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","title":"2018年英语二·选择餐厅的关注因素","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The pie chart shows what consumers consider when choosing restaurants in a city. Distinctive features rank first at 36.3%, followed by service at 26.8% and the dining environment at 23.8%. Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%. Experience clearly carries considerable weight in these choices.\n\nDining out serves purposes beyond satisfying hunger. A distinctive menu can make a meal memorable, attentive service makes guests feel valued, and a comfortable setting allows conversation to flow. These benefits matter particularly when people eat together to celebrate or maintain relationships. A lower price may offer savings, but it cannot by itself provide the experience customers seek.\n\nRestaurant owners should therefore build a recognizable identity without neglecting everyday standards. Creative dishes will attract attention only briefly if food quality or service disappoints. Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone. The aim should be to give customers a reason to return, rather than merely a reason to enter.","paragraphs":[{"id":"5da9dabf-fc1b-5ee9-ae47-f02688335820","sentences":[{"id":"411fe138-46b2-5350-8136-d974d858433b","text":"The pie chart shows what consumers consider when choosing restaurants in a city."},{"id":"26c4d76f-af74-5b57-a1a5-75870af42b51","text":"Distinctive features rank first at 36.3%, followed by service at 26.8% and the dining environment at 23.8%."},{"id":"4f6c3c70-09c7-55d6-9b92-366d949ed35f","text":"Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%."},{"id":"bd785fcc-1d78-54db-a4dd-5acfbbdc93b5","text":"Experience clearly carries considerable weight in these choices."}]},{"id":"24f30235-2971-58f0-a1bc-afbbe9ee473e","sentences":[{"id":"6a6f18d4-0d51-527b-8708-bf5881df5510","text":"Dining out serves purposes beyond satisfying hunger."},{"id":"47f69845-3efd-503e-8a68-bc20623c7cc6","text":"A distinctive menu can make a meal memorable, attentive service makes guests feel valued, and a comfortable setting allows conversation to flow."},{"id":"f95df850-ab19-5c21-9cfa-51ff892a6f23","text":"These benefits matter particularly when people eat together to celebrate or maintain relationships."},{"id":"c2a36081-f581-59f6-b31d-b382e3903059","text":"A lower price may offer savings, but it cannot by itself provide the experience customers seek."}]},{"id":"8b293621-0ef0-5b6f-9e21-a9f19153699a","sentences":[{"id":"ff1eaf9c-feee-530f-b670-cc3eb3801ead","text":"Restaurant owners should therefore build a recognizable identity without neglecting everyday standards."},{"id":"4b11d828-e352-5c3d-9f20-d56dc9e2b686","text":"Creative dishes will attract attention only briefly if food quality or service disappoints."},{"id":"b6626d4e-bace-579b-bac1-ffce17cb822f","text":"Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone."},{"id":"6717b551-452d-5e10-8cd4-8dfb308c4140","text":"The aim should be to give customers a reason to return, rather than merely a reason to enter."}]}],"sentences":[{"id":"411fe138-46b2-5350-8136-d974d858433b","text":"The pie chart shows what consumers consider when choosing restaurants in a city."},{"id":"26c4d76f-af74-5b57-a1a5-75870af42b51","text":"Distinctive features rank first at 36.3%, followed by service at 26.8% and the dining environment at 23.8%."},{"id":"4f6c3c70-09c7-55d6-9b92-366d949ed35f","text":"Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%."},{"id":"bd785fcc-1d78-54db-a4dd-5acfbbdc93b5","text":"Experience clearly carries considerable weight in these choices."},{"id":"6a6f18d4-0d51-527b-8708-bf5881df5510","text":"Dining out serves purposes beyond satisfying hunger."},{"id":"47f69845-3efd-503e-8a68-bc20623c7cc6","text":"A distinctive menu can make a meal memorable, attentive service makes guests feel valued, and a comfortable setting allows conversation to flow."},{"id":"f95df850-ab19-5c21-9cfa-51ff892a6f23","text":"These benefits matter particularly when people eat together to celebrate or maintain relationships."},{"id":"c2a36081-f581-59f6-b31d-b382e3903059","text":"A lower price may offer savings, but it cannot by itself provide the experience customers seek."},{"id":"ff1eaf9c-feee-530f-b670-cc3eb3801ead","text":"Restaurant owners should therefore build a recognizable identity without neglecting everyday standards."},{"id":"4b11d828-e352-5c3d-9f20-d56dc9e2b686","text":"Creative dishes will attract attention only briefly if food quality or service disappoints."},{"id":"b6626d4e-bace-579b-bac1-ffce17cb822f","text":"Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone."},{"id":"6717b551-452d-5e10-8cd4-8dfb308c4140","text":"The aim should be to give customers a reason to return, rather than merely a reason to enter."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    25,
    true
  ),
(
    '66f90b54-0052-5da4-99ef-906093c5379e'::uuid,
    (select id from collection),
    '2019年英语二·本科毕业生去向变化',
    'The chart compares graduate destinations at a university in 2013 and 2018. Employment remained the largest category, although its share fell from 68.1% to 60.7%. Further study rose from 26.3% to 34%, while entrepreneurship doubled from a low base of 1.3% to 2.6%, though it still represented a limited share.

The shift towards further study may reflect a desire for stronger qualifications and more specialized knowledge. Faced with demanding recruitment standards, graduates may regard additional education as an investment in future opportunities. Others may prefer to test a business idea, accepting uncertainty in exchange for greater independence. Together, these changes suggest that the transition from university to work is becoming less uniform.

Universities should respond with guidance that recognizes different ambitions. Students need realistic information about employment, postgraduate study and business risks, alongside opportunities to assess their own strengths. No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development.',
    '{"id":"66f90b54-0052-5da4-99ef-906093c5379e","title":"2019年英语二·本科毕业生去向变化","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart compares graduate destinations at a university in 2013 and 2018. Employment remained the largest category, although its share fell from 68.1% to 60.7%. Further study rose from 26.3% to 34%, while entrepreneurship doubled from a low base of 1.3% to 2.6%, though it still represented a limited share.\n\nThe shift towards further study may reflect a desire for stronger qualifications and more specialized knowledge. Faced with demanding recruitment standards, graduates may regard additional education as an investment in future opportunities. Others may prefer to test a business idea, accepting uncertainty in exchange for greater independence. Together, these changes suggest that the transition from university to work is becoming less uniform.\n\nUniversities should respond with guidance that recognizes different ambitions. Students need realistic information about employment, postgraduate study and business risks, alongside opportunities to assess their own strengths. No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development.","paragraphs":[{"id":"7ed2f167-1e1c-5c54-98f2-8a5dc840ab1a","sentences":[{"id":"33432a1b-9e00-5181-9e13-bc33c706fb9e","text":"The chart compares graduate destinations at a university in 2013 and 2018."},{"id":"027dfd2f-7359-5e60-8334-02836400e831","text":"Employment remained the largest category, although its share fell from 68.1% to 60.7%."},{"id":"133fecee-5492-559c-a75f-d7387f739f7f","text":"Further study rose from 26.3% to 34%, while entrepreneurship doubled from a low base of 1.3% to 2.6%, though it still represented a limited share."}]},{"id":"3db6955b-5f8f-52d9-8e73-177c449c3cf5","sentences":[{"id":"29a7a7db-2ac5-52f8-b973-406707cc2d96","text":"The shift towards further study may reflect a desire for stronger qualifications and more specialized knowledge."},{"id":"2a689051-cc6d-527b-bea6-a7476af61672","text":"Faced with demanding recruitment standards, graduates may regard additional education as an investment in future opportunities."},{"id":"63e8c36b-594e-5299-94e2-8dcd505a50d6","text":"Others may prefer to test a business idea, accepting uncertainty in exchange for greater independence."},{"id":"5837643f-04f8-58ef-914d-a9c27ae30b20","text":"Together, these changes suggest that the transition from university to work is becoming less uniform."}]},{"id":"a941705a-7245-5ff3-a8d5-79f49588dd3d","sentences":[{"id":"4b5c2cb7-a000-5ee6-be96-cf94218b3c84","text":"Universities should respond with guidance that recognizes different ambitions."},{"id":"43446e14-d630-5caa-9096-7c807af6ab05","text":"Students need realistic information about employment, postgraduate study and business risks, alongside opportunities to assess their own strengths."},{"id":"4dd7c151-3ca0-5006-84e0-d0e7fba484a3","text":"No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development."}]}],"sentences":[{"id":"33432a1b-9e00-5181-9e13-bc33c706fb9e","text":"The chart compares graduate destinations at a university in 2013 and 2018."},{"id":"027dfd2f-7359-5e60-8334-02836400e831","text":"Employment remained the largest category, although its share fell from 68.1% to 60.7%."},{"id":"133fecee-5492-559c-a75f-d7387f739f7f","text":"Further study rose from 26.3% to 34%, while entrepreneurship doubled from a low base of 1.3% to 2.6%, though it still represented a limited share."},{"id":"29a7a7db-2ac5-52f8-b973-406707cc2d96","text":"The shift towards further study may reflect a desire for stronger qualifications and more specialized knowledge."},{"id":"2a689051-cc6d-527b-bea6-a7476af61672","text":"Faced with demanding recruitment standards, graduates may regard additional education as an investment in future opportunities."},{"id":"63e8c36b-594e-5299-94e2-8dcd505a50d6","text":"Others may prefer to test a business idea, accepting uncertainty in exchange for greater independence."},{"id":"5837643f-04f8-58ef-914d-a9c27ae30b20","text":"Together, these changes suggest that the transition from university to work is becoming less uniform."},{"id":"4b5c2cb7-a000-5ee6-be96-cf94218b3c84","text":"Universities should respond with guidance that recognizes different ambitions."},{"id":"43446e14-d630-5caa-9096-7c807af6ab05","text":"Students need realistic information about employment, postgraduate study and business risks, alongside opportunities to assess their own strengths."},{"id":"4dd7c151-3ca0-5006-84e0-d0e7fba484a3","text":"No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    26,
    true
  ),
(
    'ce0a9be4-c62e-5f9b-be48-6f49f4196e6a'::uuid,
    (select id from collection),
    '2020年英语二·手机阅读目的',
    'The pie chart presents the purposes of mobile reading among students at a university. Learning accounts for 59.5%, well ahead of passing the time at 21.3% and obtaining information at 17%. Other purposes make up 2.2%. The dominant share of learning highlights the phone’s potential as a study tool.

Its appeal lies partly in removing barriers of time and place. A student can consult an article between classes or carry an entire library without carrying a bag of books. Understanding, however, does not arise merely because a text is accessible; it requires sustained attention. The same device that opens a useful text also delivers messages and distractions, making concentration an essential part of effective mobile learning.

The challenge is therefore to turn convenience into sustained attention. Students can select reliable materials, silence unnecessary notifications and reserve time for reading beyond brief fragments. Mobile reading is most productive when accessibility serves a clear purpose: not simply to consume more words, but to understand, question and retain what is read.',
    '{"id":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","title":"2020年英语二·手机阅读目的","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The pie chart presents the purposes of mobile reading among students at a university. Learning accounts for 59.5%, well ahead of passing the time at 21.3% and obtaining information at 17%. Other purposes make up 2.2%. The dominant share of learning highlights the phone’s potential as a study tool.\n\nIts appeal lies partly in removing barriers of time and place. A student can consult an article between classes or carry an entire library without carrying a bag of books. Understanding, however, does not arise merely because a text is accessible; it requires sustained attention. The same device that opens a useful text also delivers messages and distractions, making concentration an essential part of effective mobile learning.\n\nThe challenge is therefore to turn convenience into sustained attention. Students can select reliable materials, silence unnecessary notifications and reserve time for reading beyond brief fragments. Mobile reading is most productive when accessibility serves a clear purpose: not simply to consume more words, but to understand, question and retain what is read.","paragraphs":[{"id":"3bb9a5bd-f1b0-56b0-b4d1-80fd39b8fa33","sentences":[{"id":"7e1a4e33-226b-5dd1-959e-44758f37eeb3","text":"The pie chart presents the purposes of mobile reading among students at a university."},{"id":"6592d80c-419c-5523-a0d5-3172adb0ceb9","text":"Learning accounts for 59.5%, well ahead of passing the time at 21.3% and obtaining information at 17%."},{"id":"a397ad23-92a3-52e4-9c3b-03aa8cd194da","text":"Other purposes make up 2.2%."},{"id":"d82eb59a-fe39-5178-8b83-adda854946a3","text":"The dominant share of learning highlights the phone’s potential as a study tool."}]},{"id":"aa477069-01e5-5561-b239-04e7ec1b4e0e","sentences":[{"id":"8a8d95b8-9bd3-5ed2-971f-4342627c6eca","text":"Its appeal lies partly in removing barriers of time and place."},{"id":"e6f8b3cb-e835-5766-a402-42d1f4554103","text":"A student can consult an article between classes or carry an entire library without carrying a bag of books."},{"id":"a6281f8e-e2e6-5982-b823-fce6a32b7cc3","text":"Understanding, however, does not arise merely because a text is accessible; it requires sustained attention."},{"id":"afe0cadd-f286-5b3e-af65-34fc236e69b9","text":"The same device that opens a useful text also delivers messages and distractions, making concentration an essential part of effective mobile learning."}]},{"id":"2902d9b8-8d11-57d2-8ef8-69495d966951","sentences":[{"id":"ff0566af-39a9-500d-9b76-fca6827b8fba","text":"The challenge is therefore to turn convenience into sustained attention."},{"id":"d06722e7-8fab-51ec-b24d-9221234f7ee1","text":"Students can select reliable materials, silence unnecessary notifications and reserve time for reading beyond brief fragments."},{"id":"bf11446b-8f8a-514b-8e7b-153b2af27d2f","text":"Mobile reading is most productive when accessibility serves a clear purpose: not simply to consume more words, but to understand, question and retain what is read."}]}],"sentences":[{"id":"7e1a4e33-226b-5dd1-959e-44758f37eeb3","text":"The pie chart presents the purposes of mobile reading among students at a university."},{"id":"6592d80c-419c-5523-a0d5-3172adb0ceb9","text":"Learning accounts for 59.5%, well ahead of passing the time at 21.3% and obtaining information at 17%."},{"id":"a397ad23-92a3-52e4-9c3b-03aa8cd194da","text":"Other purposes make up 2.2%."},{"id":"d82eb59a-fe39-5178-8b83-adda854946a3","text":"The dominant share of learning highlights the phone’s potential as a study tool."},{"id":"8a8d95b8-9bd3-5ed2-971f-4342627c6eca","text":"Its appeal lies partly in removing barriers of time and place."},{"id":"e6f8b3cb-e835-5766-a402-42d1f4554103","text":"A student can consult an article between classes or carry an entire library without carrying a bag of books."},{"id":"a6281f8e-e2e6-5982-b823-fce6a32b7cc3","text":"Understanding, however, does not arise merely because a text is accessible; it requires sustained attention."},{"id":"afe0cadd-f286-5b3e-af65-34fc236e69b9","text":"The same device that opens a useful text also delivers messages and distractions, making concentration an essential part of effective mobile learning."},{"id":"ff0566af-39a9-500d-9b76-fca6827b8fba","text":"The challenge is therefore to turn convenience into sustained attention."},{"id":"d06722e7-8fab-51ec-b24d-9221234f7ee1","text":"Students can select reliable materials, silence unnecessary notifications and reserve time for reading beyond brief fragments."},{"id":"bf11446b-8f8a-514b-8e7b-153b2af27d2f","text":"Mobile reading is most productive when accessibility serves a clear purpose: not simply to consume more words, but to understand, question and retain what is read."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    27,
    true
  ),
(
    'b7cc1bd8-928e-5321-ac11-3d25676d27d8'::uuid,
    (select id from collection),
    '2021年英语二·体育锻炼方式',
    'The chart shows how residents of a city exercise. Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends. Family exercise attracts 23.9%, while organized group activities account for 15.8%. Individual exercise and informal companionship are therefore more common than organized participation.

Convenience helps explain the pattern. Exercising alone allows people to choose their own schedule and pace, avoiding the difficulty of coordinating busy lives. Friends, meanwhile, can provide encouragement without requiring the structure of a formal programme. Their company may turn exercise from a duty into an enjoyable social occasion. Organized activities can be useful, but fixed times and locations may make them harder to fit into daily routines.

The practical lesson is to make regular exercise easy to sustain. Communities should provide accessible spaces for individuals as well as flexible opportunities for people to exercise together. Residents can then choose arrangements that suit their circumstances. A routine that people enjoy and maintain matters more than whether they follow it alone or in company.',
    '{"id":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","title":"2021年英语二·体育锻炼方式","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows how residents of a city exercise. Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends. Family exercise attracts 23.9%, while organized group activities account for 15.8%. Individual exercise and informal companionship are therefore more common than organized participation.\n\nConvenience helps explain the pattern. Exercising alone allows people to choose their own schedule and pace, avoiding the difficulty of coordinating busy lives. Friends, meanwhile, can provide encouragement without requiring the structure of a formal programme. Their company may turn exercise from a duty into an enjoyable social occasion. Organized activities can be useful, but fixed times and locations may make them harder to fit into daily routines.\n\nThe practical lesson is to make regular exercise easy to sustain. Communities should provide accessible spaces for individuals as well as flexible opportunities for people to exercise together. Residents can then choose arrangements that suit their circumstances. A routine that people enjoy and maintain matters more than whether they follow it alone or in company.","paragraphs":[{"id":"44cfcb4d-14c3-521c-a8d5-2bf0b720dbfc","sentences":[{"id":"f382786e-6778-5e91-bca5-889d8b6ef9d0","text":"The chart shows how residents of a city exercise."},{"id":"b7eb690a-c457-52b9-af53-5cf5c316ac84","text":"Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends."},{"id":"bd81785e-e8fc-5a8e-bb98-f351837724df","text":"Family exercise attracts 23.9%, while organized group activities account for 15.8%."},{"id":"167a3e8d-1664-5288-8685-c78bbc1d5c0d","text":"Individual exercise and informal companionship are therefore more common than organized participation."}]},{"id":"9b87f173-2d27-5dd7-9530-08ce58219254","sentences":[{"id":"1a39efd0-bd8b-53a6-9373-1a4eca0d4538","text":"Convenience helps explain the pattern."},{"id":"5739c902-3cd7-5f17-a3db-fb8505ac4c90","text":"Exercising alone allows people to choose their own schedule and pace, avoiding the difficulty of coordinating busy lives."},{"id":"5c246b7f-f491-534c-9a05-523de038bf14","text":"Friends, meanwhile, can provide encouragement without requiring the structure of a formal programme."},{"id":"50be4acb-f111-5cb9-aa5f-3096e3aeaf75","text":"Their company may turn exercise from a duty into an enjoyable social occasion."},{"id":"5333f4b5-8ba9-51f5-b636-779248e920b2","text":"Organized activities can be useful, but fixed times and locations may make them harder to fit into daily routines."}]},{"id":"bb81a9f0-5a6a-51c6-891c-91d9919d921d","sentences":[{"id":"191be40e-8728-5e06-9a6f-c72183dac016","text":"The practical lesson is to make regular exercise easy to sustain."},{"id":"4f99e6a1-2483-5c82-a6c4-e27d7b3e0ce1","text":"Communities should provide accessible spaces for individuals as well as flexible opportunities for people to exercise together."},{"id":"4e25faa2-f977-5477-9fdf-5552cf039abd","text":"Residents can then choose arrangements that suit their circumstances."},{"id":"69d858ba-dd37-53de-84bd-6471678a0fbb","text":"A routine that people enjoy and maintain matters more than whether they follow it alone or in company."}]}],"sentences":[{"id":"f382786e-6778-5e91-bca5-889d8b6ef9d0","text":"The chart shows how residents of a city exercise."},{"id":"b7eb690a-c457-52b9-af53-5cf5c316ac84","text":"Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends."},{"id":"bd81785e-e8fc-5a8e-bb98-f351837724df","text":"Family exercise attracts 23.9%, while organized group activities account for 15.8%."},{"id":"167a3e8d-1664-5288-8685-c78bbc1d5c0d","text":"Individual exercise and informal companionship are therefore more common than organized participation."},{"id":"1a39efd0-bd8b-53a6-9373-1a4eca0d4538","text":"Convenience helps explain the pattern."},{"id":"5739c902-3cd7-5f17-a3db-fb8505ac4c90","text":"Exercising alone allows people to choose their own schedule and pace, avoiding the difficulty of coordinating busy lives."},{"id":"5c246b7f-f491-534c-9a05-523de038bf14","text":"Friends, meanwhile, can provide encouragement without requiring the structure of a formal programme."},{"id":"50be4acb-f111-5cb9-aa5f-3096e3aeaf75","text":"Their company may turn exercise from a duty into an enjoyable social occasion."},{"id":"5333f4b5-8ba9-51f5-b636-779248e920b2","text":"Organized activities can be useful, but fixed times and locations may make them harder to fit into daily routines."},{"id":"191be40e-8728-5e06-9a6f-c72183dac016","text":"The practical lesson is to make regular exercise easy to sustain."},{"id":"4f99e6a1-2483-5c82-a6c4-e27d7b3e0ce1","text":"Communities should provide accessible spaces for individuals as well as flexible opportunities for people to exercise together."},{"id":"4e25faa2-f977-5477-9fdf-5552cf039abd","text":"Residents can then choose arrangements that suit their circumstances."},{"id":"69d858ba-dd37-53de-84bd-6471678a0fbb","text":"A routine that people enjoy and maintain matters more than whether they follow it alone or in company."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    28,
    true
  ),
(
    '2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87'::uuid,
    (select id from collection),
    '2022年英语二·全国与农村快递业务量',
    'The chart shows substantial growth in China’s express delivery volume between 2018 and 2020. National deliveries rose from 51 billion to 83 billion parcels, while rural deliveries increased from 12 billion to 30 billion. Particularly striking is the doubling of rural volume from 2019 to 2020.

This expansion reflects the close relationship between online commerce and physical distribution. Ordering goods is convenient only when they can reach buyers reliably. Improved roads, local collection points and delivery networks can bring rural households into larger markets. The benefits also run in the opposite direction: rural producers can sell beyond their immediate surroundings, creating further demand for delivery services.

The figures thus point to stronger connections between rural and urban economies. To sustain these benefits, the sector should improve efficiency while reducing damaged parcels, excessive packaging and pressure on delivery workers. Growth is most meaningful when it makes trade more accessible without shifting unreasonable costs onto people or the environment. Better connections should bring better service, not volume alone.',
    '{"id":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","title":"2022年英语二·全国与农村快递业务量","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows substantial growth in China’s express delivery volume between 2018 and 2020. National deliveries rose from 51 billion to 83 billion parcels, while rural deliveries increased from 12 billion to 30 billion. Particularly striking is the doubling of rural volume from 2019 to 2020.\n\nThis expansion reflects the close relationship between online commerce and physical distribution. Ordering goods is convenient only when they can reach buyers reliably. Improved roads, local collection points and delivery networks can bring rural households into larger markets. The benefits also run in the opposite direction: rural producers can sell beyond their immediate surroundings, creating further demand for delivery services.\n\nThe figures thus point to stronger connections between rural and urban economies. To sustain these benefits, the sector should improve efficiency while reducing damaged parcels, excessive packaging and pressure on delivery workers. Growth is most meaningful when it makes trade more accessible without shifting unreasonable costs onto people or the environment. Better connections should bring better service, not volume alone.","paragraphs":[{"id":"da978b11-0304-5882-a5cd-3ddf7b30f9a4","sentences":[{"id":"d81a96f5-b106-576a-a056-2d228ddd2fb8","text":"The chart shows substantial growth in China’s express delivery volume between 2018 and 2020."},{"id":"e551cc5b-e8c9-5827-95d7-a6cf47d95178","text":"National deliveries rose from 51 billion to 83 billion parcels, while rural deliveries increased from 12 billion to 30 billion."},{"id":"c592f60c-d609-5f1d-9f4c-9db669835746","text":"Particularly striking is the doubling of rural volume from 2019 to 2020."}]},{"id":"b8b89976-ff91-5e45-9556-2d7f0f029a2e","sentences":[{"id":"880fe9e6-e6ae-50be-8136-72c2db3efd98","text":"This expansion reflects the close relationship between online commerce and physical distribution."},{"id":"939d65a6-3256-5c7b-92c5-1d7696c5e071","text":"Ordering goods is convenient only when they can reach buyers reliably."},{"id":"f7836f10-d25e-520c-8e49-ff3f99299926","text":"Improved roads, local collection points and delivery networks can bring rural households into larger markets."},{"id":"61715457-0d31-5f04-bcd5-8dee563d1952","text":"The benefits also run in the opposite direction: rural producers can sell beyond their immediate surroundings, creating further demand for delivery services."}]},{"id":"d27a85bd-1247-5ec1-af57-d9084f7baf4c","sentences":[{"id":"41b21682-289c-54b7-86a4-8d852d620d78","text":"The figures thus point to stronger connections between rural and urban economies."},{"id":"9a91be8c-77f9-5213-bdc6-dc15a3a5b690","text":"To sustain these benefits, the sector should improve efficiency while reducing damaged parcels, excessive packaging and pressure on delivery workers."},{"id":"e907d67a-71ce-57c5-8e2c-c76c7cd86ef6","text":"Growth is most meaningful when it makes trade more accessible without shifting unreasonable costs onto people or the environment."},{"id":"7f6f9d30-5461-5aaa-b367-d56939fb3e24","text":"Better connections should bring better service, not volume alone."}]}],"sentences":[{"id":"d81a96f5-b106-576a-a056-2d228ddd2fb8","text":"The chart shows substantial growth in China’s express delivery volume between 2018 and 2020."},{"id":"e551cc5b-e8c9-5827-95d7-a6cf47d95178","text":"National deliveries rose from 51 billion to 83 billion parcels, while rural deliveries increased from 12 billion to 30 billion."},{"id":"c592f60c-d609-5f1d-9f4c-9db669835746","text":"Particularly striking is the doubling of rural volume from 2019 to 2020."},{"id":"880fe9e6-e6ae-50be-8136-72c2db3efd98","text":"This expansion reflects the close relationship between online commerce and physical distribution."},{"id":"939d65a6-3256-5c7b-92c5-1d7696c5e071","text":"Ordering goods is convenient only when they can reach buyers reliably."},{"id":"f7836f10-d25e-520c-8e49-ff3f99299926","text":"Improved roads, local collection points and delivery networks can bring rural households into larger markets."},{"id":"61715457-0d31-5f04-bcd5-8dee563d1952","text":"The benefits also run in the opposite direction: rural producers can sell beyond their immediate surroundings, creating further demand for delivery services."},{"id":"41b21682-289c-54b7-86a4-8d852d620d78","text":"The figures thus point to stronger connections between rural and urban economies."},{"id":"9a91be8c-77f9-5213-bdc6-dc15a3a5b690","text":"To sustain these benefits, the sector should improve efficiency while reducing damaged parcels, excessive packaging and pressure on delivery workers."},{"id":"e907d67a-71ce-57c5-8e2c-c76c7cd86ef6","text":"Growth is most meaningful when it makes trade more accessible without shifting unreasonable costs onto people or the environment."},{"id":"7f6f9d30-5461-5aaa-b367-d56939fb3e24","text":"Better connections should bring better service, not volume alone."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    29,
    true
  ),
(
    'bd3d8a78-f92a-5d4b-b5b9-d13de05abc92'::uuid,
    (select id from collection),
    '2023年英语二·居民健康素养水平变化',
    'The line chart records a sustained improvement in health literacy among Chinese residents from 2012 to 2021. The proportion rose from 8.80% to 25.40%, with growth becoming more pronounced in later years. This rise points to a growing capacity to obtain, understand and use basic health information in everyday decisions.

Greater access to health education may help explain this progress. Community guidance, clearer medical explanations and widely available information can bring practical knowledge into everyday life. Yet knowledge becomes useful only when people can judge its reliability and apply it. Understanding why a habit matters, for example, is more likely to support informed choices than merely remembering a slogan.

Despite a gain of 16.6 percentage points, the 2021 figure still leaves considerable room for progress. Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims. The ultimate goal is not simply more information, but the ability to make sensible decisions when health questions arise in daily life.',
    '{"id":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","title":"2023年英语二·居民健康素养水平变化","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The line chart records a sustained improvement in health literacy among Chinese residents from 2012 to 2021. The proportion rose from 8.80% to 25.40%, with growth becoming more pronounced in later years. This rise points to a growing capacity to obtain, understand and use basic health information in everyday decisions.\n\nGreater access to health education may help explain this progress. Community guidance, clearer medical explanations and widely available information can bring practical knowledge into everyday life. Yet knowledge becomes useful only when people can judge its reliability and apply it. Understanding why a habit matters, for example, is more likely to support informed choices than merely remembering a slogan.\n\nDespite a gain of 16.6 percentage points, the 2021 figure still leaves considerable room for progress. Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims. The ultimate goal is not simply more information, but the ability to make sensible decisions when health questions arise in daily life.","paragraphs":[{"id":"394f2bf6-df0e-58c2-b852-756a66c7cec4","sentences":[{"id":"dcf88a02-2f01-5a35-849d-7c1e208e159f","text":"The line chart records a sustained improvement in health literacy among Chinese residents from 2012 to 2021."},{"id":"0eb93957-f0eb-5e32-a340-91f78ab91b9a","text":"The proportion rose from 8.80% to 25.40%, with growth becoming more pronounced in later years."},{"id":"4b9dd9a2-cfa5-5717-8863-c595843bdb20","text":"This rise points to a growing capacity to obtain, understand and use basic health information in everyday decisions."}]},{"id":"30442197-b014-52c1-8967-72ecd59c9987","sentences":[{"id":"327cf984-48d1-5062-a565-539e70f414ff","text":"Greater access to health education may help explain this progress."},{"id":"b82f3f71-2a75-5488-b852-7eee2591c578","text":"Community guidance, clearer medical explanations and widely available information can bring practical knowledge into everyday life."},{"id":"ecbe8de2-944e-51e9-8ff9-df515514cf16","text":"Yet knowledge becomes useful only when people can judge its reliability and apply it."},{"id":"747268dc-f401-581a-839d-b7fae785fd6a","text":"Understanding why a habit matters, for example, is more likely to support informed choices than merely remembering a slogan."}]},{"id":"4ce38a21-5046-5572-981f-330df5af5e13","sentences":[{"id":"f9e0d64f-2b6f-55e0-9b6c-e3dc50a0aa3e","text":"Despite a gain of 16.6 percentage points, the 2021 figure still leaves considerable room for progress."},{"id":"c82bc04f-9d07-5163-a7f8-72ecc53e84bf","text":"Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims."},{"id":"43136319-525c-5854-9958-b58ab3071511","text":"The ultimate goal is not simply more information, but the ability to make sensible decisions when health questions arise in daily life."}]}],"sentences":[{"id":"dcf88a02-2f01-5a35-849d-7c1e208e159f","text":"The line chart records a sustained improvement in health literacy among Chinese residents from 2012 to 2021."},{"id":"0eb93957-f0eb-5e32-a340-91f78ab91b9a","text":"The proportion rose from 8.80% to 25.40%, with growth becoming more pronounced in later years."},{"id":"4b9dd9a2-cfa5-5717-8863-c595843bdb20","text":"This rise points to a growing capacity to obtain, understand and use basic health information in everyday decisions."},{"id":"327cf984-48d1-5062-a565-539e70f414ff","text":"Greater access to health education may help explain this progress."},{"id":"b82f3f71-2a75-5488-b852-7eee2591c578","text":"Community guidance, clearer medical explanations and widely available information can bring practical knowledge into everyday life."},{"id":"ecbe8de2-944e-51e9-8ff9-df515514cf16","text":"Yet knowledge becomes useful only when people can judge its reliability and apply it."},{"id":"747268dc-f401-581a-839d-b7fae785fd6a","text":"Understanding why a habit matters, for example, is more likely to support informed choices than merely remembering a slogan."},{"id":"f9e0d64f-2b6f-55e0-9b6c-e3dc50a0aa3e","text":"Despite a gain of 16.6 percentage points, the 2021 figure still leaves considerable room for progress."},{"id":"c82bc04f-9d07-5163-a7f8-72ecc53e84bf","text":"Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims."},{"id":"43136319-525c-5854-9958-b58ab3071511","text":"The ultimate goal is not simply more information, but the ability to make sensible decisions when health questions arise in daily life."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    30,
    true
  ),
(
    '16e5cd87-3f31-5b5b-ab90-e280bc91c923'::uuid,
    (select id from collection),
    '2024年英语二·劳动实践课收获',
    'The chart summarizes students’ gains from a university course combining learning with practical work. Acquiring knowledge leads at 91.3%, closely followed by improved practical skills at 84.8%. A better mood is reported by 54.4%, whereas improved teamwork skills are mentioned by 32.6%. The strongest benefits concern learning through direct participation.

Practical work makes ideas testable. When students plant, repair or produce something, practical work can help them connect instructions with actions and respond to results. Completing a useful task can also bring satisfaction that passive learning rarely offers. Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another.

Course design should therefore preserve practical engagement while strengthening opportunities for teamwork. Projects can assign complementary responsibilities and ask students to reflect on both their results and their collaboration. In this way, labour education can develop not only the ability to complete a task, but also the judgement and cooperation needed to complete it well with others.',
    '{"id":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","title":"2024年英语二·劳动实践课收获","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart summarizes students’ gains from a university course combining learning with practical work. Acquiring knowledge leads at 91.3%, closely followed by improved practical skills at 84.8%. A better mood is reported by 54.4%, whereas improved teamwork skills are mentioned by 32.6%. The strongest benefits concern learning through direct participation.\n\nPractical work makes ideas testable. When students plant, repair or produce something, practical work can help them connect instructions with actions and respond to results. Completing a useful task can also bring satisfaction that passive learning rarely offers. Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another.\n\nCourse design should therefore preserve practical engagement while strengthening opportunities for teamwork. Projects can assign complementary responsibilities and ask students to reflect on both their results and their collaboration. In this way, labour education can develop not only the ability to complete a task, but also the judgement and cooperation needed to complete it well with others.","paragraphs":[{"id":"1c710aaa-2e82-57aa-9d2e-6f54649fc6be","sentences":[{"id":"a80a82e4-794a-5699-81a4-f064c3d4b6a9","text":"The chart summarizes students’ gains from a university course combining learning with practical work."},{"id":"e7adcb25-5376-54f1-a9a2-4fc3ae6ccee8","text":"Acquiring knowledge leads at 91.3%, closely followed by improved practical skills at 84.8%."},{"id":"38026745-1795-5db3-a594-ebae1b46b0a1","text":"A better mood is reported by 54.4%, whereas improved teamwork skills are mentioned by 32.6%."},{"id":"eb78f86f-f70d-57c4-bc8d-0c251d46ecaa","text":"The strongest benefits concern learning through direct participation."}]},{"id":"76062b00-dfd0-5a4d-90aa-088abb771949","sentences":[{"id":"cff1b2e3-9421-5c52-ad65-34981a41d515","text":"Practical work makes ideas testable."},{"id":"9febea0d-9a4b-5750-a52a-f1ee9ce90421","text":"When students plant, repair or produce something, practical work can help them connect instructions with actions and respond to results."},{"id":"67901576-aeea-5b4d-91bb-8a8350727afd","text":"Completing a useful task can also bring satisfaction that passive learning rarely offers."},{"id":"9fd67ccb-1fc2-5202-bb4f-1ddf4e59fcf4","text":"Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another."}]},{"id":"3669b8a6-7e61-528f-8a22-8ef74bb426f5","sentences":[{"id":"17fcd157-f344-5a9c-b0ac-1ee2c7f83871","text":"Course design should therefore preserve practical engagement while strengthening opportunities for teamwork."},{"id":"f86f25e4-c9f3-5f42-85a2-c269622c254d","text":"Projects can assign complementary responsibilities and ask students to reflect on both their results and their collaboration."},{"id":"73204934-b731-5313-b17b-a9df48809069","text":"In this way, labour education can develop not only the ability to complete a task, but also the judgement and cooperation needed to complete it well with others."}]}],"sentences":[{"id":"a80a82e4-794a-5699-81a4-f064c3d4b6a9","text":"The chart summarizes students’ gains from a university course combining learning with practical work."},{"id":"e7adcb25-5376-54f1-a9a2-4fc3ae6ccee8","text":"Acquiring knowledge leads at 91.3%, closely followed by improved practical skills at 84.8%."},{"id":"38026745-1795-5db3-a594-ebae1b46b0a1","text":"A better mood is reported by 54.4%, whereas improved teamwork skills are mentioned by 32.6%."},{"id":"eb78f86f-f70d-57c4-bc8d-0c251d46ecaa","text":"The strongest benefits concern learning through direct participation."},{"id":"cff1b2e3-9421-5c52-ad65-34981a41d515","text":"Practical work makes ideas testable."},{"id":"9febea0d-9a4b-5750-a52a-f1ee9ce90421","text":"When students plant, repair or produce something, practical work can help them connect instructions with actions and respond to results."},{"id":"67901576-aeea-5b4d-91bb-8a8350727afd","text":"Completing a useful task can also bring satisfaction that passive learning rarely offers."},{"id":"9fd67ccb-1fc2-5202-bb4f-1ddf4e59fcf4","text":"Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another."},{"id":"17fcd157-f344-5a9c-b0ac-1ee2c7f83871","text":"Course design should therefore preserve practical engagement while strengthening opportunities for teamwork."},{"id":"f86f25e4-c9f3-5f42-85a2-c269622c254d","text":"Projects can assign complementary responsibilities and ask students to reflect on both their results and their collaboration."},{"id":"73204934-b731-5313-b17b-a9df48809069","text":"In this way, labour education can develop not only the ability to complete a task, but also the judgement and cooperation needed to complete it well with others."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    31,
    true
  ),
(
    'a1e4dd9d-5b4c-5923-879c-2e8e5830258d'::uuid,
    (select id from collection),
    '2025年英语二·老年人日常休闲活动',
    'The chart shows elderly residents’ daily leisure activities in a community. Television is most common at 90.8%, followed by walking at 68.3%. Gardening, reading and chess attract 34.7%, 31.8% and 18.4% respectively. Easily accessible activities clearly occupy a prominent place in residents’ routines.

Television offers information and entertainment with little physical effort, while walks provide gentle exercise and opportunities to meet neighbours. Other activities may depend more on personal interests, space or companions. Their lower participation rates need not reduce their value: reading can stimulate thought, and a game of chess can provide both mental challenge and social contact. The pattern therefore calls for variety rather than a single prescription for retirement.

Communities can help by maintaining safe paths, providing comfortable reading spaces and making it easy to find activity partners. These modest arrangements expand choice without imposing a preferred lifestyle. A satisfying later life depends not on everyone doing the same things, but on having meaningful activities suited to individual interests and abilities.',
    '{"id":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","title":"2025年英语二·老年人日常休闲活动","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows elderly residents’ daily leisure activities in a community. Television is most common at 90.8%, followed by walking at 68.3%. Gardening, reading and chess attract 34.7%, 31.8% and 18.4% respectively. Easily accessible activities clearly occupy a prominent place in residents’ routines.\n\nTelevision offers information and entertainment with little physical effort, while walks provide gentle exercise and opportunities to meet neighbours. Other activities may depend more on personal interests, space or companions. Their lower participation rates need not reduce their value: reading can stimulate thought, and a game of chess can provide both mental challenge and social contact. The pattern therefore calls for variety rather than a single prescription for retirement.\n\nCommunities can help by maintaining safe paths, providing comfortable reading spaces and making it easy to find activity partners. These modest arrangements expand choice without imposing a preferred lifestyle. A satisfying later life depends not on everyone doing the same things, but on having meaningful activities suited to individual interests and abilities.","paragraphs":[{"id":"ead679b3-6fb9-5690-9bbc-0180c72dcb9d","sentences":[{"id":"c7f00968-5c1c-5a45-91e5-bfd8668c7221","text":"The chart shows elderly residents’ daily leisure activities in a community."},{"id":"2afd8885-0d8f-53da-be0b-bc240d5b6280","text":"Television is most common at 90.8%, followed by walking at 68.3%."},{"id":"b5be4612-722d-58e3-af06-747b7b350145","text":"Gardening, reading and chess attract 34.7%, 31.8% and 18.4% respectively."},{"id":"d473e937-f68a-5785-8468-68813faaea08","text":"Easily accessible activities clearly occupy a prominent place in residents’ routines."}]},{"id":"ac3a264d-43bd-51a0-a400-64f19bd7b0a6","sentences":[{"id":"a9811d84-121c-5851-9987-d888d763527b","text":"Television offers information and entertainment with little physical effort, while walks provide gentle exercise and opportunities to meet neighbours."},{"id":"80821fe5-5911-5058-9573-bf35e045b264","text":"Other activities may depend more on personal interests, space or companions."},{"id":"3761ee1b-3b56-5403-9376-b3e6d05a46f6","text":"Their lower participation rates need not reduce their value: reading can stimulate thought, and a game of chess can provide both mental challenge and social contact."},{"id":"d403ab53-e38b-5b96-88bf-737d5b2b8afe","text":"The pattern therefore calls for variety rather than a single prescription for retirement."}]},{"id":"e30d9255-1024-5033-87e9-ec3c6ddc08ed","sentences":[{"id":"35cfd668-afa6-5f02-a7f0-591f12855dd6","text":"Communities can help by maintaining safe paths, providing comfortable reading spaces and making it easy to find activity partners."},{"id":"5f09fa21-e25f-5b87-824b-4aa58020ea5f","text":"These modest arrangements expand choice without imposing a preferred lifestyle."},{"id":"fe8d3a61-499a-5caf-8b8f-53248ca97b06","text":"A satisfying later life depends not on everyone doing the same things, but on having meaningful activities suited to individual interests and abilities."}]}],"sentences":[{"id":"c7f00968-5c1c-5a45-91e5-bfd8668c7221","text":"The chart shows elderly residents’ daily leisure activities in a community."},{"id":"2afd8885-0d8f-53da-be0b-bc240d5b6280","text":"Television is most common at 90.8%, followed by walking at 68.3%."},{"id":"b5be4612-722d-58e3-af06-747b7b350145","text":"Gardening, reading and chess attract 34.7%, 31.8% and 18.4% respectively."},{"id":"d473e937-f68a-5785-8468-68813faaea08","text":"Easily accessible activities clearly occupy a prominent place in residents’ routines."},{"id":"a9811d84-121c-5851-9987-d888d763527b","text":"Television offers information and entertainment with little physical effort, while walks provide gentle exercise and opportunities to meet neighbours."},{"id":"80821fe5-5911-5058-9573-bf35e045b264","text":"Other activities may depend more on personal interests, space or companions."},{"id":"3761ee1b-3b56-5403-9376-b3e6d05a46f6","text":"Their lower participation rates need not reduce their value: reading can stimulate thought, and a game of chess can provide both mental challenge and social contact."},{"id":"d403ab53-e38b-5b96-88bf-737d5b2b8afe","text":"The pattern therefore calls for variety rather than a single prescription for retirement."},{"id":"35cfd668-afa6-5f02-a7f0-591f12855dd6","text":"Communities can help by maintaining safe paths, providing comfortable reading spaces and making it easy to find activity partners."},{"id":"5f09fa21-e25f-5b87-824b-4aa58020ea5f","text":"These modest arrangements expand choice without imposing a preferred lifestyle."},{"id":"fe8d3a61-499a-5caf-8b8f-53248ca97b06","text":"A satisfying later life depends not on everyone doing the same things, but on having meaningful activities suited to individual interests and abilities."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    32,
    true
  ),
(
    'fd5a894c-934d-5e58-9fd8-e9ed9d703fa9'::uuid,
    (select id from collection),
    '2026年英语二·儿童户外活动的看法',
    'The chart presents views on children’s outdoor activities. Satisfying curiosity and developing observation skills receive almost identical support, at 54.6% and 54.5%. Physical fitness is mentioned by 37.2%, while stronger parent-child interaction attracts 33.2%. The strongest benefits concern intellectual exploration.

Outdoors, children encounter things that cannot be fully understood from descriptions alone. Watching an insect or noticing seasonal changes invites questions, close attention and the testing of ideas. Movement adds physical benefits, while a parent’s participation can turn discovery into conversation. These gains are connected: a shared walk can exercise the body, stimulate curiosity and create time for family contact.

Adults should therefore leave room for exploration rather than organize every moment around instructions. Choosing safe surroundings, listening to questions and allowing time to observe can make ordinary outings valuable. The aim is not to turn nature into another classroom, but to let children learn through active engagement with the world and the people beside them.',
    '{"id":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","title":"2026年英语二·儿童户外活动的看法","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart presents views on children’s outdoor activities. Satisfying curiosity and developing observation skills receive almost identical support, at 54.6% and 54.5%. Physical fitness is mentioned by 37.2%, while stronger parent-child interaction attracts 33.2%. The strongest benefits concern intellectual exploration.\n\nOutdoors, children encounter things that cannot be fully understood from descriptions alone. Watching an insect or noticing seasonal changes invites questions, close attention and the testing of ideas. Movement adds physical benefits, while a parent’s participation can turn discovery into conversation. These gains are connected: a shared walk can exercise the body, stimulate curiosity and create time for family contact.\n\nAdults should therefore leave room for exploration rather than organize every moment around instructions. Choosing safe surroundings, listening to questions and allowing time to observe can make ordinary outings valuable. The aim is not to turn nature into another classroom, but to let children learn through active engagement with the world and the people beside them.","paragraphs":[{"id":"70ac658c-f477-5947-9513-1eff434f9564","sentences":[{"id":"9a8a7551-391a-5170-b197-6abc83615be4","text":"The chart presents views on children’s outdoor activities."},{"id":"79074458-ddc6-5752-a042-6163e9f823ee","text":"Satisfying curiosity and developing observation skills receive almost identical support, at 54.6% and 54.5%."},{"id":"cafa08ee-c98e-5535-b314-6249f669f464","text":"Physical fitness is mentioned by 37.2%, while stronger parent-child interaction attracts 33.2%."},{"id":"eeaebfdc-e6d7-5cb8-a02a-4989ba866ca7","text":"The strongest benefits concern intellectual exploration."}]},{"id":"ec95a631-620a-5cc4-9595-c52fe8c02f74","sentences":[{"id":"6bca34b8-b116-5131-a971-b907b940493c","text":"Outdoors, children encounter things that cannot be fully understood from descriptions alone."},{"id":"c797ec02-4d90-5090-bb5d-bc95ae1a980f","text":"Watching an insect or noticing seasonal changes invites questions, close attention and the testing of ideas."},{"id":"10df5836-11b6-556d-810e-3f4f58fe3c6e","text":"Movement adds physical benefits, while a parent’s participation can turn discovery into conversation."},{"id":"85c5e454-4e1b-57d6-8391-48143ad5a83e","text":"These gains are connected: a shared walk can exercise the body, stimulate curiosity and create time for family contact."}]},{"id":"f7129872-e878-55ce-bffd-0c8993bc5227","sentences":[{"id":"064d0145-52ab-5fda-8faa-0030f4bf27fe","text":"Adults should therefore leave room for exploration rather than organize every moment around instructions."},{"id":"533fb6c6-1cc3-5ea1-b36f-459218e1c387","text":"Choosing safe surroundings, listening to questions and allowing time to observe can make ordinary outings valuable."},{"id":"70b51901-685c-582b-9991-05b1452d4ffe","text":"The aim is not to turn nature into another classroom, but to let children learn through active engagement with the world and the people beside them."}]}],"sentences":[{"id":"9a8a7551-391a-5170-b197-6abc83615be4","text":"The chart presents views on children’s outdoor activities."},{"id":"79074458-ddc6-5752-a042-6163e9f823ee","text":"Satisfying curiosity and developing observation skills receive almost identical support, at 54.6% and 54.5%."},{"id":"cafa08ee-c98e-5535-b314-6249f669f464","text":"Physical fitness is mentioned by 37.2%, while stronger parent-child interaction attracts 33.2%."},{"id":"eeaebfdc-e6d7-5cb8-a02a-4989ba866ca7","text":"The strongest benefits concern intellectual exploration."},{"id":"6bca34b8-b116-5131-a971-b907b940493c","text":"Outdoors, children encounter things that cannot be fully understood from descriptions alone."},{"id":"c797ec02-4d90-5090-bb5d-bc95ae1a980f","text":"Watching an insect or noticing seasonal changes invites questions, close attention and the testing of ideas."},{"id":"10df5836-11b6-556d-810e-3f4f58fe3c6e","text":"Movement adds physical benefits, while a parent’s participation can turn discovery into conversation."},{"id":"85c5e454-4e1b-57d6-8391-48143ad5a83e","text":"These gains are connected: a shared walk can exercise the body, stimulate curiosity and create time for family contact."},{"id":"064d0145-52ab-5fda-8faa-0030f4bf27fe","text":"Adults should therefore leave room for exploration rather than organize every moment around instructions."},{"id":"533fb6c6-1cc3-5ea1-b36f-459218e1c387","text":"Choosing safe surroundings, listening to questions and allowing time to observe can make ordinary outings valuable."},{"id":"70b51901-685c-582b-9991-05b1452d4ffe","text":"The aim is not to turn nature into another classroom, but to let children learn through active engagement with the world and the people beside them."}],"currentSentenceIndex":0,"origin":"system"}'::jsonb,
    33,
    true
  ),
(
    'f0d0b9fd-98a5-45a0-a3c0-975d19c157c3'::uuid,
    (select id from collection),
    '感谢导师帮助与分享录取喜讯',
    'Dear Alex,

Please accept my heartfelt thanks for your guidance. Your advice meant a great deal: it helped me understand my options and decide what to do next. You helped me feel at home in conversations that had once seemed intimidating. I have now been admitted to university and hope you will share my excitement.

You called this a well-deserved success, but your encouragement helped me put effort into the right things. In return, I would love to welcome you to China and introduce you to my city. Please tell me when you might be able to visit.

I look forward to seeing you again; do keep in touch.

Best wishes, Li Ming',
    '{"id":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","title":"感谢导师帮助与分享录取喜讯","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Alex,\n\nPlease accept my heartfelt thanks for your guidance. Your advice meant a great deal: it helped me understand my options and decide what to do next. You helped me feel at home in conversations that had once seemed intimidating. I have now been admitted to university and hope you will share my excitement.\n\nYou called this a well-deserved success, but your encouragement helped me put effort into the right things. In return, I would love to welcome you to China and introduce you to my city. Please tell me when you might be able to visit.\n\nI look forward to seeing you again; do keep in touch.\n\nBest wishes, Li Ming","paragraphs":[{"id":"bb35853e-c898-48d1-81e2-1f43ff328fe5","sentences":[{"id":"cdbbcec6-90ba-4d83-8864-a9a602cc8371","text":"Dear Alex,"}]},{"id":"88f9d8a4-029f-4885-827d-d0d79bbb3880","sentences":[{"id":"647bcf8a-dde5-480d-aea5-a08609cd023c","text":"Please accept my heartfelt thanks for your guidance."},{"id":"d939e2f8-2cf5-4241-b391-6267de20d4fa","text":"Your advice meant a great deal: it helped me understand my options and decide what to do next."},{"id":"47d99545-4c97-4ec1-ad49-0b4255c84e60","text":"You helped me feel at home in conversations that had once seemed intimidating."},{"id":"a7bf933e-d4d1-4983-9b5f-feff6c200cb6","text":"I have now been admitted to university and hope you will share my excitement."}]},{"id":"e2600bbf-461a-4546-869f-49e8a5a881b8","sentences":[{"id":"25638bbe-53df-472e-9986-438036cb43af","text":"You called this a well-deserved success, but your encouragement helped me put effort into the right things."},{"id":"fba610a8-5bad-4587-a2f2-a97947bd9c33","text":"In return, I would love to welcome you to China and introduce you to my city."},{"id":"d9d72013-e151-4507-b531-dc8d3b58dd40","text":"Please tell me when you might be able to visit."}]},{"id":"c915d73c-107d-42bd-9a4d-079d18fdb63e","sentences":[{"id":"2f36d950-3d2c-481b-adf4-3b8a7571d9aa","text":"I look forward to seeing you again; do keep in touch."}]},{"id":"3952da51-29cd-4422-90fc-52d9d86c186f","sentences":[{"id":"e8d06bc6-2fcf-4032-8868-6a1db8637aa8","text":"Best wishes, Li Ming"}]}],"sentences":[{"id":"cdbbcec6-90ba-4d83-8864-a9a602cc8371","text":"Dear Alex,"},{"id":"647bcf8a-dde5-480d-aea5-a08609cd023c","text":"Please accept my heartfelt thanks for your guidance."},{"id":"d939e2f8-2cf5-4241-b391-6267de20d4fa","text":"Your advice meant a great deal: it helped me understand my options and decide what to do next."},{"id":"47d99545-4c97-4ec1-ad49-0b4255c84e60","text":"You helped me feel at home in conversations that had once seemed intimidating."},{"id":"a7bf933e-d4d1-4983-9b5f-feff6c200cb6","text":"I have now been admitted to university and hope you will share my excitement."},{"id":"25638bbe-53df-472e-9986-438036cb43af","text":"You called this a well-deserved success, but your encouragement helped me put effort into the right things."},{"id":"fba610a8-5bad-4587-a2f2-a97947bd9c33","text":"In return, I would love to welcome you to China and introduce you to my city."},{"id":"d9d72013-e151-4507-b531-dc8d3b58dd40","text":"Please tell me when you might be able to visit."},{"id":"2f36d950-3d2c-481b-adf4-3b8a7571d9aa","text":"I look forward to seeing you again; do keep in touch."},{"id":"e8d06bc6-2fcf-4032-8868-6a1db8637aa8","text":"Best wishes, Li Ming"}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-small"}'::jsonb,
    34,
    true
  ),
(
    '6ffa395b-fa36-4f0f-bdd7-94fed6aad69e'::uuid,
    (select id from collection),
    '校园文化展示日招募通知',
    'NOTICE Volunteers Needed

Our cultural presentation day will serve as a platform for students to exchange stories and practise public speaking. After brief opening remarks, a hands-on activity will help participants prepare short presentations.

Students will rehearse together before presenting, and each talk will include a question-and-answer session. Volunteers will welcome visitors, organize materials and create a welcoming atmosphere. Anyone willing to take part in these tasks is welcome to apply. Patience and a willingness to listen are more important than previous speaking experience.

Please send a short introduction to the Students’ Union by Friday. Training will be provided before the event next Wednesday.

The Students’ Union',
    '{"id":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","title":"校园文化展示日招募通知","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"NOTICE Volunteers Needed\n\nOur cultural presentation day will serve as a platform for students to exchange stories and practise public speaking. After brief opening remarks, a hands-on activity will help participants prepare short presentations.\n\nStudents will rehearse together before presenting, and each talk will include a question-and-answer session. Volunteers will welcome visitors, organize materials and create a welcoming atmosphere. Anyone willing to take part in these tasks is welcome to apply. Patience and a willingness to listen are more important than previous speaking experience.\n\nPlease send a short introduction to the Students’ Union by Friday. Training will be provided before the event next Wednesday.\n\nThe Students’ Union","paragraphs":[{"id":"289d26cf-e91f-4121-a04b-95db6d4a8670","sentences":[{"id":"ce517619-0adf-4b24-853e-288f00860d36","text":"NOTICE"},{"id":"0040b36e-e879-4fff-9d42-28d52dca2bc6","text":"Volunteers Needed"}]},{"id":"94a296d1-c14b-457f-899e-f009745df754","sentences":[{"id":"a5365aee-f281-4f0b-a396-f52f0a6fbf84","text":"Our cultural presentation day will serve as a platform for students to exchange stories and practise public speaking."},{"id":"02a59bce-b129-4048-9d26-8e9cc53e673f","text":"After brief opening remarks, a hands-on activity will help participants prepare short presentations."}]},{"id":"b0ebbbbd-b3a4-4386-9dd3-a76f50124668","sentences":[{"id":"b669c362-ceae-4a55-aaae-17821685e46c","text":"Students will rehearse together before presenting, and each talk will include a question-and-answer session."},{"id":"384dd920-a125-4566-93b9-a0b2e558e3e9","text":"Volunteers will welcome visitors, organize materials and create a welcoming atmosphere."},{"id":"1a1dfc55-a08e-4012-9d23-e4fd7560ecad","text":"Anyone willing to take part in these tasks is welcome to apply."},{"id":"9c25ba43-5db5-4f0e-b0f2-ed677e6413da","text":"Patience and a willingness to listen are more important than previous speaking experience."}]},{"id":"51203da0-9781-4ced-bc63-cdaf999156ae","sentences":[{"id":"443fa73e-7d9f-476d-8b13-724d7da251a7","text":"Please send a short introduction to the Students’ Union by Friday."},{"id":"1ca16275-c3b5-4807-a9a8-7f451129fc70","text":"Training will be provided before the event next Wednesday."}]},{"id":"5b917a9f-2740-4e6d-ad87-3bdd8be6c989","sentences":[{"id":"73ac814d-5899-4376-8ebe-7ed3620ce284","text":"The Students’ Union"}]}],"sentences":[{"id":"ce517619-0adf-4b24-853e-288f00860d36","text":"NOTICE"},{"id":"0040b36e-e879-4fff-9d42-28d52dca2bc6","text":"Volunteers Needed"},{"id":"a5365aee-f281-4f0b-a396-f52f0a6fbf84","text":"Our cultural presentation day will serve as a platform for students to exchange stories and practise public speaking."},{"id":"02a59bce-b129-4048-9d26-8e9cc53e673f","text":"After brief opening remarks, a hands-on activity will help participants prepare short presentations."},{"id":"b669c362-ceae-4a55-aaae-17821685e46c","text":"Students will rehearse together before presenting, and each talk will include a question-and-answer session."},{"id":"384dd920-a125-4566-93b9-a0b2e558e3e9","text":"Volunteers will welcome visitors, organize materials and create a welcoming atmosphere."},{"id":"1a1dfc55-a08e-4012-9d23-e4fd7560ecad","text":"Anyone willing to take part in these tasks is welcome to apply."},{"id":"9c25ba43-5db5-4f0e-b0f2-ed677e6413da","text":"Patience and a willingness to listen are more important than previous speaking experience."},{"id":"443fa73e-7d9f-476d-8b13-724d7da251a7","text":"Please send a short introduction to the Students’ Union by Friday."},{"id":"1ca16275-c3b5-4807-a9a8-7f451129fc70","text":"Training will be provided before the event next Wednesday."},{"id":"73ac814d-5899-4376-8ebe-7ed3620ce284","text":"The Students’ Union"}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-small"}'::jsonb,
    35,
    true
  ),
(
    '3bc4eb7a-23f5-414b-834b-fd401d2c998f'::uuid,
    (select id from collection),
    '翻译练习方法建议',
    'Dear Jack,

To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally.

Break a difficult task into steps: understand the passage, draft your translation and compare versions of the same passage. Regular reading will also help you build a foundation for natural expression. Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise. Pay attention to recurring mistakes instead of trying to correct everything at once. A short notebook will make it easier to compare your work over time.

I hope this approach helps you make each session more useful.

Best wishes, Li Ming',
    '{"id":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","title":"翻译练习方法建议","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Jack,\n\nTo make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally.\n\nBreak a difficult task into steps: understand the passage, draft your translation and compare versions of the same passage. Regular reading will also help you build a foundation for natural expression. Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise. Pay attention to recurring mistakes instead of trying to correct everything at once. A short notebook will make it easier to compare your work over time.\n\nI hope this approach helps you make each session more useful.\n\nBest wishes, Li Ming","paragraphs":[{"id":"2b58c12c-7415-465c-97c7-ac3b03d9b402","sentences":[{"id":"ad296734-e614-423d-b0ed-0274e8fa99e5","text":"Dear Jack,"}]},{"id":"4cc3c363-d02c-4159-aeb8-e2762be08bed","sentences":[{"id":"910ff012-bf2c-4bfa-86fb-a8ee59131dd5","text":"To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally."}]},{"id":"9cf9d97e-100c-44d3-9cfa-6cd47a020aae","sentences":[{"id":"b358ec2e-8a1c-4c98-a23c-abc65016d74e","text":"Break a difficult task into steps: understand the passage, draft your translation and compare versions of the same passage."},{"id":"2c23386c-5878-44e4-a8e5-2f6436ac6c5c","text":"Regular reading will also help you build a foundation for natural expression."},{"id":"7fcb6aca-954f-4403-9e70-92d73c395a65","text":"Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise."},{"id":"87139c87-199c-4511-b178-0318f8e329e4","text":"Pay attention to recurring mistakes instead of trying to correct everything at once."},{"id":"519b870a-ded6-4ec1-ab50-2786706727f7","text":"A short notebook will make it easier to compare your work over time."}]},{"id":"a27bc56d-8d4d-4ba7-93af-fb4dad3012f5","sentences":[{"id":"6ab970ab-f2c6-4895-a85e-eb68a1ed6169","text":"I hope this approach helps you make each session more useful."}]},{"id":"8ed9eabd-79e6-432e-a25c-c9ecfc03a6fc","sentences":[{"id":"8f0ee7c9-0d80-484e-aebe-399fc9c73cc8","text":"Best wishes, Li Ming"}]}],"sentences":[{"id":"ad296734-e614-423d-b0ed-0274e8fa99e5","text":"Dear Jack,"},{"id":"910ff012-bf2c-4bfa-86fb-a8ee59131dd5","text":"To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally."},{"id":"b358ec2e-8a1c-4c98-a23c-abc65016d74e","text":"Break a difficult task into steps: understand the passage, draft your translation and compare versions of the same passage."},{"id":"2c23386c-5878-44e4-a8e5-2f6436ac6c5c","text":"Regular reading will also help you build a foundation for natural expression."},{"id":"7fcb6aca-954f-4403-9e70-92d73c395a65","text":"Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise."},{"id":"87139c87-199c-4511-b178-0318f8e329e4","text":"Pay attention to recurring mistakes instead of trying to correct everything at once."},{"id":"519b870a-ded6-4ec1-ab50-2786706727f7","text":"A short notebook will make it easier to compare your work over time."},{"id":"6ab970ab-f2c6-4895-a85e-eb68a1ed6169","text":"I hope this approach helps you make each session more useful."},{"id":"8f0ee7c9-0d80-484e-aebe-399fc9c73cc8","text":"Best wishes, Li Ming"}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-small"}'::jsonb,
    36,
    true
  ),
(
    'a88f5192-a71f-476f-9489-167c8f5e6a77'::uuid,
    (select id from collection),
    '临时改约与替代安排',
    'Dear Professor Smith,

Please accept my sincere apologies for changing our meeting at short notice. A compulsory examination has been moved to Friday, so I cannot visit as planned.

Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting. Would next Tuesday afternoon be a suitable alternative? If the following week would suit you better, I will gladly meet at your convenience. A prompt response would help me arrange my travel. I would still greatly value the opportunity to discuss my research with you, and will prepare a short outline in advance.

Thank you for your understanding.

Yours sincerely, Li Ming',
    '{"id":"a88f5192-a71f-476f-9489-167c8f5e6a77","title":"临时改约与替代安排","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Professor Smith,\n\nPlease accept my sincere apologies for changing our meeting at short notice. A compulsory examination has been moved to Friday, so I cannot visit as planned.\n\nKnowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting. Would next Tuesday afternoon be a suitable alternative? If the following week would suit you better, I will gladly meet at your convenience. A prompt response would help me arrange my travel. I would still greatly value the opportunity to discuss my research with you, and will prepare a short outline in advance.\n\nThank you for your understanding.\n\nYours sincerely, Li Ming","paragraphs":[{"id":"67f00a64-314c-401d-bc86-18b093e7de15","sentences":[{"id":"44175ea1-1fb0-4619-af44-86c13dce9057","text":"Dear Professor Smith,"}]},{"id":"d737151c-062d-4a71-9e85-071380017c57","sentences":[{"id":"fa483ed6-f12b-49d5-b208-ab0df78106ec","text":"Please accept my sincere apologies for changing our meeting at short notice."},{"id":"4142aa23-400f-47ad-9fc5-f1374113a5ad","text":"A compulsory examination has been moved to Friday, so I cannot visit as planned."}]},{"id":"a66bd1c1-4db2-45ef-b964-95ec544c71a9","sentences":[{"id":"174f36a4-e7a0-4273-9557-363ef2888d77","text":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting."},{"id":"afee4f28-8d9f-423d-a19c-0d393ab77478","text":"Would next Tuesday afternoon be a suitable alternative?"},{"id":"2b374885-25e0-44b3-8415-a07dea21f650","text":"If the following week would suit you better, I will gladly meet at your convenience."},{"id":"8452aea9-29d4-4733-a7c2-b676d5337c53","text":"A prompt response would help me arrange my travel."},{"id":"5367847f-e861-4fd2-b6c7-2dc68205a845","text":"I would still greatly value the opportunity to discuss my research with you, and will prepare a short outline in advance."}]},{"id":"67818023-3c63-4cd4-8fe0-41d994b2223c","sentences":[{"id":"dd663432-6dda-48f3-8684-c9dcaddfd028","text":"Thank you for your understanding."}]},{"id":"7c73dd20-b436-44b7-a8e8-cbed4d8c216b","sentences":[{"id":"88ee4cc8-0658-4a27-b490-960e9d6d83c5","text":"Yours sincerely, Li Ming"}]}],"sentences":[{"id":"44175ea1-1fb0-4619-af44-86c13dce9057","text":"Dear Professor Smith,"},{"id":"fa483ed6-f12b-49d5-b208-ab0df78106ec","text":"Please accept my sincere apologies for changing our meeting at short notice."},{"id":"4142aa23-400f-47ad-9fc5-f1374113a5ad","text":"A compulsory examination has been moved to Friday, so I cannot visit as planned."},{"id":"174f36a4-e7a0-4273-9557-363ef2888d77","text":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting."},{"id":"afee4f28-8d9f-423d-a19c-0d393ab77478","text":"Would next Tuesday afternoon be a suitable alternative?"},{"id":"2b374885-25e0-44b3-8415-a07dea21f650","text":"If the following week would suit you better, I will gladly meet at your convenience."},{"id":"8452aea9-29d4-4733-a7c2-b676d5337c53","text":"A prompt response would help me arrange my travel."},{"id":"5367847f-e861-4fd2-b6c7-2dc68205a845","text":"I would still greatly value the opportunity to discuss my research with you, and will prepare a short outline in advance."},{"id":"dd663432-6dda-48f3-8684-c9dcaddfd028","text":"Thank you for your understanding."},{"id":"88ee4cc8-0658-4a27-b490-960e9d6d83c5","text":"Yours sincerely, Li Ming"}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-small"}'::jsonb,
    37,
    true
  ),
(
    'fc9add84-5993-49c7-818b-5e0d0f47fd1c'::uuid,
    (select id from collection),
    '在线课程服务投诉',
    'Dear Sir or Madam,

I am writing about your online writing course, which has failed to meet the stated standard. The description promised complete recordings and weekly individual feedback.

Several recordings are missing, and my assignments have received no comments for two weeks. The missing material has prevented me from finishing two tasks, while the absence of feedback makes it hard to identify what needs improvement. Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund. I can provide further details and copies of our previous correspondence.

A fair solution would help restore my confidence in your service.

Yours sincerely, Li Ming',
    '{"id":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","title":"在线课程服务投诉","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Sir or Madam,\n\nI am writing about your online writing course, which has failed to meet the stated standard. The description promised complete recordings and weekly individual feedback.\n\nSeveral recordings are missing, and my assignments have received no comments for two weeks. The missing material has prevented me from finishing two tasks, while the absence of feedback makes it hard to identify what needs improvement. Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund. I can provide further details and copies of our previous correspondence.\n\nA fair solution would help restore my confidence in your service.\n\nYours sincerely, Li Ming","paragraphs":[{"id":"6d061607-e8d6-4395-ab96-9f43a3530d59","sentences":[{"id":"52b70a13-71b7-42d8-b03b-368ee8d208f0","text":"Dear Sir or Madam,"}]},{"id":"95d58092-8a5c-4bfc-8a5d-809690fe2171","sentences":[{"id":"4c3e68da-b5b8-42b6-9166-b31b3e56fc7d","text":"I am writing about your online writing course, which has failed to meet the stated standard."},{"id":"7c470024-f345-4dd0-aa3c-4e5d58446c01","text":"The description promised complete recordings and weekly individual feedback."}]},{"id":"ab3aad73-3e54-4d76-9d67-7822bdecbe73","sentences":[{"id":"aa56c9a4-095c-4feb-a545-2f537c6c010d","text":"Several recordings are missing, and my assignments have received no comments for two weeks."},{"id":"d32a9217-6ac7-4b82-a82e-e693e4fc7d6f","text":"The missing material has prevented me from finishing two tasks, while the absence of feedback makes it hard to identify what needs improvement."},{"id":"7a3e4952-653f-4c7b-8c08-6e302a23b368","text":"Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund."},{"id":"edb6a102-79a9-4e55-afff-528553ae630c","text":"I can provide further details and copies of our previous correspondence."}]},{"id":"950c6a5b-cab2-4742-8db9-ff2c73013335","sentences":[{"id":"1b9bf366-ae6b-4ba9-b36e-005b6cca79d8","text":"A fair solution would help restore my confidence in your service."}]},{"id":"132533f3-cca0-41ae-8437-4721958ca9b6","sentences":[{"id":"7ef3b267-2f53-4a2c-b220-e5b90c346e2e","text":"Yours sincerely, Li Ming"}]}],"sentences":[{"id":"52b70a13-71b7-42d8-b03b-368ee8d208f0","text":"Dear Sir or Madam,"},{"id":"4c3e68da-b5b8-42b6-9166-b31b3e56fc7d","text":"I am writing about your online writing course, which has failed to meet the stated standard."},{"id":"7c470024-f345-4dd0-aa3c-4e5d58446c01","text":"The description promised complete recordings and weekly individual feedback."},{"id":"aa56c9a4-095c-4feb-a545-2f537c6c010d","text":"Several recordings are missing, and my assignments have received no comments for two weeks."},{"id":"d32a9217-6ac7-4b82-a82e-e693e4fc7d6f","text":"The missing material has prevented me from finishing two tasks, while the absence of feedback makes it hard to identify what needs improvement."},{"id":"7a3e4952-653f-4c7b-8c08-6e302a23b368","text":"Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund."},{"id":"edb6a102-79a9-4e55-afff-528553ae630c","text":"I can provide further details and copies of our previous correspondence."},{"id":"1b9bf366-ae6b-4ba9-b36e-005b6cca79d8","text":"A fair solution would help restore my confidence in your service."},{"id":"7ef3b267-2f53-4a2c-b220-e5b90c346e2e","text":"Yours sincerely, Li Ming"}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-small"}'::jsonb,
    38,
    true
  ),
(
    '9249c547-0b6a-41c9-a5db-623a0d74d889'::uuid,
    (select id from collection),
    '老屋保护调查分工',
    'Dear Jack,

I would like to put forward a plan for our investigation of existing protection measures. For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.

Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions. We can then make revisions together and reach an agreement before the visit. A shared schedule will help us keep track of the work. With permission, photographs can help us check details when we compare our findings.

I welcome your suggestions on how to preserve cultural heritage while understanding residents’ needs.

Best wishes, Li Ming',
    '{"id":"9249c547-0b6a-41c9-a5db-623a0d74d889","title":"老屋保护调查分工","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Dear Jack,\n\nI would like to put forward a plan for our investigation of existing protection measures. For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.\n\nLet us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions. We can then make revisions together and reach an agreement before the visit. A shared schedule will help us keep track of the work. With permission, photographs can help us check details when we compare our findings.\n\nI welcome your suggestions on how to preserve cultural heritage while understanding residents’ needs.\n\nBest wishes, Li Ming","paragraphs":[{"id":"f8475d64-b922-46b2-8060-d847269623be","sentences":[{"id":"f8c6d05d-5fee-4e67-9920-5c310e98da9b","text":"Dear Jack,"}]},{"id":"1374571a-b0f7-4184-b504-35ade48f7813","sentences":[{"id":"39f2e13d-6c00-4110-b5ad-287c9b948bf8","text":"I would like to put forward a plan for our investigation of existing protection measures."},{"id":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","text":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns."}]},{"id":"187f05ab-05f9-4842-aca5-0458c79d7235","sentences":[{"id":"9586600d-a235-4f75-a565-f62127987355","text":"Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions."},{"id":"3accd780-4135-4fac-9547-853aeab06eec","text":"We can then make revisions together and reach an agreement before the visit."},{"id":"3a7c2ede-4aad-4355-8509-5c6826b0b350","text":"A shared schedule will help us keep track of the work."},{"id":"e7f2966a-0343-416e-b294-1c73303f3762","text":"With permission, photographs can help us check details when we compare our findings."}]},{"id":"78fef976-41d8-401c-82fc-fe16954b58a3","sentences":[{"id":"7a527383-c26f-4dbd-9f7d-14273dbc3aa6","text":"I welcome your suggestions on how to preserve cultural heritage while understanding residents’ needs."}]},{"id":"9a6ab65f-3cc3-4b4f-97e0-3d2317755e50","sentences":[{"id":"edb2ffdc-804c-4ba2-8047-3394a3d061fe","text":"Best wishes, Li Ming"}]}],"sentences":[{"id":"f8c6d05d-5fee-4e67-9920-5c310e98da9b","text":"Dear Jack,"},{"id":"39f2e13d-6c00-4110-b5ad-287c9b948bf8","text":"I would like to put forward a plan for our investigation of existing protection measures."},{"id":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","text":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns."},{"id":"9586600d-a235-4f75-a565-f62127987355","text":"Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions."},{"id":"3accd780-4135-4fac-9547-853aeab06eec","text":"We can then make revisions together and reach an agreement before the visit."},{"id":"3a7c2ede-4aad-4355-8509-5c6826b0b350","text":"A shared schedule will help us keep track of the work."},{"id":"e7f2966a-0343-416e-b294-1c73303f3762","text":"With permission, photographs can help us check details when we compare our findings."},{"id":"7a527383-c26f-4dbd-9f7d-14273dbc3aa6","text":"I welcome your suggestions on how to preserve cultural heritage while understanding residents’ needs."},{"id":"edb2ffdc-804c-4ba2-8047-3394a3d061fe","text":"Best wishes, Li Ming"}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-small"}'::jsonb,
    39,
    true
  ),
(
    'bc901145-82a5-4138-8975-70015d8f3a35'::uuid,
    (select id from collection),
    '社区健身项目参与变化',
    'The chart shows an upward trend in participation in a community exercise programme from 2017 to 2023. Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020. Growth accelerated initially, then slowed before the rate began to level off in 2022.

One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines. Flexible sessions allow participants to choose their own pace, while exercising with neighbours offers mutual encouragement. Under these conditions, people may find it easier to maintain a habit instead of attending only occasionally.

A stable participation rate does not mean that the programme has no further value. Organizers should seek feedback from residents who remain excluded and offer suitable times and activities. Serving existing participants well remains important even when attracting new members becomes more difficult. Even when growth slows, maintaining enjoyable, reliable opportunities can protect the long-term benefits of participation.',
    '{"id":"bc901145-82a5-4138-8975-70015d8f3a35","title":"社区健身项目参与变化","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows an upward trend in participation in a community exercise programme from 2017 to 2023. Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020. Growth accelerated initially, then slowed before the rate began to level off in 2022.\n\nOne possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines. Flexible sessions allow participants to choose their own pace, while exercising with neighbours offers mutual encouragement. Under these conditions, people may find it easier to maintain a habit instead of attending only occasionally.\n\nA stable participation rate does not mean that the programme has no further value. Organizers should seek feedback from residents who remain excluded and offer suitable times and activities. Serving existing participants well remains important even when attracting new members becomes more difficult. Even when growth slows, maintaining enjoyable, reliable opportunities can protect the long-term benefits of participation.","paragraphs":[{"id":"33646583-00f1-460f-aaf0-9e440304fa1f","sentences":[{"id":"05482767-e4bd-40d0-8795-6fe7db30d5cd","text":"The chart shows an upward trend in participation in a community exercise programme from 2017 to 2023."},{"id":"8b5762db-926c-417d-bb93-668c5e662e0b","text":"Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020."},{"id":"2f392b82-7f42-43b3-b634-a1568b5dcf16","text":"Growth accelerated initially, then slowed before the rate began to level off in 2022."}]},{"id":"816fba18-9b80-443b-b28e-13122520e371","sentences":[{"id":"a2357308-fa11-43e2-8c3a-ce819773ee17","text":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines."},{"id":"82b0ef57-b650-4b7c-b414-676b1d60896e","text":"Flexible sessions allow participants to choose their own pace, while exercising with neighbours offers mutual encouragement."},{"id":"38600771-b386-4800-9f38-8627c43072d8","text":"Under these conditions, people may find it easier to maintain a habit instead of attending only occasionally."}]},{"id":"09f95684-0f05-49ab-bbc2-6b51e141d6fe","sentences":[{"id":"a928cb33-91da-4c4e-99ed-356b8231a8df","text":"A stable participation rate does not mean that the programme has no further value."},{"id":"012a6235-8a05-4cde-a98a-5e1da45a795c","text":"Organizers should seek feedback from residents who remain excluded and offer suitable times and activities."},{"id":"6404717c-d0cb-4b05-90fe-b588ee73659d","text":"Serving existing participants well remains important even when attracting new members becomes more difficult."},{"id":"972aab69-33bf-4b0a-abe9-ea64b343be39","text":"Even when growth slows, maintaining enjoyable, reliable opportunities can protect the long-term benefits of participation."}]}],"sentences":[{"id":"05482767-e4bd-40d0-8795-6fe7db30d5cd","text":"The chart shows an upward trend in participation in a community exercise programme from 2017 to 2023."},{"id":"8b5762db-926c-417d-bb93-668c5e662e0b","text":"Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020."},{"id":"2f392b82-7f42-43b3-b634-a1568b5dcf16","text":"Growth accelerated initially, then slowed before the rate began to level off in 2022."},{"id":"a2357308-fa11-43e2-8c3a-ce819773ee17","text":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines."},{"id":"82b0ef57-b650-4b7c-b414-676b1d60896e","text":"Flexible sessions allow participants to choose their own pace, while exercising with neighbours offers mutual encouragement."},{"id":"38600771-b386-4800-9f38-8627c43072d8","text":"Under these conditions, people may find it easier to maintain a habit instead of attending only occasionally."},{"id":"a928cb33-91da-4c4e-99ed-356b8231a8df","text":"A stable participation rate does not mean that the programme has no further value."},{"id":"012a6235-8a05-4cde-a98a-5e1da45a795c","text":"Organizers should seek feedback from residents who remain excluded and offer suitable times and activities."},{"id":"6404717c-d0cb-4b05-90fe-b588ee73659d","text":"Serving existing participants well remains important even when attracting new members becomes more difficult."},{"id":"972aab69-33bf-4b0a-abe9-ea64b343be39","text":"Even when growth slows, maintaining enjoyable, reliable opportunities can protect the long-term benefits of participation."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    40,
    true
  ),
(
    'f850c265-1c5d-4508-b90b-4da0bff2406a'::uuid,
    (select id from collection),
    '电子与纸质阅读时长变化',
    'The chart contrasts an upward trend in digital reading with a downward trend in print reading between 2018 and 2024. Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two. In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance.

Digital resources offer instant access to books without requiring readers to carry them. This convenience can contribute to a deliberate choice of format, especially for people reading between other commitments. Yet choosing a screen does not necessarily mean abandoning deep reading, just as choosing paper does not guarantee concentration.

The more useful question is whether either format supports understanding and enjoyment. Readers should protect time for sustained attention and choose materials that suit their purposes. By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period.',
    '{"id":"f850c265-1c5d-4508-b90b-4da0bff2406a","title":"电子与纸质阅读时长变化","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart contrasts an upward trend in digital reading with a downward trend in print reading between 2018 and 2024. Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two. In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance.\n\nDigital resources offer instant access to books without requiring readers to carry them. This convenience can contribute to a deliberate choice of format, especially for people reading between other commitments. Yet choosing a screen does not necessarily mean abandoning deep reading, just as choosing paper does not guarantee concentration.\n\nThe more useful question is whether either format supports understanding and enjoyment. Readers should protect time for sustained attention and choose materials that suit their purposes. By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period.","paragraphs":[{"id":"d95b9929-5d02-4ed4-997a-69a805a5e014","sentences":[{"id":"67591780-c927-4cc4-bf84-45088606c0e6","text":"The chart contrasts an upward trend in digital reading with a downward trend in print reading between 2018 and 2024."},{"id":"1714d6b5-7139-4262-b954-f778b57968d2","text":"Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two."},{"id":"d7f238c8-4986-4f8b-aa9d-2c98a4b0c5d3","text":"In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance."}]},{"id":"eb1fbb20-52bb-433f-add0-9b6ddc11c121","sentences":[{"id":"4a89bdf1-5b33-454e-b315-2712bfe16c66","text":"Digital resources offer instant access to books without requiring readers to carry them."},{"id":"76f0cd17-2306-425e-a4c8-12f84e4e67fc","text":"This convenience can contribute to a deliberate choice of format, especially for people reading between other commitments."},{"id":"61e2bed7-4153-48b1-af74-c2d95d0ff9c3","text":"Yet choosing a screen does not necessarily mean abandoning deep reading, just as choosing paper does not guarantee concentration."}]},{"id":"4b3c93ae-b22e-44da-a335-83c1da4f897c","sentences":[{"id":"e115bbab-4615-4662-8ddb-91251299cf36","text":"The more useful question is whether either format supports understanding and enjoyment."},{"id":"42eda2d8-c9ee-4127-8806-a3c7e9a50e43","text":"Readers should protect time for sustained attention and choose materials that suit their purposes."},{"id":"12f8ac30-0b42-451a-81f8-bc97b0f043bb","text":"By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period."}]}],"sentences":[{"id":"67591780-c927-4cc4-bf84-45088606c0e6","text":"The chart contrasts an upward trend in digital reading with a downward trend in print reading between 2018 and 2024."},{"id":"1714d6b5-7139-4262-b954-f778b57968d2","text":"Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two."},{"id":"d7f238c8-4986-4f8b-aa9d-2c98a4b0c5d3","text":"In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance."},{"id":"4a89bdf1-5b33-454e-b315-2712bfe16c66","text":"Digital resources offer instant access to books without requiring readers to carry them."},{"id":"76f0cd17-2306-425e-a4c8-12f84e4e67fc","text":"This convenience can contribute to a deliberate choice of format, especially for people reading between other commitments."},{"id":"61e2bed7-4153-48b1-af74-c2d95d0ff9c3","text":"Yet choosing a screen does not necessarily mean abandoning deep reading, just as choosing paper does not guarantee concentration."},{"id":"e115bbab-4615-4662-8ddb-91251299cf36","text":"The more useful question is whether either format supports understanding and enjoyment."},{"id":"42eda2d8-c9ee-4127-8806-a3c7e9a50e43","text":"Readers should protect time for sustained attention and choose materials that suit their purposes."},{"id":"12f8ac30-0b42-451a-81f8-bc97b0f043bb","text":"By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    41,
    true
  ),
(
    'c42827eb-d0a1-4b40-85ed-b010a2a056e6'::uuid,
    (select id from collection),
    '餐厅选择与物有所值',
    'Food quality ranks first in this survey, selected by 56% of respondents. That share is twice as high as service at 28%, while a smaller proportion, 9%, choose atmosphere. The remaining share of 7% covers other reasons, leaving quality clearly in the lead.

Value for money need not mean the lowest possible price. People may willingly pay more when good ingredients and consistent preparation make a meal dependable. A distinctive identity can attract attention, but a restaurant must deliver the experience it promises. Otherwise, novelty is unlikely to create customer loyalty or repeat visits.

Owners should therefore balance creativity with standards they can maintain every day. Training staff, checking ingredients and listening to complaints can make a restaurant more trustworthy. Value is therefore judged across the whole experience, not at the moment of the first advertisement. The aim is to earn confidence rather than depend on promotion alone.',
    '{"id":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","title":"餐厅选择与物有所值","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"Food quality ranks first in this survey, selected by 56% of respondents. That share is twice as high as service at 28%, while a smaller proportion, 9%, choose atmosphere. The remaining share of 7% covers other reasons, leaving quality clearly in the lead.\n\nValue for money need not mean the lowest possible price. People may willingly pay more when good ingredients and consistent preparation make a meal dependable. A distinctive identity can attract attention, but a restaurant must deliver the experience it promises. Otherwise, novelty is unlikely to create customer loyalty or repeat visits.\n\nOwners should therefore balance creativity with standards they can maintain every day. Training staff, checking ingredients and listening to complaints can make a restaurant more trustworthy. Value is therefore judged across the whole experience, not at the moment of the first advertisement. The aim is to earn confidence rather than depend on promotion alone.","paragraphs":[{"id":"b815719f-9bf9-4ce0-bb93-322f4d1b4c5d","sentences":[{"id":"7c75dfbe-0820-4e45-8dec-670aed156df8","text":"Food quality ranks first in this survey, selected by 56% of respondents."},{"id":"5588d3b9-3efc-4e1e-b3ef-4faa555dcf34","text":"That share is twice as high as service at 28%, while a smaller proportion, 9%, choose atmosphere."},{"id":"c6d348db-7468-46fb-9e54-87b655136c02","text":"The remaining share of 7% covers other reasons, leaving quality clearly in the lead."}]},{"id":"bac0bc05-bee2-4b99-a68e-1575d2970324","sentences":[{"id":"42b08f8b-86f4-49d8-8cdf-7b89d0d248d9","text":"Value for money need not mean the lowest possible price."},{"id":"ee1e79d4-e488-4696-876b-c8feaec1f559","text":"People may willingly pay more when good ingredients and consistent preparation make a meal dependable."},{"id":"c9cdf91a-7321-4e04-b257-b577d3214a02","text":"A distinctive identity can attract attention, but a restaurant must deliver the experience it promises."},{"id":"7d5fd23a-4cb8-4d57-93c1-4285d515834a","text":"Otherwise, novelty is unlikely to create customer loyalty or repeat visits."}]},{"id":"95f607b8-f97a-444a-8fc3-c51d72667f7a","sentences":[{"id":"4c3ac66e-186e-4597-b337-577818953866","text":"Owners should therefore balance creativity with standards they can maintain every day."},{"id":"26432758-5eaa-4691-bd5d-2314b4fb6d4a","text":"Training staff, checking ingredients and listening to complaints can make a restaurant more trustworthy."},{"id":"6b66892a-7856-4a5b-a74d-d3d8c8826cfb","text":"Value is therefore judged across the whole experience, not at the moment of the first advertisement."},{"id":"87854f28-aaeb-4534-9edb-9ef484e37f23","text":"The aim is to earn confidence rather than depend on promotion alone."}]}],"sentences":[{"id":"7c75dfbe-0820-4e45-8dec-670aed156df8","text":"Food quality ranks first in this survey, selected by 56% of respondents."},{"id":"5588d3b9-3efc-4e1e-b3ef-4faa555dcf34","text":"That share is twice as high as service at 28%, while a smaller proportion, 9%, choose atmosphere."},{"id":"c6d348db-7468-46fb-9e54-87b655136c02","text":"The remaining share of 7% covers other reasons, leaving quality clearly in the lead."},{"id":"42b08f8b-86f4-49d8-8cdf-7b89d0d248d9","text":"Value for money need not mean the lowest possible price."},{"id":"ee1e79d4-e488-4696-876b-c8feaec1f559","text":"People may willingly pay more when good ingredients and consistent preparation make a meal dependable."},{"id":"c9cdf91a-7321-4e04-b257-b577d3214a02","text":"A distinctive identity can attract attention, but a restaurant must deliver the experience it promises."},{"id":"7d5fd23a-4cb8-4d57-93c1-4285d515834a","text":"Otherwise, novelty is unlikely to create customer loyalty or repeat visits."},{"id":"4c3ac66e-186e-4597-b337-577818953866","text":"Owners should therefore balance creativity with standards they can maintain every day."},{"id":"26432758-5eaa-4691-bd5d-2314b4fb6d4a","text":"Training staff, checking ingredients and listening to complaints can make a restaurant more trustworthy."},{"id":"6b66892a-7856-4a5b-a74d-d3d8c8826cfb","text":"Value is therefore judged across the whole experience, not at the moment of the first advertisement."},{"id":"87854f28-aaeb-4534-9edb-9ef484e37f23","text":"The aim is to earn confidence rather than depend on promotion alone."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    42,
    true
  ),
(
    'f78915da-57e5-4dbe-a103-7dab0b654f96'::uuid,
    (select id from collection),
    '实践课程中的技能与反馈',
    'The survey reports gains from a practical course: 82% mention skills, 70% subject knowledge and 45% teamwork. Compared with teamwork, individual learning outcomes are more widely reported.

Learning by doing can bridge the gap between knowing an idea and putting it into practice. A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience. Meaningful feedback helps them see why an approach worked, creating transferable skills rather than a habit of following instructions. Completing useful work can also produce a sense of achievement, linking effort with visible results. Teamwork additionally requires shared goals and complementary roles that make members depend on one another.

Teachers can design projects and ask students to reflect on both their understanding and their joint responsibilities. A short discussion of decisions and difficulties can connect the finished product with the learning behind it. Completing a task matters, but understanding how and why it was completed gives practical education its deeper value.',
    '{"id":"f78915da-57e5-4dbe-a103-7dab0b654f96","title":"实践课程中的技能与反馈","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The survey reports gains from a practical course: 82% mention skills, 70% subject knowledge and 45% teamwork. Compared with teamwork, individual learning outcomes are more widely reported.\n\nLearning by doing can bridge the gap between knowing an idea and putting it into practice. A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience. Meaningful feedback helps them see why an approach worked, creating transferable skills rather than a habit of following instructions. Completing useful work can also produce a sense of achievement, linking effort with visible results. Teamwork additionally requires shared goals and complementary roles that make members depend on one another.\n\nTeachers can design projects and ask students to reflect on both their understanding and their joint responsibilities. A short discussion of decisions and difficulties can connect the finished product with the learning behind it. Completing a task matters, but understanding how and why it was completed gives practical education its deeper value.","paragraphs":[{"id":"6d219323-8c7b-4076-b3e0-d623dbec5984","sentences":[{"id":"90062bdc-23ce-4b82-90b7-bda5e1ef7928","text":"The survey reports gains from a practical course: 82% mention skills, 70% subject knowledge and 45% teamwork."},{"id":"73fbb28e-71b5-4eb0-b813-51a91d787a97","text":"Compared with teamwork, individual learning outcomes are more widely reported."}]},{"id":"df77eb85-4760-4493-9b4f-32bca43c0588","sentences":[{"id":"600333e6-13b6-41ff-aaf3-c2da287255ee","text":"Learning by doing can bridge the gap between knowing an idea and putting it into practice."},{"id":"76cfbe61-3dab-4a49-a871-2cf100558038","text":"A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience."},{"id":"46673c71-4c85-4ba1-847e-8d4ce4bced42","text":"Meaningful feedback helps them see why an approach worked, creating transferable skills rather than a habit of following instructions."},{"id":"56dfe76a-082a-4389-bd6a-895f069271dd","text":"Completing useful work can also produce a sense of achievement, linking effort with visible results."},{"id":"6b8fed24-6525-467b-9af8-e2890126b166","text":"Teamwork additionally requires shared goals and complementary roles that make members depend on one another."}]},{"id":"53726ad3-9dba-4708-ab6d-f73c92aff60c","sentences":[{"id":"6d390072-64f2-4b73-b937-1f9cbdcad35a","text":"Teachers can design projects and ask students to reflect on both their understanding and their joint responsibilities."},{"id":"4271b6e8-e2e0-47a8-9153-dd0cb472b1a0","text":"A short discussion of decisions and difficulties can connect the finished product with the learning behind it."},{"id":"ed7340ab-628b-489c-ae5e-f2e76f570e91","text":"Completing a task matters, but understanding how and why it was completed gives practical education its deeper value."}]}],"sentences":[{"id":"90062bdc-23ce-4b82-90b7-bda5e1ef7928","text":"The survey reports gains from a practical course: 82% mention skills, 70% subject knowledge and 45% teamwork."},{"id":"73fbb28e-71b5-4eb0-b813-51a91d787a97","text":"Compared with teamwork, individual learning outcomes are more widely reported."},{"id":"600333e6-13b6-41ff-aaf3-c2da287255ee","text":"Learning by doing can bridge the gap between knowing an idea and putting it into practice."},{"id":"76cfbe61-3dab-4a49-a871-2cf100558038","text":"A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience."},{"id":"46673c71-4c85-4ba1-847e-8d4ce4bced42","text":"Meaningful feedback helps them see why an approach worked, creating transferable skills rather than a habit of following instructions."},{"id":"56dfe76a-082a-4389-bd6a-895f069271dd","text":"Completing useful work can also produce a sense of achievement, linking effort with visible results."},{"id":"6b8fed24-6525-467b-9af8-e2890126b166","text":"Teamwork additionally requires shared goals and complementary roles that make members depend on one another."},{"id":"6d390072-64f2-4b73-b937-1f9cbdcad35a","text":"Teachers can design projects and ask students to reflect on both their understanding and their joint responsibilities."},{"id":"4271b6e8-e2e0-47a8-9153-dd0cb472b1a0","text":"A short discussion of decisions and difficulties can connect the finished product with the learning behind it."},{"id":"ed7340ab-628b-489c-ae5e-f2e76f570e91","text":"Completing a task matters, but understanding how and why it was completed gives practical education its deeper value."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    43,
    true
  ),
(
    '015a7c73-e695-455e-91f2-614330c31d4c'::uuid,
    (select id from collection),
    '选择职业道路的依据',
    'The survey asks what matters most in choosing a future path: interests lead at 48%, followed by development opportunities at 35% and starting income at 17%. The pattern suggests that immediate pay is not the only concern as students prepare for employment.

Students must weigh the options in light of personal circumstances and incomplete knowledge of the changing workplace. Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses. Further study may strengthen qualifications, but it is a better fit only when it serves a genuine learning need. Career guidance can provide informed advice about opportunities that may be worth exploring.

Useful support should protect academic responsibilities while creating time for exploration. A choice made deliberately is more valuable than simply following the most fashionable route. There is no universal answer, but clearer information and honest reflection can help students find a direction they can explain and sustain.',
    '{"id":"015a7c73-e695-455e-91f2-614330c31d4c","title":"选择职业道路的依据","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The survey asks what matters most in choosing a future path: interests lead at 48%, followed by development opportunities at 35% and starting income at 17%. The pattern suggests that immediate pay is not the only concern as students prepare for employment.\n\nStudents must weigh the options in light of personal circumstances and incomplete knowledge of the changing workplace. Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses. Further study may strengthen qualifications, but it is a better fit only when it serves a genuine learning need. Career guidance can provide informed advice about opportunities that may be worth exploring.\n\nUseful support should protect academic responsibilities while creating time for exploration. A choice made deliberately is more valuable than simply following the most fashionable route. There is no universal answer, but clearer information and honest reflection can help students find a direction they can explain and sustain.","paragraphs":[{"id":"fd08b8f5-d9a6-4b0c-8da7-7f422ea180df","sentences":[{"id":"a0073d89-3ea0-4c09-ae0f-1a198cdf0975","text":"The survey asks what matters most in choosing a future path: interests lead at 48%, followed by development opportunities at 35% and starting income at 17%."},{"id":"c6d37f99-1880-4f48-97c8-17da85c3fe8e","text":"The pattern suggests that immediate pay is not the only concern as students prepare for employment."}]},{"id":"c839fc8f-3bd2-4892-a7ab-239f1a51d074","sentences":[{"id":"8a148d51-9e18-4cbf-9025-21b42b80274b","text":"Students must weigh the options in light of personal circumstances and incomplete knowledge of the changing workplace."},{"id":"2838c5ab-6625-4af0-82d7-cb5b3593b1e1","text":"Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses."},{"id":"23adccce-5fd4-4551-bd00-63d451d064c0","text":"Further study may strengthen qualifications, but it is a better fit only when it serves a genuine learning need."},{"id":"1549fddc-0434-4c4b-afec-b149ce3342bc","text":"Career guidance can provide informed advice about opportunities that may be worth exploring."}]},{"id":"36b02e31-cc89-49df-8f72-71a3a5ab608d","sentences":[{"id":"bc29b762-4c1a-4fc7-9fe8-31629384ede8","text":"Useful support should protect academic responsibilities while creating time for exploration."},{"id":"031853c7-dbea-473b-876b-24a29fb96863","text":"A choice made deliberately is more valuable than simply following the most fashionable route."},{"id":"d026c81c-555c-406a-ba2a-8c8b7ff2f7ce","text":"There is no universal answer, but clearer information and honest reflection can help students find a direction they can explain and sustain."}]}],"sentences":[{"id":"a0073d89-3ea0-4c09-ae0f-1a198cdf0975","text":"The survey asks what matters most in choosing a future path: interests lead at 48%, followed by development opportunities at 35% and starting income at 17%."},{"id":"c6d37f99-1880-4f48-97c8-17da85c3fe8e","text":"The pattern suggests that immediate pay is not the only concern as students prepare for employment."},{"id":"8a148d51-9e18-4cbf-9025-21b42b80274b","text":"Students must weigh the options in light of personal circumstances and incomplete knowledge of the changing workplace."},{"id":"2838c5ab-6625-4af0-82d7-cb5b3593b1e1","text":"Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses."},{"id":"23adccce-5fd4-4551-bd00-63d451d064c0","text":"Further study may strengthen qualifications, but it is a better fit only when it serves a genuine learning need."},{"id":"1549fddc-0434-4c4b-afec-b149ce3342bc","text":"Career guidance can provide informed advice about opportunities that may be worth exploring."},{"id":"bc29b762-4c1a-4fc7-9fe8-31629384ede8","text":"Useful support should protect academic responsibilities while creating time for exploration."},{"id":"031853c7-dbea-473b-876b-24a29fb96863","text":"A choice made deliberately is more valuable than simply following the most fashionable route."},{"id":"d026c81c-555c-406a-ba2a-8c8b7ff2f7ce","text":"There is no universal answer, but clearer information and honest reflection can help students find a direction they can explain and sustain."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    44,
    true
  ),
(
    '94930d76-65b4-4990-9abc-895b541b4f53'::uuid,
    (select id from collection),
    '健康信息怎样转为行动',
    'The chart distinguishes three abilities: 78% of residents can find health information, 56% can explain it and 34% can apply it to a decision. The pattern reveals a gap between access and use, although the abilities are related.

To access reliable information, people need more than an internet connection. They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations. Someone may know a recommendation yet remain unsure what it means in their particular circumstances. Practical guidance can then help them turn knowledge into action, including everyday decisions about disease prevention. Difficulty may result from unfamiliar terms rather than an unwillingness to learn.

Health education should therefore use plain language and familiar situations, asking residents to explain how advice applies to a concrete example. Such checks can reveal misunderstandings before information is mistaken for understanding. The goal is health literacy that supports informed action, not simply a larger flow of messages.',
    '{"id":"94930d76-65b4-4990-9abc-895b541b4f53","title":"健康信息怎样转为行动","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart distinguishes three abilities: 78% of residents can find health information, 56% can explain it and 34% can apply it to a decision. The pattern reveals a gap between access and use, although the abilities are related.\n\nTo access reliable information, people need more than an internet connection. They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations. Someone may know a recommendation yet remain unsure what it means in their particular circumstances. Practical guidance can then help them turn knowledge into action, including everyday decisions about disease prevention. Difficulty may result from unfamiliar terms rather than an unwillingness to learn.\n\nHealth education should therefore use plain language and familiar situations, asking residents to explain how advice applies to a concrete example. Such checks can reveal misunderstandings before information is mistaken for understanding. The goal is health literacy that supports informed action, not simply a larger flow of messages.","paragraphs":[{"id":"5a036e45-6643-496d-a7d2-286673aa9428","sentences":[{"id":"4134bc67-6a7f-4bc7-86cc-2c40e1bf6ef9","text":"The chart distinguishes three abilities: 78% of residents can find health information, 56% can explain it and 34% can apply it to a decision."},{"id":"d853cd0b-0ca1-4df3-93ed-715795ab193e","text":"The pattern reveals a gap between access and use, although the abilities are related."}]},{"id":"b8a8da31-17c3-4ff0-b626-f692e2504fff","sentences":[{"id":"afe4a050-ac51-4ad5-9023-fa42003ed520","text":"To access reliable information, people need more than an internet connection."},{"id":"9c988b68-6335-468f-ace3-1bf39d2a0993","text":"They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations."},{"id":"946616de-121b-44d0-bb37-b076bdaa8af3","text":"Someone may know a recommendation yet remain unsure what it means in their particular circumstances."},{"id":"c6c06063-068f-481c-91cf-ccde929a46b7","text":"Practical guidance can then help them turn knowledge into action, including everyday decisions about disease prevention."},{"id":"5f947172-477d-4a09-ad48-60cb67bf7164","text":"Difficulty may result from unfamiliar terms rather than an unwillingness to learn."}]},{"id":"bacdfa5e-a327-4116-9172-d8132ae3ba5e","sentences":[{"id":"e0b3e032-f729-46db-8868-b39c578ac752","text":"Health education should therefore use plain language and familiar situations, asking residents to explain how advice applies to a concrete example."},{"id":"e25397fa-a5e5-4074-806a-443f0a392067","text":"Such checks can reveal misunderstandings before information is mistaken for understanding."},{"id":"7d55f22d-806a-4e5c-abfc-4f684b8cacd3","text":"The goal is health literacy that supports informed action, not simply a larger flow of messages."}]}],"sentences":[{"id":"4134bc67-6a7f-4bc7-86cc-2c40e1bf6ef9","text":"The chart distinguishes three abilities: 78% of residents can find health information, 56% can explain it and 34% can apply it to a decision."},{"id":"d853cd0b-0ca1-4df3-93ed-715795ab193e","text":"The pattern reveals a gap between access and use, although the abilities are related."},{"id":"afe4a050-ac51-4ad5-9023-fa42003ed520","text":"To access reliable information, people need more than an internet connection."},{"id":"9c988b68-6335-468f-ace3-1bf39d2a0993","text":"They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations."},{"id":"946616de-121b-44d0-bb37-b076bdaa8af3","text":"Someone may know a recommendation yet remain unsure what it means in their particular circumstances."},{"id":"c6c06063-068f-481c-91cf-ccde929a46b7","text":"Practical guidance can then help them turn knowledge into action, including everyday decisions about disease prevention."},{"id":"5f947172-477d-4a09-ad48-60cb67bf7164","text":"Difficulty may result from unfamiliar terms rather than an unwillingness to learn."},{"id":"e0b3e032-f729-46db-8868-b39c578ac752","text":"Health education should therefore use plain language and familiar situations, asking residents to explain how advice applies to a concrete example."},{"id":"e25397fa-a5e5-4074-806a-443f0a392067","text":"Such checks can reveal misunderstandings before information is mistaken for understanding."},{"id":"7d55f22d-806a-4e5c-abfc-4f684b8cacd3","text":"The goal is health literacy that supports informed action, not simply a larger flow of messages."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    45,
    true
  ),
(
    '46d1cf0d-aca3-4777-8752-fc928fa8a615'::uuid,
    (select id from collection),
    '数字阅读中的自主选择',
    'A survey identifies interruptions as the main reading difficulty for 52% of students, followed by choosing materials at 29% and finding time at 19%. Digital resources are available, but availability alone does not guarantee independent learning in practice.

The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning. A reader without a clear purpose may also spend more time browsing than understanding. The problem may be related to habits formed around quick responses, rather than to the screen itself. Students need to access reliable information and make informed choices about both content and the way they use it.

A practical start is to reduce distractions, select one text and reserve a short period for concentrated reading. Reflecting on what was learned afterwards can make that choice more deliberate next time. The benefit of technology depends on purposeful use, not simply the number of articles opened or words displayed.',
    '{"id":"46d1cf0d-aca3-4777-8752-fc928fa8a615","title":"数字阅读中的自主选择","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"A survey identifies interruptions as the main reading difficulty for 52% of students, followed by choosing materials at 29% and finding time at 19%. Digital resources are available, but availability alone does not guarantee independent learning in practice.\n\nThe same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning. A reader without a clear purpose may also spend more time browsing than understanding. The problem may be related to habits formed around quick responses, rather than to the screen itself. Students need to access reliable information and make informed choices about both content and the way they use it.\n\nA practical start is to reduce distractions, select one text and reserve a short period for concentrated reading. Reflecting on what was learned afterwards can make that choice more deliberate next time. The benefit of technology depends on purposeful use, not simply the number of articles opened or words displayed.","paragraphs":[{"id":"f312853d-94cb-4feb-a013-d7d7e12cde64","sentences":[{"id":"5f6bee65-ba58-462c-bf78-a3d2dbfb508b","text":"A survey identifies interruptions as the main reading difficulty for 52% of students, followed by choosing materials at 29% and finding time at 19%."},{"id":"34af1a47-b56f-4009-bc26-c831a452972e","text":"Digital resources are available, but availability alone does not guarantee independent learning in practice."}]},{"id":"6f3b0220-3a2a-4d1b-b296-150e1e012415","sentences":[{"id":"6a5e3d29-e47f-4616-bdf0-a184fb1ab707","text":"The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning."},{"id":"35274d6c-a215-4a56-8679-29b9309c28d6","text":"A reader without a clear purpose may also spend more time browsing than understanding."},{"id":"eacdef5e-7cbc-4042-b88e-1c542f98ebf8","text":"The problem may be related to habits formed around quick responses, rather than to the screen itself."},{"id":"9b25f170-6492-4be2-9fc0-60264c14a828","text":"Students need to access reliable information and make informed choices about both content and the way they use it."}]},{"id":"11fb13c2-bc78-4ae5-ae06-d6a81b2e6fb0","sentences":[{"id":"d554d968-edd2-426c-9175-19bc834ec464","text":"A practical start is to reduce distractions, select one text and reserve a short period for concentrated reading."},{"id":"52c870e0-b12e-43d7-bc15-b8ecc1e02065","text":"Reflecting on what was learned afterwards can make that choice more deliberate next time."},{"id":"3468255d-58d8-4f9f-93a4-15f844f23f1a","text":"The benefit of technology depends on purposeful use, not simply the number of articles opened or words displayed."}]}],"sentences":[{"id":"5f6bee65-ba58-462c-bf78-a3d2dbfb508b","text":"A survey identifies interruptions as the main reading difficulty for 52% of students, followed by choosing materials at 29% and finding time at 19%."},{"id":"34af1a47-b56f-4009-bc26-c831a452972e","text":"Digital resources are available, but availability alone does not guarantee independent learning in practice."},{"id":"6a5e3d29-e47f-4616-bdf0-a184fb1ab707","text":"The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning."},{"id":"35274d6c-a215-4a56-8679-29b9309c28d6","text":"A reader without a clear purpose may also spend more time browsing than understanding."},{"id":"eacdef5e-7cbc-4042-b88e-1c542f98ebf8","text":"The problem may be related to habits formed around quick responses, rather than to the screen itself."},{"id":"9b25f170-6492-4be2-9fc0-60264c14a828","text":"Students need to access reliable information and make informed choices about both content and the way they use it."},{"id":"d554d968-edd2-426c-9175-19bc834ec464","text":"A practical start is to reduce distractions, select one text and reserve a short period for concentrated reading."},{"id":"52c870e0-b12e-43d7-bc15-b8ecc1e02065","text":"Reflecting on what was learned afterwards can make that choice more deliberate next time."},{"id":"3468255d-58d8-4f9f-93a4-15f844f23f1a","text":"The benefit of technology depends on purposeful use, not simply the number of articles opened or words displayed."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    46,
    true
  ),
(
    '55f5ba9e-8e81-4bfd-9432-e82ed8b4304f'::uuid,
    (select id from collection),
    '社区文化中心的多样参与',
    'The survey reports three main benefits of a cultural centre: learning at 65%, social contact at 58% and confidence at 41%. These overlapping gains suggest that meaningful participation can combine personal growth with a sense of belonging.

Accessible public spaces make it easier to meet neighbours, practise skills and maintain relationships. Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups. When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties. Yet a centre must respect personal choice if it hopes to meet diverse needs.

Clear information about times, costs and access can help less experienced residents decide where to begin. Flexible arrangements and shared responsibilities can help people contribute without feeling forced into identical routines. The best provision offers opportunities rather than prescriptions. Its value lies in enabling people to find activities and companionship that matter to them.',
    '{"id":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","title":"社区文化中心的多样参与","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The survey reports three main benefits of a cultural centre: learning at 65%, social contact at 58% and confidence at 41%. These overlapping gains suggest that meaningful participation can combine personal growth with a sense of belonging.\n\nAccessible public spaces make it easier to meet neighbours, practise skills and maintain relationships. Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups. When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties. Yet a centre must respect personal choice if it hopes to meet diverse needs.\n\nClear information about times, costs and access can help less experienced residents decide where to begin. Flexible arrangements and shared responsibilities can help people contribute without feeling forced into identical routines. The best provision offers opportunities rather than prescriptions. Its value lies in enabling people to find activities and companionship that matter to them.","paragraphs":[{"id":"845fc394-8b29-4d29-878c-fb36d06776ad","sentences":[{"id":"f6371998-3c70-4279-83b5-9821864661de","text":"The survey reports three main benefits of a cultural centre: learning at 65%, social contact at 58% and confidence at 41%."},{"id":"1b8355bc-70b2-4d54-a48c-c4fec12a3fc6","text":"These overlapping gains suggest that meaningful participation can combine personal growth with a sense of belonging."}]},{"id":"4df5e7fa-fdd2-4a34-9876-76efe8c7dba1","sentences":[{"id":"9c338162-f9a3-4e4d-90c4-e7e39b6039df","text":"Accessible public spaces make it easier to meet neighbours, practise skills and maintain relationships."},{"id":"80d73534-3124-482e-bf9e-6c11e09400b2","text":"Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups."},{"id":"cb92e036-dde7-4cf8-a927-8aac38656364","text":"When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties."},{"id":"31fc7372-cf85-4bef-a3e1-6a734bb78b88","text":"Yet a centre must respect personal choice if it hopes to meet diverse needs."}]},{"id":"27c9a428-0d4f-41d8-a451-edfc93e1918f","sentences":[{"id":"ab768098-fffb-44b8-b640-a8bad38cc58e","text":"Clear information about times, costs and access can help less experienced residents decide where to begin."},{"id":"043e4876-127a-4955-a63e-ab3dbbf27fca","text":"Flexible arrangements and shared responsibilities can help people contribute without feeling forced into identical routines."},{"id":"08633489-3e24-4556-b15a-f754d9ed551e","text":"The best provision offers opportunities rather than prescriptions."},{"id":"d9cf6774-ef55-4c85-88ab-743c1d3a6e66","text":"Its value lies in enabling people to find activities and companionship that matter to them."}]}],"sentences":[{"id":"f6371998-3c70-4279-83b5-9821864661de","text":"The survey reports three main benefits of a cultural centre: learning at 65%, social contact at 58% and confidence at 41%."},{"id":"1b8355bc-70b2-4d54-a48c-c4fec12a3fc6","text":"These overlapping gains suggest that meaningful participation can combine personal growth with a sense of belonging."},{"id":"9c338162-f9a3-4e4d-90c4-e7e39b6039df","text":"Accessible public spaces make it easier to meet neighbours, practise skills and maintain relationships."},{"id":"80d73534-3124-482e-bf9e-6c11e09400b2","text":"Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups."},{"id":"cb92e036-dde7-4cf8-a927-8aac38656364","text":"When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties."},{"id":"31fc7372-cf85-4bef-a3e1-6a734bb78b88","text":"Yet a centre must respect personal choice if it hopes to meet diverse needs."},{"id":"ab768098-fffb-44b8-b640-a8bad38cc58e","text":"Clear information about times, costs and access can help less experienced residents decide where to begin."},{"id":"043e4876-127a-4955-a63e-ab3dbbf27fca","text":"Flexible arrangements and shared responsibilities can help people contribute without feeling forced into identical routines."},{"id":"08633489-3e24-4556-b15a-f754d9ed551e","text":"The best provision offers opportunities rather than prescriptions."},{"id":"d9cf6774-ef55-4c85-88ab-743c1d3a6e66","text":"Its value lies in enabling people to find activities and companionship that matter to them."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    47,
    true
  ),
(
    '8703cbe6-ec03-4368-8967-1c45b1ca5703'::uuid,
    (select id from collection),
    '物流扩张的质量条件',
    'The chart shows county deliveries more than doubling from two million parcels in 2020 to five million in 2024, alongside growth in collection points from 40 to 85. The network can expand rapidly when access and demand reinforce each other.

Better transport links and reliable delivery help expand market access for both rural buyers and local producers. These benefits may be driven by local collection points that make distant sellers easier to reach. Public services must develop alongside trade if growth is to support balanced development.

Planning must balance competing needs for speed, decent working conditions and environmental protection. Environmental costs can rise when more parcels mean unnecessary journeys and excessive packaging. Local feedback can identify where collection hours or transport gaps make apparently available services difficult to use. Shared routes and reusable materials can improve resource efficiency without removing useful services. Continued progress should therefore concern lasting benefits, not volume alone.',
    '{"id":"8703cbe6-ec03-4368-8967-1c45b1ca5703","title":"物流扩张的质量条件","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows county deliveries more than doubling from two million parcels in 2020 to five million in 2024, alongside growth in collection points from 40 to 85. The network can expand rapidly when access and demand reinforce each other.\n\nBetter transport links and reliable delivery help expand market access for both rural buyers and local producers. These benefits may be driven by local collection points that make distant sellers easier to reach. Public services must develop alongside trade if growth is to support balanced development.\n\nPlanning must balance competing needs for speed, decent working conditions and environmental protection. Environmental costs can rise when more parcels mean unnecessary journeys and excessive packaging. Local feedback can identify where collection hours or transport gaps make apparently available services difficult to use. Shared routes and reusable materials can improve resource efficiency without removing useful services. Continued progress should therefore concern lasting benefits, not volume alone.","paragraphs":[{"id":"c9d1a7c6-164b-4537-b1c4-7a331df5e832","sentences":[{"id":"6f7b2187-0510-4dbf-89ba-131bb89c5780","text":"The chart shows county deliveries more than doubling from two million parcels in 2020 to five million in 2024, alongside growth in collection points from 40 to 85."},{"id":"9d6ff748-8780-494f-8db1-8052049aa410","text":"The network can expand rapidly when access and demand reinforce each other."}]},{"id":"7597641e-07b8-496e-a39f-1c25710c7acd","sentences":[{"id":"3ca7dc50-9047-4a73-9e34-3b3c6c03e873","text":"Better transport links and reliable delivery help expand market access for both rural buyers and local producers."},{"id":"6d3d02cf-11f8-4199-a476-5cfcdcf3fd65","text":"These benefits may be driven by local collection points that make distant sellers easier to reach."},{"id":"efe28f43-2d91-476b-b95b-4e1d74f4c9b9","text":"Public services must develop alongside trade if growth is to support balanced development."}]},{"id":"fb738181-393a-45ae-8a53-6692d1b952a7","sentences":[{"id":"b5d6d723-7c68-4f2e-b653-309cb5d39661","text":"Planning must balance competing needs for speed, decent working conditions and environmental protection."},{"id":"28aadd8b-7001-4fa8-ac8c-c678405aa7c1","text":"Environmental costs can rise when more parcels mean unnecessary journeys and excessive packaging."},{"id":"9e1493fa-fc35-48ea-bf72-471cb5a94f6b","text":"Local feedback can identify where collection hours or transport gaps make apparently available services difficult to use."},{"id":"a8b8a797-a675-4bc0-bc5d-e2d170f65ad2","text":"Shared routes and reusable materials can improve resource efficiency without removing useful services."},{"id":"b47487d1-ca72-4bb1-80c5-023451dba18c","text":"Continued progress should therefore concern lasting benefits, not volume alone."}]}],"sentences":[{"id":"6f7b2187-0510-4dbf-89ba-131bb89c5780","text":"The chart shows county deliveries more than doubling from two million parcels in 2020 to five million in 2024, alongside growth in collection points from 40 to 85."},{"id":"9d6ff748-8780-494f-8db1-8052049aa410","text":"The network can expand rapidly when access and demand reinforce each other."},{"id":"3ca7dc50-9047-4a73-9e34-3b3c6c03e873","text":"Better transport links and reliable delivery help expand market access for both rural buyers and local producers."},{"id":"6d3d02cf-11f8-4199-a476-5cfcdcf3fd65","text":"These benefits may be driven by local collection points that make distant sellers easier to reach."},{"id":"efe28f43-2d91-476b-b95b-4e1d74f4c9b9","text":"Public services must develop alongside trade if growth is to support balanced development."},{"id":"b5d6d723-7c68-4f2e-b653-309cb5d39661","text":"Planning must balance competing needs for speed, decent working conditions and environmental protection."},{"id":"28aadd8b-7001-4fa8-ac8c-c678405aa7c1","text":"Environmental costs can rise when more parcels mean unnecessary journeys and excessive packaging."},{"id":"9e1493fa-fc35-48ea-bf72-471cb5a94f6b","text":"Local feedback can identify where collection hours or transport gaps make apparently available services difficult to use."},{"id":"a8b8a797-a675-4bc0-bc5d-e2d170f65ad2","text":"Shared routes and reusable materials can improve resource efficiency without removing useful services."},{"id":"b47487d1-ca72-4bb1-80c5-023451dba18c","text":"Continued progress should therefore concern lasting benefits, not volume alone."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    48,
    true
  ),
(
    '4ab57fd9-5d91-43a1-a5e4-a8af331a4a32'::uuid,
    (select id from collection),
    '节日支出的变化与取舍',
    'The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018. Travel records a modest change from 20% to 22%, while meals rise from 25% to 28%. Other expenses take the remaining share in each year.

The pattern may reflect a reassessment of what makes a celebration worthwhile. A realistic budget asks people to distinguish thoughtful giving from purchases made simply to meet expectations. Spending less on gifts need not weaken relationships if shared time and care remain central.

A gift''s meaning depends on the relationship behind it, not merely its price. Small changes across categories can matter when a family has limited resources and several obligations to balance. In my view, festive spending is worthwhile when it respects family priorities without creating financial strain. The aim is a celebration people enjoy and can afford, with generosity expressed through attention as well as money.',
    '{"id":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","title":"节日支出的变化与取舍","createdAt":"2026-10-26T00:00:00.000Z","sourceText":"The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018. Travel records a modest change from 20% to 22%, while meals rise from 25% to 28%. Other expenses take the remaining share in each year.\n\nThe pattern may reflect a reassessment of what makes a celebration worthwhile. A realistic budget asks people to distinguish thoughtful giving from purchases made simply to meet expectations. Spending less on gifts need not weaken relationships if shared time and care remain central.\n\nA gift''s meaning depends on the relationship behind it, not merely its price. Small changes across categories can matter when a family has limited resources and several obligations to balance. In my view, festive spending is worthwhile when it respects family priorities without creating financial strain. The aim is a celebration people enjoy and can afford, with generosity expressed through attention as well as money.","paragraphs":[{"id":"c06ed312-54e1-4005-affd-d0385bf461ca","sentences":[{"id":"d8ac9324-a8b3-49cb-8571-0326814717e5","text":"The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018."},{"id":"4573c6fe-6606-4d18-bc97-d9c15a858548","text":"Travel records a modest change from 20% to 22%, while meals rise from 25% to 28%."},{"id":"8467a6dd-2415-42fa-b71b-2e5c36b13ee2","text":"Other expenses take the remaining share in each year."}]},{"id":"0c7056be-a068-42b6-a44d-7311394bbb55","sentences":[{"id":"d9462a94-b51d-4081-b47a-f908466fc59f","text":"The pattern may reflect a reassessment of what makes a celebration worthwhile."},{"id":"e6ec70f4-aaba-42f0-b46f-b7a19895abdd","text":"A realistic budget asks people to distinguish thoughtful giving from purchases made simply to meet expectations."},{"id":"5b107ab8-1c36-4069-be54-86fd607c8b16","text":"Spending less on gifts need not weaken relationships if shared time and care remain central."}]},{"id":"e5e052a2-11b1-4f4a-8d78-316e873fab17","sentences":[{"id":"9c1e79c8-f64e-4253-b570-e61d9f010075","text":"A gift''s meaning depends on the relationship behind it, not merely its price."},{"id":"a6490108-756b-47aa-99a1-8543ee172aee","text":"Small changes across categories can matter when a family has limited resources and several obligations to balance."},{"id":"93cdc3f0-57c6-4928-a06b-c1445948bee8","text":"In my view, festive spending is worthwhile when it respects family priorities without creating financial strain."},{"id":"f476d29e-55ed-4967-b64c-99f0036b4e2a","text":"The aim is a celebration people enjoy and can afford, with generosity expressed through attention as well as money."}]}],"sentences":[{"id":"d8ac9324-a8b3-49cb-8571-0326814717e5","text":"The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018."},{"id":"4573c6fe-6606-4d18-bc97-d9c15a858548","text":"Travel records a modest change from 20% to 22%, while meals rise from 25% to 28%."},{"id":"8467a6dd-2415-42fa-b71b-2e5c36b13ee2","text":"Other expenses take the remaining share in each year."},{"id":"d9462a94-b51d-4081-b47a-f908466fc59f","text":"The pattern may reflect a reassessment of what makes a celebration worthwhile."},{"id":"e6ec70f4-aaba-42f0-b46f-b7a19895abdd","text":"A realistic budget asks people to distinguish thoughtful giving from purchases made simply to meet expectations."},{"id":"5b107ab8-1c36-4069-be54-86fd607c8b16","text":"Spending less on gifts need not weaken relationships if shared time and care remain central."},{"id":"9c1e79c8-f64e-4253-b570-e61d9f010075","text":"A gift''s meaning depends on the relationship behind it, not merely its price."},{"id":"a6490108-756b-47aa-99a1-8543ee172aee","text":"Small changes across categories can matter when a family has limited resources and several obligations to balance."},{"id":"93cdc3f0-57c6-4928-a06b-c1445948bee8","text":"In my view, festive spending is worthwhile when it respects family priorities without creating financial strain."},{"id":"f476d29e-55ed-4967-b64c-99f0036b4e2a","text":"The aim is a celebration people enjoy and can afford, with generosity expressed through attention as well as money."}],"currentSentenceIndex":0,"origin":"system","systemGroup":"mock-large"}'::jsonb,
    49,
    true
  )
) as documents (
  id,
  collection_id,
  title,
  source_text,
  document_data,
  sort_order,
  is_published
)
on conflict (id) do update set
  collection_id = excluded.collection_id,
  title = excluded.title,
  source_text = excluded.source_text,
  document_data = excluded.document_data,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

insert into public.system_writing_items (
  id,
  item_type,
  item_data,
  sort_order,
  is_published
)
values
(
    'e1f6414a-da57-58f6-b628-0c3acd8d22c8'::uuid,
    'phrase',
    '{"id":"e1f6414a-da57-58f6-b628-0c3acd8d22c8","text":"warm hospitality","phraseType":"noun_phrase","meaning":"热情款待","optionalEnglishExplanation":"Kind and welcoming treatment of guests.","tags":["感谢、祝贺与友好回应"],"priority":"P1","usageNote":"用于接待后的感谢；hospitality通常不可数。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"62e71405-aeef-51a9-8eca-e0c0fda97284","sentenceText":"Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange.","translation":"你周到的安排与热情款待，让我在整个交流期间都感到受到欢迎。","evidence":{"surface":"warm hospitality","start":33,"end":49,"rule":"exact"},"exampleSentenceId":"c6953d57-74a1-4a6d-8369-44a566f22c0e"}],"type":"phrase"}'::jsonb,
    0,
    true
  ),
(
    'ac2a8f29-306d-5108-881a-fa6e9c63ca8e'::uuid,
    'phrase',
    '{"id":"ac2a8f29-306d-5108-881a-fa6e9c63ca8e","text":"thoughtful arrangements","phraseType":"noun_phrase","meaning":"周到的安排","optionalEnglishExplanation":"Plans made with care for other people''s needs.","tags":["感谢、祝贺与友好回应"],"priority":"P1","usageNote":"安排要与实际来访或活动对应。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"62e71405-aeef-51a9-8eca-e0c0fda97284","sentenceText":"Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange.","translation":"你周到的安排与热情款待，让我在整个交流期间都感到受到欢迎。","evidence":{"surface":"thoughtful arrangements","start":5,"end":28,"rule":"exact"},"exampleSentenceId":"c6953d57-74a1-4a6d-8369-44a566f22c0e"}],"type":"phrase"}'::jsonb,
    1,
    true
  ),
(
    '2bd71c9d-2b3a-5c51-af91-0ecd09a686d6'::uuid,
    'phrase',
    '{"id":"2bd71c9d-2b3a-5c51-af91-0ecd09a686d6","text":"return your kindness","phraseType":"verb_phrase","meaning":"回报你的好意","optionalEnglishExplanation":"Do something kind in response to another person''s help.","tags":["感谢、祝贺与友好回应"],"priority":"P1","usageNote":"by后接动名词，写明怎样回报。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"1dfa0010-3213-5f59-a6ce-cd2cffd88def","sentenceText":"It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food.","translation":"我很乐意带你游览我的城市，介绍我们的传统和当地食物，以回报你的好意。","evidence":{"surface":"return your kindness","start":26,"end":46,"rule":"exact"},"exampleSentenceId":"ff94728e-7931-4e8a-bc8f-862659a3a342"}],"type":"phrase"}'::jsonb,
    2,
    true
  ),
(
    '83b7eb50-b276-5e69-862c-d06c15de919e'::uuid,
    'phrase',
    '{"id":"83b7eb50-b276-5e69-862c-d06c15de919e","text":"feel at home","phraseType":"verb_phrase","meaning":"感到自在","optionalEnglishExplanation":"Feel comfortable and welcome in a place.","tags":["感谢、祝贺与友好回应"],"priority":"P1","usageNote":"make后接动词原形feel。","examples":[{"essayId":"4fc8d915-6628-58cf-bf99-ab8fc56c586b","sentenceId":"692a27e6-aaab-5211-8fba-21d6e1703718","sentenceText":"To help us feel at home, I thought I would introduce my daily habits.","translation":"为了让共同生活更自在，我想介绍自己的日常习惯。","evidence":{"surface":"feel at home","start":11,"end":23,"rule":"exact"}},{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"47d99545-4c97-4ec1-ad49-0b4255c84e60","sentenceText":"You helped me feel at home in conversations that had once seemed intimidating.","translation":"你帮助我在一度感到紧张的交谈中自在起来。","evidence":{"surface":"feel at home","start":14,"end":26,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    3,
    true
  ),
(
    'f34f98bf-662b-50a5-b1c8-c5a38e4fe488'::uuid,
    'phrase',
    '{"id":"f34f98bf-662b-50a5-b1c8-c5a38e4fe488","text":"pay off","phraseType":"verb_phrase","meaning":"取得回报","optionalEnglishExplanation":"Produce a worthwhile result after effort.","tags":["感谢、祝贺与友好回应"],"priority":"P1","usageNote":"作“努力见效”时通常不带宾语。","examples":[{"essayId":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","sentenceId":"b22ba0f0-c781-5bfd-8b9a-4d7f437874c7","sentenceText":"I know how much effort you have put into this goal, and I am delighted that it has paid off.","translation":"我知道你为这个目标付出了很多努力，很高兴努力得到了回报。","evidence":{"surface":"paid off","start":83,"end":91,"rule":"grammatical_variant"},"exampleSentenceId":"0a137474-c73e-4c9f-9069-e8a4b02d9652"}],"type":"phrase"}'::jsonb,
    4,
    true
  ),
(
    '374b1e79-d630-56ae-a533-12347203cca5'::uuid,
    'phrase',
    '{"id":"374b1e79-d630-56ae-a533-12347203cca5","text":"keep in touch","phraseType":"verb_phrase","meaning":"保持联系","optionalEnglishExplanation":"Continue communicating over time.","tags":["感谢、祝贺与友好回应"],"priority":"P1","usageNote":"用于熟人或交流伙伴的自然收尾。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"c0da20ae-3b41-565c-b52a-a194616eadc3","sentenceText":"Do keep in touch.","translation":"请保持联系。","evidence":{"surface":"keep in touch","start":3,"end":16,"rule":"exact"}},{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"2f36d950-3d2c-481b-adf4-3b8a7571d9aa","sentenceText":"I look forward to seeing you again; do keep in touch.","translation":"期待与你再见；请保持联系。","evidence":{"surface":"keep in touch","start":39,"end":52,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    5,
    true
  ),
(
    '0c2e8ac2-476a-53f0-ac70-ab5e9db88453'::uuid,
    'phrase',
    '{"id":"0c2e8ac2-476a-53f0-ac70-ab5e9db88453","text":"heartfelt thanks","phraseType":"noun_phrase","meaning":"衷心感谢","optionalEnglishExplanation":"Sincere and deeply felt gratitude.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"语气较郑重，一封短信不必重复使用。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"647bcf8a-dde5-480d-aea5-a08609cd023c","sentenceText":"Please accept my heartfelt thanks for your guidance.","translation":"请接受我对你指导的衷心感谢。","evidence":{"surface":"heartfelt thanks","start":17,"end":33,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    6,
    true
  ),
(
    'cf68f945-81e9-5c5a-b6d5-d08b3d1217ef'::uuid,
    'phrase',
    '{"id":"cf68f945-81e9-5c5a-b6d5-d08b3d1217ef","text":"make me feel welcome","phraseType":"verb_phrase","meaning":"让我感到受到欢迎","optionalEnglishExplanation":"Help someone feel accepted and included.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"时态随来访时间改变；例句用made。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"62e71405-aeef-51a9-8eca-e0c0fda97284","sentenceText":"Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange.","translation":"你周到的安排与热情款待，让我在整个交流期间都感到受到欢迎。","evidence":{"surface":"made me feel welcome","start":50,"end":70,"rule":"grammatical_variant"},"exampleSentenceId":"c6953d57-74a1-4a6d-8369-44a566f22c0e"}],"type":"phrase"}'::jsonb,
    7,
    true
  ),
(
    'd7fae502-9caa-5ae4-8f98-b0ae3a77b31a'::uuid,
    'phrase',
    '{"id":"d7fae502-9caa-5ae4-8f98-b0ae3a77b31a","text":"mean a great deal","phraseType":"verb_phrase","meaning":"意义重大","optionalEnglishExplanation":"Be very important or valuable to someone.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"常与to someone连用，说明对谁重要。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"d939e2f8-2cf5-4241-b391-6267de20d4fa","sentenceText":"Your advice meant a great deal: it helped me understand my options and decide what to do next.","translation":"你的建议意义重大，让我理解了可选道路，并决定下一步行动。","evidence":{"surface":"meant a great deal","start":12,"end":30,"rule":"grammatical_variant"},"exampleSentenceId":"5b25a37b-1f41-40ae-abe0-cf695cd51da2"},{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"93266ab7-f9cd-581e-ab55-14bc726fdaa1","sentenceText":"Such a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness.","translation":"如此难忘的经历意义重大：它让我理解了美国文化，也让我更珍惜你的好意。","evidence":{"surface":"meant a great deal","start":28,"end":46,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    8,
    true
  ),
(
    '1f6b400b-d2c1-5fc5-b10a-87ce115137e9'::uuid,
    'phrase',
    '{"id":"1f6b400b-d2c1-5fc5-b10a-87ce115137e9","text":"be admitted to","phraseType":"verb_phrase","meaning":"被……录取","optionalEnglishExplanation":"Be officially accepted as a student or member.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"on后用being admitted；不是admit to university表示录取。","examples":[{"essayId":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","sentenceId":"7acc0be6-8f8c-50b2-af2f-285aaa677a7e","sentenceText":"Congratulations on being admitted to university!","translation":"祝贺你被大学录取！","evidence":{"surface":"being admitted to","start":19,"end":36,"rule":"grammatical_variant"}},{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"a7bf933e-d4d1-4983-9b5f-feff6c200cb6","sentenceText":"I have now been admitted to university and hope you will share my excitement.","translation":"我已被大学录取，希望与你分享这份喜悦。","evidence":{"surface":"been admitted to","start":11,"end":27,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    9,
    true
  ),
(
    'be67de1b-031a-5bea-bac0-f68eedc527ce'::uuid,
    'phrase',
    '{"id":"be67de1b-031a-5bea-bac0-f68eedc527ce","text":"a well-deserved success","phraseType":"noun_phrase","meaning":"实至名归的成功","optionalEnglishExplanation":"An achievement earned through effort or ability.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"well-deserved作前置定语保留连字符。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"25638bbe-53df-472e-9986-438036cb43af","sentenceText":"You called this a well-deserved success, but your encouragement helped me put effort into the right things.","translation":"你说这是实至名归的成功，但正是你的鼓励帮助我把努力用在正确的事情上。","evidence":{"surface":"a well-deserved success","start":16,"end":39,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    10,
    true
  ),
(
    '6b82c9f9-a4fe-5f42-9b61-537eb4fa4e9a'::uuid,
    'phrase',
    '{"id":"6b82c9f9-a4fe-5f42-9b61-537eb4fa4e9a","text":"share your excitement","phraseType":"verb_phrase","meaning":"分享你的喜悦","optionalEnglishExplanation":"Feel pleased about another person''s good news.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"表示共鸣，不是宣称自己有相同经历。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"a7bf933e-d4d1-4983-9b5f-feff6c200cb6","sentenceText":"I have now been admitted to university and hope you will share my excitement.","translation":"我已被大学录取，希望与你分享这份喜悦。","evidence":{"surface":"share my excitement","start":57,"end":76,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    11,
    true
  ),
(
    '56e01487-8c6c-5ec4-a8d3-e39ee43ee34b'::uuid,
    'phrase',
    '{"id":"56e01487-8c6c-5ec4-a8d3-e39ee43ee34b","text":"a new beginning","phraseType":"noun_phrase","meaning":"新的开始","optionalEnglishExplanation":"The start of a fresh stage in life.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"适合入学、入职或迁居的祝愿。","examples":[{"essayId":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","sentenceId":"32410fb8-420d-551b-959c-3a4eb9fd894f","sentenceText":"You have earned a break, and I wish you a wonderful new beginning.","translation":"你值得好好休息，祝你迎来美好的新开始。","evidence":{"surface":"a wonderful new beginning","start":40,"end":65,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    12,
    true
  ),
(
    '5e42579b-ebfc-5a46-a603-e48c4d1f8207'::uuid,
    'phrase',
    '{"id":"5e42579b-ebfc-5a46-a603-e48c4d1f8207","text":"put effort into","phraseType":"verb_phrase","meaning":"为……投入努力","optionalEnglishExplanation":"Spend energy and care on a task.","tags":["感谢、祝贺与友好回应"],"priority":"P2","usageNote":"into后接名词或动名词。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"25638bbe-53df-472e-9986-438036cb43af","sentenceText":"You called this a well-deserved success, but your encouragement helped me put effort into the right things.","translation":"你说这是实至名归的成功，但正是你的鼓励帮助我把努力用在正确的事情上。","evidence":{"surface":"put effort into","start":74,"end":89,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    13,
    true
  ),
(
    '865a5329-bec2-57cb-899f-144735cf8036'::uuid,
    'phrase',
    '{"id":"865a5329-bec2-57cb-899f-144735cf8036","text":"make the most of","phraseType":"verb_phrase","meaning":"充分利用","optionalEnglishExplanation":"Use an opportunity as effectively as possible.","tags":["感谢、祝贺与友好回应"],"priority":"P3","usageNote":"the不可省；不等于要求参与所有活动。","examples":[{"essayId":"d3511bd1-6016-5a5b-9069-15a50765c276","sentenceId":"86da657e-7f92-5fc6-b512-7aaedcd724c2","sentenceText":"To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask.","translation":"为了充分利用此次参观，请提前阅读简短介绍，记下想提的问题。","evidence":{"surface":"make the most of","start":3,"end":19,"rule":"exact"},"exampleSentenceId":"4b6aa3b8-61d8-47fe-9baa-b826909fbe5e"}],"type":"phrase"}'::jsonb,
    14,
    true
  ),
(
    'b03699d0-6fb7-5f28-85ef-a32361b60d44'::uuid,
    'phrase',
    '{"id":"b03699d0-6fb7-5f28-85ef-a32361b60d44","text":"a memorable experience","phraseType":"noun_phrase","meaning":"难忘的经历","optionalEnglishExplanation":"An experience that is likely to be remembered.","tags":["感谢、祝贺与友好回应"],"priority":"P3","usageNote":"用具体交流支撑memorable，避免只堆形容词。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"93266ab7-f9cd-581e-ab55-14bc726fdaa1","sentenceText":"Such a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness.","translation":"如此难忘的经历意义重大：它让我理解了美国文化，也让我更珍惜你的好意。","evidence":{"surface":"a memorable experience","start":5,"end":27,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    15,
    true
  ),
(
    '10ed0afb-bc5b-5dac-ad34-a6088d7f3095'::uuid,
    'phrase',
    '{"id":"10ed0afb-bc5b-5dac-ad34-a6088d7f3095","text":"bring ... to life","phraseType":"verb_phrase","meaning":"使一个主题鲜活起来","optionalEnglishExplanation":"Make a subject vivid and engaging.","tags":["感谢、祝贺与友好回应"],"priority":"P3","usageNote":"例句将a subject替换为local history。 subject为对象槽位，可替换成文化、历史或故事。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"55067b35-a6b9-5bd0-b1a5-f8cbaa077275","sentenceText":"They brought American culture to life in a way that books never could.","translation":"这些交流让美国文化变得鲜活，这是书本无法做到的。","evidence":{"surface":"brought American culture to life","start":5,"end":37,"rule":"object_slot"}},{"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"49d71a88-631d-51ef-839c-c6eb7ef8c9e6","sentenceText":"I hope we can bring this story to life together.","translation":"希望我们一起把故事生动呈现出来。","evidence":{"surface":"bring this story to life","start":14,"end":38,"rule":"object_slot"}}],"type":"phrase"}'::jsonb,
    16,
    true
  ),
(
    '78933ce3-ea94-56e5-92f2-21463caab6e8'::uuid,
    'phrase',
    '{"id":"78933ce3-ea94-56e5-92f2-21463caab6e8","text":"when time permits","phraseType":"other_phrase","meaning":"在时间允许时","optionalEnglishExplanation":"When there is enough time available.","tags":["感谢、祝贺与友好回应"],"priority":"P3","usageNote":"when从句不用再加will。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"1e55b317-6a9c-5113-81dc-7c55e7fa0a88","sentenceText":"I hope you will visit China when time permits.","translation":"希望你在时间允许时来中国。","evidence":{"surface":"when time permits","start":28,"end":45,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    17,
    true
  ),
(
    'a28f0052-6203-5a60-bb4d-8416eff1160c'::uuid,
    'phrase',
    '{"id":"a28f0052-6203-5a60-bb4d-8416eff1160c","text":"in return","phraseType":"other_phrase","meaning":"作为回报","optionalEnglishExplanation":"As a response to something received.","tags":["感谢、祝贺与友好回应"],"priority":"P3","usageNote":"通常承接前文已说明的帮助。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"fba610a8-5bad-4587-a2f2-a97947bd9c33","sentenceText":"In return, I would love to welcome you to China and introduce you to my city.","translation":"作为回报，我很愿意欢迎你来中国，带你了解我的城市。","evidence":{"surface":"In return","start":0,"end":9,"rule":"exact"},"exampleSentenceId":"27c0b5a5-eb4e-47df-954b-ef8b5b55e074"}],"type":"phrase"}'::jsonb,
    18,
    true
  ),
(
    '94813a7f-b4f7-56f9-a4bf-663f30b4c10d'::uuid,
    'phrase',
    '{"id":"94813a7f-b4f7-56f9-a4bf-663f30b4c10d","text":"look forward to","phraseType":"verb_phrase","meaning":"期待","optionalEnglishExplanation":"Feel pleased about something expected in the future.","tags":["感谢、祝贺与友好回应"],"priority":"P3","usageNote":"to是介词，后接名词或动名词。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"feb510a7-64f6-5d43-9ae9-0024e154b962","sentenceText":"I look forward to your prompt reply.","translation":"期待及时回复。","evidence":{"surface":"look forward to","start":2,"end":17,"rule":"exact"}},{"essayId":"4fc8d915-6628-58cf-bf99-ab8fc56c586b","sentenceId":"f82a2b10-4c09-5b38-b3e7-4ec73275a83e","sentenceText":"I am looking forward to sharing an apartment with you.","translation":"我期待与你合租公寓。","evidence":{"surface":"looking forward to","start":5,"end":23,"rule":"grammatical_variant"}},{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"7b037ee4-f489-5050-b2b8-ebc8a08bd7dc","sentenceText":"I look forward to your reply.","translation":"期待您的回复。","evidence":{"surface":"look forward to","start":2,"end":17,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    19,
    true
  ),
(
    '46c463ee-b249-5484-8a37-9afb45347a48'::uuid,
    'phrase',
    '{"id":"46c463ee-b249-5484-8a37-9afb45347a48","text":"take part in","phraseType":"verb_phrase","meaning":"参加","optionalEnglishExplanation":"Participate in an activity.","tags":["邀请、活动与内容介绍"],"priority":"P1","usageNote":"in后接具体活动；与加入群体的join区分。","examples":[{"essayId":"62a45036-d5ec-5bc9-a8a7-f8484bba7b13","sentenceId":"da7e0a7a-1159-57a6-b198-f3ccb74caf08","sentenceText":"Our class is holding a charity sale to support children in need, and I warmly invite you to take part in the event.","translation":"我们班将举办义卖，支持有需要的儿童，诚邀大家参加。","evidence":{"surface":"take part in","start":92,"end":104,"rule":"exact"},"exampleSentenceId":"b0cde08f-e977-45d1-8352-27c6fc9a0d86"},{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"1a1dfc55-a08e-4012-9d23-e4fd7560ecad","sentenceText":"Anyone willing to take part in these tasks is welcome to apply.","translation":"欢迎愿意参与这些工作的人申请。","evidence":{"surface":"take part in","start":18,"end":30,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    20,
    true
  ),
(
    'f3faa02a-e2a7-5b82-b6bf-9d5677d726e6'::uuid,
    'phrase',
    '{"id":"f3faa02a-e2a7-5b82-b6bf-9d5677d726e6","text":"be scheduled for","phraseType":"verb_phrase","meaning":"定于……举行","optionalEnglishExplanation":"Be arranged to happen at a stated time.","tags":["邀请、活动与内容介绍"],"priority":"P1","usageNote":"时间在for后；地点另用in、at或online。","examples":[{"essayId":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","sentenceId":"44653e67-eb34-5c3f-8ad3-bc8f5a0ea7ad","sentenceText":"I would like to invite you to an online meeting on adapting to university life, scheduled for 3 p.m. next Saturday.","translation":"我想邀请你参加下周六下午三点举行的线上会议，主题是适应大学生活。","evidence":{"surface":"scheduled for","start":80,"end":93,"rule":"grammatical_variant"},"exampleSentenceId":"f95d823b-c758-4568-98fa-5990877615db"}],"type":"phrase"}'::jsonb,
    21,
    true
  ),
(
    'efe2d51e-1584-5b70-a55b-bd42b274e24b'::uuid,
    'phrase',
    '{"id":"efe2d51e-1584-5b70-a55b-bd42b274e24b","text":"bring ... together","phraseType":"verb_phrase","meaning":"让人们相聚交流","optionalEnglishExplanation":"Create an opportunity for people to meet and interact.","tags":["邀请、活动与内容介绍"],"priority":"P1","usageNote":"to do说明聚在一起的目的。 宾语是可替换槽位，原句可用people、students或generations。","examples":[{"essayId":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","sentenceId":"5bb7775a-70e4-50eb-93a7-4299b3b32ffd","sentenceText":"I will begin with preparations such as cleaning homes and decorating doors, then explain how the reunion dinner brings generations together.","translation":"我会先介绍打扫房屋、装饰门面等准备，再解释团圆饭怎样让几代人相聚。","evidence":{"surface":"brings generations together","start":112,"end":139,"rule":"object_slot"}}],"type":"phrase"}'::jsonb,
    22,
    true
  ),
(
    'c3d1cefd-3bdf-50d0-be57-e915635946bb'::uuid,
    'phrase',
    '{"id":"c3d1cefd-3bdf-50d0-be57-e915635946bb","text":"join the cast","phraseType":"verb_phrase","meaning":"加入演员阵容","optionalEnglishExplanation":"Become one of the performers in a play or film.","tags":["邀请、活动与内容介绍"],"priority":"P1","usageNote":"表示参演；不是邀请当观众。","examples":[{"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"3a888f5b-e082-5c2c-a360-4d4c65068f8b","sentenceText":"I am putting together a short play based on Journey to the West and would love you to join the cast.","translation":"我正在筹备一部根据《西游记》改编的短剧，很希望你加入演员阵容。","evidence":{"surface":"join the cast","start":86,"end":99,"rule":"exact"},"exampleSentenceId":"c84522a5-7a3c-441e-ba66-cd72c97570ea"}],"type":"phrase"}'::jsonb,
    23,
    true
  ),
(
    '94d3eb47-4db3-5eac-84dd-47ac30eff02d'::uuid,
    'phrase',
    '{"id":"94d3eb47-4db3-5eac-84dd-47ac30eff02d","text":"confirm your attendance","phraseType":"verb_phrase","meaning":"确认参加","optionalEnglishExplanation":"State definitely that you will attend.","tags":["邀请、活动与内容介绍"],"priority":"P1","usageNote":"只在需要统计人数时提出截止要求。","examples":[{"essayId":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","sentenceId":"ee50b616-82de-5bbb-8780-8f430a1d0f71","sentenceText":"Please confirm your attendance by Thursday.","translation":"请于周四前确认参加。","evidence":{"surface":"confirm your attendance","start":7,"end":30,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    24,
    true
  ),
(
    '3e391bbb-6502-59c6-b0a0-f1f415f348a2'::uuid,
    'phrase',
    '{"id":"3e391bbb-6502-59c6-b0a0-f1f415f348a2","text":"in advance","phraseType":"other_phrase","meaning":"提前","optionalEnglishExplanation":"Before the time when something happens.","tags":["邀请、活动与内容介绍"],"priority":"P1","usageNote":"可修饰发送、准备、预订等动作。","examples":[{"essayId":"d3511bd1-6016-5a5b-9069-15a50765c276","sentenceId":"86da657e-7f92-5fc6-b512-7aaedcd724c2","sentenceText":"To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask.","translation":"为了充分利用此次参观，请提前阅读简短介绍，记下想提的问题。","evidence":{"surface":"in advance","start":64,"end":74,"rule":"exact"},"exampleSentenceId":"4b6aa3b8-61d8-47fe-9baa-b826909fbe5e"},{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"5367847f-e861-4fd2-b6c7-2dc68205a845","sentenceText":"I would still greatly value the opportunity to discuss my research with you, and will prepare a short outline in advance.","translation":"我仍十分珍惜与您讨论研究的机会，并会提前准备简短提纲。","evidence":{"surface":"in advance","start":110,"end":120,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    25,
    true
  ),
(
    '4c5c207b-a6b0-55b6-866c-1c16da37e28a'::uuid,
    'phrase',
    '{"id":"4c5c207b-a6b0-55b6-866c-1c16da37e28a","text":"serve as a platform","phraseType":"verb_phrase","meaning":"作为交流平台","optionalEnglishExplanation":"Provide a setting for an activity or exchange.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"后接for群体或主题，不可只说platform而无内容。","examples":[{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"a5365aee-f281-4f0b-a396-f52f0a6fbf84","sentenceText":"Our cultural presentation day will serve as a platform for students to exchange stories and practise public speaking.","translation":"文化展示日将为学生交流故事、练习公众表达提供平台。","evidence":{"surface":"serve as a platform","start":35,"end":54,"rule":"exact"},"exampleSentenceId":"804a54a6-3c3f-46df-af66-ef75c2850e35"}],"type":"phrase"}'::jsonb,
    26,
    true
  ),
(
    '4ac41871-0df8-5a52-95a3-3d8c0275c3b1'::uuid,
    'phrase',
    '{"id":"4ac41871-0df8-5a52-95a3-3d8c0275c3b1","text":"a hands-on activity","phraseType":"noun_phrase","meaning":"亲身操作的活动","optionalEnglishExplanation":"An activity involving direct practical participation.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"an activity可数；hands-on修饰名词。","examples":[{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"02a59bce-b129-4048-9d26-8e9cc53e673f","sentenceText":"After brief opening remarks, a hands-on activity will help participants prepare short presentations.","translation":"简短开场后，一项实践活动将帮助参与者准备短篇展示。","evidence":{"surface":"a hands-on activity","start":29,"end":48,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    27,
    true
  ),
(
    '813f036f-e015-5ec3-8cd2-00b31cfbbc20'::uuid,
    'phrase',
    '{"id":"813f036f-e015-5ec3-8cd2-00b31cfbbc20","text":"sample regional dishes","phraseType":"verb_phrase","meaning":"品尝地方菜肴","optionalEnglishExplanation":"Taste food from different regions.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"sample作动词，不是样品的意思。","examples":[{"essayId":"45e8079a-3dfa-5a72-8e7c-718cf9283b2f","sentenceId":"a9858830-a126-58c9-93bd-6b96cf820bd5","sentenceText":"You can sample regional dishes, hear the stories behind them and watch a dumpling-making demonstration.","translation":"你们可以品尝地方菜肴、了解背后故事，并观看包饺子示范。","evidence":{"surface":"sample regional dishes","start":8,"end":30,"rule":"exact"},"exampleSentenceId":"4d33437a-7d51-4c0c-adbd-aff209d9f276"}],"type":"phrase"}'::jsonb,
    28,
    true
  ),
(
    '56aa5fac-34ec-562f-9b35-65a53f94c4c8'::uuid,
    'phrase',
    '{"id":"56aa5fac-34ec-562f-9b35-65a53f94c4c8","text":"be based on","phraseType":"verb_phrase","meaning":"根据……改编或建立","optionalEnglishExplanation":"Use something as a starting point or source.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"作品名可自选，但介绍要与所选作品一致。","examples":[{"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"3a888f5b-e082-5c2c-a360-4d4c65068f8b","sentenceText":"I am putting together a short play based on Journey to the West and would love you to join the cast.","translation":"我正在筹备一部根据《西游记》改编的短剧，很希望你加入演员阵容。","evidence":{"surface":"based on","start":35,"end":43,"rule":"grammatical_variant"},"exampleSentenceId":"c84522a5-7a3c-441e-ba66-cd72c97570ea"}],"type":"phrase"}'::jsonb,
    29,
    true
  ),
(
    'cb631c67-70fc-5f4f-a029-ecbc2ec37e5b'::uuid,
    'phrase',
    '{"id":"cb631c67-70fc-5f4f-a029-ecbc2ec37e5b","text":"focus on","phraseType":"verb_phrase","meaning":"聚焦","optionalEnglishExplanation":"Give particular attention to a topic.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"on后接名词或动名词。","examples":[{"essayId":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","sentenceId":"92cd6d91-5f4c-5f02-a1fc-0cdc8d7860c2","sentenceText":"My presentation will focus on the Spring Festival and the meaning of family reunion.","translation":"演讲将聚焦春节及家庭团聚的意义。","evidence":{"surface":"focus on","start":21,"end":29,"rule":"exact"},"exampleSentenceId":"3f05271c-d814-4ef3-a12f-33b89d0bc110"}],"type":"phrase"}'::jsonb,
    30,
    true
  ),
(
    'ee724147-ce08-5d88-82f2-9e9a9c7e3b22'::uuid,
    'phrase',
    '{"id":"ee724147-ce08-5d88-82f2-9e9a9c7e3b22","text":"cultural references","phraseType":"noun_phrase","meaning":"文化背景信息","optionalEnglishExplanation":"Ideas or details that depend on cultural knowledge.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"适合文化介绍与改编，不等于参考文献。","examples":[{"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"29b8cfc1-ad38-570d-9ad2-fcee8f4c5f97","sentenceText":"I will explain the cultural references and help everyone learn their lines.","translation":"我会解释文化背景，帮助大家熟悉台词。","evidence":{"surface":"cultural references","start":19,"end":38,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    31,
    true
  ),
(
    '6a579dbb-8b90-5c28-bbfb-1344a0ec1042'::uuid,
    'phrase',
    '{"id":"6a579dbb-8b90-5c28-bbfb-1344a0ec1042","text":"rehearse together","phraseType":"verb_phrase","meaning":"共同排练","optionalEnglishExplanation":"Practise a performance as a group.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"rehearse用于演出排练，不泛指所有学习。","examples":[{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"b669c362-ceae-4a55-aaae-17821685e46c","sentenceText":"Students will rehearse together before presenting, and each talk will include a question-and-answer session.","translation":"学生将先共同排练再展示，每次发言还设问答环节。","evidence":{"surface":"rehearse together","start":14,"end":31,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    32,
    true
  ),
(
    '8a14b879-af97-5013-bdc0-6108f42dc8b6'::uuid,
    'phrase',
    '{"id":"8a14b879-af97-5013-bdc0-6108f42dc8b6","text":"learn your lines","phraseType":"verb_phrase","meaning":"熟悉台词","optionalEnglishExplanation":"Memorize and practise the words of a role.","tags":["邀请、活动与内容介绍"],"priority":"P2","usageNote":"your随演员人称调整。","examples":[{"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"29b8cfc1-ad38-570d-9ad2-fcee8f4c5f97","sentenceText":"I will explain the cultural references and help everyone learn their lines.","translation":"我会解释文化背景，帮助大家熟悉台词。","evidence":{"surface":"learn their lines","start":57,"end":74,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    33,
    true
  ),
(
    '9fc7c403-c67f-552a-b772-3825b15cb7d4'::uuid,
    'phrase',
    '{"id":"9fc7c403-c67f-552a-b772-3825b15cb7d4","text":"opening remarks","phraseType":"noun_phrase","meaning":"开场致辞","optionalEnglishExplanation":"Short introductory comments at an event.","tags":["邀请、活动与内容介绍"],"priority":"P3","usageNote":"remarks通常用复数，勿与双方开篇辩词混同。","examples":[{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"02a59bce-b129-4048-9d26-8e9cc53e673f","sentenceText":"After brief opening remarks, a hands-on activity will help participants prepare short presentations.","translation":"简短开场后，一项实践活动将帮助参与者准备短篇展示。","evidence":{"surface":"opening remarks","start":12,"end":27,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    34,
    true
  ),
(
    '050d78e2-cc33-5f27-8558-373111a1c01c'::uuid,
    'phrase',
    '{"id":"050d78e2-cc33-5f27-8558-373111a1c01c","text":"a question-and-answer session","phraseType":"noun_phrase","meaning":"问答环节","optionalEnglishExplanation":"A period when people ask and answer questions.","tags":["邀请、活动与内容介绍"],"priority":"P3","usageNote":"a session可数；适用于讲座或会议。","examples":[{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"b669c362-ceae-4a55-aaae-17821685e46c","sentenceText":"Students will rehearse together before presenting, and each talk will include a question-and-answer session.","translation":"学生将先共同排练再展示，每次发言还设问答环节。","evidence":{"surface":"a question-and-answer session","start":78,"end":107,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    35,
    true
  ),
(
    'caaa22dd-ea4b-5ea6-8d22-196d39e2b4a9'::uuid,
    'phrase',
    '{"id":"caaa22dd-ea4b-5ea6-8d22-196d39e2b4a9","text":"volunteer duties","phraseType":"noun_phrase","meaning":"志愿者职责","optionalEnglishExplanation":"Tasks assigned to people offering unpaid help.","tags":["邀请、活动与内容介绍"],"priority":"P3","usageNote":"duties需与活动匹配。","examples":[{"essayId":"86a1454d-7ea6-50ee-a9f9-11987ad1638d","sentenceId":"6f72159c-3c46-5d2a-90e7-1aade4bb0429","sentenceText":"Volunteer duties will include welcoming students, leading tours and assisting with activities.","translation":"志愿者职责包括迎接学生、带领参观并协助活动。","evidence":{"surface":"Volunteer duties","start":0,"end":16,"rule":"exact"},"exampleSentenceId":"c1a66c0f-f639-4ddf-a1db-08c793e4e899"}],"type":"phrase"}'::jsonb,
    36,
    true
  ),
(
    'fbde8b0d-5537-5352-8fab-4cb10d542af1'::uuid,
    'phrase',
    '{"id":"fbde8b0d-5537-5352-8fab-4cb10d542af1","text":"available throughout","phraseType":"other_phrase","meaning":"全程有空或可到岗","optionalEnglishExplanation":"Able to participate for an entire period.","tags":["邀请、活动与内容介绍"],"priority":"P3","usageNote":"throughout后接时段。","examples":[{"essayId":"86a1454d-7ea6-50ee-a9f9-11987ad1638d","sentenceId":"e51a8333-2c0c-5fb2-80a5-7d3efcee6228","sentenceText":"Applicants should be responsible, approachable and available throughout the camp.","translation":"申请者应有责任心、容易亲近，且整个营期都能到岗。","evidence":{"surface":"available throughout","start":51,"end":71,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    37,
    true
  ),
(
    '80bba3fc-d4b5-5a0b-983e-4703e5039280'::uuid,
    'phrase',
    '{"id":"80bba3fc-d4b5-5a0b-983e-4703e5039280","text":"submit an application","phraseType":"verb_phrase","meaning":"提交申请","optionalEnglishExplanation":"Send a formal request to take part.","tags":["邀请、活动与内容介绍"],"priority":"P3","usageNote":"报名期限必须早于活动开始。","examples":[{"essayId":"86a1454d-7ea6-50ee-a9f9-11987ad1638d","sentenceId":"f560fe9c-6794-5bf1-b468-7fc691d4f5ec","sentenceText":"Please submit an application with a brief introduction and your contact details to the Students’ Union by June 10.","translation":"请于六月十日前向学生会提交申请，附简短介绍与联系方式。","evidence":{"surface":"submit an application","start":7,"end":28,"rule":"exact"},"exampleSentenceId":"ff397db8-883a-4644-98a3-eb7d67ea729c"}],"type":"phrase"}'::jsonb,
    38,
    true
  ),
(
    '28f110fc-a7c9-5215-b3b7-6e6429028a82'::uuid,
    'phrase',
    '{"id":"28f110fc-a7c9-5215-b3b7-6e6429028a82","text":"a welcoming atmosphere","phraseType":"noun_phrase","meaning":"友好的氛围","optionalEnglishExplanation":"A setting in which people feel accepted and comfortable.","tags":["邀请、活动与内容介绍"],"priority":"P3","usageNote":"最好说明具体做法，不让atmosphere成为空话。","examples":[{"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"384dd920-a125-4566-93b9-a0b2e558e3e9","sentenceText":"Volunteers will welcome visitors, organize materials and create a welcoming atmosphere.","translation":"志愿者将迎接来访者、整理材料并营造友好氛围。","evidence":{"surface":"a welcoming atmosphere","start":64,"end":86,"rule":"exact"},"exampleSentenceId":"0ab52c8a-2d77-4ca3-bb49-8963520a7543"}],"type":"phrase"}'::jsonb,
    39,
    true
  ),
(
    '5ac50bd1-cf77-5dad-838c-d3973e4372e4'::uuid,
    'phrase',
    '{"id":"5ac50bd1-cf77-5dad-838c-d3973e4372e4","text":"a good command of","phraseType":"noun_phrase","meaning":"熟练掌握","optionalEnglishExplanation":"Strong knowledge of and ability to use a language or skill.","tags":["建议、推荐与方法"],"priority":"P1","usageNote":"of后填语言或技能，不加动词原形。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"07cdf405-cb94-5325-bf99-658f26bcfa77","sentenceText":"First, develop a good command of both languages through regular reading.","translation":"首先，通过经常阅读，熟练掌握两种语言。","evidence":{"surface":"a good command of","start":15,"end":32,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    40,
    true
  ),
(
    '2358ed92-7a0e-5088-939e-e0efc385ad8c'::uuid,
    'phrase',
    '{"id":"2358ed92-7a0e-5088-939e-e0efc385ad8c","text":"compare versions","phraseType":"verb_phrase","meaning":"比较不同版本","optionalEnglishExplanation":"Examine different versions to identify similarities and differences.","tags":["建议、推荐与方法"],"priority":"P1","usageNote":"比较的重点应明确，不只是机械对答案。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"b358ec2e-8a1c-4c98-a23c-abc65016d74e","sentenceText":"Break a difficult task into steps: understand the passage, draft your translation and compare versions of the same passage.","translation":"把困难任务拆成几步：理解文章、起草译文、比较不同版本。","evidence":{"surface":"compare versions","start":86,"end":102,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    41,
    true
  ),
(
    'c37f4276-0c34-567b-9d7f-b062ea42e9a7'::uuid,
    'phrase',
    '{"id":"c37f4276-0c34-567b-9d7f-b062ea42e9a7","text":"keep a record of","phraseType":"verb_phrase","meaning":"记录","optionalEnglishExplanation":"Write down information so that it can be used later.","tags":["建议、推荐与方法"],"priority":"P1","usageNote":"of后接名词；record在这里是名词。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"28737ac6-9c4e-52da-b636-2a7fc394845a","sentenceText":"Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding.","translation":"记录有用表达和反复出现的错误，让每次练习更有收获。","evidence":{"surface":"Keep a record of","start":0,"end":16,"rule":"exact"},"exampleSentenceId":"7ccce385-9a10-4134-88b0-ee379a1765cf"},{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"ee3f95a8-05f8-507c-b207-b765ef09ab02","sentenceText":"We could first select several streets and keep a record of signs of damage or restoration, taking photographs with permission.","translation":"我们可以先选几条街，记录损坏或修复迹象，并经允许拍照。","evidence":{"surface":"keep a record of","start":42,"end":58,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    42,
    true
  ),
(
    '049411b9-bce9-59f3-8b4d-d6200cc3de39'::uuid,
    'phrase',
    '{"id":"049411b9-bce9-59f3-8b4d-d6200cc3de39","text":"put ... into practice","phraseType":"verb_phrase","meaning":"付诸实践","optionalEnglishExplanation":"Use an idea or skill in real activity.","tags":["建议、推荐与方法"],"priority":"P1","usageNote":"宾语可置于put与into practice之间。 允许put与into之间出现it、knowledge或what you learn等宾语。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"7fcb6aca-954f-4403-9e70-92d73c395a65","sentenceText":"Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise.","translation":"寻求有实际帮助的反馈来发现薄弱处，再把所学用于下一次练习。","evidence":{"surface":"put what you learn into practice","start":59,"end":91,"rule":"object_slot"},"exampleSentenceId":"c1219933-0b3a-4ce7-918b-2fdf62eadb75"},{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"600333e6-13b6-41ff-aaf3-c2da287255ee","sentenceText":"Learning by doing can bridge the gap between knowing an idea and putting it into practice.","translation":"在做中学可弥合了解一个想法与将其付诸实践的差距。","evidence":{"surface":"putting it into practice","start":65,"end":89,"rule":"object_slot"}}],"type":"phrase"}'::jsonb,
    43,
    true
  ),
(
    '94514fb7-a4aa-5a1c-8b3b-0a1bfc02cbb0'::uuid,
    'phrase',
    '{"id":"94514fb7-a4aa-5a1c-8b3b-0a1bfc02cbb0","text":"identify your weaknesses","phraseType":"verb_phrase","meaning":"发现自己的薄弱处","optionalEnglishExplanation":"Recognize areas in which improvement is needed.","tags":["建议、推荐与方法"],"priority":"P1","usageNote":"弱点应通过反馈确定，不先给对方贴标签。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"7fcb6aca-954f-4403-9e70-92d73c395a65","sentenceText":"Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise.","translation":"寻求有实际帮助的反馈来发现薄弱处，再把所学用于下一次练习。","evidence":{"surface":"identify your weaknesses","start":28,"end":52,"rule":"exact"},"exampleSentenceId":"c1219933-0b3a-4ce7-918b-2fdf62eadb75"},{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"2838c5ab-6625-4af0-82d7-cb5b3593b1e1","sentenceText":"Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses.","translation":"实践岗位可拓宽他们的视野，帮助评估个人优势并发现薄弱处。","evidence":{"surface":"identify their weaknesses","start":92,"end":117,"rule":"grammatical_variant"},"exampleSentenceId":"dbeb8394-61cd-458a-9e52-0708a77f8924"}],"type":"phrase"}'::jsonb,
    44,
    true
  ),
(
    'f373fe9a-3f0f-562c-b188-9ff13ee623f6'::uuid,
    'phrase',
    '{"id":"f373fe9a-3f0f-562c-b188-9ff13ee623f6","text":"break ... into steps","phraseType":"verb_phrase","meaning":"拆分成步骤","optionalEnglishExplanation":"Divide a task into smaller stages.","tags":["建议、推荐与方法"],"priority":"P1","usageNote":"break后宾语置于into之前。 break与into之间须有任务宾语，steps前可有manageable修饰。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"b358ec2e-8a1c-4c98-a23c-abc65016d74e","sentenceText":"Break a difficult task into steps: understand the passage, draft your translation and compare versions of the same passage.","translation":"把困难任务拆成几步：理解文章、起草译文、比较不同版本。","evidence":{"surface":"Break a difficult task into steps","start":0,"end":33,"rule":"object_slot"}}],"type":"phrase"}'::jsonb,
    45,
    true
  ),
(
    '4cfee45f-d800-5812-9888-df4bbb812a0c'::uuid,
    'phrase',
    '{"id":"4cfee45f-d800-5812-9888-df4bbb812a0c","text":"build a foundation","phraseType":"verb_phrase","meaning":"打下基础","optionalEnglishExplanation":"Develop the basic knowledge needed for later progress.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"通常与for后续能力连用。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"2c23386c-5878-44e4-a8e5-2f6436ac6c5c","sentenceText":"Regular reading will also help you build a foundation for natural expression.","translation":"经常阅读也有助于为自然表达打下基础。","evidence":{"surface":"build a foundation","start":35,"end":53,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    46,
    true
  ),
(
    'c3aad812-3e5a-5b3e-ad2b-73a88c9f5f5f'::uuid,
    'phrase',
    '{"id":"c3aad812-3e5a-5b3e-ad2b-73a88c9f5f5f","text":"word for word","phraseType":"other_phrase","meaning":"逐词地","optionalEnglishExplanation":"By following each word separately.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"用于描述翻译方式，不是逐字引用的固定许可。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"ba2dea57-62c8-57cd-9c48-122975e1aa03","sentenceText":"Before drafting, identify the writer’s main point and the links between sentences rather than translate word for word.","translation":"动笔前，先确定作者主旨与句间联系，不要逐词硬译。","evidence":{"surface":"word for word","start":104,"end":117,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    47,
    true
  ),
(
    '2e7ef9be-3990-5724-a4c5-dd14765551c6'::uuid,
    'phrase',
    '{"id":"2e7ef9be-3990-5724-a4c5-dd14765551c6","text":"pay attention to","phraseType":"verb_phrase","meaning":"注意","optionalEnglishExplanation":"Direct your awareness towards something.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"to为介词，后接名词、动名词或从句。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"77087d09-acb8-5112-b10d-0af922a187df","sentenceText":"Then compare your version with a reliable translation, paying attention to differences in phrasing.","translation":"随后将自己的译文与可靠译文比较，留意措辞差别。","evidence":{"surface":"paying attention to","start":55,"end":74,"rule":"grammatical_variant"}},{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"87139c87-199c-4511-b178-0318f8e329e4","sentenceText":"Pay attention to recurring mistakes instead of trying to correct everything at once.","translation":"注意反复出现的错误，不必一次纠正所有问题。","evidence":{"surface":"Pay attention to","start":0,"end":16,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    48,
    true
  ),
(
    '57454dc3-a310-5d14-afa1-7db72fb96dc7'::uuid,
    'phrase',
    '{"id":"57454dc3-a310-5d14-afa1-7db72fb96dc7","text":"recurring mistakes","phraseType":"noun_phrase","meaning":"反复出现的错误","optionalEnglishExplanation":"Errors that happen repeatedly.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"不要把任何一次错误都叫recurring。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"28737ac6-9c4e-52da-b636-2a7fc394845a","sentenceText":"Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding.","translation":"记录有用表达和反复出现的错误，让每次练习更有收获。","evidence":{"surface":"recurring mistakes","start":40,"end":58,"rule":"exact"},"exampleSentenceId":"7ccce385-9a10-4134-88b0-ee379a1765cf"},{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"87139c87-199c-4511-b178-0318f8e329e4","sentenceText":"Pay attention to recurring mistakes instead of trying to correct everything at once.","translation":"注意反复出现的错误，不必一次纠正所有问题。","evidence":{"surface":"recurring mistakes","start":17,"end":35,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    49,
    true
  ),
(
    'db9ba0d2-45d0-59bb-a79d-7c7fac965dee'::uuid,
    'phrase',
    '{"id":"db9ba0d2-45d0-59bb-a79d-7c7fac965dee","text":"seek feedback","phraseType":"verb_phrase","meaning":"寻求反馈","optionalEnglishExplanation":"Ask for information that can help improve performance.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"feedback通常不可数。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"012a6235-8a05-4cde-a98a-5e1da45a795c","sentenceText":"Organizers should seek feedback from residents who remain excluded and offer suitable times and activities.","translation":"组织者应向仍无法参加的居民征求反馈，提供合适时段与活动。","evidence":{"surface":"seek feedback","start":18,"end":31,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    50,
    true
  ),
(
    'e5ecef63-dc4a-5ca1-9091-6d366e55bbd9'::uuid,
    'phrase',
    '{"id":"e5ecef63-dc4a-5ca1-9091-6d366e55bbd9","text":"make steady progress","phraseType":"verb_phrase","meaning":"稳步进步","optionalEnglishExplanation":"Improve gradually and consistently.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"用于建议，不保证固定时间内达成某成绩。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"910ff012-bf2c-4bfa-86fb-a8ee59131dd5","sentenceText":"To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally.","translation":"要稳步进步，应设定现实目标、建立可坚持的安排，而非偶尔翻译长文。","evidence":{"surface":"make steady progress","start":3,"end":23,"rule":"exact"},"exampleSentenceId":"58b2d447-ddf9-4545-97e0-9c71e2f00c8a"}],"type":"phrase"}'::jsonb,
    51,
    true
  ),
(
    '91820987-62f8-54c6-9e20-027bc6e602f0'::uuid,
    'phrase',
    '{"id":"91820987-62f8-54c6-9e20-027bc6e602f0","text":"set realistic goals","phraseType":"verb_phrase","meaning":"设定现实目标","optionalEnglishExplanation":"Choose aims that are achievable under actual conditions.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"目标需考虑约束，不是只写越高越好。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"910ff012-bf2c-4bfa-86fb-a8ee59131dd5","sentenceText":"To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally.","translation":"要稳步进步，应设定现实目标、建立可坚持的安排，而非偶尔翻译长文。","evidence":{"surface":"set realistic goals","start":25,"end":44,"rule":"exact"},"exampleSentenceId":"58b2d447-ddf9-4545-97e0-9c71e2f00c8a"}],"type":"phrase"}'::jsonb,
    52,
    true
  ),
(
    'f89d16eb-a0eb-5edb-b201-a49ae356c189'::uuid,
    'phrase',
    '{"id":"f89d16eb-a0eb-5edb-b201-a49ae356c189","text":"a manageable routine","phraseType":"noun_phrase","meaning":"可坚持的日常安排","optionalEnglishExplanation":"A regular plan that can be followed without excessive difficulty.","tags":["建议、推荐与方法"],"priority":"P2","usageNote":"用manageable强调可执行而非任务少。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"910ff012-bf2c-4bfa-86fb-a8ee59131dd5","sentenceText":"To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally.","translation":"要稳步进步，应设定现实目标、建立可坚持的安排，而非偶尔翻译长文。","evidence":{"surface":"a manageable routine","start":55,"end":75,"rule":"exact"},"exampleSentenceId":"58b2d447-ddf9-4545-97e0-9c71e2f00c8a"}],"type":"phrase"}'::jsonb,
    53,
    true
  ),
(
    'e17e3705-1ab3-5968-83d4-9a0a1d6b9cec'::uuid,
    'phrase',
    '{"id":"e17e3705-1ab3-5968-83d4-9a0a1d6b9cec","text":"weigh the options","phraseType":"verb_phrase","meaning":"权衡选项","optionalEnglishExplanation":"Consider the advantages and disadvantages of alternatives.","tags":["建议、推荐与方法"],"priority":"P3","usageNote":"options需是可比较的实际选择。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"8a148d51-9e18-4cbf-9025-21b42b80274b","sentenceText":"Students must weigh the options in light of personal circumstances and incomplete knowledge of the changing workplace.","translation":"学生必须结合个人处境及对职场的不充分了解权衡选项。","evidence":{"surface":"weigh the options","start":14,"end":31,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    54,
    true
  ),
(
    '49e611a9-06ef-5f45-bd38-e18cb15a8378'::uuid,
    'phrase',
    '{"id":"49e611a9-06ef-5f45-bd38-e18cb15a8378","text":"be worth exploring","phraseType":"verb_phrase","meaning":"值得探索","optionalEnglishExplanation":"Deserve time and attention for further examination.","tags":["建议、推荐与方法"],"priority":"P3","usageNote":"worth后接动名词。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"1549fddc-0434-4c4b-afec-b149ce3342bc","sentenceText":"Career guidance can provide informed advice about opportunities that may be worth exploring.","translation":"职业指导可就值得探索的机会提供有依据的建议。","evidence":{"surface":"be worth exploring","start":73,"end":91,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    55,
    true
  ),
(
    'ca214aef-292b-5928-b5df-0c545421a48a'::uuid,
    'phrase',
    '{"id":"ca214aef-292b-5928-b5df-0c545421a48a","text":"a better fit","phraseType":"noun_phrase","meaning":"更合适的选择","optionalEnglishExplanation":"An option that matches particular needs more closely.","tags":["建议、推荐与方法"],"priority":"P3","usageNote":"通常用for说明适合谁或什么需要。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"23adccce-5fd4-4551-bd00-63d451d064c0","sentenceText":"Further study may strengthen qualifications, but it is a better fit only when it serves a genuine learning need.","translation":"深造可能提升资历，但只有服务真实学习需要时才更合适。","evidence":{"surface":"a better fit","start":55,"end":67,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    56,
    true
  ),
(
    'ac184e08-2adb-5507-9e9b-612daf2dd216'::uuid,
    'phrase',
    '{"id":"ac184e08-2adb-5507-9e9b-612daf2dd216","text":"broaden your perspective","phraseType":"verb_phrase","meaning":"拓宽视野","optionalEnglishExplanation":"Help you understand a wider range of ideas or experiences.","tags":["建议、推荐与方法"],"priority":"P3","usageNote":"应说明接触的不同经验，不是所有活动都套。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"2838c5ab-6625-4af0-82d7-cb5b3593b1e1","sentenceText":"Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses.","translation":"实践岗位可拓宽他们的视野，帮助评估个人优势并发现薄弱处。","evidence":{"surface":"broaden their perspective","start":25,"end":50,"rule":"grammatical_variant"},"exampleSentenceId":"dbeb8394-61cd-458a-9e52-0708a77f8924"}],"type":"phrase"}'::jsonb,
    57,
    true
  ),
(
    '64adb220-682d-5312-b946-ff1ec8b5b518'::uuid,
    'phrase',
    '{"id":"64adb220-682d-5312-b946-ff1ec8b5b518","text":"easier to grasp","phraseType":"other_phrase","meaning":"更容易理解","optionalEnglishExplanation":"Less difficult to understand.","tags":["建议、推荐与方法"],"priority":"P3","usageNote":"make后用宾语加形容词结构。","examples":[{"essayId":"db0ac466-ee60-57bf-82aa-0ac19f6484e2","sentenceId":"820e70e7-57ab-5a84-aa61-aa42281c00e0","sentenceText":"Watching machines perform practical tasks could make ideas about automation much easier to grasp.","translation":"观看机器执行实际任务，能让自动化概念更容易理解。","evidence":{"surface":"easier to grasp","start":81,"end":96,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    58,
    true
  ),
(
    'b91e10ee-e31a-5a54-b39f-f5ea9face05a'::uuid,
    'phrase',
    '{"id":"b91e10ee-e31a-5a54-b39f-f5ea9face05a","text":"informed advice","phraseType":"noun_phrase","meaning":"有依据的建议","optionalEnglishExplanation":"Advice based on relevant knowledge and experience.","tags":["建议、推荐与方法"],"priority":"P3","usageNote":"informed修饰有知识依据，不是已经被通知。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"1549fddc-0434-4c4b-afec-b149ce3342bc","sentenceText":"Career guidance can provide informed advice about opportunities that may be worth exploring.","translation":"职业指导可就值得探索的机会提供有依据的建议。","evidence":{"surface":"informed advice","start":28,"end":43,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    59,
    true
  ),
(
    '60d016b1-74d2-513b-9221-02c022cdd9de'::uuid,
    'phrase',
    '{"id":"60d016b1-74d2-513b-9221-02c022cdd9de","text":"as planned","phraseType":"other_phrase","meaning":"按原计划","optionalEnglishExplanation":"In the way previously arranged.","tags":["道歉、投诉与补救"],"priority":"P1","usageNote":"承认原有约定，不用于尚未商定的假设。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"f045d61c-3efd-555b-8937-4ec9df7c73d0","sentenceText":"I am very sorry that I cannot visit you as planned.","translation":"很抱歉，我无法按计划拜访您。","evidence":{"surface":"as planned","start":40,"end":50,"rule":"exact"}},{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"4142aa23-400f-47ad-9fc5-f1374113a5ad","sentenceText":"A compulsory examination has been moved to Friday, so I cannot visit as planned.","translation":"一场必考考试改到了周五，因此我无法按计划拜访。","evidence":{"surface":"as planned","start":69,"end":79,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    60,
    true
  ),
(
    '2026ffff-172c-5d67-9c17-2019de2013f1'::uuid,
    'phrase',
    '{"id":"2026ffff-172c-5d67-9c17-2019de2013f1","text":"set aside time","phraseType":"verb_phrase","meaning":"专门留出时间","optionalEnglishExplanation":"Reserve time for a particular purpose.","tags":["道歉、投诉与补救"],"priority":"P1","usageNote":"用于承认对方安排的成本。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"7d67f59d-6b4d-507e-b956-4036742c09b9","sentenceText":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements.","translation":"想到您已专门为我留出时间，我为打乱您的安排诚恳道歉。","evidence":{"surface":"set aside time","start":22,"end":36,"rule":"exact"},"exampleSentenceId":"05d57aff-685a-4a0d-8f51-ac99e2916a8e"},{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"174f36a4-e7a0-4273-9557-363ef2888d77","sentenceText":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting.","translation":"知道您已为我留出时间，我为更改会面、打乱您的安排诚恳致歉。","evidence":{"surface":"set aside time","start":22,"end":36,"rule":"exact"},"exampleSentenceId":"c44ea336-7055-4bf0-900d-a5bdd8b0249e"}],"type":"phrase"}'::jsonb,
    61,
    true
  ),
(
    'a8cfb1a6-c787-5d78-be3a-aceb5472f009'::uuid,
    'phrase',
    '{"id":"a8cfb1a6-c787-5d78-be3a-aceb5472f009","text":"adjust my plans","phraseType":"verb_phrase","meaning":"调整我的计划","optionalEnglishExplanation":"Change arrangements to suit new circumstances.","tags":["道歉、投诉与补救"],"priority":"P1","usageNote":"配合对方时用，不要求对方独自承担调整。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"2beef8e3-9288-5ef0-9d5f-bc1902c4d002","sentenceText":"If another date would suit you better, I will gladly adjust my plans.","translation":"若其他日期更合适，我很愿意调整计划。","evidence":{"surface":"adjust my plans","start":53,"end":68,"rule":"exact"},"exampleSentenceId":"894c83f1-dd40-486b-80cc-1b98a4cd264b"}],"type":"phrase"}'::jsonb,
    62,
    true
  ),
(
    '5f2d1576-30b8-56f4-ab49-39582130a60e'::uuid,
    'phrase',
    '{"id":"5f2d1576-30b8-56f4-ab49-39582130a60e","text":"resolve the matter","phraseType":"verb_phrase","meaning":"解决此事","optionalEnglishExplanation":"Find a satisfactory solution to a problem.","tags":["道歉、投诉与补救"],"priority":"P1","usageNote":"正式但不过分强硬，适合投诉收尾。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"47017027-c32d-5f95-8250-22a268b50c5f","sentenceText":"Please let me know how you intend to resolve this matter.","translation":"请告知贵方打算怎样解决此事。","evidence":{"surface":"resolve this matter","start":37,"end":56,"rule":"grammatical_variant"}},{"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"7a3e4952-653f-4c7b-8c08-6e302a23b368","sentenceText":"Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund.","translation":"请免费补齐课程并提供承诺的反馈，或作出合理退款，以解决此事。","evidence":{"surface":"resolve the matter","start":7,"end":25,"rule":"exact"},"exampleSentenceId":"4d9aea56-1232-47a6-8bcd-a588a15729b3"}],"type":"phrase"}'::jsonb,
    63,
    true
  ),
(
    '346ba3c0-143f-5b0b-aebd-d010dadb76c6'::uuid,
    'phrase',
    '{"id":"346ba3c0-143f-5b0b-aebd-d010dadb76c6","text":"a full refund","phraseType":"noun_phrase","meaning":"全额退款","optionalEnglishExplanation":"The return of all money paid.","tags":["道歉、投诉与补救"],"priority":"P1","usageNote":"refund作可数名词，此处要a。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"0f5a7269-e1fb-5cea-9775-be597d3cc390","sentenceText":"If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item.","translation":"若无法及时安排，请全额退款，并告知怎样退回故障商品。","evidence":{"surface":"a full refund","start":50,"end":63,"rule":"exact"},"exampleSentenceId":"2d652e87-02c8-455c-afc0-cde69ddaa645"}],"type":"phrase"}'::jsonb,
    64,
    true
  ),
(
    '9f193a02-1d0f-5a74-93ca-d5084a45d9fa'::uuid,
    'phrase',
    '{"id":"9f193a02-1d0f-5a74-93ca-d5084a45d9fa","text":"at no additional cost","phraseType":"other_phrase","meaning":"不另收费","optionalEnglishExplanation":"Without requiring any extra payment.","tags":["道歉、投诉与补救"],"priority":"P1","usageNote":"说明合理诉求，不编造原店政策。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"950e19e2-d257-585a-b37b-1c21132551dd","sentenceText":"I would therefore appreciate a replacement at no additional cost.","translation":"因此，希望能免费更换新品。","evidence":{"surface":"at no additional cost","start":43,"end":64,"rule":"exact"}},{"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"7a3e4952-653f-4c7b-8c08-6e302a23b368","sentenceText":"Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund.","translation":"请免费补齐课程并提供承诺的反馈，或作出合理退款，以解决此事。","evidence":{"surface":"at no additional cost","start":51,"end":72,"rule":"exact"},"exampleSentenceId":"4d9aea56-1232-47a6-8bcd-a588a15729b3"}],"type":"phrase"}'::jsonb,
    65,
    true
  ),
(
    'f1c18e80-27b5-54ed-8d7c-63f912a0ca56'::uuid,
    'phrase',
    '{"id":"f1c18e80-27b5-54ed-8d7c-63f912a0ca56","text":"sincere apologies","phraseType":"noun_phrase","meaning":"诚恳的歉意","optionalEnglishExplanation":"A genuine expression of regret for causing a problem.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"apologies通常用复数；也可写I sincerely apologize。","examples":[{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"fa483ed6-f12b-49d5-b208-ab0df78106ec","sentenceText":"Please accept my sincere apologies for changing our meeting at short notice.","translation":"临时更改会面安排，请接受我诚恳的歉意。","evidence":{"surface":"sincere apologies","start":17,"end":34,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    66,
    true
  ),
(
    'c8223831-cb8a-55e0-b761-95bfb751de81'::uuid,
    'phrase',
    '{"id":"c8223831-cb8a-55e0-b761-95bfb751de81","text":"at short notice","phraseType":"other_phrase","meaning":"临时；提前时间很短","optionalEnglishExplanation":"With very little advance warning.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"只有确属临时变化时使用。","examples":[{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"fa483ed6-f12b-49d5-b208-ab0df78106ec","sentenceText":"Please accept my sincere apologies for changing our meeting at short notice.","translation":"临时更改会面安排，请接受我诚恳的歉意。","evidence":{"surface":"at short notice","start":60,"end":75,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    67,
    true
  ),
(
    'db724576-95fb-5ed8-a1e0-4ac4e7cd8e15'::uuid,
    'phrase',
    '{"id":"db724576-95fb-5ed8-a1e0-4ac4e7cd8e15","text":"disrupt your arrangements","phraseType":"verb_phrase","meaning":"打乱你的安排","optionalEnglishExplanation":"Interfere with plans someone has already made.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"apologize for后接动名词。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"7d67f59d-6b4d-507e-b956-4036742c09b9","sentenceText":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements.","translation":"想到您已专门为我留出时间，我为打乱您的安排诚恳道歉。","evidence":{"surface":"disrupting your arrangements","start":71,"end":99,"rule":"grammatical_variant"},"exampleSentenceId":"05d57aff-685a-4a0d-8f51-ac99e2916a8e"},{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"174f36a4-e7a0-4273-9557-363ef2888d77","sentenceText":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting.","translation":"知道您已为我留出时间，我为更改会面、打乱您的安排诚恳致歉。","evidence":{"surface":"disrupting your arrangements","start":71,"end":99,"rule":"grammatical_variant"},"exampleSentenceId":"c44ea336-7055-4bf0-900d-a5bdd8b0249e"}],"type":"phrase"}'::jsonb,
    68,
    true
  ),
(
    '6a430f3b-0788-5c6d-8487-b91776a731d6'::uuid,
    'phrase',
    '{"id":"6a430f3b-0788-5c6d-8487-b91776a731d6","text":"a suitable alternative","phraseType":"noun_phrase","meaning":"合适的替代方案","optionalEnglishExplanation":"Another option that meets the relevant needs.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"若原题要求以后见面，线上只能补充而非完全替代。","examples":[{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"afee4f28-8d9f-423d-a19c-0d393ab77478","sentenceText":"Would next Tuesday afternoon be a suitable alternative?","translation":"下周二下午是否是合适的替代时间？","evidence":{"surface":"a suitable alternative","start":32,"end":54,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    69,
    true
  ),
(
    '4e2e62c4-409d-578f-8dec-a33592704a91'::uuid,
    'phrase',
    '{"id":"4e2e62c4-409d-578f-8dec-a33592704a91","text":"at your convenience","phraseType":"other_phrase","meaning":"在你方便的时候","optionalEnglishExplanation":"At a time that suits the other person.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"与明确日期结合更可执行，不必只写模糊时间。","examples":[{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"2b374885-25e0-44b3-8415-a07dea21f650","sentenceText":"If the following week would suit you better, I will gladly meet at your convenience.","translation":"如果下一周对您更合适，我很乐意在您方便时会面。","evidence":{"surface":"at your convenience","start":64,"end":83,"rule":"exact"},"exampleSentenceId":"f6dd4ab1-5344-4a8b-b1b9-0ff8467d2b5d"}],"type":"phrase"}'::jsonb,
    70,
    true
  ),
(
    'a45ae5dc-ab74-549b-b38b-901a73fdc1e6'::uuid,
    'phrase',
    '{"id":"a45ae5dc-ab74-549b-b38b-901a73fdc1e6","text":"make the trip","phraseType":"verb_phrase","meaning":"成行","optionalEnglishExplanation":"Carry out a planned journey.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"解释取消旅行，原因宜简洁。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"f92db6ed-b529-5612-9e75-0b7097148e83","sentenceText":"A compulsory examination has been rescheduled for the day of my departure, so I can no longer make the trip.","translation":"一场必考考试改到了出发当天，因此我无法成行。","evidence":{"surface":"make the trip","start":94,"end":107,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    71,
    true
  ),
(
    'b52f3ed2-d590-5231-8a4c-5b9a99434593'::uuid,
    'phrase',
    '{"id":"b52f3ed2-d590-5231-8a4c-5b9a99434593","text":"fail to respond","phraseType":"verb_phrase","meaning":"没有反应","optionalEnglishExplanation":"Not react or provide the expected response.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"主语可为按键或系统；人未回复也可用，但语气不同。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"01e0ee39-97a0-5b8a-89ee-934d0b967582","sentenceText":"The screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies.","translation":"屏幕反复变为空白，几个按键也没有反应，导致词典无法用于学习。","evidence":{"surface":"fail to respond","start":51,"end":66,"rule":"exact"},"exampleSentenceId":"852effc7-5a70-4771-ade4-181ac6f23de7"}],"type":"phrase"}'::jsonb,
    72,
    true
  ),
(
    '599afaff-907b-521c-84e4-a9ed4edbd33e'::uuid,
    'phrase',
    '{"id":"599afaff-907b-521c-84e4-a9ed4edbd33e","text":"go blank","phraseType":"verb_phrase","meaning":"变为空白","optionalEnglishExplanation":"Stop showing visible information.","tags":["道歉、投诉与补救"],"priority":"P2","usageNote":"故障具体描述，不必同时夸大所有功能都坏。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"01e0ee39-97a0-5b8a-89ee-934d0b967582","sentenceText":"The screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies.","translation":"屏幕反复变为空白，几个按键也没有反应，导致词典无法用于学习。","evidence":{"surface":"goes blank","start":22,"end":32,"rule":"grammatical_variant"},"exampleSentenceId":"852effc7-5a70-4771-ade4-181ac6f23de7"}],"type":"phrase"}'::jsonb,
    73,
    true
  ),
(
    '5a698d3b-35ea-5120-91ea-6cfef01b78f3'::uuid,
    'phrase',
    '{"id":"5a698d3b-35ea-5120-91ea-6cfef01b78f3","text":"a faulty item","phraseType":"noun_phrase","meaning":"有故障的商品","optionalEnglishExplanation":"A product that does not work correctly.","tags":["道歉、投诉与补救"],"priority":"P3","usageNote":"faulty与item对应，不用于服务态度投诉。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"0f5a7269-e1fb-5cea-9775-be597d3cc390","sentenceText":"If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item.","translation":"若无法及时安排，请全额退款，并告知怎样退回故障商品。","evidence":{"surface":"the faulty item","start":92,"end":107,"rule":"grammatical_variant"},"exampleSentenceId":"2d652e87-02c8-455c-afc0-cde69ddaa645"}],"type":"phrase"}'::jsonb,
    74,
    true
  ),
(
    '7cb0bca7-0bf9-5aab-8b44-cf8aad5c5326'::uuid,
    'phrase',
    '{"id":"7cb0bca7-0bf9-5aab-8b44-cf8aad5c5326","text":"retain the receipt","phraseType":"verb_phrase","meaning":"保存收据","optionalEnglishExplanation":"Keep proof of a purchase.","tags":["道歉、投诉与补救"],"priority":"P3","usageNote":"提供凭据，不捏造真实订单号码。","examples":[{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"c7e01761-e989-503e-82d7-2e9d069a8b50","sentenceText":"I have retained the receipt and can provide photographs if required.","translation":"我保存了收据，必要时可提供照片。","evidence":{"surface":"retained the receipt","start":7,"end":27,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    75,
    true
  ),
(
    'd00b2769-bbf3-512f-bff9-5cb184b7b7a5'::uuid,
    'phrase',
    '{"id":"d00b2769-bbf3-512f-bff9-5cb184b7b7a5","text":"provide further details","phraseType":"verb_phrase","meaning":"提供更多细节","optionalEnglishExplanation":"Supply additional relevant information.","tags":["道歉、投诉与补救"],"priority":"P3","usageNote":"details用复数，所指应在前文出现。","examples":[{"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"edb6a102-79a9-4e55-afff-528553ae630c","sentenceText":"I can provide further details and copies of our previous correspondence.","translation":"我可以提供更多细节和此前通信副本。","evidence":{"surface":"provide further details","start":6,"end":29,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    76,
    true
  ),
(
    '01c098d6-0f93-5273-b341-f1199ca8c96f'::uuid,
    'phrase',
    '{"id":"01c098d6-0f93-5273-b341-f1199ca8c96f","text":"a prompt response","phraseType":"noun_phrase","meaning":"及时回复","optionalEnglishExplanation":"A reply given without unnecessary delay.","tags":["道歉、投诉与补救"],"priority":"P3","usageNote":"说明为何需要及时回复，比反复催促自然。","examples":[{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"8452aea9-29d4-4733-a7c2-b676d5337c53","sentenceText":"A prompt response would help me arrange my travel.","translation":"及时回复将有助于我安排旅程。","evidence":{"surface":"A prompt response","start":0,"end":17,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    77,
    true
  ),
(
    '1e25cfc2-6d38-51eb-9355-ac0f8ba1ebb3'::uuid,
    'phrase',
    '{"id":"1e25cfc2-6d38-51eb-9355-ac0f8ba1ebb3","text":"meet the stated standard","phraseType":"verb_phrase","meaning":"达到所声明的标准","optionalEnglishExplanation":"Reach the level that was explicitly promised.","tags":["道歉、投诉与补救"],"priority":"P3","usageNote":"需有明确承诺作为依据，不凭空指控。","examples":[{"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"4c3e68da-b5b8-42b6-9166-b31b3e56fc7d","sentenceText":"I am writing about your online writing course, which has failed to meet the stated standard.","translation":"我就贵方在线写作课程来信，课程未达到所声明的标准。","evidence":{"surface":"meet the stated standard","start":67,"end":91,"rule":"exact"},"exampleSentenceId":"8e378ed6-44f1-4c2b-8b8c-64de2dbf8406"}],"type":"phrase"}'::jsonb,
    78,
    true
  ),
(
    '37be8654-ad3c-504c-bf6d-ea1684ba78cd'::uuid,
    'phrase',
    '{"id":"37be8654-ad3c-504c-bf6d-ea1684ba78cd","text":"restore my confidence","phraseType":"verb_phrase","meaning":"恢复我的信心","optionalEnglishExplanation":"Help someone trust a service or organization again.","tags":["道歉、投诉与补救"],"priority":"P3","usageNote":"适合正式投诉，不必每封都加入。","examples":[{"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"1b9bf366-ae6b-4ba9-b36e-005b6cca79d8","sentenceText":"A fair solution would help restore my confidence in your service.","translation":"公平处理将有助于恢复我对贵方服务的信心。","evidence":{"surface":"restore my confidence","start":27,"end":48,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    79,
    true
  ),
(
    '5af95009-3c31-56a6-8d0c-cc655ed532cb'::uuid,
    'phrase',
    '{"id":"5af95009-3c31-56a6-8d0c-cc655ed532cb","text":"put forward a plan","phraseType":"verb_phrase","meaning":"提出计划","optionalEnglishExplanation":"Present a proposed course of action.","tags":["计划、调查与沟通"],"priority":"P1","usageNote":"a plan后可接for具体任务。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"39f2e13d-6c00-4110-b5ad-287c9b948bf8","sentenceText":"I would like to put forward a plan for our investigation of existing protection measures.","translation":"我想就现有保护措施的调查提出计划。","evidence":{"surface":"put forward a plan","start":16,"end":34,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    80,
    true
  ),
(
    'ff4e62bd-5214-5481-8adc-289ec193d770'::uuid,
    'phrase',
    '{"id":"ff4e62bd-5214-5481-8adc-289ec193d770","text":"field observations","phraseType":"noun_phrase","meaning":"实地观察","optionalEnglishExplanation":"Information gathered by directly examining a real setting.","tags":["计划、调查与沟通"],"priority":"P1","usageNote":"观察应与要获得的信息对应。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"e019c065-b5f7-5720-a4b8-0c8e837fbae3","sentenceText":"For our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns.","translation":"关于我们的老屋保护调查，我建议把实地观察与访谈结合，以同时了解建筑状况和居民关切。","evidence":{"surface":"field observations","start":60,"end":78,"rule":"exact"},"exampleSentenceId":"8c754cd9-9eb3-4d95-8815-7c94d0d4719d"},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","sentenceText":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.","translation":"对于这次调查，我建议开展实地观察与访谈，以便收集可靠依据并找出共同关切。","evidence":{"surface":"field observations","start":40,"end":58,"rule":"exact"},"exampleSentenceId":"f718dc5e-99e6-40cb-b886-e66f4d75bc58"}],"type":"phrase"}'::jsonb,
    81,
    true
  ),
(
    'e7956402-0c26-5654-bb12-c240d013014f'::uuid,
    'phrase',
    '{"id":"e7956402-0c26-5654-bb12-c240d013014f","text":"conduct interviews","phraseType":"verb_phrase","meaning":"开展访谈","optionalEnglishExplanation":"Ask people organized questions to gather information.","tags":["计划、调查与沟通"],"priority":"P1","usageNote":"采访不是只为凑流程，要写明了解什么。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"f78528cd-b015-5bbc-a2f1-0478f2e349c1","sentenceText":"Then we could conduct interviews with residents about maintenance costs, everyday needs and their views on preservation.","translation":"然后就维护成本、日常需要和保护观点采访居民。","evidence":{"surface":"conduct interviews","start":14,"end":32,"rule":"exact"}},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","sentenceText":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.","translation":"对于这次调查，我建议开展实地观察与访谈，以便收集可靠依据并找出共同关切。","evidence":{"surface":"conducting interviews","start":63,"end":84,"rule":"grammatical_variant"},"exampleSentenceId":"f718dc5e-99e6-40cb-b886-e66f4d75bc58"}],"type":"phrase"}'::jsonb,
    82,
    true
  ),
(
    '6e7a05c8-31ab-5582-a951-fef6dc7cd531'::uuid,
    'phrase',
    '{"id":"6e7a05c8-31ab-5582-a951-fef6dc7cd531","text":"share responsibilities","phraseType":"verb_phrase","meaning":"分担职责","optionalEnglishExplanation":"Divide tasks among people involved.","tags":["计划、调查与沟通"],"priority":"P1","usageNote":"不表示每个人必须承担完全相同任务。","examples":[{"essayId":"4fc8d915-6628-58cf-bf99-ab8fc56c586b","sentenceId":"42a397fd-7b0e-589c-bee0-84eb104902ae","sentenceText":"I prefer a quiet study environment, keep shared spaces tidy and am happy to share responsibilities for the housework.","translation":"我喜欢安静的学习环境，会保持公共区域整洁，也愿意分担家务责任。","evidence":{"surface":"share responsibilities","start":76,"end":98,"rule":"exact"},"exampleSentenceId":"cd67cadf-ff3a-46e3-95ae-b30a9236ab7d"},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"9586600d-a235-4f75-a565-f62127987355","sentenceText":"Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions.","translation":"我们分担职责：我起草记录清单，你设计关于成本和地方传统的问题。","evidence":{"surface":"share responsibilities","start":7,"end":29,"rule":"exact"},"exampleSentenceId":"67df22f9-047a-487e-b1d0-f26f0cfba324"},{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"043e4876-127a-4955-a63e-ab3dbbf27fca","sentenceText":"Flexible arrangements and shared responsibilities can help people contribute without feeling forced into identical routines.","translation":"灵活安排与共同责任能让人们作贡献，而不感到被迫遵循相同作息。","evidence":{"surface":"shared responsibilities","start":26,"end":49,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    83,
    true
  ),
(
    '45d1aa71-40c6-5206-ad66-3ae0425d0297'::uuid,
    'phrase',
    '{"id":"45d1aa71-40c6-5206-ad66-3ae0425d0297","text":"compare our findings","phraseType":"verb_phrase","meaning":"比较调查发现","optionalEnglishExplanation":"Examine collected results together.","tags":["计划、调查与沟通"],"priority":"P1","usageNote":"findings通常复数，指获得的信息或结果。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"f5cdb8ca-4df8-5fc4-9a1e-ec699835a16a","sentenceText":"I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings.","translation":"我拟观察清单，你准备访谈问题，随后我们共同比较发现。","evidence":{"surface":"compare our findings","start":96,"end":116,"rule":"exact"},"exampleSentenceId":"6dc457d3-0eb1-4ab3-a3ce-2786c65c8d87"},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"e7f2966a-0343-416e-b294-1c73303f3762","sentenceText":"With permission, photographs can help us check details when we compare our findings.","translation":"经允许拍摄的照片，可在比较调查发现时帮助核对细节。","evidence":{"surface":"compare our findings","start":63,"end":83,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    84,
    true
  ),
(
    '9d3e35eb-dba5-5117-b1d5-f10f730248dc'::uuid,
    'phrase',
    '{"id":"9d3e35eb-dba5-5117-b1d5-f10f730248dc","text":"welcome your suggestions","phraseType":"verb_phrase","meaning":"欢迎你的建议","optionalEnglishExplanation":"Be pleased to receive ideas for improvement.","tags":["计划、调查与沟通"],"priority":"P1","usageNote":"would让征求意见更委婉。","examples":[{"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"3ab2a030-a750-593f-b255-88b1fa34771a","sentenceText":"I would welcome your suggestions on the topic and arrangements.","translation":"欢迎您就主题和安排提出建议。","evidence":{"surface":"welcome your suggestions","start":8,"end":32,"rule":"exact"}},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"7a527383-c26f-4dbd-9f7d-14273dbc3aa6","sentenceText":"I welcome your suggestions on how to preserve cultural heritage while understanding residents’ needs.","translation":"欢迎你就如何兼顾文化遗产保护与了解居民需要提出建议。","evidence":{"surface":"welcome your suggestions","start":2,"end":26,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    85,
    true
  ),
(
    'a6491afb-28bb-57dd-bdd4-ec7ef3d21ab5'::uuid,
    'phrase',
    '{"id":"a6491afb-28bb-57dd-bdd4-ec7ef3d21ab5","text":"an observation checklist","phraseType":"noun_phrase","meaning":"观察记录清单","optionalEnglishExplanation":"A list of features to record during direct observation.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"清单有助于统一项目，不保证调查必然客观。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"f5cdb8ca-4df8-5fc4-9a1e-ec699835a16a","sentenceText":"I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings.","translation":"我拟观察清单，你准备访谈问题，随后我们共同比较发现。","evidence":{"surface":"the observation checklist","start":12,"end":37,"rule":"grammatical_variant"},"exampleSentenceId":"6dc457d3-0eb1-4ab3-a3ce-2786c65c8d87"}],"type":"phrase"}'::jsonb,
    86,
    true
  ),
(
    'd4beadd3-2101-51a0-9718-4d0c25b21f2f'::uuid,
    'phrase',
    '{"id":"d4beadd3-2101-51a0-9718-4d0c25b21f2f","text":"with permission","phraseType":"other_phrase","meaning":"经允许","optionalEnglishExplanation":"After receiving approval from the relevant person.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"适合真实调查的基本安排，不展开无关政策。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"ee3f95a8-05f8-507c-b207-b765ef09ab02","sentenceText":"We could first select several streets and keep a record of signs of damage or restoration, taking photographs with permission.","translation":"我们可以先选几条街，记录损坏或修复迹象，并经允许拍照。","evidence":{"surface":"with permission","start":110,"end":125,"rule":"exact"}},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"e7f2966a-0343-416e-b294-1c73303f3762","sentenceText":"With permission, photographs can help us check details when we compare our findings.","translation":"经允许拍摄的照片，可在比较调查发现时帮助核对细节。","evidence":{"surface":"With permission","start":0,"end":15,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    87,
    true
  ),
(
    '26158b91-cb12-538b-9dc4-54581911e226'::uuid,
    'phrase',
    '{"id":"26158b91-cb12-538b-9dc4-54581911e226","text":"existing protection measures","phraseType":"noun_phrase","meaning":"现有保护措施","optionalEnglishExplanation":"Actions already in place to preserve something.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"existing说明调查已有安排，不是直接宣布新政策。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"39f2e13d-6c00-4110-b5ad-287c9b948bf8","sentenceText":"I would like to put forward a plan for our investigation of existing protection measures.","translation":"我想就现有保护措施的调查提出计划。","evidence":{"surface":"existing protection measures","start":60,"end":88,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    88,
    true
  ),
(
    '17e58756-8a69-50be-83a3-ee1067911b02'::uuid,
    'phrase',
    '{"id":"17e58756-8a69-50be-83a3-ee1067911b02","text":"collect reliable evidence","phraseType":"verb_phrase","meaning":"收集可靠依据","optionalEnglishExplanation":"Gather information that can reasonably support a conclusion.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"适合调查方法，避免把猜测当发现。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","sentenceText":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.","translation":"对于这次调查，我建议开展实地观察与访谈，以便收集可靠依据并找出共同关切。","evidence":{"surface":"collect reliable evidence","start":100,"end":125,"rule":"exact"},"exampleSentenceId":"f718dc5e-99e6-40cb-b886-e66f4d75bc58"}],"type":"phrase"}'::jsonb,
    89,
    true
  ),
(
    'a9d88f0d-a2f9-5d5e-a8cd-7def6e080c7d'::uuid,
    'phrase',
    '{"id":"a9d88f0d-a2f9-5d5e-a8cd-7def6e080c7d","text":"identify common concerns","phraseType":"verb_phrase","meaning":"找出共同关切","optionalEnglishExplanation":"Recognize issues that matter to several people.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"访谈结果未出前用may等合理推测。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","sentenceText":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.","translation":"对于这次调查，我建议开展实地观察与访谈，以便收集可靠依据并找出共同关切。","evidence":{"surface":"identify common concerns","start":130,"end":154,"rule":"exact"},"exampleSentenceId":"f718dc5e-99e6-40cb-b886-e66f4d75bc58"}],"type":"phrase"}'::jsonb,
    90,
    true
  ),
(
    '7aa6bb47-e84f-537a-b7f7-06e04eb1f6d5'::uuid,
    'phrase',
    '{"id":"7aa6bb47-e84f-537a-b7f7-06e04eb1f6d5","text":"prepare a draft","phraseType":"verb_phrase","meaning":"准备初稿","optionalEnglishExplanation":"Make a preliminary version for further work.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"draft可指方案、问卷或文章初稿。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"9586600d-a235-4f75-a565-f62127987355","sentenceText":"Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions.","translation":"我们分担职责：我起草记录清单，你设计关于成本和地方传统的问题。","evidence":{"surface":"prepare a draft","start":38,"end":53,"rule":"exact"},"exampleSentenceId":"67df22f9-047a-487e-b1d0-f26f0cfba324"}],"type":"phrase"}'::jsonb,
    91,
    true
  ),
(
    '107e9ce8-26eb-5adb-8b92-a4f4d8851cb9'::uuid,
    'phrase',
    '{"id":"107e9ce8-26eb-5adb-8b92-a4f4d8851cb9","text":"make revisions","phraseType":"verb_phrase","meaning":"作出修改","optionalEnglishExplanation":"Change a draft to improve it.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"revisions复数常用；说明修改依据更有内容。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3accd780-4135-4fac-9547-853aeab06eec","sentenceText":"We can then make revisions together and reach an agreement before the visit.","translation":"之后我们共同修改，在走访前达成一致。","evidence":{"surface":"make revisions","start":12,"end":26,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    92,
    true
  ),
(
    '9d899bd0-761a-5778-b48a-f32cc2ab723e'::uuid,
    'phrase',
    '{"id":"9d899bd0-761a-5778-b48a-f32cc2ab723e","text":"reach an agreement","phraseType":"verb_phrase","meaning":"达成一致","optionalEnglishExplanation":"Arrive at a shared decision.","tags":["计划、调查与沟通"],"priority":"P2","usageNote":"agreement可数，此处用an。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3accd780-4135-4fac-9547-853aeab06eec","sentenceText":"We can then make revisions together and reach an agreement before the visit.","translation":"之后我们共同修改，在走访前达成一致。","evidence":{"surface":"reach an agreement","start":40,"end":58,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    93,
    true
  ),
(
    '4ee1b01a-f8b1-5d9e-8f98-f4001ff08e9e'::uuid,
    'phrase',
    '{"id":"4ee1b01a-f8b1-5d9e-8f98-f4001ff08e9e","text":"present opposing views","phraseType":"verb_phrase","meaning":"陈述对立观点","optionalEnglishExplanation":"Explain different sides of an argument.","tags":["计划、调查与沟通"],"priority":"P3","usageNote":"用于辩论而非普通经验分享。","examples":[{"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"d7483016-4270-5a5e-8a7f-259a3fa2fc06","sentenceText":"Two teams of four students will present opposing views, exchange questions and give closing statements.","translation":"两队各四名学生将陈述对立观点、相互提问并作总结陈词。","evidence":{"surface":"present opposing views","start":32,"end":54,"rule":"exact"},"exampleSentenceId":"136a03f0-2c9b-467e-a472-9310f378fa53"}],"type":"phrase"}'::jsonb,
    94,
    true
  ),
(
    '68fb49c0-412f-5f2e-8d22-af1138229108'::uuid,
    'phrase',
    '{"id":"68fb49c0-412f-5f2e-8d22-af1138229108","text":"equal speaking time","phraseType":"noun_phrase","meaning":"相等的发言时间","optionalEnglishExplanation":"The same amount of time allocated for each speaker or side.","tags":["计划、调查与沟通"],"priority":"P3","usageNote":"安排须与流程一致。","examples":[{"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"84012285-afcb-5c16-9935-e14bde43b780","sentenceText":"Each team will have equal speaking time, and the audience will vote after hearing both sides.","translation":"两队发言时间相等，观众将在听完双方后投票。","evidence":{"surface":"equal speaking time","start":20,"end":39,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    95,
    true
  ),
(
    '8d5be783-60a6-58b4-a430-ca54efbe0b9a'::uuid,
    'phrase',
    '{"id":"8d5be783-60a6-58b4-a430-ca54efbe0b9a","text":"chair the discussion","phraseType":"verb_phrase","meaning":"主持讨论","optionalEnglishExplanation":"Lead a discussion and manage its procedure.","tags":["计划、调查与沟通"],"priority":"P3","usageNote":"chair在这里是动词。","examples":[{"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"850051a6-308a-5a01-a6b2-277e477d8cbe","sentenceText":"I can prepare the schedule and invite a student to chair the discussion.","translation":"我可以准备日程，并邀请一名学生主持讨论。","evidence":{"surface":"chair the discussion","start":51,"end":71,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    96,
    true
  ),
(
    'e6bda8f8-9fd0-5bf7-8970-763808ee8e27'::uuid,
    'phrase',
    '{"id":"e6bda8f8-9fd0-5bf7-8970-763808ee8e27","text":"closing statements","phraseType":"noun_phrase","meaning":"总结陈词","optionalEnglishExplanation":"Final remarks summarizing a position.","tags":["计划、调查与沟通"],"priority":"P3","usageNote":"区别opening statements开篇陈词。","examples":[{"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"d7483016-4270-5a5e-8a7f-259a3fa2fc06","sentenceText":"Two teams of four students will present opposing views, exchange questions and give closing statements.","translation":"两队各四名学生将陈述对立观点、相互提问并作总结陈词。","evidence":{"surface":"closing statements","start":84,"end":102,"rule":"exact"},"exampleSentenceId":"136a03f0-2c9b-467e-a472-9310f378fa53"}],"type":"phrase"}'::jsonb,
    97,
    true
  ),
(
    '4087ee09-3218-5443-a56e-a939841c8cc1'::uuid,
    'phrase',
    '{"id":"4087ee09-3218-5443-a56e-a939841c8cc1","text":"keep track of","phraseType":"verb_phrase","meaning":"跟踪；记录","optionalEnglishExplanation":"Monitor progress or remain aware of relevant details.","tags":["计划、调查与沟通"],"priority":"P3","usageNote":"of后接跟踪对象。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3a7c2ede-4aad-4355-8509-5c6826b0b350","sentenceText":"A shared schedule will help us keep track of the work.","translation":"统一日程将帮助我们跟踪工作。","evidence":{"surface":"keep track of","start":31,"end":44,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    98,
    true
  ),
(
    '3c43d501-05e1-54da-9a18-e9cf1ef1d66e'::uuid,
    'phrase',
    '{"id":"3c43d501-05e1-54da-9a18-e9cf1ef1d66e","text":"sound workable","phraseType":"verb_phrase","meaning":"听起来可行","optionalEnglishExplanation":"Seem practical enough to carry out.","tags":["计划、调查与沟通"],"priority":"P3","usageNote":"sound为系动词，后接形容词。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"7f595850-0cde-5be4-8d87-dead2e0d84bf","sentenceText":"Does this approach sound workable to you?","translation":"你觉得这个方法可行吗？","evidence":{"surface":"sound workable","start":19,"end":33,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    99,
    true
  ),
(
    '14ef53e9-124f-5aab-a859-aa0bc29d14f7'::uuid,
    'phrase',
    '{"id":"14ef53e9-124f-5aab-a859-aa0bc29d14f7","text":"rise steadily","phraseType":"verb_phrase","meaning":"稳步上升","optionalEnglishExplanation":"Increase in a regular and consistent way.","tags":["趋势、变化与幅度"],"priority":"P1","usageNote":"steadily强调持续平稳，需有走势支持。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"1714d6b5-7139-4262-b954-f778b57968d2","sentenceText":"Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two.","translation":"电子阅读由每周两小时稳步升至六小时，纸质阅读的对应数值由六小时逐渐降至两小时。","evidence":{"surface":"rose steadily","start":16,"end":29,"rule":"grammatical_variant"},"exampleSentenceId":"6341d4ba-d3b6-4834-bdbe-400f6f189d2f"}],"type":"phrase"}'::jsonb,
    100,
    true
  ),
(
    '3312495e-6e72-56e5-bce4-061ce0e2b9e8'::uuid,
    'phrase',
    '{"id":"3312495e-6e72-56e5-bce4-061ce0e2b9e8","text":"decline gradually","phraseType":"verb_phrase","meaning":"逐渐下降","optionalEnglishExplanation":"Decrease slowly over time.","tags":["趋势、变化与幅度"],"priority":"P1","usageNote":"人口数量与比例不可混写。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"1714d6b5-7139-4262-b954-f778b57968d2","sentenceText":"Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two.","translation":"电子阅读由每周两小时稳步升至六小时，纸质阅读的对应数值由六小时逐渐降至两小时。","evidence":{"surface":"declined gradually","start":95,"end":113,"rule":"grammatical_variant"},"exampleSentenceId":"6341d4ba-d3b6-4834-bdbe-400f6f189d2f"}],"type":"phrase"}'::jsonb,
    101,
    true
  ),
(
    '9dcce37c-709e-5110-b529-845278d2e1bf'::uuid,
    'phrase',
    '{"id":"9dcce37c-709e-5110-b529-845278d2e1bf","text":"remain relatively stable","phraseType":"verb_phrase","meaning":"保持相对稳定","optionalEnglishExplanation":"Change only slightly over the stated period.","tags":["趋势、变化与幅度"],"priority":"P1","usageNote":"允许小幅变化，不等于完全不变。","examples":[{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"4f39dbdf-e190-5cae-ae52-4e79097e9e28","sentenceText":"American brands remained relatively stable at around 12% to 13%.","translation":"美系品牌相对稳定，约为12%至13%。","evidence":{"surface":"remained relatively stable","start":16,"end":42,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    102,
    true
  ),
(
    '6687cd91-7e6d-5f5a-a98c-ba9e2d441d20'::uuid,
    'phrase',
    '{"id":"6687cd91-7e6d-5f5a-a98c-ba9e2d441d20","text":"more than double","phraseType":"verb_phrase","meaning":"增加到两倍以上","optionalEnglishExplanation":"Become greater than twice the original amount.","tags":["趋势、变化与幅度"],"priority":"P1","usageNote":"不是“额外增加两倍”；须比较终值与起值。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"d5e738ae-56c2-5957-986a-db4e07b99fee","sentenceText":"The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million.","translation":"城镇人口由三亿增至六亿六千六百万，达到两倍以上；乡村人口则由八亿三千四百万降至六亿七千四百万。","evidence":{"surface":"more than doubled","start":21,"end":38,"rule":"grammatical_variant"},"exampleSentenceId":"0e9d65e8-3b4d-4b66-818d-fd38257ee6da"},{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"6f7b2187-0510-4dbf-89ba-131bb89c5780","sentenceText":"The chart shows county deliveries more than doubling from two million parcels in 2020 to five million in 2024, alongside growth in collection points from 40 to 85.","translation":"图表显示县域快递由2020年200万件增至2024年500万件，达到两倍以上；取件点同时由40个增至85个。","evidence":{"surface":"more than doubling","start":34,"end":52,"rule":"grammatical_variant"},"exampleSentenceId":"a1f2cd52-700a-4fce-a454-8254265a8981"}],"type":"phrase"}'::jsonb,
    103,
    true
  ),
(
    'de6309da-3206-574a-ae65-cd1032f78be0'::uuid,
    'phrase',
    '{"id":"de6309da-3206-574a-ae65-cd1032f78be0","text":"a sharp increase","phraseType":"noun_phrase","meaning":"大幅增加","optionalEnglishExplanation":"A large and noticeable rise.","tags":["趋势、变化与幅度"],"priority":"P1","usageNote":"幅度必须足够明显，不用于极小变化。","examples":[{"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"33b5fe39-5c88-5669-820c-4e1054ed1c79","sentenceText":"In developing countries, subscriptions showed a sharp increase from well below 1 billion to 4 billion, whereas developed countries recorded a much gentler rise to approximately 1 billion.","translation":"发展中国家的订阅量由远低于十亿大幅增至四十亿，发达国家则缓慢增至约十亿。","evidence":{"surface":"a sharp increase","start":46,"end":62,"rule":"exact"},"exampleSentenceId":"8ca0de15-c26e-4271-a83a-c2fb516f6a13"},{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"8b5762db-926c-417d-bb93-668c5e662e0b","sentenceText":"Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020.","translation":"参与率由10%升至60%，2019至2020年间大幅增加。","evidence":{"surface":"a sharp increase","start":54,"end":70,"rule":"exact"},"exampleSentenceId":"22dc7d45-2f5a-485b-b87d-8aae22937246"}],"type":"phrase"}'::jsonb,
    104,
    true
  ),
(
    '23f763a2-40de-5862-a604-46340b8dd1dc'::uuid,
    'phrase',
    '{"id":"23f763a2-40de-5862-a604-46340b8dd1dc","text":"level off","phraseType":"verb_phrase","meaning":"趋于平稳","optionalEnglishExplanation":"Stop rising or falling after a period of change.","tags":["趋势、变化与幅度"],"priority":"P1","usageNote":"教学假设，需新题确有平台阶段才用。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"2f392b82-7f42-43b3-b634-a1568b5dcf16","sentenceText":"Growth accelerated initially, then slowed before the rate began to level off in 2022.","translation":"增长起初加快，随后放缓，到2022年参与率开始趋稳。","evidence":{"surface":"level off","start":67,"end":76,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    105,
    true
  ),
(
    '4a84220b-645b-5eec-ada0-29abf4ffaebf'::uuid,
    'phrase',
    '{"id":"4a84220b-645b-5eec-ada0-29abf4ffaebf","text":"an upward trend","phraseType":"noun_phrase","meaning":"上升趋势","optionalEnglishExplanation":"A general movement towards higher values.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"不能据此直接比较绝对差值。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"05482767-e4bd-40d0-8795-6fe7db30d5cd","sentenceText":"The chart shows an upward trend in participation in a community exercise programme from 2017 to 2023.","translation":"图表显示2017至2023年社区健身项目参与率上升。","evidence":{"surface":"an upward trend","start":16,"end":31,"rule":"exact"}},{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"67591780-c927-4cc4-bf84-45088606c0e6","sentenceText":"The chart contrasts an upward trend in digital reading with a downward trend in print reading between 2018 and 2024.","translation":"图表对照2018至2024年电子阅读上升与纸质阅读下降的趋势。","evidence":{"surface":"an upward trend","start":20,"end":35,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    106,
    true
  ),
(
    'c00c7922-a3ac-532e-bdf1-7dd2d67020b0'::uuid,
    'phrase',
    '{"id":"c00c7922-a3ac-532e-bdf1-7dd2d67020b0","text":"a downward trend","phraseType":"noun_phrase","meaning":"下降趋势","optionalEnglishExplanation":"A general movement towards lower values.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"仅两点说明区间方向，不断言每年都降。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"67591780-c927-4cc4-bf84-45088606c0e6","sentenceText":"The chart contrasts an upward trend in digital reading with a downward trend in print reading between 2018 and 2024.","translation":"图表对照2018至2024年电子阅读上升与纸质阅读下降的趋势。","evidence":{"surface":"a downward trend","start":60,"end":76,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    107,
    true
  ),
(
    '2389ee6b-2f6c-54a3-ab88-fb89cdb65be0'::uuid,
    'phrase',
    '{"id":"2389ee6b-2f6c-54a3-ab88-fb89cdb65be0","text":"growth accelerated","phraseType":"other_phrase","meaning":"增长加快","optionalEnglishExplanation":"The rate of increase became faster.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"需比较相邻阶段变化速度。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"2f392b82-7f42-43b3-b634-a1568b5dcf16","sentenceText":"Growth accelerated initially, then slowed before the rate began to level off in 2022.","translation":"增长起初加快，随后放缓，到2022年参与率开始趋稳。","evidence":{"surface":"Growth accelerated","start":0,"end":18,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    108,
    true
  ),
(
    'cdb71c3c-8cae-5884-bacc-d523bb2e3899'::uuid,
    'phrase',
    '{"id":"cdb71c3c-8cae-5884-bacc-d523bb2e3899","text":"growth slowed","phraseType":"other_phrase","meaning":"增长放缓","optionalEnglishExplanation":"The rate of increase became lower.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"市场饱和若非题干信息，只能作为解释假设。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"972aab69-33bf-4b0a-abe9-ea64b343be39","sentenceText":"Even when growth slows, maintaining enjoyable, reliable opportunities can protect the long-term benefits of participation.","translation":"即使增长放缓，保持愉快、可靠的参与机会仍可维护长期收益。","evidence":{"surface":"growth slows","start":10,"end":22,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    109,
    true
  ),
(
    '67c45c0b-59ec-5154-9b90-c1719e97e589'::uuid,
    'phrase',
    '{"id":"67c45c0b-59ec-5154-9b90-c1719e97e589","text":"reach a peak","phraseType":"verb_phrase","meaning":"达到峰值","optionalEnglishExplanation":"Attain the highest point within a stated range.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"只指所示范围，不宣称历史最高。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"8b5762db-926c-417d-bb93-668c5e662e0b","sentenceText":"Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020.","translation":"参与率由10%升至60%，2019至2020年间大幅增加。","evidence":{"surface":"reached a peak","start":26,"end":40,"rule":"grammatical_variant"},"exampleSentenceId":"22dc7d45-2f5a-485b-b87d-8aae22937246"}],"type":"phrase"}'::jsonb,
    110,
    true
  ),
(
    'f1501abd-99ab-5116-8475-86ce14053c99'::uuid,
    'phrase',
    '{"id":"f1501abd-99ab-5116-8475-86ce14053c99","text":"fall to a low","phraseType":"verb_phrase","meaning":"降至低点","optionalEnglishExplanation":"Decrease to a particularly low value.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"需图中确有先降后回升。","examples":[{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"d8ac9324-a8b3-49cb-8571-0326814717e5","sentenceText":"The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018.","translation":"图表显示礼物支出在2020年降至20%的低点，之后回升至2024年25%，而2018年为30%。","evidence":{"surface":"falling to a low","start":30,"end":46,"rule":"grammatical_variant"},"exampleSentenceId":"a530d5e5-8993-41a9-ac22-482d5b9c48a1"}],"type":"phrase"}'::jsonb,
    111,
    true
  ),
(
    'd0712c26-9432-558a-abeb-99cb7f80e5f8'::uuid,
    'phrase',
    '{"id":"d0712c26-9432-558a-abeb-99cb7f80e5f8","text":"a sustained improvement","phraseType":"noun_phrase","meaning":"持续改善","optionalEnglishExplanation":"A positive development maintained over time.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"只有指标上升确属正面时用improvement。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"dcf88a02-2f01-5a35-849d-7c1e208e159f","sentenceText":"The line chart records a sustained improvement in health literacy among Chinese residents from 2012 to 2021.","translation":"折线图记录2012至2021年中国居民健康素养持续改善。","evidence":{"surface":"a sustained improvement","start":23,"end":46,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    112,
    true
  ),
(
    'b0b02627-f3e4-5a19-a569-eb5a3b5b3ede'::uuid,
    'phrase',
    '{"id":"b0b02627-f3e4-5a19-a569-eb5a3b5b3ede","text":"expand rapidly","phraseType":"verb_phrase","meaning":"迅速扩大","optionalEnglishExplanation":"Become larger at a fast rate.","tags":["趋势、变化与幅度"],"priority":"P2","usageNote":"原因部分需要合理条件，不作为图中已证事实。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"9d6ff748-8780-494f-8db1-8052049aa410","sentenceText":"The network can expand rapidly when access and demand reinforce each other.","translation":"可达性与需求相互促进时，网络能够迅速扩张。","evidence":{"surface":"expand rapidly","start":16,"end":30,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    113,
    true
  ),
(
    'd0258186-8911-58a8-8da6-a2c72dfb052e'::uuid,
    'phrase',
    '{"id":"d0258186-8911-58a8-8da6-a2c72dfb052e","text":"a modest change","phraseType":"noun_phrase","meaning":"小幅变化","optionalEnglishExplanation":"A relatively small alteration.","tags":["趋势、变化与幅度"],"priority":"P3","usageNote":"modest描述幅度，不评价该类不重要。","examples":[{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"4573c6fe-6606-4d18-bc97-d9c15a858548","sentenceText":"Travel records a modest change from 20% to 22%, while meals rise from 25% to 28%.","translation":"交通由20%小幅变至22%，聚餐则由25%升至28%。","evidence":{"surface":"a modest change","start":15,"end":30,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    114,
    true
  ),
(
    '15cedf22-7989-5c77-a96a-e3d795a670d1'::uuid,
    'phrase',
    '{"id":"15cedf22-7989-5c77-a96a-e3d795a670d1","text":"reverse the pattern","phraseType":"verb_phrase","meaning":"逆转原有格局","optionalEnglishExplanation":"Change an established relationship into its opposite.","tags":["趋势、变化与幅度"],"priority":"P3","usageNote":"用于方向或排名确实逆转。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"d7f238c8-4986-4f8b-aa9d-2c98a4b0c5d3","sentenceText":"In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance.","translation":"2021年是转折点，两者几乎相等；随后电子阅读逆转了纸质占主导的格局。","evidence":{"surface":"reversed the pattern","start":86,"end":106,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    115,
    true
  ),
(
    '45ebc2fb-569d-5f83-acc0-dbf33dd9fbc9'::uuid,
    'phrase',
    '{"id":"45ebc2fb-569d-5f83-acc0-dbf33dd9fbc9","text":"a turning point","phraseType":"noun_phrase","meaning":"转折点","optionalEnglishExplanation":"A moment when the direction of development changes.","tags":["趋势、变化与幅度"],"priority":"P3","usageNote":"必须有前后方向或结构变化。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"d7f238c8-4986-4f8b-aa9d-2c98a4b0c5d3","sentenceText":"In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance.","translation":"2021年是转折点，两者几乎相等；随后电子阅读逆转了纸质占主导的格局。","evidence":{"surface":"a turning point","start":9,"end":24,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    116,
    true
  ),
(
    '4acd2c6f-4573-5d32-aaa1-b0ea0bacd4d9'::uuid,
    'phrase',
    '{"id":"4acd2c6f-4573-5d32-aaa1-b0ea0bacd4d9","text":"by the end","phraseType":"other_phrase","meaning":"到期末","optionalEnglishExplanation":"At or before the final point of a stated period.","tags":["趋势、变化与幅度"],"priority":"P3","usageNote":"后接of the period等范围。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"12f8ac30-0b42-451a-81f8-bc97b0f043bb","sentenceText":"By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period.","translation":"到期末，明显差距已形成，但时长本身不能确定读者在该时期获得了什么。","evidence":{"surface":"By the end","start":0,"end":10,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    117,
    true
  ),
(
    'ce306225-8b37-5b0f-9ad0-863eec62c6b6'::uuid,
    'phrase',
    '{"id":"ce306225-8b37-5b0f-9ad0-863eec62c6b6","text":"over the period","phraseType":"other_phrase","meaning":"在该时期内","optionalEnglishExplanation":"During the full interval being discussed.","tags":["趋势、变化与幅度"],"priority":"P3","usageNote":"先明确时期，避免指代不明。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"12f8ac30-0b42-451a-81f8-bc97b0f043bb","sentenceText":"By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period.","translation":"到期末，明显差距已形成，但时长本身不能确定读者在该时期获得了什么。","evidence":{"surface":"over the period","start":97,"end":112,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    118,
    true
  ),
(
    'f9f67198-11f6-50db-af53-e9b6672c986f'::uuid,
    'phrase',
    '{"id":"f9f67198-11f6-50db-af53-e9b6672c986f","text":"from a low base","phraseType":"other_phrase","meaning":"从较低基数出发","optionalEnglishExplanation":"Starting with a relatively small initial amount.","tags":["趋势、变化与幅度"],"priority":"P3","usageNote":"适合创业比例等小基数，不忽略绝对规模。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"133fecee-5492-559c-a75f-d7387f739f7f","sentenceText":"Further study rose from 26.3% to 34%, while entrepreneurship doubled from a low base of 1.3% to 2.6%, though it still represented a limited share.","translation":"升学由26.3%增至34%，创业则由1.3%的低基数翻倍至2.6%，但仍只占有限份额。","evidence":{"surface":"from a low base","start":69,"end":84,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    119,
    true
  ),
(
    'cb4bf055-979b-5ca7-8138-d7a8cf201c54'::uuid,
    'phrase',
    '{"id":"cb4bf055-979b-5ca7-8138-d7a8cf201c54","text":"account for","phraseType":"verb_phrase","meaning":"占……比例","optionalEnglishExplanation":"Represent a stated share of a total.","tags":["比例、排序与对照"],"priority":"P1","usageNote":"指支出份额，不自动是居民人数比例。","examples":[{"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"17a19865-ea2e-5629-b248-70198c7aead9","sentenceText":"Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%.","translation":"礼物占最大份额40%，交通、亲友聚餐及其他支出各20%。","evidence":{"surface":"account for","start":110,"end":121,"rule":"exact"},"exampleSentenceId":"34c67f36-54fa-4a5e-a8e1-e3066bac3a64"},{"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"cf385388-4cb3-57c5-aa8b-5d479be471f1","sentenceText":"Enjoying scenery and relieving stress dominate, accounting for 37% and 33% respectively.","translation":"欣赏风景和缓解压力占主导，分别为37%与33%。","evidence":{"surface":"accounting for","start":48,"end":62,"rule":"grammatical_variant"}},{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"4f6c3c70-09c7-55d6-9b92-366d949ed35f","sentenceText":"Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%.","translation":"价格占不到十分之一，为8.4%，其他因素为4.7%。","evidence":{"surface":"accounts for","start":6,"end":18,"rule":"grammatical_variant"},"exampleSentenceId":"ba60080c-0a40-47fc-b13b-94a592bc9320"}],"type":"phrase"}'::jsonb,
    120,
    true
  ),
(
    '018dc601-adf1-59ff-89df-75435a40e68c'::uuid,
    'phrase',
    '{"id":"018dc601-adf1-59ff-89df-75435a40e68c","text":"be followed by","phraseType":"verb_phrase","meaning":"其次是","optionalEnglishExplanation":"Come next in a sequence or ranking.","tags":["比例、排序与对照"],"priority":"P1","usageNote":"过去分词短语followed by也可直接接在前句。","examples":[{"essayId":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","sentenceId":"d73b5039-9d98-5658-a9c4-934980d07dbd","sentenceText":"We will begin with brief introductions, followed by a discussion of study habits, friendships and campus activities.","translation":"我们先作简短介绍，再讨论学习习惯、友谊与校园活动。","evidence":{"surface":"followed by","start":40,"end":51,"rule":"grammatical_variant"}},{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"26c4d76f-af74-5b57-a1a5-75870af42b51","sentenceText":"Distinctive features rank first at 36.3%, followed by service at 26.8% and the dining environment at 23.8%.","translation":"特色以36.3%居首，其次为服务26.8%与用餐环境23.8%。","evidence":{"surface":"followed by","start":42,"end":53,"rule":"grammatical_variant"}},{"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"b7eb690a-c457-52b9-af53-5cf5c316ac84","sentenceText":"Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends.","translation":"略超一半即54.3%报告独自锻炼，其次为47.7%与朋友锻炼。","evidence":{"surface":"followed by","start":48,"end":59,"rule":"grammatical_variant"},"exampleSentenceId":"e16635dd-bf3e-44b7-9dc9-21746f8b368c"}],"type":"phrase"}'::jsonb,
    121,
    true
  ),
(
    'c650b34f-1eeb-56ab-a487-dd102f40cbee'::uuid,
    'phrase',
    '{"id":"c650b34f-1eeb-56ab-a487-dd102f40cbee","text":"rank first","phraseType":"verb_phrase","meaning":"排名第一","optionalEnglishExplanation":"Occupy the highest position in a ranking.","tags":["比例、排序与对照"],"priority":"P1","usageNote":"排名不等于价值必然最高。","examples":[{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"26c4d76f-af74-5b57-a1a5-75870af42b51","sentenceText":"Distinctive features rank first at 36.3%, followed by service at 26.8% and the dining environment at 23.8%.","translation":"特色以36.3%居首，其次为服务26.8%与用餐环境23.8%。","evidence":{"surface":"rank first","start":21,"end":31,"rule":"exact"}},{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"7c75dfbe-0820-4e45-8dec-670aed156df8","sentenceText":"Food quality ranks first in this survey, selected by 56% of respondents.","translation":"食品质量在此调查中排名第一，56%的受访者选择该项。","evidence":{"surface":"ranks first","start":13,"end":24,"rule":"grammatical_variant"},"exampleSentenceId":"bb848f94-878d-4231-93fb-3707e6218640"}],"type":"phrase"}'::jsonb,
    122,
    true
  ),
(
    'c3f7c704-caa5-5702-9ff6-307bed3f0167'::uuid,
    'phrase',
    '{"id":"c3f7c704-caa5-5702-9ff6-307bed3f0167","text":"almost equal","phraseType":"other_phrase","meaning":"几乎相等","optionalEnglishExplanation":"Very close in amount or level.","tags":["比例、排序与对照"],"priority":"P1","usageNote":"用于微小差距，不写绝对相等。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"8aab1db4-8270-5714-ae18-51ff58b39862","sentenceText":"By 2010, the two population figures were almost equal.","translation":"到2010年，两组人口数值几乎相等。","evidence":{"surface":"almost equal","start":41,"end":53,"rule":"exact"}},{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"d7f238c8-4986-4f8b-aa9d-2c98a4b0c5d3","sentenceText":"In 2021, a turning point, the figures were almost equal; digital reading subsequently reversed the pattern of print dominance.","translation":"2021年是转折点，两者几乎相等；随后电子阅读逆转了纸质占主导的格局。","evidence":{"surface":"almost equal","start":43,"end":55,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    123,
    true
  ),
(
    '8a0a0253-7c72-5d74-bdf6-23cee2f9121c'::uuid,
    'phrase',
    '{"id":"8a0a0253-7c72-5d74-bdf6-23cee2f9121c","text":"a considerable gap","phraseType":"noun_phrase","meaning":"明显差距","optionalEnglishExplanation":"A substantial difference between two values.","tags":["比例、排序与对照"],"priority":"P1","usageNote":"比较指标和单位须一致。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"12f8ac30-0b42-451a-81f8-bc97b0f043bb","sentenceText":"By the end, a considerable gap had emerged, but hours alone cannot establish what readers gained over the period.","translation":"到期末，明显差距已形成，但时长本身不能确定读者在该时期获得了什么。","evidence":{"surface":"a considerable gap","start":12,"end":30,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    124,
    true
  ),
(
    '734ab494-08d4-5513-8e10-aa92ff548bf6'::uuid,
    'phrase',
    '{"id":"734ab494-08d4-5513-8e10-aa92ff548bf6","text":"the corresponding figure","phraseType":"noun_phrase","meaning":"对应数值","optionalEnglishExplanation":"The value for the same measure in another group.","tags":["比例、排序与对照"],"priority":"P1","usageNote":"前文须明确比较哪项指标。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"1714d6b5-7139-4262-b954-f778b57968d2","sentenceText":"Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two.","translation":"电子阅读由每周两小时稳步升至六小时，纸质阅读的对应数值由六小时逐渐降至两小时。","evidence":{"surface":"the corresponding figure","start":60,"end":84,"rule":"exact"},"exampleSentenceId":"6341d4ba-d3b6-4834-bdbe-400f6f189d2f"}],"type":"phrase"}'::jsonb,
    125,
    true
  ),
(
    'e52606f7-4d96-5bb0-a869-47531051363c'::uuid,
    'phrase',
    '{"id":"e52606f7-4d96-5bb0-a869-47531051363c","text":"the largest share","phraseType":"noun_phrase","meaning":"最大份额","optionalEnglishExplanation":"The greatest part of the total being compared.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"构成分类需与题目口径一致。","examples":[{"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"17a19865-ea2e-5629-b248-70198c7aead9","sentenceText":"Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%.","translation":"礼物占最大份额40%，交通、亲友聚餐及其他支出各20%。","evidence":{"surface":"the largest share","start":11,"end":28,"rule":"exact"},"exampleSentenceId":"34c67f36-54fa-4a5e-a8e1-e3066bac3a64"}],"type":"phrase"}'::jsonb,
    126,
    true
  ),
(
    '2f945bf2-b14a-56dd-b7a2-9ca759d807da'::uuid,
    'phrase',
    '{"id":"2f945bf2-b14a-56dd-b7a2-9ca759d807da","text":"a smaller proportion","phraseType":"noun_phrase","meaning":"较小比例","optionalEnglishExplanation":"A lower share of the relevant group.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"不能写成合作收益幅度更小。","examples":[{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"5588d3b9-3efc-4e1e-b3ef-4faa555dcf34","sentenceText":"That share is twice as high as service at 28%, while a smaller proportion, 9%, choose atmosphere.","translation":"其比例是服务28%的两倍，较小比例9%选择环境。","evidence":{"surface":"a smaller proportion","start":53,"end":73,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    127,
    true
  ),
(
    'e9a28a52-3747-57f3-9d9c-d41bfca034d3'::uuid,
    'phrase',
    '{"id":"e9a28a52-3747-57f3-9d9c-d41bfca034d3","text":"respectively","phraseType":"other_phrase","meaning":"分别","optionalEnglishExplanation":"In the same order as the items already named.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"顺序必须与前文对象对应。","examples":[{"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"cf385388-4cb3-57c5-aa8b-5d479be471f1","sentenceText":"Enjoying scenery and relieving stress dominate, accounting for 37% and 33% respectively.","translation":"欣赏风景和缓解压力占主导，分别为37%与33%。","evidence":{"surface":"respectively","start":75,"end":87,"rule":"exact"}},{"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"b5be4612-722d-58e3-af06-747b7b350145","sentenceText":"Gardening, reading and chess attract 34.7%, 31.8% and 18.4% respectively.","translation":"养花、阅读、下棋分别为34.7%、31.8%与18.4%。","evidence":{"surface":"respectively","start":60,"end":72,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    128,
    true
  ),
(
    '5c33dfe8-30dc-5e53-bec3-0cec6bcd9e03'::uuid,
    'phrase',
    '{"id":"5c33dfe8-30dc-5e53-bec3-0cec6bcd9e03","text":"closely followed by","phraseType":"other_phrase","meaning":"紧随其后的是","optionalEnglishExplanation":"With the next item only slightly lower.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"用于2026年几乎相等的前两项，不用于差距很大的排序。","examples":[{"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"e7adcb25-5376-54f1-a9a2-4fc3ae6ccee8","sentenceText":"Acquiring knowledge leads at 91.3%, closely followed by improved practical skills at 84.8%.","translation":"获取知识以91.3%领先，动手技能提升84.8%紧随其后。","evidence":{"surface":"closely followed by","start":36,"end":55,"rule":"exact"},"exampleSentenceId":"7aaa54b2-84b2-49df-ae12-e2c52dfa4a8d"}],"type":"phrase"}'::jsonb,
    129,
    true
  ),
(
    'c185f0a1-718b-5908-b7a6-0727fd00e876'::uuid,
    'phrase',
    '{"id":"c185f0a1-718b-5908-b7a6-0727fd00e876","text":"well ahead of","phraseType":"other_phrase","meaning":"明显高于","optionalEnglishExplanation":"Much higher or further forward than another item.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"差距较小不使用well。","examples":[{"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"6592d80c-419c-5523-a0d5-3172adb0ceb9","sentenceText":"Learning accounts for 59.5%, well ahead of passing the time at 21.3% and obtaining information at 17%.","translation":"学习占59.5%，明显高于消磨时间21.3%与获取信息17%。","evidence":{"surface":"well ahead of","start":29,"end":42,"rule":"exact"},"exampleSentenceId":"a187a40d-e6f1-4e28-bde2-ad733fe0c6f4"}],"type":"phrase"}'::jsonb,
    130,
    true
  ),
(
    'cedc6e3e-e387-5105-99d2-b28720fe9e2b'::uuid,
    'phrase',
    '{"id":"cedc6e3e-e387-5105-99d2-b28720fe9e2b","text":"just over half","phraseType":"other_phrase","meaning":"略超一半","optionalEnglishExplanation":"Slightly more than fifty percent.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"原图问参与方式时用report，不擅自写成偏好prefer。","examples":[{"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"b7eb690a-c457-52b9-af53-5cf5c316ac84","sentenceText":"Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends.","translation":"略超一半即54.3%报告独自锻炼，其次为47.7%与朋友锻炼。","evidence":{"surface":"Just over half","start":0,"end":14,"rule":"exact"},"exampleSentenceId":"e16635dd-bf3e-44b7-9dc9-21746f8b368c"}],"type":"phrase"}'::jsonb,
    131,
    true
  ),
(
    'cdeb1d19-9740-5402-babc-2f4e8d7fb256'::uuid,
    'phrase',
    '{"id":"cdeb1d19-9740-5402-babc-2f4e8d7fb256","text":"less than a tenth","phraseType":"other_phrase","meaning":"不到十分之一","optionalEnglishExplanation":"A share smaller than ten percent.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"主目的单选口径才用main。","examples":[{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"4f6c3c70-09c7-55d6-9b92-366d949ed35f","sentenceText":"Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%.","translation":"价格占不到十分之一，为8.4%，其他因素为4.7%。","evidence":{"surface":"less than a tenth","start":19,"end":36,"rule":"exact"},"exampleSentenceId":"ba60080c-0a40-47fc-b13b-94a592bc9320"}],"type":"phrase"}'::jsonb,
    132,
    true
  ),
(
    '5f97740d-e3eb-547a-b6ca-913c2bf05a8f'::uuid,
    'phrase',
    '{"id":"5f97740d-e3eb-547a-b6ca-913c2bf05a8f","text":"percentage points","phraseType":"noun_phrase","meaning":"百分点","optionalEnglishExplanation":"Units used to express the difference between percentages.","tags":["比例、排序与对照"],"priority":"P2","usageNote":"不同于相对增长百分之五十。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"f9e0d64f-2b6f-55e0-9b6c-e3dc50a0aa3e","sentenceText":"Despite a gain of 16.6 percentage points, the 2021 figure still leaves considerable room for progress.","translation":"尽管已增加16.6个百分点，2021年的比例仍留下相当提升空间。","evidence":{"surface":"percentage points","start":23,"end":40,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    133,
    true
  ),
(
    '348f785b-7f2f-5bbb-a545-5fe08b282b34'::uuid,
    'phrase',
    '{"id":"348f785b-7f2f-5bbb-a545-5fe08b282b34","text":"twice as high","phraseType":"other_phrase","meaning":"高至两倍","optionalEnglishExplanation":"At two times the comparison level.","tags":["比例、排序与对照"],"priority":"P3","usageNote":"as后接比较对象；不是多出两倍。","examples":[{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"5588d3b9-3efc-4e1e-b3ef-4faa555dcf34","sentenceText":"That share is twice as high as service at 28%, while a smaller proportion, 9%, choose atmosphere.","translation":"其比例是服务28%的两倍，较小比例9%选择环境。","evidence":{"surface":"twice as high","start":14,"end":27,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    134,
    true
  ),
(
    'a1e0dded-4d0c-5f6e-b575-1753c5e52547'::uuid,
    'phrase',
    '{"id":"a1e0dded-4d0c-5f6e-b575-1753c5e52547","text":"the remaining share","phraseType":"noun_phrase","meaning":"剩余份额","optionalEnglishExplanation":"The part of a total not yet described.","tags":["比例、排序与对照"],"priority":"P3","usageNote":"仅用于互斥且完整的构成，不能套多选。","examples":[{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"c6d348db-7468-46fb-9e54-87b655136c02","sentenceText":"The remaining share of 7% covers other reasons, leaving quality clearly in the lead.","translation":"剩余7%涵盖其他原因，食品质量明显领先。","evidence":{"surface":"The remaining share","start":0,"end":19,"rule":"exact"}},{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"8467a6dd-2415-42fa-b71b-2e5c36b13ee2","sentenceText":"Other expenses take the remaining share in each year.","translation":"其他支出在各年占剩余份额。","evidence":{"surface":"the remaining share","start":20,"end":39,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    135,
    true
  ),
(
    'e215f573-b862-5454-a764-e4da87eaa882'::uuid,
    'phrase',
    '{"id":"e215f573-b862-5454-a764-e4da87eaa882","text":"a reversal in ranking","phraseType":"noun_phrase","meaning":"排名逆转","optionalEnglishExplanation":"A change in which of two items holds the higher position.","tags":["比例、排序与对照"],"priority":"P3","usageNote":"排名确有互换才用reversal。","examples":[{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"a1cdd944-4ba5-5674-8abb-df0c75beb18f","sentenceText":"The chart shows a reversal in ranking between Chinese and Japanese car brands from 2008 to 2009.","translation":"图表显示2008至2009年国产与日系汽车品牌排名逆转。","evidence":{"surface":"a reversal in ranking","start":16,"end":37,"rule":"exact"},"exampleSentenceId":"773e4480-260f-4147-b981-1e08dd189d8a"}],"type":"phrase"}'::jsonb,
    136,
    true
  ),
(
    '9896df2b-b5c1-53d1-924a-a8b47a4b2a16'::uuid,
    'phrase',
    '{"id":"9896df2b-b5c1-53d1-924a-a8b47a4b2a16","text":"on average","phraseType":"other_phrase","meaning":"平均而言","optionalEnglishExplanation":"As a typical value calculated across a group.","tags":["比例、排序与对照"],"priority":"P3","usageNote":"平均不等于每一家都增加。","examples":[{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"10cf6856-f5e4-5552-adc8-b30f99994aee","sentenceText":"Attendance grew faster proportionally, indicating more visits per museum on average.","translation":"人次相对增长更快，表明平均每馆人次增加。","evidence":{"surface":"on average","start":73,"end":83,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    137,
    true
  ),
(
    'ad74ec24-a9bf-5233-aabf-5b421d803bd1'::uuid,
    'phrase',
    '{"id":"ad74ec24-a9bf-5233-aabf-5b421d803bd1","text":"compared with","phraseType":"other_phrase","meaning":"与……相比","optionalEnglishExplanation":"When examined alongside another item.","tags":["比例、排序与对照"],"priority":"P3","usageNote":"rate与rates比较，不让比例直接比人。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"73fbb28e-71b5-4eb0-b813-51a91d787a97","sentenceText":"Compared with teamwork, individual learning outcomes are more widely reported.","translation":"与团队合作相比，个人学习收获被报告得更普遍。","evidence":{"surface":"Compared with","start":0,"end":13,"rule":"exact"}},{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"d8ac9324-a8b3-49cb-8571-0326814717e5","sentenceText":"The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018.","translation":"图表显示礼物支出在2020年降至20%的低点，之后回升至2024年25%，而2018年为30%。","evidence":{"surface":"compared with","start":96,"end":109,"rule":"exact"},"exampleSentenceId":"a530d5e5-8993-41a9-ac22-482d5b9c48a1"}],"type":"phrase"}'::jsonb,
    138,
    true
  ),
(
    'a78ed5cb-7c14-57fb-83ac-38853a95804e'::uuid,
    'phrase',
    '{"id":"a78ed5cb-7c14-57fb-83ac-38853a95804e","text":"a limited share","phraseType":"noun_phrase","meaning":"有限份额","optionalEnglishExplanation":"A relatively small part of the total.","tags":["比例、排序与对照"],"priority":"P3","usageNote":"适合小基数高增长的准确概括。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"133fecee-5492-559c-a75f-d7387f739f7f","sentenceText":"Further study rose from 26.3% to 34%, while entrepreneurship doubled from a low base of 1.3% to 2.6%, though it still represented a limited share.","translation":"升学由26.3%增至34%，创业则由1.3%的低基数翻倍至2.6%，但仍只占有限份额。","evidence":{"surface":"a limited share","start":130,"end":145,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    139,
    true
  ),
(
    '9d9af648-3295-5f90-9903-f1e30ed98ee6'::uuid,
    'phrase',
    '{"id":"9d9af648-3295-5f90-9903-f1e30ed98ee6","text":"may reflect","phraseType":"verb_phrase","meaning":"可能反映","optionalEnglishExplanation":"Could indicate an underlying condition or cause.","tags":["因果、条件与评价"],"priority":"P1","usageNote":"用于合理解释，不声称图表证明因果。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"29a7a7db-2ac5-52f8-b973-406707cc2d96","sentenceText":"The shift towards further study may reflect a desire for stronger qualifications and more specialized knowledge.","translation":"转向升学可能反映对更强资历与更专门知识的追求。","evidence":{"surface":"may reflect","start":32,"end":43,"rule":"exact"}},{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"d9462a94-b51d-4081-b47a-f908466fc59f","sentenceText":"The pattern may reflect a reassessment of what makes a celebration worthwhile.","translation":"该分布可能反映对什么使庆祝值得的重新考虑。","evidence":{"surface":"may reflect","start":12,"end":23,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    140,
    true
  ),
(
    'b04aa251-4b26-58ff-a53d-d82554de74de'::uuid,
    'phrase',
    '{"id":"b04aa251-4b26-58ff-a53d-d82554de74de","text":"be related to","phraseType":"verb_phrase","meaning":"与……有关","optionalEnglishExplanation":"Have a relevant connection with something.","tags":["因果、条件与评价"],"priority":"P1","usageNote":"related to不自动表示已证因果。","examples":[{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"eacdef5e-7cbc-4042-b88e-1c542f98ebf8","sentenceText":"The problem may be related to habits formed around quick responses, rather than to the screen itself.","translation":"问题可能与围绕即时回应形成的习惯有关，而非屏幕本身。","evidence":{"surface":"be related to","start":16,"end":29,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    141,
    true
  ),
(
    '6bd2efad-4dbf-5560-91d9-10ecf3d786d7'::uuid,
    'phrase',
    '{"id":"6bd2efad-4dbf-5560-91d9-10ecf3d786d7","text":"help explain","phraseType":"verb_phrase","meaning":"有助于解释","optionalEnglishExplanation":"Provide part of the reason for a pattern.","tags":["因果、条件与评价"],"priority":"P1","usageNote":"不是唯一解释，后面要给机制。","examples":[{"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"1a39efd0-bd8b-53a6-9373-1a4eca0d4538","sentenceText":"Convenience helps explain the pattern.","translation":"便利有助于解释这种分布。","evidence":{"surface":"helps explain","start":12,"end":25,"rule":"grammatical_variant"}},{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"327cf984-48d1-5062-a565-539e70f414ff","sentenceText":"Greater access to health education may help explain this progress.","translation":"健康教育更易获取，可能有助于解释这一进步。","evidence":{"surface":"help explain","start":39,"end":51,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    142,
    true
  ),
(
    '055550ca-c1ba-54c4-9595-414ab99a1f2e'::uuid,
    'phrase',
    '{"id":"055550ca-c1ba-54c4-9595-414ab99a1f2e","text":"reinforce each other","phraseType":"verb_phrase","meaning":"相互促进","optionalEnglishExplanation":"Make one another stronger or more effective.","tags":["因果、条件与评价"],"priority":"P1","usageNote":"下一句宜说明怎样相互促进。","examples":[{"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"12177767-b20c-5e49-bdec-6986f9c3c663","sentenceText":"The two leading purposes therefore reinforce each other: enjoying a different environment can itself be a way of recovering energy.","translation":"两项主要目的相互促进：享受不同环境，本身就是恢复精力的方式。","evidence":{"surface":"reinforce each other","start":35,"end":55,"rule":"exact"}},{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"00c8ec84-eefb-5a42-9299-e9687e9a2dc7","sentenceText":"The two trends can reinforce each other.","translation":"两种趋势可以相互促进。","evidence":{"surface":"reinforce each other","start":19,"end":39,"rule":"exact"}},{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"9d6ff748-8780-494f-8db1-8052049aa410","sentenceText":"The network can expand rapidly when access and demand reinforce each other.","translation":"可达性与需求相互促进时，网络能够迅速扩张。","evidence":{"surface":"reinforce each other","start":54,"end":74,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    143,
    true
  ),
(
    'a9d48007-613c-5757-925e-4cbf9c7e9cca'::uuid,
    'phrase',
    '{"id":"a9d48007-613c-5757-925e-4cbf9c7e9cca","text":"depend on","phraseType":"verb_phrase","meaning":"取决于","optionalEnglishExplanation":"Be determined or influenced by something.","tags":["因果、条件与评价"],"priority":"P1","usageNote":"后接名词或动名词，说明条件。","examples":[{"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"80821fe5-5911-5058-9573-bf35e045b264","sentenceText":"Other activities may depend more on personal interests, space or companions.","translation":"其他活动可能更取决于个人兴趣、空间或伙伴。","evidence":{"surface":"depend more on","start":21,"end":35,"rule":"grammatical_variant"}},{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"87854f28-aaeb-4534-9edb-9ef484e37f23","sentenceText":"The aim is to earn confidence rather than depend on promotion alone.","translation":"目标是赢得信心，而非仅依赖宣传。","evidence":{"surface":"depend on","start":42,"end":51,"rule":"exact"}},{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"6b8fed24-6525-467b-9af8-e2890126b166","sentenceText":"Teamwork additionally requires shared goals and complementary roles that make members depend on one another.","translation":"团队合作还需要共同目标与互补角色，让成员相互依赖。","evidence":{"surface":"depend on","start":86,"end":95,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    144,
    true
  ),
(
    '57e8b719-934f-5e78-8a8e-7c94754f908f'::uuid,
    'phrase',
    '{"id":"57e8b719-934f-5e78-8a8e-7c94754f908f","text":"put pressure on","phraseType":"verb_phrase","meaning":"给……带来压力","optionalEnglishExplanation":"Create demands that are difficult to meet.","tags":["因果、条件与评价"],"priority":"P1","usageNote":"can表示可能影响，不把一切增长都写成危机。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"329254f4-2a37-5bd0-8082-ad23a94f6937","sentenceText":"As more people settle in cities, growing demand can put pressure on housing and public services, further reshaping everyday life.","translation":"随着更多人在城市定居，增加的需求可能给住房与公共服务带来压力，进一步重塑日常生活。","evidence":{"surface":"put pressure on","start":52,"end":67,"rule":"exact"}},{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"6a5e3d29-e47f-4616-bdf0-a184fb1ab707","sentenceText":"The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning.","translation":"提供数字资源的同一设备也会带来给注意力造成压力的消息与干扰，因此持续专注成为自主学习的重要部分。","evidence":{"surface":"put pressure on","start":97,"end":112,"rule":"exact"},"exampleSentenceId":"0a10d930-e9e6-4946-a302-3d838ab1abf2"}],"type":"phrase"}'::jsonb,
    145,
    true
  ),
(
    '8bbdc7ce-ee87-5e05-b805-31f65df47e88'::uuid,
    'phrase',
    '{"id":"8bbdc7ce-ee87-5e05-b805-31f65df47e88","text":"contribute to","phraseType":"verb_phrase","meaning":"促成；有助于","optionalEnglishExplanation":"Help bring about a result.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"to为介词，后接名词或动名词。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"76f0cd17-2306-425e-a4c8-12f84e4e67fc","sentenceText":"This convenience can contribute to a deliberate choice of format, especially for people reading between other commitments.","translation":"这种便利有助于形成有意识的媒介选择，尤其对在其他事务间隙阅读的人。","evidence":{"surface":"contribute to","start":21,"end":34,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    146,
    true
  ),
(
    'e4aacbfa-7f49-5350-999e-7d0a13c7c244'::uuid,
    'phrase',
    '{"id":"e4aacbfa-7f49-5350-999e-7d0a13c7c244","text":"be driven by","phraseType":"verb_phrase","meaning":"受到……推动","optionalEnglishExplanation":"Be strongly motivated or influenced by something.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"动力需贴题，不全写economic development。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"6d3d02cf-11f8-4199-a476-5cfcdcf3fd65","sentenceText":"These benefits may be driven by local collection points that make distant sellers easier to reach.","translation":"这些收益可能由让远方卖家更易接触的当地取件点推动。","evidence":{"surface":"be driven by","start":19,"end":31,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    147,
    true
  ),
(
    '2fcbb294-d8fa-5941-a463-6df9a6e0f96b'::uuid,
    'phrase',
    '{"id":"2fcbb294-d8fa-5941-a463-6df9a6e0f96b","text":"remove barriers","phraseType":"verb_phrase","meaning":"消除障碍","optionalEnglishExplanation":"Reduce obstacles that make action difficult.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"说明什么障碍更有解释力。","examples":[{"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"8a8d95b8-9bd3-5ed2-971f-4342627c6eca","sentenceText":"Its appeal lies partly in removing barriers of time and place.","translation":"它的吸引力部分在于突破时间与地点限制。","evidence":{"surface":"removing barriers","start":26,"end":43,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    148,
    true
  ),
(
    'fcb0e064-d1a9-5404-8250-1fff8b2c8c1e'::uuid,
    'phrase',
    '{"id":"fcb0e064-d1a9-5404-8250-1fff8b2c8c1e","text":"in turn","phraseType":"other_phrase","meaning":"反过来；继而","optionalEnglishExplanation":"As a following result or response.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"应有反馈或递进，不作任意连接词。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"017a588b-5db2-59a6-8d05-2be155a37c21","sentenceText":"Students, in turn, should consider what a job teaches them as well as what it pays.","translation":"学生也应既考虑工作教会自己什么，也考虑报酬。","evidence":{"surface":"in turn","start":10,"end":17,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    149,
    true
  ),
(
    '2524514f-0764-5d25-96f5-421b1f79fc3a'::uuid,
    'phrase',
    '{"id":"2524514f-0764-5d25-96f5-421b1f79fc3a","text":"lead to","phraseType":"verb_phrase","meaning":"导致；带来","optionalEnglishExplanation":"Produce or result in something.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"结果可好可坏；避免无根据断言。","examples":[{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"b1625c5d-f0bc-5280-a75a-d1141bc498e5","sentenceText":"By helping visitors understand what they see, museums can ensure that wider access leads to deeper cultural engagement rather than simply larger crowds.","translation":"帮助来访者理解所见，能确保更广接触通向更深文化参与，而不只是更大人流。","evidence":{"surface":"leads to","start":83,"end":91,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    150,
    true
  ),
(
    'c5366c5d-e0e4-5b78-8161-f8a47e81a734'::uuid,
    'phrase',
    '{"id":"c5366c5d-e0e4-5b78-8161-f8a47e81a734","text":"result from","phraseType":"verb_phrase","meaning":"由……引起","optionalEnglishExplanation":"Be caused by an earlier condition.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"结果作主语，与result in的方向相反。","examples":[{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"5f947172-477d-4a09-ad48-60cb67bf7164","sentenceText":"Difficulty may result from unfamiliar terms rather than an unwillingness to learn.","translation":"困难可能源于陌生术语，而非不愿学习。","evidence":{"surface":"result from","start":15,"end":26,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    151,
    true
  ),
(
    '92d02a61-2d4a-5b09-85e3-5735a571feb9'::uuid,
    'phrase',
    '{"id":"92d02a61-2d4a-5b09-85e3-5735a571feb9","text":"rather than","phraseType":"other_phrase","meaning":"而非","optionalEnglishExplanation":"Instead of an alternative being contrasted.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"比较两侧尽量结构平行；不是每段必用。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"ba2dea57-62c8-57cd-9c48-122975e1aa03","sentenceText":"Before drafting, identify the writer’s main point and the links between sentences rather than translate word for word.","translation":"动笔前，先确定作者主旨与句间联系，不要逐词硬译。","evidence":{"surface":"rather than","start":82,"end":93,"rule":"exact"}},{"essayId":"db0ac466-ee60-57bf-82aa-0ac19f6484e2","sentenceId":"4126d075-64a4-575c-89eb-999aad5563a3","sentenceText":"It offers a chance to see technology in action rather than simply read about it.","translation":"它让你看到技术实际运用，而不只是读到有关介绍。","evidence":{"surface":"rather than","start":47,"end":58,"rule":"exact"},"exampleSentenceId":"31730cd5-851f-4b47-b648-f5f0f8b74433"},{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"a055726d-d932-5895-82e1-200fac595731","sentenceText":"For manufacturers, the lesson is to earn rather than assume consumers’ trust.","translation":"对厂商而言，启示是要赢得、而非想当然地拥有消费者信任。","evidence":{"surface":"rather than","start":41,"end":52,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    152,
    true
  ),
(
    '4fc887f9-521b-53d4-8b46-5bdc19e41390'::uuid,
    'phrase',
    '{"id":"4fc887f9-521b-53d4-8b46-5bdc19e41390","text":"not necessarily","phraseType":"other_phrase","meaning":"未必","optionalEnglishExplanation":"Not in every case or as an automatic consequence.","tags":["因果、条件与评价"],"priority":"P2","usageNote":"限定推断，不表示该判断一定错误。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"61e2bed7-4153-48b1-af74-c2d95d0ff9c3","sentenceText":"Yet choosing a screen does not necessarily mean abandoning deep reading, just as choosing paper does not guarantee concentration.","translation":"但选择屏幕未必意味着放弃深入阅读，正如选择纸张也不保证专注。","evidence":{"surface":"not necessarily","start":27,"end":42,"rule":"exact"},"exampleSentenceId":"9f53d954-7d0b-4759-a8e4-b79852870f58"}],"type":"phrase"}'::jsonb,
    153,
    true
  ),
(
    '1d61dc00-0162-5568-92ec-f493aa4d2cf4'::uuid,
    'phrase',
    '{"id":"1d61dc00-0162-5568-92ec-f493aa4d2cf4","text":"one possible explanation","phraseType":"noun_phrase","meaning":"一个可能解释","optionalEnglishExplanation":"One reasonable account of why something happens.","tags":["因果、条件与评价"],"priority":"P3","usageNote":"is that后接完整句。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"a2357308-fa11-43e2-8c3a-ce819773ee17","sentenceText":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines.","translation":"一个可能解释是更易参与的课程让规律身体活动更容易融入日常作息。","evidence":{"surface":"One possible explanation","start":0,"end":24,"rule":"exact"},"exampleSentenceId":"35c6354e-5f6a-42f1-a3af-b01637c9d05b"},{"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"834feef5-ed1b-5898-b2d9-684a11d51b9c","sentenceText":"One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries.","translation":"一种可能的解释是，更便宜的手机与更广的网络覆盖，让发展中国家的移动服务更易获取。","evidence":{"surface":"One possible explanation","start":0,"end":24,"rule":"exact"},"exampleSentenceId":"fbd25b78-1689-49fd-ac2d-6910c156bedf"}],"type":"phrase"}'::jsonb,
    154,
    true
  ),
(
    '77397bae-f371-5791-906d-a628c7b55652'::uuid,
    'phrase',
    '{"id":"77397bae-f371-5791-906d-a628c7b55652","text":"under these conditions","phraseType":"other_phrase","meaning":"在这些条件下","optionalEnglishExplanation":"Within the circumstances already described.","tags":["因果、条件与评价"],"priority":"P3","usageNote":"these必须有清楚前文所指。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"38600771-b386-4800-9f38-8627c43072d8","sentenceText":"Under these conditions, people may find it easier to maintain a habit instead of attending only occasionally.","translation":"在这些条件下，人们可能更容易保持习惯，而非偶尔参加。","evidence":{"surface":"Under these conditions","start":0,"end":22,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    155,
    true
  ),
(
    '18cafcd7-6e95-5ddc-8682-f036a0cca0d3'::uuid,
    'phrase',
    '{"id":"18cafcd7-6e95-5ddc-8682-f036a0cca0d3","text":"long-term benefits","phraseType":"noun_phrase","meaning":"长期收益","optionalEnglishExplanation":"Positive effects that continue over an extended period.","tags":["因果、条件与评价"],"priority":"P3","usageNote":"不要只写long-term而无条件或内容。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"972aab69-33bf-4b0a-abe9-ea64b343be39","sentenceText":"Even when growth slows, maintaining enjoyable, reliable opportunities can protect the long-term benefits of participation.","translation":"即使增长放缓，保持愉快、可靠的参与机会仍可维护长期收益。","evidence":{"surface":"long-term benefits","start":86,"end":104,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    156,
    true
  ),
(
    'f8fc87b4-f22d-586e-bd4d-069e0f47311d'::uuid,
    'phrase',
    '{"id":"f8fc87b4-f22d-586e-bd4d-069e0f47311d","text":"serve a clear purpose","phraseType":"verb_phrase","meaning":"服务于明确目的","optionalEnglishExplanation":"Contribute to an identifiable aim.","tags":["因果、条件与评价"],"priority":"P3","usageNote":"用于选择标准，不把所有人限定成相同目标。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"4dd7c151-3ca0-5006-84e0-d0e7fba484a3","sentenceText":"No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development.","translation":"没有哪条路天然更好：深造因服务明确目的而有价值，工作则因提供适合的发展前景而有价值。","evidence":{"surface":"serves a clear purpose","start":70,"end":92,"rule":"grammatical_variant"},"exampleSentenceId":"e9d6d92d-caab-4da6-be9f-8e52a6efd2a5"},{"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"bf11446b-8f8a-514b-8e7b-153b2af27d2f","sentenceText":"Mobile reading is most productive when accessibility serves a clear purpose: not simply to consume more words, but to understand, question and retain what is read.","translation":"便捷获取服务清楚目的时，手机阅读最有效：不只摄入更多文字，而是理解、质疑并记住所读。","evidence":{"surface":"serves a clear purpose","start":53,"end":75,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    157,
    true
  ),
(
    'f71fa0e1-eb2f-5cba-a8fb-fd0b3f933c01'::uuid,
    'phrase',
    '{"id":"f71fa0e1-eb2f-5cba-a8fb-fd0b3f933c01","text":"address specific concerns","phraseType":"verb_phrase","meaning":"回应具体关切","optionalEnglishExplanation":"Deal with clearly identified issues.","tags":["因果、条件与评价"],"priority":"P3","usageNote":"措施要与前面分析的需求对应。","examples":[{"essayId":"989d1b46-48f3-51a9-b788-c26e8ac1d042","sentenceId":"11d91b06-f0e4-50f1-b824-e3368f5af064","sentenceText":"Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need.","translation":"回应具体关切，比提供忽视真实需要的福利更有可能提升士气。","evidence":{"surface":"Addressing specific concerns","start":0,"end":28,"rule":"grammatical_variant"},"exampleSentenceId":"8e8ce4d5-c3b4-401d-9a43-4a3848cadf34"}],"type":"phrase"}'::jsonb,
    158,
    true
  ),
(
    'ed75a38f-ceb9-58ac-a3f9-3aa85f430fa2'::uuid,
    'phrase',
    '{"id":"ed75a38f-ceb9-58ac-a3f9-3aa85f430fa2","text":"balance competing needs","phraseType":"verb_phrase","meaning":"平衡相互竞争的需要","optionalEnglishExplanation":"Consider different demands that cannot all be fully satisfied.","tags":["因果、条件与评价"],"priority":"P3","usageNote":"写明需要之间的取舍，别只说balance。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"b5d6d723-7c68-4f2e-b653-309cb5d39661","sentenceText":"Planning must balance competing needs for speed, decent working conditions and environmental protection.","translation":"规划必须平衡速度、体面工作条件和环境保护的不同需要。","evidence":{"surface":"balance competing needs","start":14,"end":37,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    159,
    true
  ),
(
    '746def7c-537c-5c92-81c4-cb74acf025a2'::uuid,
    'phrase',
    '{"id":"746def7c-537c-5c92-81c4-cb74acf025a2","text":"practical experience","phraseType":"noun_phrase","meaning":"实践经验","optionalEnglishExplanation":"Knowledge gained by doing real tasks.","tags":["教育、能力与就业"],"priority":"P1","usageNote":"experience泛指经验通常不可数。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"72764995-94a4-54db-a234-d10627667919","sentenceText":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers.","translation":"随着毕业临近，实践经验更有价值：学生需要探索职业兴趣、发展可迁移技能，并向雇主展示能力。","evidence":{"surface":"practical experience","start":26,"end":46,"rule":"exact"},"exampleSentenceId":"26cdfd47-e838-47e5-ab16-714f64d19c5d"}],"type":"phrase"}'::jsonb,
    160,
    true
  ),
(
    '03f4e30f-eba7-52ee-9439-1ead6c976aa0'::uuid,
    'phrase',
    '{"id":"03f4e30f-eba7-52ee-9439-1ead6c976aa0","text":"transferable skills","phraseType":"noun_phrase","meaning":"可迁移技能","optionalEnglishExplanation":"Abilities useful in more than one job or setting.","tags":["教育、能力与就业"],"priority":"P1","usageNote":"应举具体技能，不只使用高级名词。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"72764995-94a4-54db-a234-d10627667919","sentenceText":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers.","translation":"随着毕业临近，实践经验更有价值：学生需要探索职业兴趣、发展可迁移技能，并向雇主展示能力。","evidence":{"surface":"transferable skills","start":118,"end":137,"rule":"exact"},"exampleSentenceId":"26cdfd47-e838-47e5-ab16-714f64d19c5d"},{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"46673c71-4c85-4ba1-847e-8d4ce4bced42","sentenceText":"Meaningful feedback helps them see why an approach worked, creating transferable skills rather than a habit of following instructions.","translation":"有实际帮助的反馈让他们看清方法为何有效，培养可迁移技能，而非只习惯照指令做。","evidence":{"surface":"transferable skills","start":68,"end":87,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    161,
    true
  ),
(
    '3602876e-b9ec-5447-99db-32501e7ac60d'::uuid,
    'phrase',
    '{"id":"3602876e-b9ec-5447-99db-32501e7ac60d","text":"test career interests","phraseType":"verb_phrase","meaning":"探索职业兴趣","optionalEnglishExplanation":"Explore whether a type of work matches personal interests.","tags":["教育、能力与就业"],"priority":"P1","usageNote":"通过体验检验兴趣，不是职业测验分数。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"72764995-94a4-54db-a234-d10627667919","sentenceText":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers.","translation":"随着毕业临近，实践经验更有价值：学生需要探索职业兴趣、发展可迁移技能，并向雇主展示能力。","evidence":{"surface":"test career interests","start":87,"end":108,"rule":"exact"},"exampleSentenceId":"26cdfd47-e838-47e5-ab16-714f64d19c5d"}],"type":"phrase"}'::jsonb,
    162,
    true
  ),
(
    '9efcd2c4-53e9-5b4b-b1ee-8e565764db86'::uuid,
    'phrase',
    '{"id":"9efcd2c4-53e9-5b4b-b1ee-8e565764db86","text":"prepare for employment","phraseType":"verb_phrase","meaning":"为就业作准备","optionalEnglishExplanation":"Get ready to enter the labour market.","tags":["教育、能力与就业"],"priority":"P1","usageNote":"只作合理动机解释，不声称人人如此。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"12058a17-dbc4-5808-96cb-da22270bfede","sentenceText":"A carefully chosen position can help students prepare for employment.","translation":"精心选择的岗位可帮助学生为就业作准备。","evidence":{"surface":"prepare for employment","start":46,"end":68,"rule":"exact"}},{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"c6d37f99-1880-4f48-97c8-17da85c3fe8e","sentenceText":"The pattern suggests that immediate pay is not the only concern as students prepare for employment.","translation":"这一分布表明，学生为就业作准备时，眼前收入并非唯一关切。","evidence":{"surface":"prepare for employment","start":76,"end":98,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    163,
    true
  ),
(
    '7b27c8a6-f1ef-5344-989a-a5e51a279310'::uuid,
    'phrase',
    '{"id":"7b27c8a6-f1ef-5344-989a-a5e51a279310","text":"independent learning","phraseType":"noun_phrase","meaning":"自主学习","optionalEnglishExplanation":"Learning that involves taking responsibility for one''s own study.","tags":["教育、能力与就业"],"priority":"P1","usageNote":"与自学完全不听指导区分。","examples":[{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"34af1a47-b56f-4009-bc26-c831a452972e","sentenceText":"Digital resources are available, but availability alone does not guarantee independent learning in practice.","translation":"数字资源虽可获得，可得性本身并不保证自主学习。","evidence":{"surface":"independent learning","start":75,"end":95,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    164,
    true
  ),
(
    'c4f29ac7-1a98-53a8-b0ab-3b109e8f102c'::uuid,
    'phrase',
    '{"id":"c4f29ac7-1a98-53a8-b0ab-3b109e8f102c","text":"meaningful feedback","phraseType":"noun_phrase","meaning":"有实际帮助的反馈","optionalEnglishExplanation":"Information that gives useful guidance for improvement.","tags":["教育、能力与就业"],"priority":"P1","usageNote":"说明问题和改进方向，比只有分数更具体。","examples":[{"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"7fcb6aca-954f-4403-9e70-92d73c395a65","sentenceText":"Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise.","translation":"寻求有实际帮助的反馈来发现薄弱处，再把所学用于下一次练习。","evidence":{"surface":"meaningful feedback","start":5,"end":24,"rule":"exact"},"exampleSentenceId":"c1219933-0b3a-4ce7-918b-2fdf62eadb75"},{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"46673c71-4c85-4ba1-847e-8d4ce4bced42","sentenceText":"Meaningful feedback helps them see why an approach worked, creating transferable skills rather than a habit of following instructions.","translation":"有实际帮助的反馈让他们看清方法为何有效，培养可迁移技能，而非只习惯照指令做。","evidence":{"surface":"Meaningful feedback","start":0,"end":19,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    165,
    true
  ),
(
    '68a3fbfd-b197-56b0-9e42-1041dd289813'::uuid,
    'phrase',
    '{"id":"68a3fbfd-b197-56b0-9e42-1041dd289813","text":"bridge the gap","phraseType":"verb_phrase","meaning":"弥合差距","optionalEnglishExplanation":"Connect two areas that are separated in practice.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"后用between A and B，不让gap指代不明。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"600333e6-13b6-41ff-aaf3-c2da287255ee","sentenceText":"Learning by doing can bridge the gap between knowing an idea and putting it into practice.","translation":"在做中学可弥合了解一个想法与将其付诸实践的差距。","evidence":{"surface":"bridge the gap","start":22,"end":36,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    166,
    true
  ),
(
    'f18e11fa-28b6-5e77-b623-d6baf6b1fd1c'::uuid,
    'phrase',
    '{"id":"f18e11fa-28b6-5e77-b623-d6baf6b1fd1c","text":"academic responsibilities","phraseType":"noun_phrase","meaning":"学业责任","optionalEnglishExplanation":"Duties associated with study and coursework.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"并非所有兼职都必然影响学业。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"bc29b762-4c1a-4fc7-9fe8-31629384ede8","sentenceText":"Useful support should protect academic responsibilities while creating time for exploration.","translation":"有效支持应保护学业责任，同时为探索创造时间。","evidence":{"surface":"academic responsibilities","start":30,"end":55,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    167,
    true
  ),
(
    '7634add6-81fa-58c0-8928-b405f36eebe3'::uuid,
    'phrase',
    '{"id":"7634add6-81fa-58c0-8928-b405f36eebe3","text":"a sense of achievement","phraseType":"noun_phrase","meaning":"成就感","optionalEnglishExplanation":"Satisfaction from accomplishing something worthwhile.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"a sense of不可省成achievement作所有情况。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"56dfe76a-082a-4389-bd6a-895f069271dd","sentenceText":"Completing useful work can also produce a sense of achievement, linking effort with visible results.","translation":"完成有用工作还可带来成就感，把努力与可见结果联系起来。","evidence":{"surface":"a sense of achievement","start":40,"end":62,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    168,
    true
  ),
(
    '7a78a852-c8f3-55c8-840d-ea9f406a23f7'::uuid,
    'phrase',
    '{"id":"7a78a852-c8f3-55c8-840d-ea9f406a23f7","text":"complementary roles","phraseType":"noun_phrase","meaning":"互补角色","optionalEnglishExplanation":"Different responsibilities that support one another.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"互补意味着任务需彼此配合，不只各做各的。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"6b8fed24-6525-467b-9af8-e2890126b166","sentenceText":"Teamwork additionally requires shared goals and complementary roles that make members depend on one another.","translation":"团队合作还需要共同目标与互补角色，让成员相互依赖。","evidence":{"surface":"complementary roles","start":48,"end":67,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    169,
    true
  ),
(
    '327ec3f3-726c-5ba8-9e7f-9f37da9d06eb'::uuid,
    'phrase',
    '{"id":"327ec3f3-726c-5ba8-9e7f-9f37da9d06eb","text":"shared goals","phraseType":"noun_phrase","meaning":"共同目标","optionalEnglishExplanation":"Aims held jointly by people working together.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"搭配协调或互相依赖，形成机制。","examples":[{"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"9fd67ccb-1fc2-5202-bb4f-1ddf4e59fcf4","sentenceText":"Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another.","translation":"但合作不会仅因学生在同一地点工作就产生，它需要共同目标与真实的相互依赖。","evidence":{"surface":"shared goals","start":97,"end":109,"rule":"exact"},"exampleSentenceId":"ed02ab3a-44cd-41c0-bb46-b8e2851ce3c4"},{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"6b8fed24-6525-467b-9af8-e2890126b166","sentenceText":"Teamwork additionally requires shared goals and complementary roles that make members depend on one another.","translation":"团队合作还需要共同目标与互补角色，让成员相互依赖。","evidence":{"surface":"shared goals","start":31,"end":43,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    170,
    true
  ),
(
    '8f232528-0303-5195-9cde-21eebee80c32'::uuid,
    'phrase',
    '{"id":"8f232528-0303-5195-9cde-21eebee80c32","text":"reflect on experience","phraseType":"verb_phrase","meaning":"反思经历","optionalEnglishExplanation":"Think carefully about what an experience teaches.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"reflect on后接名词，指总结学习。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"76cfbe61-3dab-4a49-a871-2cf100558038","sentenceText":"A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience.","translation":"有明确学习目标的任务要求学生运用判断力、回应结果并反思经历。","evidence":{"surface":"reflect on experience","start":98,"end":119,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    171,
    true
  ),
(
    '7faaa4c3-e12d-50c9-ba69-266529f86cc4'::uuid,
    'phrase',
    '{"id":"7faaa4c3-e12d-50c9-ba69-266529f86cc4","text":"career guidance","phraseType":"noun_phrase","meaning":"职业指导","optionalEnglishExplanation":"Advice and information about work and career decisions.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"guidance通常不可数。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"1549fddc-0434-4c4b-afec-b149ce3342bc","sentenceText":"Career guidance can provide informed advice about opportunities that may be worth exploring.","translation":"职业指导可就值得探索的机会提供有依据的建议。","evidence":{"surface":"Career guidance","start":0,"end":15,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    172,
    true
  ),
(
    '722a194c-4dc7-55cd-97d4-81c0d7b77e9c'::uuid,
    'phrase',
    '{"id":"722a194c-4dc7-55cd-97d4-81c0d7b77e9c","text":"postgraduate study","phraseType":"noun_phrase","meaning":"研究生阶段学习","optionalEnglishExplanation":"Study undertaken after a first university degree.","tags":["教育、能力与就业"],"priority":"P2","usageNote":"不是把升学普遍说成更优路径。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"43446e14-d630-5caa-9096-7c807af6ab05","sentenceText":"Students need realistic information about employment, postgraduate study and business risks, alongside opportunities to assess their own strengths.","translation":"学生需要关于就业、研究生学习和创业风险的现实信息，也需要评估个人优势的机会。","evidence":{"surface":"postgraduate study","start":54,"end":72,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    173,
    true
  ),
(
    '58a78f5e-c845-5fb6-bb62-2446218e03ec'::uuid,
    'phrase',
    '{"id":"58a78f5e-c845-5fb6-bb62-2446218e03ec","text":"recruitment standards","phraseType":"noun_phrase","meaning":"招聘标准","optionalEnglishExplanation":"Criteria used to judge applicants for employment.","tags":["教育、能力与就业"],"priority":"P3","usageNote":"may和some防止绝对化。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"2a689051-cc6d-527b-bea6-a7476af61672","sentenceText":"Faced with demanding recruitment standards, graduates may regard additional education as an investment in future opportunities.","translation":"面对较高招聘标准，毕业生可能把额外教育视为对未来机会的投资。","evidence":{"surface":"recruitment standards","start":21,"end":42,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    174,
    true
  ),
(
    'fe1778c5-1c31-51a8-9c4c-84c214a2013e'::uuid,
    'phrase',
    '{"id":"fe1778c5-1c31-51a8-9c4c-84c214a2013e","text":"strengthen qualifications","phraseType":"verb_phrase","meaning":"提升资历","optionalEnglishExplanation":"Improve evidence of relevant knowledge or ability.","tags":["教育、能力与就业"],"priority":"P3","usageNote":"重在相关能力，不暗示证书越多越好。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"23adccce-5fd4-4551-bd00-63d451d064c0","sentenceText":"Further study may strengthen qualifications, but it is a better fit only when it serves a genuine learning need.","translation":"深造可能提升资历，但只有服务真实学习需要时才更合适。","evidence":{"surface":"strengthen qualifications","start":18,"end":43,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    175,
    true
  ),
(
    '8791b8d0-4dc3-5c10-9d18-4fb52d96a22a'::uuid,
    'phrase',
    '{"id":"8791b8d0-4dc3-5c10-9d18-4fb52d96a22a","text":"assess personal strengths","phraseType":"verb_phrase","meaning":"评估个人优势","optionalEnglishExplanation":"Evaluate abilities that may suit particular tasks.","tags":["教育、能力与就业"],"priority":"P3","usageNote":"与实际任务或反馈相连更具体。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"2838c5ab-6625-4af0-82d7-cb5b3593b1e1","sentenceText":"Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses.","translation":"实践岗位可拓宽他们的视野，帮助评估个人优势并发现薄弱处。","evidence":{"surface":"assess personal strengths","start":62,"end":87,"rule":"exact"},"exampleSentenceId":"dbeb8394-61cd-458a-9e52-0708a77f8924"}],"type":"phrase"}'::jsonb,
    176,
    true
  ),
(
    '69a683c7-f126-5468-86dc-5bcf029bfdbd'::uuid,
    'phrase',
    '{"id":"69a683c7-f126-5468-86dc-5bcf029bfdbd","text":"exercise judgement","phraseType":"verb_phrase","meaning":"运用判断力","optionalEnglishExplanation":"Use reason to make a decision in a situation.","tags":["教育、能力与就业"],"priority":"P3","usageNote":"judgement为英式拼写，本包统一采用。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"76cfbe61-3dab-4a49-a871-2cf100558038","sentenceText":"A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience.","translation":"有明确学习目标的任务要求学生运用判断力、回应结果并反思经历。","evidence":{"surface":"exercise judgement","start":55,"end":73,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    177,
    true
  ),
(
    'fc0d3968-3bba-5c56-9042-6223dd78bc13'::uuid,
    'phrase',
    '{"id":"fc0d3968-3bba-5c56-9042-6223dd78bc13","text":"learning by doing","phraseType":"noun_phrase","meaning":"在做中学","optionalEnglishExplanation":"Develop understanding through practical action.","tags":["教育、能力与就业"],"priority":"P3","usageNote":"适合实践主题，不是任何背诵都能替代。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"600333e6-13b6-41ff-aaf3-c2da287255ee","sentenceText":"Learning by doing can bridge the gap between knowing an idea and putting it into practice.","translation":"在做中学可弥合了解一个想法与将其付诸实践的差距。","evidence":{"surface":"Learning by doing","start":0,"end":17,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    178,
    true
  ),
(
    '6f80e382-8479-5d9e-a5dd-6021ea913dd0'::uuid,
    'phrase',
    '{"id":"6f80e382-8479-5d9e-a5dd-6021ea913dd0","text":"a clear learning goal","phraseType":"noun_phrase","meaning":"明确学习目标","optionalEnglishExplanation":"A specific outcome that study or practice aims to achieve.","tags":["教育、能力与就业"],"priority":"P3","usageNote":"goal需能解释任务作用。","examples":[{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"76cfbe61-3dab-4a49-a871-2cf100558038","sentenceText":"A task with a clear learning goal requires students to exercise judgement, respond to results and reflect on experience.","translation":"有明确学习目标的任务要求学生运用判断力、回应结果并反思经历。","evidence":{"surface":"a clear learning goal","start":12,"end":33,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    179,
    true
  ),
(
    '2b552210-fa64-5de3-80c6-c85caa333f58'::uuid,
    'phrase',
    '{"id":"2b552210-fa64-5de3-80c6-c85caa333f58","text":"access reliable information","phraseType":"verb_phrase","meaning":"获取可靠信息","optionalEnglishExplanation":"Obtain information from trustworthy sources.","tags":["科技、信息与健康"],"priority":"P1","usageNote":"access在此为动词，后直接接宾语。","examples":[{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"afe4a050-ac51-4ad5-9023-fa42003ed520","sentenceText":"To access reliable information, people need more than an internet connection.","translation":"要获取可靠信息，人们需要的不只是网络连接。","evidence":{"surface":"access reliable information","start":3,"end":30,"rule":"exact"}},{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"9b25f170-6492-4be2-9fc0-60264c14a828","sentenceText":"Students need to access reliable information and make informed choices about both content and the way they use it.","translation":"学生需要获取可靠信息，并就内容和使用方式作出有依据的选择。","evidence":{"surface":"access reliable information","start":17,"end":44,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    180,
    true
  ),
(
    'c685ab0a-73d2-54e5-bcc3-071df528a804'::uuid,
    'phrase',
    '{"id":"c685ab0a-73d2-54e5-bcc3-071df528a804","text":"sustained attention","phraseType":"noun_phrase","meaning":"持续专注","optionalEnglishExplanation":"Concentration maintained over a period of time.","tags":["科技、信息与健康"],"priority":"P1","usageNote":"不把获取文本等同于理解。","examples":[{"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"ff0566af-39a9-500d-9b76-fca6827b8fba","sentenceText":"The challenge is therefore to turn convenience into sustained attention.","translation":"因此，挑战是把便利转为持续注意。","evidence":{"surface":"sustained attention","start":52,"end":71,"rule":"exact"}},{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"42eda2d8-c9ee-4127-8806-a3c7e9a50e43","sentenceText":"Readers should protect time for sustained attention and choose materials that suit their purposes.","translation":"读者应保护持续专注时间，选择符合目的的材料。","evidence":{"surface":"sustained attention","start":32,"end":51,"rule":"exact"}},{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"6a5e3d29-e47f-4616-bdf0-a184fb1ab707","sentenceText":"The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning.","translation":"提供数字资源的同一设备也会带来给注意力造成压力的消息与干扰，因此持续专注成为自主学习的重要部分。","evidence":{"surface":"sustained attention","start":131,"end":150,"rule":"exact"},"exampleSentenceId":"0a10d930-e9e6-4946-a302-3d838ab1abf2"}],"type":"phrase"}'::jsonb,
    181,
    true
  ),
(
    '8a804931-dca0-5234-977a-4ad7c5af83b8'::uuid,
    'phrase',
    '{"id":"8a804931-dca0-5234-977a-4ad7c5af83b8","text":"health literacy","phraseType":"noun_phrase","meaning":"健康素养","optionalEnglishExplanation":"The ability to obtain, understand and use health information.","tags":["科技、信息与健康"],"priority":"P1","usageNote":"不是健康人数比例或一般识字率。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"dcf88a02-2f01-5a35-849d-7c1e208e159f","sentenceText":"The line chart records a sustained improvement in health literacy among Chinese residents from 2012 to 2021.","translation":"折线图记录2012至2021年中国居民健康素养持续改善。","evidence":{"surface":"health literacy","start":50,"end":65,"rule":"exact"}},{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"7d55f22d-806a-4e5c-abfc-4f684b8cacd3","sentenceText":"The goal is health literacy that supports informed action, not simply a larger flow of messages.","translation":"目标是支持知情行动的健康素养，而不只是更多信息流。","evidence":{"surface":"health literacy","start":12,"end":27,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    182,
    true
  ),
(
    'b932c79d-77a2-5425-b5d9-e804816929ea'::uuid,
    'phrase',
    '{"id":"b932c79d-77a2-5425-b5d9-e804816929ea","text":"regular physical activity","phraseType":"noun_phrase","meaning":"规律身体活动","optionalEnglishExplanation":"Repeated bodily movement that involves being active.","tags":["科技、信息与健康"],"priority":"P1","usageNote":"一般性学习语料，不是针对个人的医疗建议。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"a2357308-fa11-43e2-8c3a-ce819773ee17","sentenceText":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines.","translation":"一个可能解释是更易参与的课程让规律身体活动更容易融入日常作息。","evidence":{"surface":"regular physical activity","start":63,"end":88,"rule":"exact"},"exampleSentenceId":"35c6354e-5f6a-42f1-a3af-b01637c9d05b"}],"type":"phrase"}'::jsonb,
    183,
    true
  ),
(
    'df783be1-4dfb-5c36-81f8-5d847b5d21d6'::uuid,
    'phrase',
    '{"id":"df783be1-4dfb-5c36-81f8-5d847b5d21d6","text":"make informed choices","phraseType":"verb_phrase","meaning":"作出有依据的选择","optionalEnglishExplanation":"Decide using relevant understanding rather than guesswork.","tags":["科技、信息与健康"],"priority":"P1","usageNote":"informed指掌握必要信息。","examples":[{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"9b25f170-6492-4be2-9fc0-60264c14a828","sentenceText":"Students need to access reliable information and make informed choices about both content and the way they use it.","translation":"学生需要获取可靠信息，并就内容和使用方式作出有依据的选择。","evidence":{"surface":"make informed choices","start":49,"end":70,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    184,
    true
  ),
(
    '5bbc6f24-3e8e-5d98-99f6-47392ec1387b'::uuid,
    'phrase',
    '{"id":"5bbc6f24-3e8e-5d98-99f6-47392ec1387b","text":"fit into daily routines","phraseType":"verb_phrase","meaning":"融入日常作息","optionalEnglishExplanation":"Be incorporated into ordinary schedules.","tags":["科技、信息与健康"],"priority":"P1","usageNote":"fit into后接安排或环境。","examples":[{"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"5333f4b5-8ba9-51f5-b636-779248e920b2","sentenceText":"Organized activities can be useful, but fixed times and locations may make them harder to fit into daily routines.","translation":"有组织活动可能有用，但固定时间地点更难融入日常作息。","evidence":{"surface":"fit into daily routines","start":90,"end":113,"rule":"exact"}},{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"a2357308-fa11-43e2-8c3a-ce819773ee17","sentenceText":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines.","translation":"一个可能解释是更易参与的课程让规律身体活动更容易融入日常作息。","evidence":{"surface":"fit into daily routines","start":99,"end":122,"rule":"exact"},"exampleSentenceId":"35c6354e-5f6a-42f1-a3af-b01637c9d05b"}],"type":"phrase"}'::jsonb,
    185,
    true
  ),
(
    'd6fe6c6a-33a5-5603-bfb4-8dd37908a1dd'::uuid,
    'phrase',
    '{"id":"d6fe6c6a-33a5-5603-bfb4-8dd37908a1dd","text":"digital resources","phraseType":"noun_phrase","meaning":"数字资源","optionalEnglishExplanation":"Information and materials available electronically.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"可达性是潜在优势，不自动等于学习成效。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"4a89bdf1-5b33-454e-b315-2712bfe16c66","sentenceText":"Digital resources offer instant access to books without requiring readers to carry them.","translation":"数字资源让读者无需携带实体书也能即时获取书籍。","evidence":{"surface":"Digital resources","start":0,"end":17,"rule":"exact"}},{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"34af1a47-b56f-4009-bc26-c831a452972e","sentenceText":"Digital resources are available, but availability alone does not guarantee independent learning in practice.","translation":"数字资源虽可获得，可得性本身并不保证自主学习。","evidence":{"surface":"Digital resources","start":0,"end":17,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    186,
    true
  ),
(
    '57a98c32-8396-50a8-a987-3fd12e96f631'::uuid,
    'phrase',
    '{"id":"57a98c32-8396-50a8-a987-3fd12e96f631","text":"reduce distractions","phraseType":"verb_phrase","meaning":"减少干扰","optionalEnglishExplanation":"Limit things that draw attention away from a task.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"措施应与手机阅读情境相连。","examples":[{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"d554d968-edd2-426c-9175-19bc834ec464","sentenceText":"A practical start is to reduce distractions, select one text and reserve a short period for concentrated reading.","translation":"可行的开始是减少干扰、选定一篇文本，并留出短时专注阅读。","evidence":{"surface":"reduce distractions","start":24,"end":43,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    187,
    true
  ),
(
    '000c3166-4e82-58ec-9499-3b9243e6ba34'::uuid,
    'phrase',
    '{"id":"000c3166-4e82-58ec-9499-3b9243e6ba34","text":"reliable sources","phraseType":"noun_phrase","meaning":"可靠来源","optionalEnglishExplanation":"Origins of information that can reasonably be trusted.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"不等于凡是线上来源都不可靠。","examples":[{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"9c988b68-6335-468f-ace3-1bf39d2a0993","sentenceText":"They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations.","translation":"他们必须判断可靠性、比较可靠来源，区分误导性说法与可信解释。","evidence":{"surface":"reliable sources","start":37,"end":53,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    188,
    true
  ),
(
    '992b6127-fafb-5297-a760-86e125de8430'::uuid,
    'phrase',
    '{"id":"992b6127-fafb-5297-a760-86e125de8430","text":"judge reliability","phraseType":"verb_phrase","meaning":"判断可靠性","optionalEnglishExplanation":"Evaluate whether information deserves trust.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"此处词组概括能力，具体文中可补of information。","examples":[{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"9c988b68-6335-468f-ace3-1bf39d2a0993","sentenceText":"They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations.","translation":"他们必须判断可靠性、比较可靠来源，区分误导性说法与可信解释。","evidence":{"surface":"judge reliability","start":10,"end":27,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    189,
    true
  ),
(
    '53cead28-a440-5dd4-ba51-70a09e34b269'::uuid,
    'phrase',
    '{"id":"53cead28-a440-5dd4-ba51-70a09e34b269","text":"turn knowledge into action","phraseType":"verb_phrase","meaning":"把知识转为行动","optionalEnglishExplanation":"Apply understanding in actual behaviour.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"说明具体行动更能避免空话。","examples":[{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"c6c06063-068f-481c-91cf-ccde929a46b7","sentenceText":"Practical guidance can then help them turn knowledge into action, including everyday decisions about disease prevention.","translation":"随后，实用指导可帮助把知识转为行动，包括有关疾病预防的日常决定。","evidence":{"surface":"turn knowledge into action","start":38,"end":64,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    190,
    true
  ),
(
    '512edf46-8581-591c-90f6-dd4e989d8653'::uuid,
    'phrase',
    '{"id":"512edf46-8581-591c-90f6-dd4e989d8653","text":"disease prevention","phraseType":"noun_phrase","meaning":"疾病预防","optionalEnglishExplanation":"Measures and knowledge intended to reduce illness.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"写公共教育机制，不编造医学结论。","examples":[{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"c6c06063-068f-481c-91cf-ccde929a46b7","sentenceText":"Practical guidance can then help them turn knowledge into action, including everyday decisions about disease prevention.","translation":"随后，实用指导可帮助把知识转为行动，包括有关疾病预防的日常决定。","evidence":{"surface":"disease prevention","start":101,"end":119,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    191,
    true
  ),
(
    'f0013305-d743-5031-8b23-9d93c5d63c98'::uuid,
    'phrase',
    '{"id":"f0013305-d743-5031-8b23-9d93c5d63c98","text":"plain language","phraseType":"noun_phrase","meaning":"通俗语言","optionalEnglishExplanation":"Clear words that are easy for non-specialists to understand.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"plain表示易懂，不表示粗糙。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"c82bc04f-9d07-5163-a7f8-72ecc53e84bf","sentenceText":"Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims.","translation":"公共教育可以通过使用通俗语言、呈现熟悉情境，并帮助人们区分可靠建议与误导性说法发挥作用。","evidence":{"surface":"plain language","start":35,"end":49,"rule":"exact"},"exampleSentenceId":"b800ce6d-cec7-41e6-bea1-bfa2e01d17dc"},{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"e0b3e032-f729-46db-8868-b39c578ac752","sentenceText":"Health education should therefore use plain language and familiar situations, asking residents to explain how advice applies to a concrete example.","translation":"因此，健康教育应使用通俗语言和熟悉情境，请居民解释建议如何用于具体例子。","evidence":{"surface":"plain language","start":38,"end":52,"rule":"exact"},"exampleSentenceId":"c74ff098-f9b9-47ad-97b4-388c433f103d"}],"type":"phrase"}'::jsonb,
    192,
    true
  ),
(
    '6f220f48-70eb-5685-b09c-c43a08e11df9'::uuid,
    'phrase',
    '{"id":"6f220f48-70eb-5685-b09c-c43a08e11df9","text":"misleading claims","phraseType":"noun_phrase","meaning":"误导性说法","optionalEnglishExplanation":"Statements likely to create a false understanding.","tags":["科技、信息与健康"],"priority":"P2","usageNote":"distinguish A from B结构。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"c82bc04f-9d07-5163-a7f8-72ecc53e84bf","sentenceText":"Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims.","translation":"公共教育可以通过使用通俗语言、呈现熟悉情境，并帮助人们区分可靠建议与误导性说法发挥作用。","evidence":{"surface":"misleading claims","start":131,"end":148,"rule":"exact"},"exampleSentenceId":"b800ce6d-cec7-41e6-bea1-bfa2e01d17dc"},{"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"9c988b68-6335-468f-ace3-1bf39d2a0993","sentenceText":"They must judge reliability, compare reliable sources and distinguish misleading claims from sound explanations.","translation":"他们必须判断可靠性、比较可靠来源，区分误导性说法与可信解释。","evidence":{"surface":"misleading claims","start":70,"end":87,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    193,
    true
  ),
(
    '1d7a1637-c702-5f02-806e-018df7912903'::uuid,
    'phrase',
    '{"id":"1d7a1637-c702-5f02-806e-018df7912903","text":"personal circumstances","phraseType":"noun_phrase","meaning":"个人处境","optionalEnglishExplanation":"The conditions affecting an individual''s life.","tags":["科技、信息与健康"],"priority":"P3","usageNote":"不以群体平均替代个人判断。","examples":[{"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"8a148d51-9e18-4cbf-9025-21b42b80274b","sentenceText":"Students must weigh the options in light of personal circumstances and incomplete knowledge of the changing workplace.","translation":"学生必须结合个人处境及对职场的不充分了解权衡选项。","evidence":{"surface":"personal circumstances","start":44,"end":66,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    194,
    true
  ),
(
    '0c1bff12-5b4b-56a4-8b01-52f011919c3a'::uuid,
    'phrase',
    '{"id":"0c1bff12-5b4b-56a4-8b01-52f011919c3a","text":"choose your own pace","phraseType":"verb_phrase","meaning":"选择自己的节奏","optionalEnglishExplanation":"Decide how quickly to proceed.","tags":["科技、信息与健康"],"priority":"P3","usageNote":"pace可以是活动速度或进程。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"82b0ef57-b650-4b7c-b414-676b1d60896e","sentenceText":"Flexible sessions allow participants to choose their own pace, while exercising with neighbours offers mutual encouragement.","translation":"灵活课程让参与者自行选择节奏，与邻居锻炼则提供相互鼓励。","evidence":{"surface":"choose their own pace","start":40,"end":61,"rule":"grammatical_variant"}}],"type":"phrase"}'::jsonb,
    195,
    true
  ),
(
    '3cf8c205-e383-5820-b097-7f3dba72048f'::uuid,
    'phrase',
    '{"id":"3cf8c205-e383-5820-b097-7f3dba72048f","text":"mutual encouragement","phraseType":"noun_phrase","meaning":"相互鼓励","optionalEnglishExplanation":"Support that people give one another.","tags":["科技、信息与健康"],"priority":"P3","usageNote":"解释陪伴收益，不说人人必须结伴。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"82b0ef57-b650-4b7c-b414-676b1d60896e","sentenceText":"Flexible sessions allow participants to choose their own pace, while exercising with neighbours offers mutual encouragement.","translation":"灵活课程让参与者自行选择节奏，与邻居锻炼则提供相互鼓励。","evidence":{"surface":"mutual encouragement","start":103,"end":123,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    196,
    true
  ),
(
    '82b85957-48a6-501f-9761-8a4965b625fe'::uuid,
    'phrase',
    '{"id":"82b85957-48a6-501f-9761-8a4965b625fe","text":"maintain a habit","phraseType":"verb_phrase","meaning":"保持习惯","optionalEnglishExplanation":"Continue a regular behaviour over time.","tags":["科技、信息与健康"],"priority":"P3","usageNote":"要说明是什么习惯，例句用于已知上下文。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"38600771-b386-4800-9f38-8627c43072d8","sentenceText":"Under these conditions, people may find it easier to maintain a habit instead of attending only occasionally.","translation":"在这些条件下，人们可能更容易保持习惯，而非偶尔参加。","evidence":{"surface":"maintain a habit","start":53,"end":69,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    197,
    true
  ),
(
    '19511331-7554-59e5-9f36-d193f3c1324e'::uuid,
    'phrase',
    '{"id":"19511331-7554-59e5-9f36-d193f3c1324e","text":"instant access","phraseType":"noun_phrase","meaning":"即时获取","optionalEnglishExplanation":"The ability to obtain something immediately.","tags":["科技、信息与健康"],"priority":"P3","usageNote":"用于区分便利与效果。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"4a89bdf1-5b33-454e-b315-2712bfe16c66","sentenceText":"Digital resources offer instant access to books without requiring readers to carry them.","translation":"数字资源让读者无需携带实体书也能即时获取书籍。","evidence":{"surface":"instant access","start":24,"end":38,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    198,
    true
  ),
(
    '027f8e5a-af3b-5bb7-a0bd-e1e9be405ce8'::uuid,
    'phrase',
    '{"id":"027f8e5a-af3b-5bb7-a0bd-e1e9be405ce8","text":"a deliberate choice","phraseType":"noun_phrase","meaning":"经过考虑的选择","optionalEnglishExplanation":"A decision made intentionally after thought.","tags":["科技、信息与健康"],"priority":"P3","usageNote":"deliberate强调有意识考虑，不是拖延。","examples":[{"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"76f0cd17-2306-425e-a4c8-12f84e4e67fc","sentenceText":"This convenience can contribute to a deliberate choice of format, especially for people reading between other commitments.","translation":"这种便利有助于形成有意识的媒介选择，尤其对在其他事务间隙阅读的人。","evidence":{"surface":"a deliberate choice","start":35,"end":54,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    199,
    true
  ),
(
    'c19256fd-6b99-58f7-a802-0bf8f8394be8'::uuid,
    'phrase',
    '{"id":"c19256fd-6b99-58f7-a802-0bf8f8394be8","text":"cultural engagement","phraseType":"noun_phrase","meaning":"文化参与","optionalEnglishExplanation":"Active involvement with cultural ideas and activities.","tags":["文化、社区与人际联系"],"priority":"P1","usageNote":"与理解、互动等具体体验相连。","examples":[{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"b1625c5d-f0bc-5280-a75a-d1141bc498e5","sentenceText":"By helping visitors understand what they see, museums can ensure that wider access leads to deeper cultural engagement rather than simply larger crowds.","translation":"帮助来访者理解所见，能确保更广接触通向更深文化参与，而不只是更大人流。","evidence":{"surface":"cultural engagement","start":99,"end":118,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    200,
    true
  ),
(
    'ec263347-f605-59d7-a4cf-078fe9f8e054'::uuid,
    'phrase',
    '{"id":"ec263347-f605-59d7-a4cf-078fe9f8e054","text":"a sense of belonging","phraseType":"noun_phrase","meaning":"归属感","optionalEnglishExplanation":"A feeling of being accepted as part of a group.","tags":["文化、社区与人际联系"],"priority":"P1","usageNote":"需说明参与怎样带来联系。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"1b8355bc-70b2-4d54-a48c-c4fec12a3fc6","sentenceText":"These overlapping gains suggest that meaningful participation can combine personal growth with a sense of belonging.","translation":"这些可重叠收益表明，有意义的参与能结合个人成长与归属感。","evidence":{"surface":"a sense of belonging","start":95,"end":115,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    201,
    true
  ),
(
    'f258e060-e128-5d0e-bf0e-46d7b5eb2e83'::uuid,
    'phrase',
    '{"id":"f258e060-e128-5d0e-bf0e-46d7b5eb2e83","text":"maintain relationships","phraseType":"verb_phrase","meaning":"维系关系","optionalEnglishExplanation":"Keep personal connections active and meaningful.","tags":["文化、社区与人际联系"],"priority":"P1","usageNote":"不能仅以花钱多少衡量关系。","examples":[{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"f95df850-ab19-5c21-9cfa-51ff892a6f23","sentenceText":"These benefits matter particularly when people eat together to celebrate or maintain relationships.","translation":"人们为庆祝或维系关系而共餐时，这些收益尤其重要。","evidence":{"surface":"maintain relationships","start":76,"end":98,"rule":"exact"}},{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"9c338162-f9a3-4e4d-90c4-e7e39b6039df","sentenceText":"Accessible public spaces make it easier to meet neighbours, practise skills and maintain relationships.","translation":"便于使用的公共空间让居民更易结识邻居、练习技能并维系关系。","evidence":{"surface":"maintain relationships","start":80,"end":102,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    202,
    true
  ),
(
    '5789fd18-4223-5da2-a6af-ed2ebb9f5301'::uuid,
    'phrase',
    '{"id":"5789fd18-4223-5da2-a6af-ed2ebb9f5301","text":"meet diverse needs","phraseType":"verb_phrase","meaning":"满足多样需要","optionalEnglishExplanation":"Respond to different people''s requirements.","tags":["文化、社区与人际联系"],"priority":"P1","usageNote":"下一句最好举具体需要或服务。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"31fc7372-cf85-4bef-a3e1-6a734bb78b88","sentenceText":"Yet a centre must respect personal choice if it hopes to meet diverse needs.","translation":"但中心若想满足多样需要，就必须尊重个人选择。","evidence":{"surface":"meet diverse needs","start":57,"end":75,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    203,
    true
  ),
(
    '3772db14-75f8-571a-894e-ab0570a7ad84'::uuid,
    'phrase',
    '{"id":"3772db14-75f8-571a-894e-ab0570a7ad84","text":"meaningful participation","phraseType":"noun_phrase","meaning":"有意义的参与","optionalEnglishExplanation":"Involvement that offers real understanding or value.","tags":["文化、社区与人际联系"],"priority":"P1","usageNote":"不把参观次数直接当参与质量。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"1b8355bc-70b2-4d54-a48c-c4fec12a3fc6","sentenceText":"These overlapping gains suggest that meaningful participation can combine personal growth with a sense of belonging.","translation":"这些可重叠收益表明，有意义的参与能结合个人成长与归属感。","evidence":{"surface":"meaningful participation","start":37,"end":61,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    204,
    true
  ),
(
    '54ac4099-455c-5dfe-84b5-9eed930a4d7c'::uuid,
    'phrase',
    '{"id":"54ac4099-455c-5dfe-84b5-9eed930a4d7c","text":"respect personal choice","phraseType":"verb_phrase","meaning":"尊重个人选择","optionalEnglishExplanation":"Allow individuals to decide what suits them.","tags":["文化、社区与人际联系"],"priority":"P1","usageNote":"不把所有老人规定为同一生活方式。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"31fc7372-cf85-4bef-a3e1-6a734bb78b88","sentenceText":"Yet a centre must respect personal choice if it hopes to meet diverse needs.","translation":"但中心若想满足多样需要，就必须尊重个人选择。","evidence":{"surface":"respect personal choice","start":18,"end":41,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    205,
    true
  ),
(
    'f8f1dce6-e85a-5121-976d-2ecd08a02a0d'::uuid,
    'phrase',
    '{"id":"f8f1dce6-e85a-5121-976d-2ecd08a02a0d","text":"preserve cultural heritage","phraseType":"verb_phrase","meaning":"保护文化遗产","optionalEnglishExplanation":"Safeguard inherited cultural places, objects or practices.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"调查计划中不能只写倡议而省调查方法。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"7a527383-c26f-4dbd-9f7d-14273dbc3aa6","sentenceText":"I welcome your suggestions on how to preserve cultural heritage while understanding residents’ needs.","translation":"欢迎你就如何兼顾文化遗产保护与了解居民需要提出建议。","evidence":{"surface":"preserve cultural heritage","start":37,"end":63,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    206,
    true
  ),
(
    'd71da9fe-5098-59c7-a9ad-7edc9723845d'::uuid,
    'phrase',
    '{"id":"d71da9fe-5098-59c7-a9ad-7edc9723845d","text":"family reunion","phraseType":"noun_phrase","meaning":"家庭团聚","optionalEnglishExplanation":"A gathering of family members after time apart.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"作为文化演讲主线，而非罗列全部习俗。","examples":[{"essayId":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","sentenceId":"92cd6d91-5f4c-5f02-a1fc-0cdc8d7860c2","sentenceText":"My presentation will focus on the Spring Festival and the meaning of family reunion.","translation":"演讲将聚焦春节及家庭团聚的意义。","evidence":{"surface":"family reunion","start":69,"end":83,"rule":"exact"},"exampleSentenceId":"3f05271c-d814-4ef3-a12f-33b89d0bc110"}],"type":"phrase"}'::jsonb,
    207,
    true
  ),
(
    '6136866b-76c6-52bb-838b-ea1a98cb343e'::uuid,
    'phrase',
    '{"id":"6136866b-76c6-52bb-838b-ea1a98cb343e","text":"shared memories","phraseType":"noun_phrase","meaning":"共同回忆","optionalEnglishExplanation":"Experiences remembered together by several people.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"评价消费时兼顾情感价值。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"80d73534-3124-482e-bf9e-6c11e09400b2","sentenceText":"Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups.","translation":"代际交流可联系地方传统与新兴趣，在年龄群体间创造共同回忆。","evidence":{"surface":"shared memories","start":85,"end":100,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    208,
    true
  ),
(
    'ceafc3e6-08dd-5e85-b9a5-372ccf8141ee'::uuid,
    'phrase',
    '{"id":"ceafc3e6-08dd-5e85-b9a5-372ccf8141ee","text":"social contact","phraseType":"noun_phrase","meaning":"社会交往","optionalEnglishExplanation":"Interaction with other people.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"说明具体活动怎样提供交往。","examples":[{"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"cee6a5fe-a3ae-5a8a-8e54-9ca9a054619c","sentenceText":"When access is matched by useful services, mobile communication can become an everyday resource for learning, work and social contact.","translation":"当可达性与有用服务配合，移动通信就能成为学习、工作和社会交往的日常资源。","evidence":{"surface":"social contact","start":119,"end":133,"rule":"exact"}},{"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"3761ee1b-3b56-5403-9376-b3e6d05a46f6","sentenceText":"Their lower participation rates need not reduce their value: reading can stimulate thought, and a game of chess can provide both mental challenge and social contact.","translation":"参与率较低不应降低它们的价值：阅读激发思考，下棋兼具智力挑战与社会交往。","evidence":{"surface":"social contact","start":150,"end":164,"rule":"exact"}},{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"f6371998-3c70-4279-83b5-9821864661de","sentenceText":"The survey reports three main benefits of a cultural centre: learning at 65%, social contact at 58% and confidence at 41%.","translation":"调查报告文化中心的三项主要收益：学习65%、社会交往58%、自信41%。","evidence":{"surface":"social contact","start":78,"end":92,"rule":"exact"},"exampleSentenceId":"7fc24ba1-c3ec-4954-99bf-38d767d01267"}],"type":"phrase"}'::jsonb,
    209,
    true
  ),
(
    '16c9e1f2-a0fc-58eb-9873-f6869dbdfc8a'::uuid,
    'phrase',
    '{"id":"16c9e1f2-a0fc-58eb-9873-f6869dbdfc8a","text":"accessible public spaces","phraseType":"noun_phrase","meaning":"便于使用的公共空间","optionalEnglishExplanation":"Shared places that people can reach and use easily.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"accessible可指地点、设施或使用门槛。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"9c338162-f9a3-4e4d-90c4-e7e39b6039df","sentenceText":"Accessible public spaces make it easier to meet neighbours, practise skills and maintain relationships.","translation":"便于使用的公共空间让居民更易结识邻居、练习技能并维系关系。","evidence":{"surface":"Accessible public spaces","start":0,"end":24,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    210,
    true
  ),
(
    '9c68df29-3533-5c3b-8b57-9273ccb427fc'::uuid,
    'phrase',
    '{"id":"9c68df29-3533-5c3b-8b57-9273ccb427fc","text":"engaging exhibitions","phraseType":"noun_phrase","meaning":"吸引人的展览","optionalEnglishExplanation":"Displays that hold visitors'' interest.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"不把所有新增展览都断言为吸引人。","examples":[{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"0e332192-3677-5593-9432-5301cbae9ae7","sentenceText":"More museums bring cultural resources within reach of a wider public, while engaging exhibitions give people reasons to visit.","translation":"更多博物馆让更广泛公众接触文化资源，吸引人的展览则给人们参观理由。","evidence":{"surface":"engaging exhibitions","start":76,"end":96,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    211,
    true
  ),
(
    '354a21c6-877e-5742-8a57-1771d5004a9a'::uuid,
    'phrase',
    '{"id":"354a21c6-877e-5742-8a57-1771d5004a9a","text":"knowledgeable guides","phraseType":"noun_phrase","meaning":"知识丰富的讲解员","optionalEnglishExplanation":"People who explain a place or collection with understanding.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"体现讲解如何促进理解。","examples":[{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"8d1886e1-c119-52ad-9c5a-d1e6b7a44e8a","sentenceText":"Clear labels, knowledgeable guides and activities for different ages can turn a brief visit into lasting curiosity.","translation":"清楚展签、知识丰富的讲解员与适合不同年龄的活动，可让短暂参观激发持久好奇。","evidence":{"surface":"knowledgeable guides","start":14,"end":34,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    212,
    true
  ),
(
    'd7780ea3-9f82-53dd-ac36-3c1411f970fb'::uuid,
    'phrase',
    '{"id":"d7780ea3-9f82-53dd-ac36-3c1411f970fb","text":"intergenerational exchange","phraseType":"noun_phrase","meaning":"代际交流","optionalEnglishExplanation":"Communication between people from different generations.","tags":["文化、社区与人际联系"],"priority":"P2","usageNote":"可用于老人和家庭主题，不硬套所有图表。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"80d73534-3124-482e-bf9e-6c11e09400b2","sentenceText":"Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups.","translation":"代际交流可联系地方传统与新兴趣，在年龄群体间创造共同回忆。","evidence":{"surface":"Intergenerational exchange","start":0,"end":26,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    213,
    true
  ),
(
    'fa6f474c-d735-5c4d-8896-5152b64a0b18'::uuid,
    'phrase',
    '{"id":"fa6f474c-d735-5c4d-8896-5152b64a0b18","text":"companionship","phraseType":"noun_phrase","meaning":"陪伴","optionalEnglishExplanation":"The comfort and connection of spending time with others.","tags":["文化、社区与人际联系"],"priority":"P3","usageNote":"some避免把群体需求绝对化。","examples":[{"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"167a3e8d-1664-5288-8685-c78bbc1d5c0d","sentenceText":"Individual exercise and informal companionship are therefore more common than organized participation.","translation":"因此，个人锻炼与非正式陪伴，比有组织参与更普遍。","evidence":{"surface":"companionship","start":33,"end":46,"rule":"exact"}},{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"d9cf6774-ef55-4c85-88ab-743c1d3a6e66","sentenceText":"Its value lies in enabling people to find activities and companionship that matter to them.","translation":"其价值在于让人们找到对自己有意义的活动与陪伴。","evidence":{"surface":"companionship","start":57,"end":70,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    214,
    true
  ),
(
    '87056967-60d1-5520-98d0-b862579f3cf1'::uuid,
    'phrase',
    '{"id":"87056967-60d1-5520-98d0-b862579f3cf1","text":"local traditions","phraseType":"noun_phrase","meaning":"地方传统","optionalEnglishExplanation":"Practices passed down within a community.","tags":["文化、社区与人际联系"],"priority":"P3","usageNote":"具体传统需写准，不编造历史事实。","examples":[{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"9586600d-a235-4f75-a565-f62127987355","sentenceText":"Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions.","translation":"我们分担职责：我起草记录清单，你设计关于成本和地方传统的问题。","evidence":{"surface":"local traditions","start":114,"end":130,"rule":"exact"},"exampleSentenceId":"67df22f9-047a-487e-b1d0-f26f0cfba324"},{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"80d73534-3124-482e-bf9e-6c11e09400b2","sentenceText":"Intergenerational exchange can connect local traditions with new interests, creating shared memories across age groups.","translation":"代际交流可联系地方传统与新兴趣，在年龄群体间创造共同回忆。","evidence":{"surface":"local traditions","start":39,"end":55,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    215,
    true
  ),
(
    '01aacd2c-6df5-5d50-9095-ed062541c2e8'::uuid,
    'phrase',
    '{"id":"01aacd2c-6df5-5d50-9095-ed062541c2e8","text":"shared responsibilities","phraseType":"noun_phrase","meaning":"共同承担的责任","optionalEnglishExplanation":"Duties held jointly by members of a group.","tags":["文化、社区与人际联系"],"priority":"P3","usageNote":"与动词share responsibilities不同，指共同责任。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"043e4876-127a-4955-a63e-ab3dbbf27fca","sentenceText":"Flexible arrangements and shared responsibilities can help people contribute without feeling forced into identical routines.","translation":"灵活安排与共同责任能让人们作贡献，而不感到被迫遵循相同作息。","evidence":{"surface":"shared responsibilities","start":26,"end":49,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    216,
    true
  ),
(
    '4273b64c-94f7-560e-90c3-0fcc1c610853'::uuid,
    'phrase',
    '{"id":"4273b64c-94f7-560e-90c3-0fcc1c610853","text":"strengthen family ties","phraseType":"verb_phrase","meaning":"增进家庭联系","optionalEnglishExplanation":"Make relationships within a family closer.","tags":["文化、社区与人际联系"],"priority":"P3","usageNote":"用by说明机制，不只说活动有益。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"cb92e036-dde7-4cf8-a927-8aac38656364","sentenceText":"When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties.","translation":"成人与儿童共同探索时，家庭工作坊能帮助他们仔细观察、交流问题并增进家庭联系。","evidence":{"surface":"strengthen family ties","start":115,"end":137,"rule":"exact"},"exampleSentenceId":"3520e741-6537-43f5-807c-fab3aa177298"}],"type":"phrase"}'::jsonb,
    217,
    true
  ),
(
    '8acf9237-fb53-5fba-934a-f7b4c920e034'::uuid,
    'phrase',
    '{"id":"8acf9237-fb53-5fba-934a-f7b4c920e034","text":"observe closely","phraseType":"verb_phrase","meaning":"仔细观察","optionalEnglishExplanation":"Look carefully at details.","tags":["文化、社区与人际联系"],"priority":"P3","usageNote":"说明探索条件，不是所有户外活动自动产生效果。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"cb92e036-dde7-4cf8-a927-8aac38656364","sentenceText":"When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties.","translation":"成人与儿童共同探索时，家庭工作坊能帮助他们仔细观察、交流问题并增进家庭联系。","evidence":{"surface":"observe closely","start":75,"end":90,"rule":"exact"},"exampleSentenceId":"3520e741-6537-43f5-807c-fab3aa177298"}],"type":"phrase"}'::jsonb,
    218,
    true
  ),
(
    '5a79d74f-57da-563c-aa58-8e96e05d8139'::uuid,
    'phrase',
    '{"id":"5a79d74f-57da-563c-aa58-8e96e05d8139","text":"leave room for exploration","phraseType":"verb_phrase","meaning":"给探索留空间","optionalEnglishExplanation":"Allow time and freedom to investigate independently.","tags":["文化、社区与人际联系"],"priority":"P3","usageNote":"适合儿童活动与实践学习。","examples":[{"essayId":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","sentenceId":"064d0145-52ab-5fda-8faa-0030f4bf27fe","sentenceText":"Adults should therefore leave room for exploration rather than organize every moment around instructions.","translation":"因此，成人应给探索留空间，而非把每一刻都安排成服从指令。","evidence":{"surface":"leave room for exploration","start":24,"end":50,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    219,
    true
  ),
(
    '7d1a77fd-f48b-53bd-a66c-94b269f62e93'::uuid,
    'phrase',
    '{"id":"7d1a77fd-f48b-53bd-a66c-94b269f62e93","text":"value for money","phraseType":"noun_phrase","meaning":"物有所值","optionalEnglishExplanation":"Worth that justifies the amount paid.","tags":["消费、服务与城乡环境"],"priority":"P1","usageNote":"value通常不可数，不等于最低价。","examples":[{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"42b08f8b-86f4-49d8-8cdf-7b89d0d248d9","sentenceText":"Value for money need not mean the lowest possible price.","translation":"物有所值未必意味着最低价格。","evidence":{"surface":"Value for money","start":0,"end":15,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    220,
    true
  ),
(
    'fbcf06e8-5e22-586d-bee5-b5e05e04e5e2'::uuid,
    'phrase',
    '{"id":"fbcf06e8-5e22-586d-bee5-b5e05e04e5e2","text":"customer loyalty","phraseType":"noun_phrase","meaning":"顾客忠诚","optionalEnglishExplanation":"A tendency to choose the same provider repeatedly.","tags":["消费、服务与城乡环境"],"priority":"P1","usageNote":"用earn强调需要持续表现。","examples":[{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"236ce762-a637-5090-88e8-e6c8800b010b","sentenceText":"When alternatives become more appealing, established brands must work harder to justify their prices and preserve customer loyalty.","translation":"当替代选项更有吸引力，老牌厂商必须更努力证明价格合理、维持顾客忠诚。","evidence":{"surface":"customer loyalty","start":114,"end":130,"rule":"exact"}},{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"7d5fd23a-4cb8-4d57-93c1-4285d515834a","sentenceText":"Otherwise, novelty is unlikely to create customer loyalty or repeat visits.","translation":"否则，新奇很难带来顾客忠诚或再次光顾。","evidence":{"surface":"customer loyalty","start":41,"end":57,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    221,
    true
  ),
(
    '1ff86eb7-9202-58c4-ae1a-05e7e4af9d09'::uuid,
    'phrase',
    '{"id":"1ff86eb7-9202-58c4-ae1a-05e7e4af9d09","text":"repeat visits","phraseType":"noun_phrase","meaning":"再次光顾","optionalEnglishExplanation":"Visits made again after an initial experience.","tags":["消费、服务与城乡环境"],"priority":"P1","usageNote":"适合餐厅、场馆或服务。","examples":[{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"b6626d4e-bace-579b-bac1-ffce17cb822f","sentenceText":"Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone.","translation":"把鲜明特色与可靠表现结合起来，比仅依赖新奇感更可能赢得再次光顾。","evidence":{"surface":"repeat visits","start":83,"end":96,"rule":"exact"},"exampleSentenceId":"e5afbf1e-b33d-49c2-941a-62ca5568a486"},{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"7d5fd23a-4cb8-4d57-93c1-4285d515834a","sentenceText":"Otherwise, novelty is unlikely to create customer loyalty or repeat visits.","translation":"否则，新奇很难带来顾客忠诚或再次光顾。","evidence":{"surface":"repeat visits","start":61,"end":74,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    222,
    true
  ),
(
    '00411456-98c6-5e0b-bd2c-4ff5e2ac92dd'::uuid,
    'phrase',
    '{"id":"00411456-98c6-5e0b-bd2c-4ff5e2ac92dd","text":"reliable delivery","phraseType":"noun_phrase","meaning":"可靠配送","optionalEnglishExplanation":"Transport of goods that can be depended on.","tags":["消费、服务与城乡环境"],"priority":"P1","usageNote":"only when强调必要条件，不把它当唯一充分条件。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"3ca7dc50-9047-4a73-9e34-3b3c6c03e873","sentenceText":"Better transport links and reliable delivery help expand market access for both rural buyers and local producers.","translation":"更好的交通联系和可靠配送有助于扩大农村买家与当地生产者的市场接入。","evidence":{"surface":"reliable delivery","start":27,"end":44,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    223,
    true
  ),
(
    '8bec0e3b-c9a9-5bd4-be2f-661a65093938'::uuid,
    'phrase',
    '{"id":"8bec0e3b-c9a9-5bd4-be2f-661a65093938","text":"affordable housing","phraseType":"noun_phrase","meaning":"可负担住房","optionalEnglishExplanation":"Housing whose cost residents can reasonably manage.","tags":["消费、服务与城乡环境"],"priority":"P1","usageNote":"affordable相对于居民收入，不直接等于廉价。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"481e2670-5f95-5f34-a8d2-82cba2f12f9c","sentenceText":"Affordable housing, accessible schools and dependable transport must develop alongside population increases.","translation":"可负担住房、可及学校与可靠交通必须随人口同步发展。","evidence":{"surface":"Affordable housing","start":0,"end":18,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    224,
    true
  ),
(
    'da10c7c5-f021-5207-b8f0-51f72060b6b1'::uuid,
    'phrase',
    '{"id":"da10c7c5-f021-5207-b8f0-51f72060b6b1","text":"excessive packaging","phraseType":"noun_phrase","meaning":"过度包装","optionalEnglishExplanation":"More wrapping or packing material than is reasonably needed.","tags":["消费、服务与城乡环境"],"priority":"P1","usageNote":"承认保护功能，建议才不空泛。","examples":[{"essayId":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","sentenceId":"9a91be8c-77f9-5213-bdc6-dc15a3a5b690","sentenceText":"To sustain these benefits, the sector should improve efficiency while reducing damaged parcels, excessive packaging and pressure on delivery workers.","translation":"为维持收益，行业应在提升效率的同时，减少包裹损坏、过度包装与快递员压力。","evidence":{"surface":"excessive packaging","start":96,"end":115,"rule":"exact"}},{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"28aadd8b-7001-4fa8-ac8c-c678405aa7c1","sentenceText":"Environmental costs can rise when more parcels mean unnecessary journeys and excessive packaging.","translation":"更多包裹造成不必要运输与过度包装时，环境代价可能上升。","evidence":{"surface":"excessive packaging","start":77,"end":96,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    225,
    true
  ),
(
    '2b9d9646-daf8-5752-a2b9-8ed96d897bb0'::uuid,
    'phrase',
    '{"id":"2b9d9646-daf8-5752-a2b9-8ed96d897bb0","text":"competitive pricing","phraseType":"noun_phrase","meaning":"有竞争力的定价","optionalEnglishExplanation":"Setting prices that compare favourably with alternatives.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"不把便宜本身等同于质量好。","examples":[{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"c907f979-b8c1-5161-aebf-f9e7a78c7adf","sentenceText":"Competitive pricing and improvements in design and quality may have made Chinese cars a more attractive choice.","translation":"有竞争力的定价，以及设计、质量改善，可能让国产汽车更具吸引力。","evidence":{"surface":"Competitive pricing","start":0,"end":19,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    226,
    true
  ),
(
    '6348a41e-01b1-5cbf-87f9-169a8a2764c0'::uuid,
    'phrase',
    '{"id":"6348a41e-01b1-5cbf-87f9-169a8a2764c0","text":"after-sales service","phraseType":"noun_phrase","meaning":"售后服务","optionalEnglishExplanation":"Support provided after a product is bought.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"与产品购买对应。","examples":[{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"4bcacad3-e83b-57e3-9257-b621b9d598fa","sentenceText":"Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return.","translation":"赢得市场份额带来机会，但可靠性能与有效售后才会促使顾客再次选择。","evidence":{"surface":"after-sales service","start":84,"end":103,"rule":"exact"},"exampleSentenceId":"8d1233cb-026a-49db-a246-de446f742c0f"}],"type":"phrase"}'::jsonb,
    227,
    true
  ),
(
    '7610760a-728e-5a57-a0b5-513a14ec9d8d'::uuid,
    'phrase',
    '{"id":"7610760a-728e-5a57-a0b5-513a14ec9d8d","text":"a distinctive identity","phraseType":"noun_phrase","meaning":"鲜明特色","optionalEnglishExplanation":"A recognizable character that distinguishes an offering.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"identity指可辨认定位，不是身份证明。","examples":[{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"c9cdf91a-7321-4e04-b257-b577d3214a02","sentenceText":"A distinctive identity can attract attention, but a restaurant must deliver the experience it promises.","translation":"鲜明特色能吸引注意，但餐厅必须兑现承诺的体验。","evidence":{"surface":"A distinctive identity","start":0,"end":22,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    228,
    true
  ),
(
    '857163b8-6355-5c1c-8f08-90a6602da82b'::uuid,
    'phrase',
    '{"id":"857163b8-6355-5c1c-8f08-90a6602da82b","text":"attentive service","phraseType":"noun_phrase","meaning":"周到服务","optionalEnglishExplanation":"Service that notices and responds to customers'' needs.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"举例可写需求回应，但不凭空添加调查项目。","examples":[{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"47f69845-3efd-503e-8a68-bc20623c7cc6","sentenceText":"A distinctive menu can make a meal memorable, attentive service makes guests feel valued, and a comfortable setting allows conversation to flow.","translation":"特色菜单让一餐难忘，周到服务让顾客感到被重视，舒适环境则让交谈顺畅。","evidence":{"surface":"attentive service","start":46,"end":63,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    229,
    true
  ),
(
    '5d47b9f3-23e0-5083-9ca4-0247083da071'::uuid,
    'phrase',
    '{"id":"5d47b9f3-23e0-5083-9ca4-0247083da071","text":"financial strain","phraseType":"noun_phrase","meaning":"经济负担","optionalEnglishExplanation":"Pressure caused by demands on available money.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"与budget和可承受程度相连。","examples":[{"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"e87d515f-c823-5495-8d9f-c8f7d1a5fcf9","sentenceText":"In my view, festive spending is worthwhile when it strengthens relationships without creating financial strain.","translation":"我认为，节日花销在增进关系又不制造经济负担时值得。","evidence":{"surface":"financial strain","start":94,"end":110,"rule":"exact"},"exampleSentenceId":"bca656ee-2d20-4197-a42e-fb84b4604a00"},{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"93cdc3f0-57c6-4928-a06b-c1445948bee8","sentenceText":"In my view, festive spending is worthwhile when it respects family priorities without creating financial strain.","translation":"在我看来，节日支出若能尊重家庭优先事项，又不造成经济负担，就是值得的。","evidence":{"surface":"financial strain","start":95,"end":111,"rule":"exact"},"exampleSentenceId":"599c1f3e-020e-4720-aead-e0c91c67209f"}],"type":"phrase"}'::jsonb,
    230,
    true
  ),
(
    '5f3d492a-cba1-5d7b-9319-e0b68cc634f9'::uuid,
    'phrase',
    '{"id":"5f3d492a-cba1-5d7b-9319-e0b68cc634f9","text":"a realistic budget","phraseType":"noun_phrase","meaning":"切实可行的预算","optionalEnglishExplanation":"A spending plan based on actual resources.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"避免只建议一味节省而不考虑需求。","examples":[{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"e6ec70f4-aaba-42f0-b46f-b7a19895abdd","sentenceText":"A realistic budget asks people to distinguish thoughtful giving from purchases made simply to meet expectations.","translation":"现实预算要求人们区分用心赠礼与仅为满足外界期待而作的购买。","evidence":{"surface":"A realistic budget","start":0,"end":18,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    231,
    true
  ),
(
    '860f4740-56da-517a-9c2d-5ec415855746'::uuid,
    'phrase',
    '{"id":"860f4740-56da-517a-9c2d-5ec415855746","text":"expand market access","phraseType":"verb_phrase","meaning":"扩大市场接入","optionalEnglishExplanation":"Make it possible to sell to or buy from more markets.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"说明谁接触到什么市场更有解释力。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"3ca7dc50-9047-4a73-9e34-3b3c6c03e873","sentenceText":"Better transport links and reliable delivery help expand market access for both rural buyers and local producers.","translation":"更好的交通联系和可靠配送有助于扩大农村买家与当地生产者的市场接入。","evidence":{"surface":"expand market access","start":50,"end":70,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    232,
    true
  ),
(
    'a53881b0-b542-527a-b86e-1146f59af1de'::uuid,
    'phrase',
    '{"id":"a53881b0-b542-527a-b86e-1146f59af1de","text":"local collection points","phraseType":"noun_phrase","meaning":"当地取件点","optionalEnglishExplanation":"Nearby places where parcels can be collected.","tags":["消费、服务与城乡环境"],"priority":"P2","usageNote":"是可能机制，非图中直接给出的调查事实。","examples":[{"essayId":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","sentenceId":"f7836f10-d25e-520c-8e49-ff3f99299926","sentenceText":"Improved roads, local collection points and delivery networks can bring rural households into larger markets.","translation":"道路、当地取件点及配送网络的改善，能让农村家庭进入更广市场。","evidence":{"surface":"local collection points","start":16,"end":39,"rule":"exact"}},{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"6d3d02cf-11f8-4199-a476-5cfcdcf3fd65","sentenceText":"These benefits may be driven by local collection points that make distant sellers easier to reach.","translation":"这些收益可能由让远方卖家更易接触的当地取件点推动。","evidence":{"surface":"local collection points","start":32,"end":55,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    233,
    true
  ),
(
    '291d4fee-7b51-5bdb-9f44-37b6f1858719'::uuid,
    'phrase',
    '{"id":"291d4fee-7b51-5bdb-9f44-37b6f1858719","text":"public services","phraseType":"noun_phrase","meaning":"公共服务","optionalEnglishExplanation":"Services provided for the needs of a community.","tags":["消费、服务与城乡环境"],"priority":"P3","usageNote":"具体可写学校、交通等，不直接空喊改善。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"329254f4-2a37-5bd0-8082-ad23a94f6937","sentenceText":"As more people settle in cities, growing demand can put pressure on housing and public services, further reshaping everyday life.","translation":"随着更多人在城市定居，增加的需求可能给住房与公共服务带来压力，进一步重塑日常生活。","evidence":{"surface":"public services","start":80,"end":95,"rule":"exact"}},{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"efe28f43-2d91-476b-b95b-4e1d74f4c9b9","sentenceText":"Public services must develop alongside trade if growth is to support balanced development.","translation":"若增长要支持均衡发展，公共服务就必须随交易同步发展。","evidence":{"surface":"Public services","start":0,"end":15,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    234,
    true
  ),
(
    'dd5941c0-5492-5259-af76-49414e56296f'::uuid,
    'phrase',
    '{"id":"dd5941c0-5492-5259-af76-49414e56296f","text":"transport links","phraseType":"noun_phrase","meaning":"交通联系","optionalEnglishExplanation":"Routes and connections enabling movement between places.","tags":["消费、服务与城乡环境"],"priority":"P3","usageNote":"link对象要清楚。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"3ca7dc50-9047-4a73-9e34-3b3c6c03e873","sentenceText":"Better transport links and reliable delivery help expand market access for both rural buyers and local producers.","translation":"更好的交通联系和可靠配送有助于扩大农村买家与当地生产者的市场接入。","evidence":{"surface":"transport links","start":7,"end":22,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    235,
    true
  ),
(
    '4220342c-682c-5816-89ba-ec2bc4df3b8e'::uuid,
    'phrase',
    '{"id":"4220342c-682c-5816-89ba-ec2bc4df3b8e","text":"balanced development","phraseType":"noun_phrase","meaning":"均衡发展","optionalEnglishExplanation":"Progress that considers the needs of different places or groups.","tags":["消费、服务与城乡环境"],"priority":"P3","usageNote":"不是要求各地人口或经济完全相同。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"efe28f43-2d91-476b-b95b-4e1d74f4c9b9","sentenceText":"Public services must develop alongside trade if growth is to support balanced development.","translation":"若增长要支持均衡发展，公共服务就必须随交易同步发展。","evidence":{"surface":"balanced development","start":69,"end":89,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    236,
    true
  ),
(
    '44219a16-264b-50bf-861b-f2471ebe1d0c'::uuid,
    'phrase',
    '{"id":"44219a16-264b-50bf-861b-f2471ebe1d0c","text":"environmental costs","phraseType":"noun_phrase","meaning":"环境代价","optionalEnglishExplanation":"Harm or resource burdens imposed on the natural environment.","tags":["消费、服务与城乡环境"],"priority":"P3","usageNote":"评论需与图中行业或行为相关。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"28aadd8b-7001-4fa8-ac8c-c678405aa7c1","sentenceText":"Environmental costs can rise when more parcels mean unnecessary journeys and excessive packaging.","translation":"更多包裹造成不必要运输与过度包装时，环境代价可能上升。","evidence":{"surface":"Environmental costs","start":0,"end":19,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    237,
    true
  ),
(
    'c7aec243-4494-50b4-86a2-a1e66142c99d'::uuid,
    'phrase',
    '{"id":"c7aec243-4494-50b4-86a2-a1e66142c99d","text":"resource efficiency","phraseType":"noun_phrase","meaning":"资源使用效率","optionalEnglishExplanation":"The amount of useful output obtained from available resources.","tags":["消费、服务与城乡环境"],"priority":"P3","usageNote":"需说清资源和规划内容，不作空洞结尾。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"a8b8a797-a675-4bc0-bc5d-e2d170f65ad2","sentenceText":"Shared routes and reusable materials can improve resource efficiency without removing useful services.","translation":"共用线路与可重复利用材料能在不减少有用服务的情况下提升资源效率。","evidence":{"surface":"resource efficiency","start":49,"end":68,"rule":"exact"}}],"type":"phrase"}'::jsonb,
    238,
    true
  ),
(
    '4288d327-f745-59b8-b928-8dcaf6d1cdb0'::uuid,
    'phrase',
    '{"id":"4288d327-f745-59b8-b928-8dcaf6d1cdb0","text":"lasting benefits","phraseType":"noun_phrase","meaning":"持久收益","optionalEnglishExplanation":"Positive effects that continue rather than disappear quickly.","tags":["消费、服务与城乡环境"],"priority":"P3","usageNote":"用条件句区分规模与最终价值。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"b47487d1-ca72-4bb1-80c5-023451dba18c","sentenceText":"Continued progress should therefore concern lasting benefits, not volume alone.","translation":"因此，持续进步应着眼于持久收益，而不只关注业务量。","evidence":{"surface":"lasting benefits","start":44,"end":60,"rule":"exact"},"exampleSentenceId":"c25a1790-9676-4050-9e77-c86e8b88214b"}],"type":"phrase"}'::jsonb,
    239,
    true
  ),
(
    '7eab1056-302f-4c7a-af12-b4ce8014ddc6'::uuid,
    'sentence_pattern',
    '{"id":"7eab1056-302f-4c7a-af12-b4ce8014ddc6","pattern":"Thank you for [感谢事项].","function":"感谢对方的具体行动","tags":["交际"],"grammarNote":"for后填名词短语或动名词短语。","usageNote":"适用于感谢祝贺、邀请与分享，后文再展开收获。","examples":[{"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"78b94e2c-a506-5a6a-b08f-76bc3f3a005b","sentenceText":"Thank you for your congratulations.","translation":"谢谢你的祝贺。","bindings":{"感谢事项":"your congratulations"}},{"essayId":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","sentenceId":"3c01cbcd-4d7e-5bae-a1ee-81053a2fd11e","sentenceText":"Thank you for your invitation.","translation":"感谢您的邀请。","bindings":{"感谢事项":"your invitation"}},{"essayId":"dfc938b0-c3bc-58ce-a182-763abd6760fa","sentenceId":"a8288ccb-4c76-5712-baa6-ba90d3e09b7f","sentenceText":"Thank you for sharing the video of your family’s trip to China.","translation":"谢谢你分享全家在中国旅行的视频。","bindings":{"感谢事项":"sharing the video of your family’s trip to China"}}],"type":"sentence_pattern"}'::jsonb,
    0,
    true
  ),
(
    '3835053b-dfe0-4b61-8143-54ef5666a6a6'::uuid,
    'sentence_pattern',
    '{"id":"3835053b-dfe0-4b61-8143-54ef5666a6a6","pattern":"[帮助] meant a great deal: it helped me [认识] and [后续行动].","function":"用具体改变说明帮助的价值","tags":["交际"],"grammarNote":"冒号后解释meant a great deal；helped后并列动词原形。","usageNote":"感谢不是堆形容词，应说明帮助带来什么变化。","examples":[{"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"d939e2f8-2cf5-4241-b391-6267de20d4fa","sentenceText":"Your advice meant a great deal: it helped me understand my options and decide what to do next.","translation":"你的建议意义重大，让我理解了可选道路，并决定下一步行动。","bindings":{"帮助":"Your advice","认识":"understand my options","后续行动":"decide what to do next"},"exampleSentenceId":"5b25a37b-1f41-40ae-abe0-cf695cd51da2"},{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"93266ab7-f9cd-581e-ab55-14bc726fdaa1","sentenceText":"Such a memorable experience meant a great deal: it helped me understand American culture and appreciate your kindness.","translation":"如此难忘的经历意义重大：它让我理解了美国文化，也让我更珍惜你的好意。","bindings":{"帮助":"Such a memorable experience","认识":"understand American culture","后续行动":"appreciate your kindness"}}],"type":"sentence_pattern"}'::jsonb,
    1,
    true
  ),
(
    '232b1283-4901-4364-a70f-bcc2332c48cd'::uuid,
    'sentence_pattern',
    '{"id":"232b1283-4901-4364-a70f-bcc2332c48cd","pattern":"It would be a pleasure to [回应] by [具体帮助].","function":"从感谢自然转入回报或邀请","tags":["交际"],"grammarNote":"It为形式主语；by后两个动名词并列。","usageNote":"后半部分必须给实际可提供的帮助。","examples":[{"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"1dfa0010-3213-5f59-a6ce-cd2cffd88def","sentenceText":"It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food.","translation":"我很乐意带你游览我的城市，介绍我们的传统和当地食物，以回报你的好意。","bindings":{"回应":"return your kindness","具体帮助":"showing you around my city and introducing you to our traditions and local food"},"exampleSentenceId":"ff94728e-7931-4e8a-bc8f-862659a3a342"}],"type":"sentence_pattern"}'::jsonb,
    2,
    true
  ),
(
    'e8316de9-f4c2-40c8-87ac-1c11e86f14f7'::uuid,
    'sentence_pattern',
    '{"id":"e8316de9-f4c2-40c8-87ac-1c11e86f14f7","pattern":"[新阶段] calls for [能力要求], so [准备行动] will help.","function":"用新阶段要求解释准备建议","tags":["交际"],"grammarNote":"calls for接名词；so连接原因与建议；getting为主语。","usageNote":"新阶段、能力与做法必须对应。","examples":[{"essayId":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","sentenceId":"c10ad929-e081-5f86-ab38-6f7873bf8c06","sentenceText":"University learning calls for greater independence, so getting used to organizing your own time will help.","translation":"大学学习要求更强的独立性，因此习惯自行安排时间会有帮助。","bindings":{"新阶段":"University learning","能力要求":"greater independence","准备行动":"getting used to organizing your own time"},"exampleSentenceId":"cf43fa9e-5350-42ba-82e6-40512fb92a1c"}],"type":"sentence_pattern"}'::jsonb,
    3,
    true
  ),
(
    'e5aa9d97-5016-4cd9-90d0-6cf00cde524e'::uuid,
    'sentence_pattern',
    '{"id":"e5aa9d97-5016-4cd9-90d0-6cf00cde524e","pattern":"It would be wonderful if you could [参与任务].","function":"委婉邀请完成具体参与任务","tags":["交际"],"grammarNote":"if you could降低命令感；任务应有明确范围。","usageNote":"适合邀请发言、分享经验等，不给过多准备要求。","examples":[{"essayId":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","sentenceId":"e93a6f4e-5977-5df2-962d-f1f680ba23ba","sentenceText":"It would be wonderful if you could share one challenge you encountered and how you dealt with it.","translation":"若你能分享一个遇到的困难及应对办法，那就太好了。","bindings":{"参与任务":"share one challenge you encountered and how you dealt with it"},"exampleSentenceId":"f7dd0245-ca9a-4e76-a015-c5182e3ad44c"},{"essayId":"45e8079a-3dfa-5a72-8e7c-718cf9283b2f","sentenceId":"21ce44e3-337b-58f3-beca-53c4dfa88740","sentenceText":"It would be wonderful if you could introduce a favourite dish from your own country.","translation":"如果你们能介绍一道自己国家喜爱的菜肴，那就太好了。","bindings":{"参与任务":"introduce a favourite dish from your own country"},"exampleSentenceId":"146aa71c-2816-4e55-8a40-eee2632a310f"}],"type":"sentence_pattern"}'::jsonb,
    4,
    true
  ),
(
    'c4e7b843-cb2f-42dc-a6c0-fbb7c41d0ad8'::uuid,
    'sentence_pattern',
    '{"id":"c4e7b843-cb2f-42dc-a6c0-fbb7c41d0ad8","pattern":"Knowing that you have [对方已做安排], I sincerely apologize for [具体影响].","function":"承认对方付出后道歉","tags":["交际"],"grammarNote":"Knowing的逻辑主语为I；for后接动名词。","usageNote":"对方确已安排才使用，不能无依据假定。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"7d67f59d-6b4d-507e-b956-4036742c09b9","sentenceText":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements.","translation":"想到您已专门为我留出时间，我为打乱您的安排诚恳道歉。","bindings":{"对方已做安排":"set aside time for me","具体影响":"disrupting your arrangements"},"exampleSentenceId":"05d57aff-685a-4a0d-8f51-ac99e2916a8e"},{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"174f36a4-e7a0-4273-9557-363ef2888d77","sentenceText":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting.","translation":"知道您已为我留出时间，我为更改会面、打乱您的安排诚恳致歉。","bindings":{"对方已做安排":"set aside time for me","具体影响":"disrupting your arrangements by changing our meeting"},"exampleSentenceId":"c44ea336-7055-4bf0-900d-a5bdd8b0249e"}],"type":"sentence_pattern"}'::jsonb,
    5,
    true
  ),
(
    '603a976c-22b9-44b8-9336-f3675cb00c81'::uuid,
    'sentence_pattern',
    '{"id":"603a976c-22b9-44b8-9336-f3675cb00c81","pattern":"If [替代安排] would suit you better, I will gladly [配合行动].","function":"尊重对方偏好并提供调整","tags":["交际"],"grammarNote":"if从句用would表示委婉偏好；主句给承诺。","usageNote":"改约应先给具体建议，此句用于保留弹性。","examples":[{"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"2beef8e3-9288-5ef0-9d5f-bc1902c4d002","sentenceText":"If another date would suit you better, I will gladly adjust my plans.","translation":"若其他日期更合适，我很愿意调整计划。","bindings":{"替代安排":"another date","配合行动":"adjust my plans"},"exampleSentenceId":"894c83f1-dd40-486b-80cc-1b98a4cd264b"},{"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"2b374885-25e0-44b3-8415-a07dea21f650","sentenceText":"If the following week would suit you better, I will gladly meet at your convenience.","translation":"如果下一周对您更合适，我很乐意在您方便时会面。","bindings":{"替代安排":"the following week","配合行动":"meet at your convenience"},"exampleSentenceId":"f6dd4ab1-5344-4a8b-b1b9-0ff8467d2b5d"}],"type":"sentence_pattern"}'::jsonb,
    6,
    true
  ),
(
    '67fa104b-d59b-4803-9bc0-55fb3eb183dc'::uuid,
    'sentence_pattern',
    '{"id":"67fa104b-d59b-4803-9bc0-55fb3eb183dc","pattern":"I am writing about [商品或服务][补充说明].","function":"交代投诉对象并补充说明","tags":["交际"],"grammarNote":"补充说明可用分词短语交代购买背景，也可用逗号加which从句说明问题。","usageNote":"不是泛泛抱怨，后文应列事实与补救要求。","examples":[{"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"4c3e68da-b5b8-42b6-9166-b31b3e56fc7d","sentenceText":"I am writing about your online writing course, which has failed to meet the stated standard.","translation":"我就贵方在线写作课程来信，课程未达到所声明的标准。","bindings":{"商品或服务":"your online writing course","补充说明":", which has failed to meet the stated standard"},"exampleSentenceId":"8e378ed6-44f1-4c2b-8b8c-64de2dbf8406"},{"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"bf68b45a-416e-575b-9ab2-4673508c4a8c","sentenceText":"I am writing about an electronic dictionary purchased from your online store three days ago.","translation":"我就三天前从贵网店购买的电子词典来信。","bindings":{"商品或服务":"an electronic dictionary","补充说明":" purchased from your online store three days ago"}}],"type":"sentence_pattern"}'::jsonb,
    7,
    true
  ),
(
    '88d67cf6-4d2a-4435-990b-54d09ab5545b'::uuid,
    'sentence_pattern',
    '{"id":"88d67cf6-4d2a-4435-990b-54d09ab5545b","pattern":"For [任务], I suggest [方法] so that we can [目的].","function":"把方法与调查目的连接","tags":["交际"],"grammarNote":"suggest后接动名词；so that说明目的。","usageNote":"替换方法后须确认确能回答对应问题。","examples":[{"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"e019c065-b5f7-5720-a4b8-0c8e837fbae3","sentenceText":"For our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns.","translation":"关于我们的老屋保护调查，我建议把实地观察与访谈结合，以同时了解建筑状况和居民关切。","bindings":{"任务":"our survey on old-house protection","方法":"combining field observations with interviews","目的":"understand both the buildings’ condition and residents’ concerns"},"exampleSentenceId":"8c754cd9-9eb3-4d95-8815-7c94d0d4719d"},{"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","sentenceText":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.","translation":"对于这次调查，我建议开展实地观察与访谈，以便收集可靠依据并找出共同关切。","bindings":{"任务":"our investigation","方法":"making field observations and conducting interviews","目的":"collect reliable evidence and identify common concerns"},"exampleSentenceId":"f718dc5e-99e6-40cb-b886-e66f4d75bc58"}],"type":"sentence_pattern"}'::jsonb,
    8,
    true
  ),
(
    'e40b397a-7cff-4f1a-9aaa-05c494eb2014'::uuid,
    'sentence_pattern',
    '{"id":"e40b397a-7cff-4f1a-9aaa-05c494eb2014","pattern":"Which [对象] [主要感受], and why?","function":"围绕同一经历追问感受与理由","tags":["交际"],"grammarNote":"Which疑问句后接and why，避免互不相关的问题清单。","usageNote":"询问对方的真实经历，不转写自己的旅游报告。","examples":[{"essayId":"dfc938b0-c3bc-58ce-a182-763abd6760fa","sentenceId":"39cf3f7f-015a-528e-ac67-16d12c94552d","sentenceText":"Which place left the strongest impression on you, and why?","translation":"哪个地方给你印象最深，为什么？","bindings":{"对象":"place","主要感受":"left the strongest impression on you"},"exampleSentenceId":"fd074543-deab-4942-ab53-e300f3ce849d"}],"type":"sentence_pattern"}'::jsonb,
    9,
    true
  ),
(
    '04a84139-ce37-46b8-999e-e178f87228cf'::uuid,
    'sentence_pattern',
    '{"id":"04a84139-ce37-46b8-999e-e178f87228cf","pattern":"The [A人口] more than doubled, rising from [A起点] to [A终点], while the [B人口] declined from [B起点] to [B终点].","function":"同句对照相反趋势及幅度","tags":["数据表达"],"grammarNote":"rising补充more than doubled；while对照另一组。","usageNote":"more than doubled要求终值超过起值两倍；不满足时改用适当变化动词。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"d5e738ae-56c2-5957-986a-db4e07b99fee","sentenceText":"The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million.","translation":"城镇人口由三亿增至六亿六千六百万，达到两倍以上；乡村人口则由八亿三千四百万降至六亿七千四百万。","bindings":{"A人口":"urban population","A起点":"300 million","A终点":"666 million","B人口":"rural population","B起点":"834 million","B终点":"674 million"},"exampleSentenceId":"0e9d65e8-3b4d-4b66-818d-fd38257ee6da"}],"type":"sentence_pattern"}'::jsonb,
    10,
    true
  ),
(
    '476c6830-f903-418a-8111-7342059dc8a4'::uuid,
    'sentence_pattern',
    '{"id":"476c6830-f903-418a-8111-7342059dc8a4","pattern":"Particularly striking is [显著变化] from [开始时间] to [结束时间].","function":"突出最值得注意的变化","tags":["数据表达"],"grammarNote":"Particularly striking是前置表语，后接is及真正主语。","usageNote":"适合确有突出的幅度或阶段，不应只为倒装而用。","examples":[{"essayId":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","sentenceId":"c592f60c-d609-5f1d-9f4c-9db669835746","sentenceText":"Particularly striking is the doubling of rural volume from 2019 to 2020.","translation":"尤其突出的是农村业务量在2019至2020年翻倍。","bindings":{"显著变化":"the doubling of rural volume","开始时间":"2019","结束时间":"2020"},"exampleSentenceId":"836cdc48-25c1-462d-8503-89d2d44b676d"},{"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"21d11f83-d1d7-5375-a794-df45d55be494","sentenceText":"Particularly striking is the rapid expansion of the developing market from 2000 to 2008.","translation":"尤其显著的是2000至2008年发展中市场的迅速扩张。","bindings":{"显著变化":"the rapid expansion of the developing market","开始时间":"2000","结束时间":"2008"}}],"type":"sentence_pattern"}'::jsonb,
    11,
    true
  ),
(
    'beb0f328-b90a-48be-95d0-ab9dfa6e2975'::uuid,
    'sentence_pattern',
    '{"id":"beb0f328-b90a-48be-95d0-ab9dfa6e2975","pattern":"[主要类别] remained [原地位], although its share fell from [起点] to [终点].","function":"兼顾份额变化与仍居主导的地位","tags":["数据表达"],"grammarNote":"although引导让步，主句不再重复but。","usageNote":"下降不等于失去第一，必须看实际排序。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"027dfd2f-7359-5e60-8334-02836400e831","sentenceText":"Employment remained the largest category, although its share fell from 68.1% to 60.7%.","translation":"就业仍是最大类别，尽管份额由68.1%降至60.7%。","bindings":{"主要类别":"Employment","原地位":"the largest category","起点":"68.1%","终点":"60.7%"},"exampleSentenceId":"cbde89bd-dc8d-4525-b39d-6a5b91d934e1"}],"type":"sentence_pattern"}'::jsonb,
    12,
    true
  ),
(
    '41287a19-b9dd-4ca6-b667-a13fcca0ec3a'::uuid,
    'sentence_pattern',
    '{"id":"41287a19-b9dd-4ca6-b667-a13fcca0ec3a","pattern":"Together, [类别A] and [类别B] account for [合计份额] [统计对象].","function":"合并主要选项概括中心","tags":["数据表达"],"grammarNote":"Together将两项作为整体；统计对象须据题意用responses或spending等，并只合并互斥构成。","usageNote":"多选可重叠时不能把选项比例相加当去重人数。","examples":[{"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"924aed35-54ba-550d-a4d4-3057f2134b30","sentenceText":"Together, sightseeing and relaxation account for seven out of every ten responses.","translation":"观景与放松合计占每十份回答中的七份。","bindings":{"类别A":"sightseeing","类别B":"relaxation","合计份额":"seven out of every ten","统计对象":"responses"},"exampleSentenceId":"67356967-5796-4d5b-b2af-55b2bc64c080"},{"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"3626a02f-0730-59b4-971d-1b5049e633a5","sentenceText":"Together, transport and meals account for 40% of spending.","translation":"交通与聚餐合计占支出的40%。","bindings":{"类别A":"transport","类别B":"meals","合计份额":"40% of","统计对象":"spending"}}],"type":"sentence_pattern"}'::jsonb,
    13,
    true
  ),
(
    'f857ef9a-55f5-4164-bcca-7911de089c0b'::uuid,
    'sentence_pattern',
    '{"id":"f857ef9a-55f5-4164-bcca-7911de089c0b","pattern":"[收益A] and [收益B] receive almost identical support, at [A比例] and [B比例].","function":"准确表达几乎相同的支持","tags":["数据表达"],"grammarNote":"receive的主语是并列两项；at引出数据。","usageNote":"almost identical用于微小差异，不夸大领先。","examples":[{"essayId":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","sentenceId":"79074458-ddc6-5752-a042-6163e9f823ee","sentenceText":"Satisfying curiosity and developing observation skills receive almost identical support, at 54.6% and 54.5%.","translation":"满足好奇心与促进观察力得到几乎相同的支持，分别为54.6%与54.5%。","bindings":{"收益A":"Satisfying curiosity","收益B":"developing observation skills","A比例":"54.6%","B比例":"54.5%"},"exampleSentenceId":"4dfc2215-bbfd-4b8d-be9c-befce3a6a433"}],"type":"sentence_pattern"}'::jsonb,
    14,
    true
  ),
(
    '860a332b-0db7-4ea3-958f-27a960b17ec6'::uuid,
    'sentence_pattern',
    '{"id":"860a332b-0db7-4ea3-958f-27a960b17ec6","pattern":"Among [群体], [比例A] are [态度A] and [数量B] are [态度B].","function":"描述一组内部的两种态度","tags":["数据表达"],"grammarNote":"Among限定组内范围；and并列两个主谓结构。","usageNote":"none satisfied不等于everyone dissatisfied，可能还有中立或不清楚。","examples":[{"essayId":"989d1b46-48f3-51a9-b788-c26e8ac1d042","sentenceId":"2aa5641d-7933-5a7f-a0a6-df4f349b2dc4","sentenceText":"Among employees aged 41 to 50, 64% are dissatisfied and none are satisfied.","translation":"41至50岁员工中，64%不满意，无人表示满意。","bindings":{"群体":"employees aged 41 to 50","比例A":"64%","态度A":"dissatisfied","数量B":"none","态度B":"satisfied"},"exampleSentenceId":"a10095fe-3baa-40a3-b443-3b879a63c43f"}],"type":"sentence_pattern"}'::jsonb,
    15,
    true
  ),
(
    'ecdb4c76-8a72-4e6e-964c-c3e9729c37d5'::uuid,
    'sentence_pattern',
    '{"id":"ecdb4c76-8a72-4e6e-964c-c3e9729c37d5","pattern":"The proportion rose from [起点] to [终点], with growth becoming more pronounced in [阶段].","function":"变化描述后补充阶段差异","tags":["数据表达"],"grammarNote":"with加名词及分词短语，补充增长后期更显著。","usageNote":"必须有数据支持后期加快，不是所有上升图都用。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"0eb93957-f0eb-5e32-a340-91f78ab91b9a","sentenceText":"The proportion rose from 8.80% to 25.40%, with growth becoming more pronounced in later years.","translation":"比例由8.80%升至25.40%，后期增长更明显。","bindings":{"起点":"8.80%","终点":"25.40%","阶段":"later years"},"exampleSentenceId":"fad3163a-55fe-4452-95db-6d9afb7a55e4"}],"type":"sentence_pattern"}'::jsonb,
    16,
    true
  ),
(
    'd247019c-2eda-4a82-9129-d55323d9d925'::uuid,
    'sentence_pattern',
    '{"id":"d247019c-2eda-4a82-9129-d55323d9d925","pattern":"[因素A] accounts for [份额概括], at [A比例], while [因素B] represent [B比例].","function":"概括较小比例并交代其他项","tags":["数据表达"],"grammarNote":"while并列比较；at给近似描述的实际数值。","usageNote":"只用在互斥构成，不能把被选比例当效果增幅。","examples":[{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"4f6c3c70-09c7-55d6-9b92-366d949ed35f","sentenceText":"Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%.","translation":"价格占不到十分之一，为8.4%，其他因素为4.7%。","bindings":{"因素A":"Price","份额概括":"less than a tenth","A比例":"8.4%","因素B":"other factors","B比例":"4.7%"},"exampleSentenceId":"ba60080c-0a40-47fc-b13b-94a592bc9320"}],"type":"sentence_pattern"}'::jsonb,
    17,
    true
  ),
(
    'fdba8d50-67ad-4598-b302-1471c31256b9'::uuid,
    'sentence_pattern',
    '{"id":"fdba8d50-67ad-4598-b302-1471c31256b9","pattern":"It reaches [比例] in [组别], making [主体] [比较评价] by [程度].","function":"数据之后立即归纳群体差异","tags":["数据表达"],"grammarNote":"making引导结果状语；It回指前文比例。","usageNote":"需要明确前文对象，年级不可改写成连续年份。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"7b0ef93c-82d9-52a6-8656-1dc29e2de8d8","sentenceText":"It reaches 88.24% in the final year, making graduating students the most active participants by a considerable margin.","translation":"大四达到88.24%，毕业年级以明显差距成为参与最积极的群体。","bindings":{"比例":"88.24%","组别":"the final year","主体":"graduating students","比较评价":"the most active participants","程度":"a considerable margin"},"exampleSentenceId":"9f2d493b-593b-4dc6-a935-0e53e48a673f"}],"type":"sentence_pattern"}'::jsonb,
    18,
    true
  ),
(
    '6afcb55d-3dc4-49ab-bd3c-3fba66d19ff1'::uuid,
    'sentence_pattern',
    '{"id":"6afcb55d-3dc4-49ab-bd3c-3fba66d19ff1","pattern":"The strongest benefits concern [主要收获].","function":"从多个数据提炼共同特点","tags":["数据表达"],"grammarNote":"concern在此意为涉及；through说明学习方式。","usageNote":"归纳应能覆盖最高几项，不是照抄一个标签。","examples":[{"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"eb78f86f-f70d-57c4-bc8d-0c251d46ecaa","sentenceText":"The strongest benefits concern learning through direct participation.","translation":"最突出的收益是通过亲身参与学习。","bindings":{"主要收获":"learning through direct participation"}},{"essayId":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","sentenceId":"eeaebfdc-e6d7-5cb8-a02a-4989ba866ca7","sentenceText":"The strongest benefits concern intellectual exploration.","translation":"最突出的收益涉及智力探索。","bindings":{"主要收获":"intellectual exploration"}}],"type":"sentence_pattern"}'::jsonb,
    19,
    true
  ),
(
    'bc0cc872-cfa1-4092-9fb9-17aca60d6844'::uuid,
    'sentence_pattern',
    '{"id":"bc0cc872-cfa1-4092-9fb9-17aca60d6844","pattern":"As [阶段变化], [能力] becomes more valuable: [实际需求].","function":"处境变化带来需求并影响选择","tags":["解释"],"grammarNote":"As引出阶段；冒号后解释能力为何更有价值。","usageNote":"不是年龄或年级本身导致结果，应写具体需求。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"72764995-94a4-54db-a234-d10627667919","sentenceText":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers.","translation":"随着毕业临近，实践经验更有价值：学生需要探索职业兴趣、发展可迁移技能，并向雇主展示能力。","bindings":{"阶段变化":"graduation approaches","能力":"practical experience","实际需求":"students need to test career interests, develop transferable skills and demonstrate their abilities to employers"},"exampleSentenceId":"26cdfd47-e838-47e5-ab16-714f64d19c5d"}],"type":"sentence_pattern"}'::jsonb,
    20,
    true
  ),
(
    '142811d8-2d5a-4f9f-8798-2a4de5cfb343'::uuid,
    'sentence_pattern',
    '{"id":"142811d8-2d5a-4f9f-8798-2a4de5cfb343","pattern":"[活动] offers [直接作用], while [情境] provide [体验].","function":"解释活动如何满足两种相关需要","tags":["解释"],"grammarNote":"while连接两种机制，而非只罗列活动好处。","usageNote":"替换后注意单复数与动词一致。","examples":[{"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"9e504b34-807c-562c-aa9d-cac9d7556023","sentenceText":"Travel offers a temporary escape from familiar pressures, while natural surroundings provide pleasure that everyday routines may lack.","translation":"旅游让学生暂离熟悉压力，自然环境也提供日常作息可能缺少的乐趣。","bindings":{"活动":"Travel","直接作用":"a temporary escape from familiar pressures","情境":"natural surroundings","体验":"pleasure that everyday routines may lack"},"exampleSentenceId":"f5e86afb-6aae-427c-be28-7b18f9f864a2"},{"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"a9811d84-121c-5851-9987-d888d763527b","sentenceText":"Television offers information and entertainment with little physical effort, while walks provide gentle exercise and opportunities to meet neighbours.","translation":"看电视无需太多体力便能获得信息和娱乐，散步则提供温和运动及与邻居见面的机会。","bindings":{"活动":"Television","直接作用":"information and entertainment with little physical effort","情境":"walks","体验":"gentle exercise and opportunities to meet neighbours"}}],"type":"sentence_pattern"}'::jsonb,
    21,
    true
  ),
(
    'c9904c86-9ade-4157-ae91-a49c4c7d0d32'::uuid,
    'sentence_pattern',
    '{"id":"c9904c86-9ade-4157-ae91-a49c4c7d0d32","pattern":"One possible explanation is that [条件] made [目标] easier to [行动].","function":"用门槛降低解释参与变化","tags":["解释"],"grammarNote":"One possible explanation is that后接完整从句；made接宾语和补足语。","usageNote":"这是可能解释，需与图中活动相关。","examples":[{"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"a2357308-fa11-43e2-8c3a-ce819773ee17","sentenceText":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines.","translation":"一个可能解释是更易参与的课程让规律身体活动更容易融入日常作息。","bindings":{"条件":"more accessible sessions","目标":"regular physical activity","行动":"fit into daily routines"},"exampleSentenceId":"35c6354e-5f6a-42f1-a3af-b01637c9d05b"},{"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"834feef5-ed1b-5898-b2d9-684a11d51b9c","sentenceText":"One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries.","translation":"一种可能的解释是，更便宜的手机与更广的网络覆盖，让发展中国家的移动服务更易获取。","bindings":{"条件":"cheaper handsets and wider network coverage","目标":"mobile services","行动":"access in developing countries"},"exampleSentenceId":"fbd25b78-1689-49fd-ac2d-6910c156bedf"}],"type":"sentence_pattern"}'::jsonb,
    22,
    true
  ),
(
    '6168f585-0985-49aa-92e1-a0d12dec2bae'::uuid,
    'sentence_pattern',
    '{"id":"6168f585-0985-49aa-92e1-a0d12dec2bae","pattern":"[短期成效] creates an opportunity, but [长期条件] are what [真正作用].","function":"区分首次成果与持续成功条件","tags":["解释"],"grammarNote":"动名词作主语；but转折；what从句作表语。","usageNote":"长期条件必须具体，不能用同义褒义词反复修饰。","examples":[{"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"4bcacad3-e83b-57e3-9257-b621b9d598fa","sentenceText":"Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return.","translation":"赢得市场份额带来机会，但可靠性能与有效售后才会促使顾客再次选择。","bindings":{"短期成效":"Winning market share","长期条件":"reliable performance and effective after-sales service","真正作用":"encourage customers to return"},"exampleSentenceId":"8d1233cb-026a-49db-a246-de446f742c0f"}],"type":"sentence_pattern"}'::jsonb,
    23,
    true
  ),
(
    '2706f1c1-f1a5-42b7-844e-f47c3750698a'::uuid,
    'sentence_pattern',
    '{"id":"2706f1c1-f1a5-42b7-844e-f47c3750698a","pattern":"[条件A] and [条件B] help [目标] for both [主体A] and [主体B].","function":"解释基础设施对不同主体的共同收益","tags":["解释"],"grammarNote":"并列主语help加动词原形；both…and并列受益者。","usageNote":"两类主体应确实从同一机制受益。","examples":[{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"3ca7dc50-9047-4a73-9e34-3b3c6c03e873","sentenceText":"Better transport links and reliable delivery help expand market access for both rural buyers and local producers.","translation":"更好的交通联系和可靠配送有助于扩大农村买家与当地生产者的市场接入。","bindings":{"条件A":"Better transport links","条件B":"reliable delivery","目标":"expand market access","主体A":"rural buyers","主体B":"local producers"}}],"type":"sentence_pattern"}'::jsonb,
    24,
    true
  ),
(
    '541af8d6-ae6e-4713-913a-5a37ad1fa112'::uuid,
    'sentence_pattern',
    '{"id":"541af8d6-ae6e-4713-913a-5a37ad1fa112","pattern":"[能力], however, does not arise merely because [表面条件]; it requires [必要条件].","function":"区分表面形式与实质能力条件","tags":["解释"],"grammarNote":"does not arise merely because限定原因；分号后给真正条件。","usageNote":"低收益比例可提示改进方向，不证明活动完全无效。","examples":[{"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"9fd67ccb-1fc2-5202-bb4f-1ddf4e59fcf4","sentenceText":"Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another.","translation":"但合作不会仅因学生在同一地点工作就产生，它需要共同目标与真实的相互依赖。","bindings":{"能力":"Cooperation","表面条件":"students work in the same place","必要条件":"shared goals and meaningful dependence on one another"},"exampleSentenceId":"ed02ab3a-44cd-41c0-bb46-b8e2851ce3c4"},{"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"a6281f8e-e2e6-5982-b823-fce6a32b7cc3","sentenceText":"Understanding, however, does not arise merely because a text is accessible; it requires sustained attention.","translation":"然而，理解不会仅因文本容易获取而自然产生；它需要持续专注。","bindings":{"能力":"Understanding","表面条件":"a text is accessible","必要条件":"sustained attention"}}],"type":"sentence_pattern"}'::jsonb,
    25,
    true
  ),
(
    '888eab9d-a929-43c7-a596-6a68fd4ad4f0'::uuid,
    'sentence_pattern',
    '{"id":"888eab9d-a929-43c7-a596-6a68fd4ad4f0","pattern":"Understanding why [需要理解的内容] matters, for example, is more likely to [真正效果] than merely [表面行为].","function":"比较理解与机械记忆的作用","tags":["解释"],"grammarNote":"动名词结构作主语；more likely…than…作比较。","usageNote":"保持两项可比，不写任何记忆都无价值。","examples":[{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"747268dc-f401-581a-839d-b7fae785fd6a","sentenceText":"Understanding why a habit matters, for example, is more likely to support informed choices than merely remembering a slogan.","translation":"例如，理解一个习惯为何重要，比只记住一句口号更能支持有依据的选择。","bindings":{"需要理解的内容":"a habit","真正效果":"support informed choices","表面行为":"remembering a slogan"}}],"type":"sentence_pattern"}'::jsonb,
    26,
    true
  ),
(
    'cffa8a41-975e-46fb-b266-2261234bcb76'::uuid,
    'sentence_pattern',
    '{"id":"cffa8a41-975e-46fb-b266-2261234bcb76","pattern":"The same [工具] that [便利] also delivers [限制], making [必要条件] an essential part of [任务].","function":"说明同一工具的便利与限制","tags":["解释"],"grammarNote":"that修饰device；making写由此产生的注意力要求。","usageNote":"限制应来自同一工具机制，不生硬加入无关弊端。","examples":[{"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"afe0cadd-f286-5b3e-af65-34fc236e69b9","sentenceText":"The same device that opens a useful text also delivers messages and distractions, making concentration an essential part of effective mobile learning.","translation":"打开有用文本的同一设备，也带来消息与干扰，使专注成为有效手机学习的必要部分。","bindings":{"工具":"device","便利":"opens a useful text","限制":"messages and distractions","必要条件":"concentration","任务":"effective mobile learning"},"exampleSentenceId":"357b7f3a-4c39-42eb-bc8d-bfd163c91aa4"},{"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"6a5e3d29-e47f-4616-bdf0-a184fb1ab707","sentenceText":"The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning.","translation":"提供数字资源的同一设备也会带来给注意力造成压力的消息与干扰，因此持续专注成为自主学习的重要部分。","bindings":{"工具":"device","便利":"provides digital resources","限制":"messages and distractions that can put pressure on attention","必要条件":"sustained attention","任务":"independent learning"},"exampleSentenceId":"0a10d930-e9e6-4946-a302-3d838ab1abf2"}],"type":"sentence_pattern"}'::jsonb,
    27,
    true
  ),
(
    '3287e035-d6aa-42d4-8c62-ccb3fe358e1d'::uuid,
    'sentence_pattern',
    '{"id":"3287e035-d6aa-42d4-8c62-ccb3fe358e1d","pattern":"When [参与条件], [活动] can help them [收益行动].","function":"在具体条件下呈现活动的综合收益","tags":["解释"],"grammarNote":"When给出参与情境；help后并列动词原形。","usageNote":"不能把潜在收益写成每个参与者都已获得。","examples":[{"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"cb92e036-dde7-4cf8-a927-8aac38656364","sentenceText":"When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties.","translation":"成人与儿童共同探索时，家庭工作坊能帮助他们仔细观察、交流问题并增进家庭联系。","bindings":{"参与条件":"adults and children explore together","活动":"a family workshop","收益行动":"observe closely, exchange questions and strengthen family ties"},"exampleSentenceId":"3520e741-6537-43f5-807c-fab3aa177298"},{"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"9febea0d-9a4b-5750-a52a-f1ee9ce90421","sentenceText":"When students plant, repair or produce something, practical work can help them connect instructions with actions and respond to results.","translation":"学生种植、修理或制作东西时，实践工作能帮助他们把指令与行动联系起来，并根据结果作出回应。","bindings":{"参与条件":"students plant, repair or produce something","活动":"practical work","收益行动":"connect instructions with actions and respond to results"}}],"type":"sentence_pattern"}'::jsonb,
    28,
    true
  ),
(
    'f679f581-66c3-4554-a6bc-724a40fc95f5'::uuid,
    'sentence_pattern',
    '{"id":"f679f581-66c3-4554-a6bc-724a40fc95f5","pattern":"[较低指标] need not reduce their value: [价值A], and [价值B].","function":"避免由低参与率推导低价值","tags":["解释"],"grammarNote":"need not表示未必；冒号后举两项具体价值。","usageNote":"不否认参与率事实，而区分条件与价值。","examples":[{"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"3761ee1b-3b56-5403-9376-b3e6d05a46f6","sentenceText":"Their lower participation rates need not reduce their value: reading can stimulate thought, and a game of chess can provide both mental challenge and social contact.","translation":"参与率较低不应降低它们的价值：阅读激发思考，下棋兼具智力挑战与社会交往。","bindings":{"较低指标":"Their lower participation rates","价值A":"reading can stimulate thought","价值B":"a game of chess can provide both mental challenge and social contact"}}],"type":"sentence_pattern"}'::jsonb,
    29,
    true
  ),
(
    '81c3ccde-b1cf-475b-b5e3-25662a2527e2'::uuid,
    'sentence_pattern',
    '{"id":"81c3ccde-b1cf-475b-b5e3-25662a2527e2","pattern":"Continued progress should therefore concern [质量目标], not [数量指标] alone.","function":"由规模增长转向质量标准","tags":["评论"],"grammarNote":"should concern…not…alone给出发展评价重点。","usageNote":"先描述数量意义，再说明怎样改善质量。","examples":[{"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"fcc9d096-6a8c-506a-b6fe-14c06682c7e0","sentenceText":"Continued progress should therefore concern the quality of encounters, not visitor totals alone.","translation":"因此，持续进步应关注体验质量，而不只看参观总量。","bindings":{"质量目标":"the quality of encounters","数量指标":"visitor totals"},"exampleSentenceId":"db0b8af8-8b7a-4e39-91cc-c4c254b066a6"},{"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"b47487d1-ca72-4bb1-80c5-023451dba18c","sentenceText":"Continued progress should therefore concern lasting benefits, not volume alone.","translation":"因此，持续进步应着眼于持久收益，而不只关注业务量。","bindings":{"质量目标":"lasting benefits","数量指标":"volume"},"exampleSentenceId":"c25a1790-9676-4050-9e77-c86e8b88214b"}],"type":"sentence_pattern"}'::jsonb,
    30,
    true
  ),
(
    '4b013e1b-a5b1-4089-911d-c697efe954b2'::uuid,
    'sentence_pattern',
    '{"id":"4b013e1b-a5b1-4089-911d-c697efe954b2","pattern":"[针对性行动] is more likely to [目标] than [无效做法].","function":"用效果比较支持针对性措施","tags":["评论"],"grammarNote":"两个动名词短语作比较；than后不是无主长句。","usageNote":"需要说明哪些关切、怎样回应，而非空喊针对性。","examples":[{"essayId":"989d1b46-48f3-51a9-b788-c26e8ac1d042","sentenceId":"11d91b06-f0e4-50f1-b824-e3368f5af064","sentenceText":"Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need.","translation":"回应具体关切，比提供忽视真实需要的福利更有可能提升士气。","bindings":{"针对性行动":"Addressing specific concerns","目标":"improve morale","无效做法":"providing benefits that overlook what employees actually need"},"exampleSentenceId":"8e8ce4d5-c3b4-401d-9a43-4a3848cadf34"},{"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"b6626d4e-bace-579b-bac1-ffce17cb822f","sentenceText":"Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone.","translation":"把鲜明特色与可靠表现结合起来，比仅依赖新奇感更可能赢得再次光顾。","bindings":{"针对性行动":"Combining distinctive strengths with dependable performance","目标":"earn repeat visits","无效做法":"relying on novelty alone"},"exampleSentenceId":"e5afbf1e-b33d-49c2-941a-62ca5568a486"}],"type":"sentence_pattern"}'::jsonb,
    31,
    true
  ),
(
    'e6ef667a-ee6b-40ca-bcac-35393bbc3ed6'::uuid,
    'sentence_pattern',
    '{"id":"e6ef667a-ee6b-40ca-bcac-35393bbc3ed6","pattern":"[主体], in turn, should consider what [选择对象] [非金钱收益] as well as what it [直接收益].","function":"为选择提出双重评价标准","tags":["评论"],"grammarNote":"what从句平行作consider宾语；in turn承接高校责任。","usageNote":"不否定收入的重要性，只增加学习价值维度。","examples":[{"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"017a588b-5db2-59a6-8d05-2be155a37c21","sentenceText":"Students, in turn, should consider what a job teaches them as well as what it pays.","translation":"学生也应既考虑工作教会自己什么，也考虑报酬。","bindings":{"主体":"Students","选择对象":"a job","非金钱收益":"teaches them","直接收益":"pays"}}],"type":"sentence_pattern"}'::jsonb,
    32,
    true
  ),
(
    'fbe6ca4f-01a8-46ef-8f4a-533bbbc8ac96'::uuid,
    'sentence_pattern',
    '{"id":"fbe6ca4f-01a8-46ef-8f4a-533bbbc8ac96","pattern":"No [路径] is automatically superior: [选择A] is valuable when [条件A], just as [选择B] is valuable when [条件B].","function":"用一致标准评价不同道路","tags":["评论"],"grammarNote":"冒号解释判断；just as作类比；两个when限定价值条件。","usageNote":"不是宣称所有选项完全等价，而看是否匹配目的。","examples":[{"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"4dd7c151-3ca0-5006-84e0-d0e7fba484a3","sentenceText":"No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development.","translation":"没有哪条路天然更好：深造因服务明确目的而有价值，工作则因提供适合的发展前景而有价值。","bindings":{"路径":"route","选择A":"further study","条件A":"it serves a clear purpose","选择B":"a job","条件B":"it offers suitable prospects for development"},"exampleSentenceId":"e9d6d92d-caab-4da6-be9f-8e52a6efd2a5"}],"type":"sentence_pattern"}'::jsonb,
    33,
    true
  ),
(
    'b9c56360-e4db-4225-8782-5881d29fe806'::uuid,
    'sentence_pattern',
    '{"id":"b9c56360-e4db-4225-8782-5881d29fe806","pattern":"[主体] can help by [措施A], [措施B] and [措施C].","function":"用具体条件扩大参与机会","tags":["评论"],"grammarNote":"by后接三个动名词短语，结构平行。","usageNote":"每项措施应回应前文的一种限制。","examples":[{"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"35cfd668-afa6-5f02-a7f0-591f12855dd6","sentenceText":"Communities can help by maintaining safe paths, providing comfortable reading spaces and making it easy to find activity partners.","translation":"社区可维护安全步道、提供舒适阅读空间，并让寻找活动伙伴更容易。","bindings":{"主体":"Communities","措施A":"maintaining safe paths","措施B":"providing comfortable reading spaces","措施C":"making it easy to find activity partners"},"exampleSentenceId":"2fe5fd58-0a80-46d0-b7da-d61afadca731"},{"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"c82bc04f-9d07-5163-a7f8-72ecc53e84bf","sentenceText":"Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims.","translation":"公共教育可以通过使用通俗语言、呈现熟悉情境，并帮助人们区分可靠建议与误导性说法发挥作用。","bindings":{"主体":"Public education","措施A":"using plain language","措施B":"presenting familiar situations","措施C":"helping people distinguish sound advice from misleading claims"},"exampleSentenceId":"b800ce6d-cec7-41e6-bea1-bfa2e01d17dc"}],"type":"sentence_pattern"}'::jsonb,
    34,
    true
  ),
(
    'ea0e06a4-a2ea-495e-b568-513b4ebb852f'::uuid,
    'sentence_pattern',
    '{"id":"ea0e06a4-a2ea-495e-b568-513b4ebb852f","pattern":"Growth is most meaningful when it [积极结果] without [避免代价].","function":"以收益和代价共同评价增长","tags":["评论"],"grammarNote":"when引出有价值的条件；without接动名词。","usageNote":"不要把规模直接等同于进步。","examples":[{"essayId":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","sentenceId":"e907d67a-71ce-57c5-8e2c-c76c7cd86ef6","sentenceText":"Growth is most meaningful when it makes trade more accessible without shifting unreasonable costs onto people or the environment.","translation":"增长在便利交易，又不把不合理成本转嫁给人或环境时最有意义。","bindings":{"积极结果":"makes trade more accessible","避免代价":"shifting unreasonable costs onto people or the environment"},"exampleSentenceId":"835e32ab-71f0-454e-b2ba-7cc2c0c73cb2"}],"type":"sentence_pattern"}'::jsonb,
    35,
    true
  ),
(
    'c5a5b058-f7d2-42bb-86ce-3c1ca33aa667'::uuid,
    'sentence_pattern',
    '{"id":"c5a5b058-f7d2-42bb-86ce-3c1ca33aa667","pattern":"[主体] also need [支持] so that [行为] remains a choice rather than a necessity.","function":"让行动保持为选择而非被迫","tags":["评论"],"grammarNote":"so that说明配套投入的目的；rather than比较选择与必要。","usageNote":"不否定自愿迁移，重点在替代机会。","examples":[{"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"ee52aae1-e93d-5ade-b7d9-84f56928e148","sentenceText":"Rural areas also need investment so that migration remains a choice rather than a necessity.","translation":"农村也需要投入，使迁移是一种选择，而非迫不得已。","bindings":{"主体":"Rural areas","支持":"investment","行为":"migration"},"exampleSentenceId":"a970ced0-ad8e-40e6-9cde-5131434e42e4"}],"type":"sentence_pattern"}'::jsonb,
    36,
    true
  ),
(
    'be257ee8-02bb-4ba0-b4ed-e65e61748a8a'::uuid,
    'sentence_pattern',
    '{"id":"be257ee8-02bb-4ba0-b4ed-e65e61748a8a","pattern":"In my view, [行为] is worthwhile when it [价值] without [避免代价].","function":"在保留价值的同时控制成本","tags":["评论"],"grammarNote":"when与without分别限定收益和成本。","usageNote":"花钱多少不是关系质量唯一标准。","examples":[{"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"e87d515f-c823-5495-8d9f-c8f7d1a5fcf9","sentenceText":"In my view, festive spending is worthwhile when it strengthens relationships without creating financial strain.","translation":"我认为，节日花销在增进关系又不制造经济负担时值得。","bindings":{"行为":"festive spending","价值":"strengthens relationships","避免代价":"creating financial strain"},"exampleSentenceId":"bca656ee-2d20-4197-a42e-fb84b4604a00"},{"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"93cdc3f0-57c6-4928-a06b-c1445948bee8","sentenceText":"In my view, festive spending is worthwhile when it respects family priorities without creating financial strain.","translation":"在我看来，节日支出若能尊重家庭优先事项，又不造成经济负担，就是值得的。","bindings":{"行为":"festive spending","价值":"respects family priorities","避免代价":"creating financial strain"},"exampleSentenceId":"599c1f3e-020e-4720-aead-e0c91c67209f"}],"type":"sentence_pattern"}'::jsonb,
    37,
    true
  ),
(
    'c7709dc2-ad99-442e-9517-d0ce03fee2ed'::uuid,
    'sentence_pattern',
    '{"id":"c7709dc2-ad99-442e-9517-d0ce03fee2ed","pattern":"[主体] can [设计] and ask students to reflect on both [反思A] and [反思B].","function":"把任务设计与反馈反思结合","tags":["评论"],"grammarNote":"can后并列assign和ask；both…and并列反思对象。","usageNote":"合作不是仅共处，分工要有真实互补。","examples":[{"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"f86f25e4-c9f3-5f42-85a2-c269622c254d","sentenceText":"Projects can assign complementary responsibilities and ask students to reflect on both their results and their collaboration.","translation":"项目可分配互补职责，并要求学生反思结果与协作。","bindings":{"主体":"Projects","设计":"assign complementary responsibilities","反思A":"their results","反思B":"their collaboration"}},{"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"6d390072-64f2-4b73-b937-1f9cbdcad35a","sentenceText":"Teachers can design projects and ask students to reflect on both their understanding and their joint responsibilities.","translation":"教师可以设计项目，并请学生同时反思自己的理解与共同责任。","bindings":{"主体":"Teachers","设计":"design projects","反思A":"their understanding","反思B":"their joint responsibilities"},"exampleSentenceId":"4ece0bf7-6f6e-4031-b662-65447015ca39"}],"type":"sentence_pattern"}'::jsonb,
    38,
    true
  ),
(
    'cb7a9c6b-f6a9-40a2-8855-059c6c2b66e1'::uuid,
    'sentence_pattern',
    '{"id":"cb7a9c6b-f6a9-40a2-8855-059c6c2b66e1","pattern":"[条件A], [条件B] and [条件C] can make [对象] [结果].","function":"用并列行动说明如何提升活动或服务价值","tags":["评论"],"grammarNote":"三个动名词短语作并列主语；make接宾语和补足语。","usageNote":"三项具体行动须共同支持所述效果；儿童活动兼顾指导与探索，服务场景则对应稳定质量与信任。","examples":[{"essayId":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","sentenceId":"533fb6c6-1cc3-5ea1-b36f-459218e1c387","sentenceText":"Choosing safe surroundings, listening to questions and allowing time to observe can make ordinary outings valuable.","translation":"选择安全环境、倾听问题、给足观察时间，可以让普通外出有价值。","bindings":{"条件A":"Choosing safe surroundings","条件B":"listening to questions","条件C":"allowing time to observe","对象":"ordinary outings","结果":"valuable"},"exampleSentenceId":"37b1f7e8-d6fd-4125-918e-ecaa5502a410"},{"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"26432758-5eaa-4691-bd5d-2314b4fb6d4a","sentenceText":"Training staff, checking ingredients and listening to complaints can make a restaurant more trustworthy.","translation":"培训员工、检查食材并倾听投诉，可以让餐厅更值得信赖。","bindings":{"条件A":"Training staff","条件B":"checking ingredients","条件C":"listening to complaints","对象":"a restaurant","结果":"more trustworthy"},"exampleSentenceId":"ecd0179e-78d8-4a2e-bc40-93c7272cbcc2"}],"type":"sentence_pattern"}'::jsonb,
    39,
    true
  ),
(
    'c6953d57-74a1-4a6d-8369-44a566f22c0e'::uuid,
    'example_sentence',
    '{"id":"c6953d57-74a1-4a6d-8369-44a566f22c0e","text":"Your thoughtful arrangements and warm hospitality made me feel welcome throughout the exchange.","translation":"你周到的安排与热情款待，让我在整个交流期间都感到受到欢迎。","tags":["人际沟通"],"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"62e71405-aeef-51a9-8eca-e0c0fda97284","shortNote":"感谢与具体收获：用安排和款待说明交流体验。","relatedPhraseIds":["ac2a8f29-306d-5108-881a-fa6e9c63ca8e","cf68f945-81e9-5c5a-b6d5-d08b3d1217ef","e1f6414a-da57-58f6-b628-0c3acd8d22c8"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    0,
    true
  ),
(
    'ff94728e-7931-4e8a-bc8f-862659a3a342'::uuid,
    'example_sentence',
    '{"id":"ff94728e-7931-4e8a-bc8f-862659a3a342","text":"It would be a pleasure to return your kindness by showing you around my city and introducing you to our traditions and local food.","translation":"我很乐意带你游览我的城市，介绍我们的传统和当地食物，以回报你的好意。","tags":["人际沟通"],"essayId":"783dd39f-2c9e-5006-9447-d405de6fbf8e","sentenceId":"1dfa0010-3213-5f59-a6ce-cd2cffd88def","shortNote":"回访邀请：by后用可提供的具体帮助回应好意。","relatedPhraseIds":["2bd71c9d-2b3a-5c51-af91-0ecd09a686d6"],"relatedPatternIds":["232b1283-4901-4364-a70f-bcc2332c48cd"],"type":"example_sentence"}'::jsonb,
    1,
    true
  ),
(
    '0a137474-c73e-4c9f-9069-e8a4b02d9652'::uuid,
    'example_sentence',
    '{"id":"0a137474-c73e-4c9f-9069-e8a4b02d9652","text":"I know how much effort you have put into this goal, and I am delighted that it has paid off.","translation":"我知道你为这个目标付出了很多努力，很高兴努力得到了回报。","tags":["学习成长"],"essayId":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","sentenceId":"b22ba0f0-c781-5bfd-8b9a-4d7f437874c7","shortNote":"回应喜讯：把付出与成功联系起来。","relatedPhraseIds":["f34f98bf-662b-50a5-b1c8-c5a38e4fe488"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    2,
    true
  ),
(
    'cf43fa9e-5350-42ba-82e6-40512fb92a1c'::uuid,
    'example_sentence',
    '{"id":"cf43fa9e-5350-42ba-82e6-40512fb92a1c","text":"University learning calls for greater independence, so getting used to organizing your own time will help.","translation":"大学学习要求更强的独立性，因此习惯自行安排时间会有帮助。","tags":["学习成长"],"essayId":"775003e2-3ef6-5b71-b9c6-1cecfdc6212a","sentenceId":"c10ad929-e081-5f86-ab38-6f7873bf8c06","shortNote":"准备建议：用大学学习的要求解释时间管理。","relatedPhraseIds":[],"relatedPatternIds":["e8316de9-f4c2-40c8-87ac-1c11e86f14f7"],"type":"example_sentence"}'::jsonb,
    3,
    true
  ),
(
    '852effc7-5a70-4771-ade4-181ac6f23de7'::uuid,
    'example_sentence',
    '{"id":"852effc7-5a70-4771-ade4-181ac6f23de7","text":"The screen repeatedly goes blank, and several keys fail to respond, making the dictionary unusable for my studies.","translation":"屏幕反复变为空白，几个按键也没有反应，导致词典无法用于学习。","tags":["消费沟通"],"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"01e0ee39-97a0-5b8a-89ee-934d0b967582","shortNote":"故障描述：用两项可观察的问题说明影响。","relatedPhraseIds":["599afaff-907b-521c-84e4-a9ed4edbd33e","b52f3ed2-d590-5231-8a4c-5b9a99434593"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    4,
    true
  ),
(
    '2d652e87-02c8-455c-afc0-cde69ddaa645'::uuid,
    'example_sentence',
    '{"id":"2d652e87-02c8-455c-afc0-cde69ddaa645","text":"If this cannot be arranged promptly, please issue a full refund and advise me how to return the faulty item.","translation":"若无法及时安排，请全额退款，并告知怎样退回故障商品。","tags":["消费沟通"],"essayId":"d1a0fe70-d3b9-556f-91e7-3afdbd49f0dd","sentenceId":"0f5a7269-e1fb-5cea-9775-be597d3cc390","shortNote":"补救要求：在无法换货时提出退款与退货安排。","relatedPhraseIds":["346ba3c0-143f-5b0b-aebd-d010dadb76c6","5a698d3b-35ea-5120-91ea-6cfef01b78f3"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    5,
    true
  ),
(
    'b0cde08f-e977-45d1-8352-27c6fc9a0d86'::uuid,
    'example_sentence',
    '{"id":"b0cde08f-e977-45d1-8352-27c6fc9a0d86","text":"Our class is holding a charity sale to support children in need, and I warmly invite you to take part in the event.","translation":"我们班将举办义卖，支持有需要的儿童，诚邀大家参加。","tags":["校园公益"],"essayId":"62a45036-d5ec-5bc9-a8a7-f8484bba7b13","sentenceId":"da7e0a7a-1159-57a6-b198-f3ccb74caf08","shortNote":"活动动员：同时交代义卖目的与参与邀请。","relatedPhraseIds":["46c463ee-b249-5484-8a37-9afb45347a48"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    6,
    true
  ),
(
    'bf218dfd-e543-4704-9c66-2316af0c6637'::uuid,
    'example_sentence',
    '{"id":"bf218dfd-e543-4704-9c66-2316af0c6637","text":"If you have nothing to donate, you can still help by setting up stalls or serving customers.","translation":"若没有可捐物品，也能帮忙搭建摊位或接待顾客。","tags":["校园公益"],"essayId":"62a45036-d5ec-5bc9-a8a7-f8484bba7b13","sentenceId":"e2da30bb-a3b0-565d-a729-0fa2fdbc6fb3","shortNote":"替代参与方式：无法捐物时也可贡献时间。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    7,
    true
  ),
(
    'cd67cadf-ff3a-46e3-95ae-b30a9236ab7d'::uuid,
    'example_sentence',
    '{"id":"cd67cadf-ff3a-46e3-95ae-b30a9236ab7d","text":"I prefer a quiet study environment, keep shared spaces tidy and am happy to share responsibilities for the housework.","translation":"我喜欢安静的学习环境，会保持公共区域整洁，也愿意分担家务责任。","tags":["日常合作"],"essayId":"4fc8d915-6628-58cf-bf99-ab8fc56c586b","sentenceId":"42a397fd-7b0e-589c-bee0-84eb104902ae","shortNote":"生活说明：并列介绍环境偏好、整洁习惯和家务责任。","relatedPhraseIds":["6e7a05c8-31ab-5582-a951-fef6dc7cd531"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    8,
    true
  ),
(
    '9e3d7ff4-96f8-4708-8c8d-b8e2e8651105'::uuid,
    'example_sentence',
    '{"id":"9e3d7ff4-96f8-4708-8c8d-b8e2e8651105","text":"Could you suggest affordable places to shop and the easiest way to get to campus?","translation":"你能推荐价格实惠的购物地点，以及去校园最方便的方式吗？","tags":["日常合作"],"essayId":"4fc8d915-6628-58cf-bf99-ab8fc56c586b","sentenceId":"ecfe30be-aa76-586e-8a70-633547d34d07","shortNote":"具体询问：让购物与通学问题容易回复。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    9,
    true
  ),
(
    'c1a66c0f-f639-4ddf-a1db-08c793e4e899'::uuid,
    'example_sentence',
    '{"id":"c1a66c0f-f639-4ddf-a1db-08c793e4e899","text":"Volunteer duties will include welcoming students, leading tours and assisting with activities.","translation":"志愿者职责包括迎接学生、带领参观并协助活动。","tags":["校园活动"],"essayId":"86a1454d-7ea6-50ee-a9f9-11987ad1638d","sentenceId":"6f72159c-3c46-5d2a-90e7-1aade4bb0429","shortNote":"职责说明：用三个动名词明确志愿者任务。","relatedPhraseIds":["caaa22dd-ea4b-5ea6-8d22-196d39e2b4a9"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    10,
    true
  ),
(
    'ff397db8-883a-4644-98a3-eb7d67ea729c'::uuid,
    'example_sentence',
    '{"id":"ff397db8-883a-4644-98a3-eb7d67ea729c","text":"Please submit an application with a brief introduction and your contact details to the Students’ Union by June 10.","translation":"请于六月十日前向学生会提交申请，附简短介绍与联系方式。","tags":["校园活动"],"essayId":"86a1454d-7ea6-50ee-a9f9-11987ad1638d","sentenceId":"f560fe9c-6794-5bf1-b468-7fc691d4f5ec","shortNote":"申请安排：写清材料、渠道和截止时间。","relatedPhraseIds":["80bba3fc-d4b5-5a0b-983e-4703e5039280"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    11,
    true
  ),
(
    '432fc9cf-0ac9-42db-bbda-f80855cf0961'::uuid,
    'example_sentence',
    '{"id":"432fc9cf-0ac9-42db-bbda-f80855cf0961","text":"A translation must sound natural as well as convey the original meaning.","translation":"译文既要自然，也要传达原意。","tags":["学习方法"],"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"e187730e-5644-5c68-b3fb-79c0ab89550f","shortNote":"评价标准：兼顾表达自然与忠实原意。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    12,
    true
  ),
(
    '7ccce385-9a10-4134-88b0-ee379a1765cf'::uuid,
    'example_sentence',
    '{"id":"7ccce385-9a10-4134-88b0-ee379a1765cf","text":"Keep a record of useful expressions and recurring mistakes to make each exercise more rewarding.","translation":"记录有用表达和反复出现的错误，让每次练习更有收获。","tags":["学习方法"],"essayId":"5fdbe6b8-b7a1-583e-bb8a-6655c89a8ca4","sentenceId":"28737ac6-9c4e-52da-b636-2a7fc394845a","shortNote":"练习方法：记录有用表达和反复错误，以便改进。","relatedPhraseIds":["57454dc3-a310-5d14-afa1-7db72fb96dc7","c37f4276-0c34-567b-9d7f-b062ea42e9a7"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    13,
    true
  ),
(
    '3f05271c-d814-4ef3-a12f-33b89d0bc110'::uuid,
    'example_sentence',
    '{"id":"3f05271c-d814-4ef3-a12f-33b89d0bc110","text":"My presentation will focus on the Spring Festival and the meaning of family reunion.","translation":"演讲将聚焦春节及家庭团聚的意义。","tags":["文化介绍"],"essayId":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","sentenceId":"92cd6d91-5f4c-5f02-a1fc-0cdc8d7860c2","shortNote":"演讲主题：聚焦一个节日及其文化意义。","relatedPhraseIds":["cb631c67-70fc-5f4f-a029-ecbc2ec37e5b","d71da9fe-5098-59c7-a9ad-7edc9723845d"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    14,
    true
  ),
(
    '6c05c0fd-5a0b-4496-bd41-579f35d5b6ff'::uuid,
    'example_sentence',
    '{"id":"6c05c0fd-5a0b-4496-bd41-579f35d5b6ff","text":"Please let me know the time available for the talk so that I can adjust the presentation accordingly.","translation":"请告知演讲可用时长，以便我相应调整内容。","tags":["文化介绍"],"essayId":"0ceed670-f0a3-5673-915a-6dafabdfc0b1","sentenceId":"93c28518-2cf9-50dd-9ff6-b591dec630eb","shortNote":"安排询问：说明为什么需要了解演讲时长。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    15,
    true
  ),
(
    '05d57aff-685a-4a0d-8f51-ac99e2916a8e'::uuid,
    'example_sentence',
    '{"id":"05d57aff-685a-4a0d-8f51-ac99e2916a8e","text":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements.","translation":"想到您已专门为我留出时间，我为打乱您的安排诚恳道歉。","tags":["礼貌沟通"],"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"7d67f59d-6b4d-507e-b956-4036742c09b9","shortNote":"承认影响后道歉：分词结构的主语必须与I一致。","relatedPhraseIds":["2026ffff-172c-5d67-9c17-2019de2013f1","db724576-95fb-5ed8-a1e0-4ac4e7cd8e15"],"relatedPatternIds":["c4e7b843-cb2f-42dc-a6c0-fbb7c41d0ad8"],"type":"example_sentence"}'::jsonb,
    16,
    true
  ),
(
    '894c83f1-dd40-486b-80cc-1b98a4cd264b'::uuid,
    'example_sentence',
    '{"id":"894c83f1-dd40-486b-80cc-1b98a4cd264b","text":"If another date would suit you better, I will gladly adjust my plans.","translation":"若其他日期更合适，我很愿意调整计划。","tags":["礼貌沟通"],"essayId":"099273ef-e157-5d5f-97b3-02c14f1d606a","sentenceId":"2beef8e3-9288-5ef0-9d5f-bc1902c4d002","shortNote":"替代安排：把时间偏好留给对方并承诺配合。","relatedPhraseIds":["a8cfb1a6-c787-5d78-be3a-aceb5472f009"],"relatedPatternIds":["603a976c-22b9-44b8-9336-f3675cb00c81"],"type":"example_sentence"}'::jsonb,
    17,
    true
  ),
(
    '569ffffc-d656-4644-8708-cbb00748fa0b'::uuid,
    'example_sentence',
    '{"id":"569ffffc-d656-4644-8708-cbb00748fa0b","text":"The topic balances concerns about congestion and pollution against people’s need for convenient transport, giving both sides substantial arguments.","translation":"该题将拥堵与污染的顾虑，同便利交通的需求放在一起权衡，使双方都有充分可辩的理由。","tags":["活动策划"],"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"b9301c6f-ebc8-5152-9f29-4b074ee85648","shortNote":"选题理由：呈现交通议题中相互竞争的关切。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    18,
    true
  ),
(
    '136a03f0-2c9b-467e-a472-9310f378fa53'::uuid,
    'example_sentence',
    '{"id":"136a03f0-2c9b-467e-a472-9310f378fa53","text":"Two teams of four students will present opposing views, exchange questions and give closing statements.","translation":"两队各四名学生将陈述对立观点、相互提问并作总结陈词。","tags":["活动策划"],"essayId":"e6733e88-fa3c-51e0-aef7-b4d7f873ebca","sentenceId":"d7483016-4270-5a5e-8a7f-259a3fa2fc06","shortNote":"流程安排：三项并列任务形成清楚的辩论程序。","relatedPhraseIds":["4ee1b01a-f8b1-5d9e-8f98-f4001ff08e9e","e6bda8f8-9fd0-5bf7-8970-763808ee8e27"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    19,
    true
  ),
(
    'd0dac02d-2889-4ec1-a5ba-626d146268bc'::uuid,
    'example_sentence',
    '{"id":"d0dac02d-2889-4ec1-a5ba-626d146268bc","text":"Its grand halls and courtyards offer a fascinating introduction to traditional architecture and imperial life.","translation":"宏伟的殿堂与庭院，为了解传统建筑和宫廷生活提供了生动入口。","tags":["文化参观"],"essayId":"d3511bd1-6016-5a5b-9069-15a50765c276","sentenceId":"df6305ad-2e8b-550f-b2f3-99b22d6133b9","shortNote":"景点介绍：用具体建筑特色连接文化和历史。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    20,
    true
  ),
(
    '4b6aa3b8-61d8-47fe-9baa-b826909fbe5e'::uuid,
    'example_sentence',
    '{"id":"4b6aa3b8-61d8-47fe-9baa-b826909fbe5e","text":"To make the most of the visit, please read a brief introduction in advance and note any questions you would like to ask.","translation":"为了充分利用此次参观，请提前阅读简短介绍，记下想提的问题。","tags":["文化参观"],"essayId":"d3511bd1-6016-5a5b-9069-15a50765c276","sentenceId":"86da657e-7f92-5fc6-b512-7aaedcd724c2","shortNote":"行前建议：把提前阅读与提问联系到参观收获。","relatedPhraseIds":["3e391bbb-6502-59c6-b0a0-f1f415f348a2","865a5329-bec2-57cb-899f-144735cf8036"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    21,
    true
  ),
(
    'f95d823b-c758-4568-98fa-5990877615db'::uuid,
    'example_sentence',
    '{"id":"f95d823b-c758-4568-98fa-5990877615db","text":"I would like to invite you to an online meeting on adapting to university life, scheduled for 3 p.m. next Saturday.","translation":"我想邀请你参加下周六下午三点举行的线上会议，主题是适应大学生活。","tags":["校园交流"],"essayId":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","sentenceId":"44653e67-eb34-5c3f-8ad3-bc8f5a0ea7ad","shortNote":"邀请信息：在一句中交代主题、形式与时间。","relatedPhraseIds":["f3faa02a-e2a7-5b82-b6bf-9d5677d726e6"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    22,
    true
  ),
(
    'f7dd0245-ca9a-4e76-a015-c5182e3ad44c'::uuid,
    'example_sentence',
    '{"id":"f7dd0245-ca9a-4e76-a015-c5182e3ad44c","text":"It would be wonderful if you could share one challenge you encountered and how you dealt with it.","translation":"若你能分享一个遇到的困难及应对办法，那就太好了。","tags":["校园交流"],"essayId":"6a38af24-c7e7-5bb5-8488-d2b48d76ab9e","sentenceId":"e93a6f4e-5977-5df2-962d-f1f680ba23ba","shortNote":"参与任务：委婉请对方分享一个挑战及解决方法。","relatedPhraseIds":[],"relatedPatternIds":["e5aa9d97-5016-4cd9-90d0-6cf00cde524e"],"type":"example_sentence"}'::jsonb,
    23,
    true
  ),
(
    '4d33437a-7d51-4c0c-adbd-aff209d9f276'::uuid,
    'example_sentence',
    '{"id":"4d33437a-7d51-4c0c-adbd-aff209d9f276","text":"You can sample regional dishes, hear the stories behind them and watch a dumpling-making demonstration.","translation":"你们可以品尝地方菜肴、了解背后故事，并观看包饺子示范。","tags":["校园交流"],"essayId":"45e8079a-3dfa-5a72-8e7c-718cf9283b2f","sentenceId":"a9858830-a126-58c9-93bd-6b96cf820bd5","shortNote":"活动内容：用三项具体体验展示美食节的吸引力。","relatedPhraseIds":["813f036f-e015-5ec3-8cd2-00b31cfbbc20"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    24,
    true
  ),
(
    '146aa71c-2816-4e55-8a40-eee2632a310f'::uuid,
    'example_sentence',
    '{"id":"146aa71c-2816-4e55-8a40-eee2632a310f","text":"It would be wonderful if you could introduce a favourite dish from your own country.","translation":"如果你们能介绍一道自己国家喜爱的菜肴，那就太好了。","tags":["校园交流"],"essayId":"45e8079a-3dfa-5a72-8e7c-718cf9283b2f","sentenceId":"21ce44e3-337b-58f3-beca-53c4dfa88740","shortNote":"参与邀请：请来宾提供本国菜肴，形成双向交流。","relatedPhraseIds":[],"relatedPatternIds":["e5aa9d97-5016-4cd9-90d0-6cf00cde524e"],"type":"example_sentence"}'::jsonb,
    25,
    true
  ),
(
    '31730cd5-851f-4b47-b648-f5f0f8b74433'::uuid,
    'example_sentence',
    '{"id":"31730cd5-851f-4b47-b648-f5f0f8b74433","text":"It offers a chance to see technology in action rather than simply read about it.","translation":"它让你看到技术实际运用，而不只是读到有关介绍。","tags":["活动推荐"],"essayId":"db0ac466-ee60-57bf-82aa-0ac19f6484e2","sentenceId":"4126d075-64a4-575c-89eb-999aad5563a3","shortNote":"推荐理由：说明现场体验相对只读文字的价值。","relatedPhraseIds":["92d02a61-2d4a-5b09-85e3-5735a571feb9"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    26,
    true
  ),
(
    '253bef71-793e-496b-9fe3-e20cd8a6af44'::uuid,
    'example_sentence',
    '{"id":"253bef71-793e-496b-9fe3-e20cd8a6af44","text":"You could also ask questions about how the robots work and consider where human judgement is still needed.","translation":"你也可以询问机器人原理，思考哪些地方仍需要人的判断。","tags":["活动推荐"],"essayId":"db0ac466-ee60-57bf-82aa-0ac19f6484e2","sentenceId":"754c5863-4045-5eca-b424-33c25acc30a3","shortNote":"学习行动：把提问与判断人类作用连接起来。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    27,
    true
  ),
(
    '8c754cd9-9eb3-4d95-8815-7c94d0d4719d'::uuid,
    'example_sentence',
    '{"id":"8c754cd9-9eb3-4d95-8815-7c94d0d4719d","text":"For our survey on old-house protection, I suggest combining field observations with interviews so that we can understand both the buildings’ condition and residents’ concerns.","translation":"关于我们的老屋保护调查，我建议把实地观察与访谈结合，以同时了解建筑状况和居民关切。","tags":["合作调查"],"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"e019c065-b5f7-5720-a4b8-0c8e837fbae3","shortNote":"调查方法：建议与目的从句相互对应。","relatedPhraseIds":["ff4e62bd-5214-5481-8adc-289ec193d770"],"relatedPatternIds":["88d67cf6-4d2a-4435-990b-54d09ab5545b"],"type":"example_sentence"}'::jsonb,
    28,
    true
  ),
(
    '6dc457d3-0eb1-4ab3-a3ce-2786c65c8d87'::uuid,
    'example_sentence',
    '{"id":"6dc457d3-0eb1-4ab3-a3ce-2786c65c8d87","text":"I can draft the observation checklist while you prepare interview questions; afterwards, we can compare our findings.","translation":"我拟观察清单，你准备访谈问题，随后我们共同比较发现。","tags":["合作调查"],"essayId":"147a5c42-b17d-5e0f-8181-da7e0d0f8285","sentenceId":"f5cdb8ca-4df8-5fc4-9a1e-ec699835a16a","shortNote":"合作分工：用while分配任务，再汇总发现。","relatedPhraseIds":["45d1aa71-40c6-5206-ad66-3ae0425d0297","a6491afb-28bb-57dd-bdd4-ec7ef3d21ab5"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    29,
    true
  ),
(
    'c84522a5-7a3c-441e-ba66-cd72c97570ea'::uuid,
    'example_sentence',
    '{"id":"c84522a5-7a3c-441e-ba66-cd72c97570ea","text":"I am putting together a short play based on Journey to the West and would love you to join the cast.","translation":"我正在筹备一部根据《西游记》改编的短剧，很希望你加入演员阵容。","tags":["文化介绍"],"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"3a888f5b-e082-5c2c-a360-4d4c65068f8b","shortNote":"邀请目的：交代短剧来源并邀请加入。","relatedPhraseIds":["56aa5fac-34ec-562f-9b35-65a53f94c4c8","c3d1cefd-3bdf-50d0-be57-e915635946bb"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    30,
    true
  ),
(
    'a5b33bf4-676b-4488-a606-2da8f7c13c8d'::uuid,
    'example_sentence',
    '{"id":"a5b33bf4-676b-4488-a606-2da8f7c13c8d","text":"Through their disagreements and eventual cooperation, the story explores what it means to be a good teammate.","translation":"故事通过人物的分歧与最终合作，探讨怎样才算好队友。","tags":["文化介绍"],"essayId":"13f9db2f-1791-596a-a299-06df76f0239d","sentenceId":"e361d0b0-48ed-51d2-88f3-4b1b85db5649","shortNote":"主题说明：通过冲突与合作概括故事意义。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    31,
    true
  ),
(
    '44c0f4f2-4f63-457d-ba66-23d590d2d27b'::uuid,
    'example_sentence',
    '{"id":"44c0f4f2-4f63-457d-ba66-23d590d2d27b","text":"I thoroughly enjoyed it: seeing the journey through your eyes made familiar surroundings feel fresh again.","translation":"我很喜欢：通过你的视角看旅程，让熟悉的环境也重新显得新鲜。","tags":["人际沟通"],"essayId":"dfc938b0-c3bc-58ce-a182-763abd6760fa","sentenceId":"f5b213bc-bd82-5a70-8270-504dd5f583fc","shortNote":"观看感受：用具体视角解释为什么觉得新鲜。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    32,
    true
  ),
(
    'fd074543-deab-4942-ab53-e300f3ce849d'::uuid,
    'example_sentence',
    '{"id":"fd074543-deab-4942-ab53-e300f3ce849d","text":"Which place left the strongest impression on you, and why?","translation":"哪个地方给你印象最深，为什么？","tags":["人际沟通"],"essayId":"dfc938b0-c3bc-58ce-a182-763abd6760fa","sentenceId":"39cf3f7f-015a-528e-ac67-16d12c94552d","shortNote":"后续追问：围绕同一经历询问感受及理由。","relatedPhraseIds":[],"relatedPatternIds":["e40b397a-7cff-4f1a-9aaa-05c494eb2014"],"type":"example_sentence"}'::jsonb,
    33,
    true
  ),
(
    '8ca0de15-c26e-4271-a83a-c2fb516f6a13'::uuid,
    'example_sentence',
    '{"id":"8ca0de15-c26e-4271-a83a-c2fb516f6a13","text":"In developing countries, subscriptions showed a sharp increase from well below 1 billion to 4 billion, whereas developed countries recorded a much gentler rise to approximately 1 billion.","translation":"发展中国家的订阅量由远低于十亿大幅增至四十亿，发达国家则缓慢增至约十亿。","tags":["数字服务"],"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"33b5fe39-5c88-5669-820c-4e1054ed1c79","shortNote":"对照数据：区分订阅量与用户人数，并准确比较增长。","relatedPhraseIds":["de6309da-3206-574a-ae65-cd1032f78be0"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    34,
    true
  ),
(
    'fbd25b78-1689-49fd-ac2d-6910c156bedf'::uuid,
    'example_sentence',
    '{"id":"fbd25b78-1689-49fd-ac2d-6910c156bedf","text":"One possible explanation is that cheaper handsets and wider network coverage made mobile services easier to access in developing countries.","translation":"一种可能的解释是，更便宜的手机与更广的网络覆盖，让发展中国家的移动服务更易获取。","tags":["数字服务"],"essayId":"c958bdb2-5cbd-54c5-be85-883bf531bc73","sentenceId":"834feef5-ed1b-5898-b2d9-684a11d51b9c","shortNote":"可能解释：设备与覆盖降低服务获取门槛。","relatedPhraseIds":["1d61dc00-0162-5568-92ec-f493aa4d2cf4"],"relatedPatternIds":["c9904c86-9ade-4157-ae91-a49c4c7d0d32"],"type":"example_sentence"}'::jsonb,
    35,
    true
  ),
(
    '773e4480-260f-4147-b981-1e08dd189d8a'::uuid,
    'example_sentence',
    '{"id":"773e4480-260f-4147-b981-1e08dd189d8a","text":"The chart shows a reversal in ranking between Chinese and Japanese car brands from 2008 to 2009.","translation":"图表显示2008至2009年国产与日系汽车品牌排名逆转。","tags":["消费服务"],"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"a1cdd944-4ba5-5674-8abb-df0c75beb18f","shortNote":"数据概括：用排名逆转提炼核心变化。","relatedPhraseIds":["e215f573-b862-5454-a764-e4da87eaa882"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    36,
    true
  ),
(
    '8d1233cb-026a-49db-a246-de446f742c0f'::uuid,
    'example_sentence',
    '{"id":"8d1233cb-026a-49db-a246-de446f742c0f","text":"Winning market share creates an opportunity, but reliable performance and effective after-sales service are what encourage customers to return.","translation":"赢得市场份额带来机会，但可靠性能与有效售后才会促使顾客再次选择。","tags":["消费服务"],"essayId":"72dddc6a-fb4e-5a68-a9d8-44ebcddd9731","sentenceId":"4bcacad3-e83b-57e3-9257-b621b9d598fa","shortNote":"条件评论：区分初次赢得份额与持续留客。","relatedPhraseIds":["6348a41e-01b1-5cbf-87f9-169a8a2764c0"],"relatedPatternIds":["6168f585-0985-49aa-92e1-a0d12dec2bae"],"type":"example_sentence"}'::jsonb,
    37,
    true
  ),
(
    'a10095fe-3baa-40a3-b443-3b879a63c43f'::uuid,
    'example_sentence',
    '{"id":"a10095fe-3baa-40a3-b443-3b879a63c43f","text":"Among employees aged 41 to 50, 64% are dissatisfied and none are satisfied.","translation":"41至50岁员工中，64%不满意，无人表示满意。","tags":["工作支持"],"essayId":"989d1b46-48f3-51a9-b788-c26e8ac1d042","sentenceId":"2aa5641d-7933-5a7f-a0a6-df4f349b2dc4","shortNote":"组内数据：不满意与满意比例不必互补到100%。","relatedPhraseIds":[],"relatedPatternIds":["860a332b-0db7-4ea3-958f-27a960b17ec6"],"type":"example_sentence"}'::jsonb,
    38,
    true
  ),
(
    '8e8ce4d5-c3b4-401d-9a43-4a3848cadf34'::uuid,
    'example_sentence',
    '{"id":"8e8ce4d5-c3b4-401d-9a43-4a3848cadf34","text":"Addressing specific concerns is more likely to improve morale than providing benefits that overlook what employees actually need.","translation":"回应具体关切，比提供忽视真实需要的福利更有可能提升士气。","tags":["工作支持"],"essayId":"989d1b46-48f3-51a9-b788-c26e8ac1d042","sentenceId":"11d91b06-f0e4-50f1-b824-e3368f5af064","shortNote":"针对性措施：用效果比较支持回应具体需求。","relatedPhraseIds":["f71fa0e1-eb2f-5cba-a8fb-fd0b3f933c01"],"relatedPatternIds":["4b013e1b-a5b1-4089-911d-c697efe954b2"],"type":"example_sentence"}'::jsonb,
    39,
    true
  ),
(
    '9f2d493b-593b-4dc6-a935-0e53e48a673f'::uuid,
    'example_sentence',
    '{"id":"9f2d493b-593b-4dc6-a935-0e53e48a673f","text":"It reaches 88.24% in the final year, making graduating students the most active participants by a considerable margin.","translation":"大四达到88.24%，毕业年级以明显差距成为参与最积极的群体。","tags":["学习就业"],"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"7b0ef93c-82d9-52a6-8656-1dc29e2de8d8","shortNote":"突出比较：明确最高参与率及对应年级。","relatedPhraseIds":[],"relatedPatternIds":["fdba8d50-67ad-4598-b302-1471c31256b9"],"type":"example_sentence"}'::jsonb,
    40,
    true
  ),
(
    '26cdfd47-e838-47e5-ab16-714f64d19c5d'::uuid,
    'example_sentence',
    '{"id":"26cdfd47-e838-47e5-ab16-714f64d19c5d","text":"As graduation approaches, practical experience becomes more valuable: students need to test career interests, develop transferable skills and demonstrate their abilities to employers.","translation":"随着毕业临近，实践经验更有价值：学生需要探索职业兴趣、发展可迁移技能，并向雇主展示能力。","tags":["学习就业"],"essayId":"ec008595-49f7-5f74-8ff6-ad3f85ebe245","sentenceId":"72764995-94a4-54db-a234-d10627667919","shortNote":"阶段解释：说明毕业临近为何带来实践需求。","relatedPhraseIds":["03f4e30f-eba7-52ee-9439-1ead6c976aa0","3602876e-b9ec-5447-99db-32501e7ac60d","746def7c-537c-5c92-81c4-cb74acf025a2"],"relatedPatternIds":["bc0cc872-cfa1-4092-9fb9-17aca60d6844"],"type":"example_sentence"}'::jsonb,
    41,
    true
  ),
(
    '0e9d65e8-3b4d-4b66-818d-fd38257ee6da'::uuid,
    'example_sentence',
    '{"id":"0e9d65e8-3b4d-4b66-818d-fd38257ee6da","text":"The urban population more than doubled, rising from 300 million to 666 million, while the rural population declined from 834 million to 674 million.","translation":"城镇人口由三亿增至六亿六千六百万，达到两倍以上；乡村人口则由八亿三千四百万降至六亿七千四百万。","tags":["城乡发展"],"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"d5e738ae-56c2-5957-986a-db4e07b99fee","shortNote":"相反走势：同句表达超过翻倍与下降。","relatedPhraseIds":["6687cd91-7e6d-5f5a-a98c-ba9e2d441d20"],"relatedPatternIds":["04a84139-ce37-46b8-999e-e178f87228cf"],"type":"example_sentence"}'::jsonb,
    42,
    true
  ),
(
    'a970ced0-ad8e-40e6-9cde-5131434e42e4'::uuid,
    'example_sentence',
    '{"id":"a970ced0-ad8e-40e6-9cde-5131434e42e4","text":"Rural areas also need investment so that migration remains a choice rather than a necessity.","translation":"农村也需要投入，使迁移是一种选择，而非迫不得已。","tags":["城乡发展"],"essayId":"487c4ff9-9d73-5a24-9760-85628aa33f9d","sentenceId":"ee52aae1-e93d-5ade-b7d9-84f56928e148","shortNote":"配套评论：让迁移保持为选择，需要另一地区的机会。","relatedPhraseIds":["92d02a61-2d4a-5b09-85e3-5735a571feb9"],"relatedPatternIds":["c5a5b058-f7d2-42bb-86ce-3c1ca33aa667"],"type":"example_sentence"}'::jsonb,
    43,
    true
  ),
(
    '34c67f36-54fa-4a5e-a8e1-e3066bac3a64'::uuid,
    'example_sentence',
    '{"id":"34c67f36-54fa-4a5e-a8e1-e3066bac3a64","text":"Gifts take the largest share, at 40%, while transport, meals with family and friends, and other expenses each account for 20%.","translation":"礼物占最大份额40%，交通、亲友聚餐及其他支出各20%。","tags":["消费关系"],"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"17a19865-ea2e-5629-b248-70198c7aead9","shortNote":"构成数据：交代最大项与三个同占比项目。","relatedPhraseIds":["cb4bf055-979b-5ca7-8138-d7a8cf201c54","e52606f7-4d96-5bb0-a869-47531051363c"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    44,
    true
  ),
(
    'bca656ee-2d20-4197-a42e-fb84b4604a00'::uuid,
    'example_sentence',
    '{"id":"bca656ee-2d20-4197-a42e-fb84b4604a00","text":"In my view, festive spending is worthwhile when it strengthens relationships without creating financial strain.","translation":"我认为，节日花销在增进关系又不制造经济负担时值得。","tags":["消费关系"],"essayId":"2969d0a9-2d30-59ca-be57-be58fe68d70d","sentenceId":"e87d515f-c823-5495-8d9f-c8f7d1a5fcf9","shortNote":"条件评价：关系收益与可承受成本同时考虑。","relatedPhraseIds":["5d47b9f3-23e0-5083-9ca4-0247083da071"],"relatedPatternIds":["be257ee8-02bb-4ba0-b4ed-e65e61748a8a"],"type":"example_sentence"}'::jsonb,
    45,
    true
  ),
(
    '67356967-5796-4d5b-b2af-55b2bc64c080'::uuid,
    'example_sentence',
    '{"id":"67356967-5796-4d5b-b2af-55b2bc64c080","text":"Together, sightseeing and relaxation account for seven out of every ten responses.","translation":"观景与放松合计占每十份回答中的七份。","tags":["休闲学习"],"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"924aed35-54ba-550d-a4d4-3057f2134b30","shortNote":"合并概括：把两个互斥目的的份额相加。","relatedPhraseIds":["cb4bf055-979b-5ca7-8138-d7a8cf201c54"],"relatedPatternIds":["41287a19-b9dd-4ca6-b667-a13fcca0ec3a"],"type":"example_sentence"}'::jsonb,
    46,
    true
  ),
(
    'f5e86afb-6aae-427c-be28-7b18f9f864a2'::uuid,
    'example_sentence',
    '{"id":"f5e86afb-6aae-427c-be28-7b18f9f864a2","text":"Travel offers a temporary escape from familiar pressures, while natural surroundings provide pleasure that everyday routines may lack.","translation":"旅游让学生暂离熟悉压力，自然环境也提供日常作息可能缺少的乐趣。","tags":["休闲学习"],"essayId":"85ce14b0-544b-5591-bd91-58ed66b38d3a","sentenceId":"9e504b34-807c-562c-aa9d-cac9d7556023","shortNote":"机制解释：环境变化与压力恢复共同满足旅行需要。","relatedPhraseIds":[],"relatedPatternIds":["142811d8-2d5a-4f9f-8798-2a4de5cfb343"],"type":"example_sentence"}'::jsonb,
    47,
    true
  ),
(
    '3e7795e8-24eb-4721-a56d-f67a45e7eb75'::uuid,
    'example_sentence',
    '{"id":"3e7795e8-24eb-4721-a56d-f67a45e7eb75","text":"Museum numbers rose from about 4,200 to 4,700, while annual visits increased from approximately 640 million to 780 million.","translation":"博物馆约由4200家升至4700家，年参观人次由约6.4亿增至7.8亿。","tags":["文化服务"],"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"1d3bc84d-8dd8-5489-8032-c99499c84580","shortNote":"双指标变化：区分场馆数量与参观人次单位。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    48,
    true
  ),
(
    'db0b8af8-8b7a-4e39-91cc-c4c254b066a6'::uuid,
    'example_sentence',
    '{"id":"db0b8af8-8b7a-4e39-91cc-c4c254b066a6","text":"Continued progress should therefore concern the quality of encounters, not visitor totals alone.","translation":"因此，持续进步应关注体验质量，而不只看参观总量。","tags":["文化服务"],"essayId":"37f0273c-086e-5f3d-929d-9bd309d9598b","sentenceId":"fcc9d096-6a8c-506a-b6fe-14c06682c7e0","shortNote":"质量评论：数量进步后仍需关注接触体验。","relatedPhraseIds":[],"relatedPatternIds":["81c3ccde-b1cf-475b-b5e3-25662a2527e2"],"type":"example_sentence"}'::jsonb,
    49,
    true
  ),
(
    'ba60080c-0a40-47fc-b13b-94a592bc9320'::uuid,
    'example_sentence',
    '{"id":"ba60080c-0a40-47fc-b13b-94a592bc9320","text":"Price accounts for less than a tenth, at 8.4%, while other factors represent 4.7%.","translation":"价格占不到十分之一，为8.4%，其他因素为4.7%。","tags":["消费服务"],"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"4f6c3c70-09c7-55d6-9b92-366d949ed35f","shortNote":"较小份额：近似概括后给出准确数值。","relatedPhraseIds":["cb4bf055-979b-5ca7-8138-d7a8cf201c54","cdeb1d19-9740-5402-babc-2f4e8d7fb256"],"relatedPatternIds":["d247019c-2eda-4a82-9129-d55323d9d925"],"type":"example_sentence"}'::jsonb,
    50,
    true
  ),
(
    'e5afbf1e-b33d-49c2-941a-62ca5568a486'::uuid,
    'example_sentence',
    '{"id":"e5afbf1e-b33d-49c2-941a-62ca5568a486","text":"Combining distinctive strengths with dependable performance is more likely to earn repeat visits than relying on novelty alone.","translation":"把鲜明特色与可靠表现结合起来，比仅依赖新奇感更可能赢得再次光顾。","tags":["消费服务"],"essayId":"e40f3792-90b1-5de2-b6c7-ca2f0f783b14","sentenceId":"b6626d4e-bace-579b-bac1-ffce17cb822f","shortNote":"效果比较：以稳定表现解释为何不能只靠新奇留客。","relatedPhraseIds":["1ff86eb7-9202-58c4-ae1a-05e7e4af9d09"],"relatedPatternIds":["4b013e1b-a5b1-4089-911d-c697efe954b2"],"type":"example_sentence"}'::jsonb,
    51,
    true
  ),
(
    'cbde89bd-dc8d-4525-b39d-6a5b91d934e1'::uuid,
    'example_sentence',
    '{"id":"cbde89bd-dc8d-4525-b39d-6a5b91d934e1","text":"Employment remained the largest category, although its share fell from 68.1% to 60.7%.","translation":"就业仍是最大类别，尽管份额由68.1%降至60.7%。","tags":["学习就业"],"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"027dfd2f-7359-5e60-8334-02836400e831","shortNote":"让步概括：份额下降仍可保持最大类别。","relatedPhraseIds":[],"relatedPatternIds":["beb0f328-b90a-48be-95d0-ab9dfa6e2975"],"type":"example_sentence"}'::jsonb,
    52,
    true
  ),
(
    'e9d6d92d-caab-4da6-be9f-8e52a6efd2a5'::uuid,
    'example_sentence',
    '{"id":"e9d6d92d-caab-4da6-be9f-8e52a6efd2a5","text":"No route is automatically superior: further study is valuable when it serves a clear purpose, just as a job is valuable when it offers suitable prospects for development.","translation":"没有哪条路天然更好：深造因服务明确目的而有价值，工作则因提供适合的发展前景而有价值。","tags":["学习就业"],"essayId":"66f90b54-0052-5da4-99ef-906093c5379e","sentenceId":"4dd7c151-3ca0-5006-84e0-d0e7fba484a3","shortNote":"选择标准：用相同条件评价两条道路。","relatedPhraseIds":["f8fc87b4-f22d-586e-bd4d-069e0f47311d"],"relatedPatternIds":["fbe6ca4f-01a8-46ef-8f4a-533bbbc8ac96"],"type":"example_sentence"}'::jsonb,
    53,
    true
  ),
(
    'a187a40d-e6f1-4e28-bde2-ad733fe0c6f4'::uuid,
    'example_sentence',
    '{"id":"a187a40d-e6f1-4e28-bde2-ad733fe0c6f4","text":"Learning accounts for 59.5%, well ahead of passing the time at 21.3% and obtaining information at 17%.","translation":"学习占59.5%，明显高于消磨时间21.3%与获取信息17%。","tags":["数字阅读"],"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"6592d80c-419c-5523-a0d5-3172adb0ceb9","shortNote":"主要类别：用显著领先概括学习目的。","relatedPhraseIds":["c185f0a1-718b-5908-b7a6-0727fd00e876","cb4bf055-979b-5ca7-8138-d7a8cf201c54"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    54,
    true
  ),
(
    '357b7f3a-4c39-42eb-bc8d-bfd163c91aa4'::uuid,
    'example_sentence',
    '{"id":"357b7f3a-4c39-42eb-bc8d-bfd163c91aa4","text":"The same device that opens a useful text also delivers messages and distractions, making concentration an essential part of effective mobile learning.","translation":"打开有用文本的同一设备，也带来消息与干扰，使专注成为有效手机学习的必要部分。","tags":["数字阅读"],"essayId":"ce0a9be4-c62e-5f9b-be48-6f49f4196e6a","sentenceId":"afe0cadd-f286-5b3e-af65-34fc236e69b9","shortNote":"机制限制：同一设备同时带来便利与干扰。","relatedPhraseIds":[],"relatedPatternIds":["cffa8a41-975e-46fb-b266-2261234bcb76"],"type":"example_sentence"}'::jsonb,
    55,
    true
  ),
(
    'e16635dd-bf3e-44b7-9dc9-21746f8b368c'::uuid,
    'example_sentence',
    '{"id":"e16635dd-bf3e-44b7-9dc9-21746f8b368c","text":"Just over half (54.3%) report exercising alone, followed by 47.7% who exercise with friends.","translation":"略超一半即54.3%报告独自锻炼，其次为47.7%与朋友锻炼。","tags":["公共健康"],"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"b7eb690a-c457-52b9-af53-5cf5c316ac84","shortNote":"调查方式：report说明参与方式，不擅自改成偏好。","relatedPhraseIds":["018dc601-adf1-59ff-89df-75435a40e68c","cedc6e3e-e387-5105-99d2-b28720fe9e2b"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    56,
    true
  ),
(
    '308c7561-7c56-4251-881e-c688f166360d'::uuid,
    'example_sentence',
    '{"id":"308c7561-7c56-4251-881e-c688f166360d","text":"A routine that people enjoy and maintain matters more than whether they follow it alone or in company.","translation":"让人喜欢且能坚持的习惯，比独自还是结伴实行更重要。","tags":["公共健康"],"essayId":"b7cc1bd8-928e-5321-ac11-3d25676d27d8","sentenceId":"69d858ba-dd37-53de-84bd-6471678a0fbb","shortNote":"评价标准：能否享受并长期坚持比方式本身更重要。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    57,
    true
  ),
(
    '836cdc48-25c1-462d-8503-89d2d44b676d'::uuid,
    'example_sentence',
    '{"id":"836cdc48-25c1-462d-8503-89d2d44b676d","text":"Particularly striking is the doubling of rural volume from 2019 to 2020.","translation":"尤其突出的是农村业务量在2019至2020年翻倍。","tags":["城乡服务"],"essayId":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","sentenceId":"c592f60c-d609-5f1d-9f4c-9db669835746","shortNote":"突出变化：倒装用于强调确有依据的翻倍阶段。","relatedPhraseIds":[],"relatedPatternIds":["476c6830-f903-418a-8111-7342059dc8a4"],"type":"example_sentence"}'::jsonb,
    58,
    true
  ),
(
    '835e32ab-71f0-454e-b2ba-7cc2c0c73cb2'::uuid,
    'example_sentence',
    '{"id":"835e32ab-71f0-454e-b2ba-7cc2c0c73cb2","text":"Growth is most meaningful when it makes trade more accessible without shifting unreasonable costs onto people or the environment.","translation":"增长在便利交易，又不把不合理成本转嫁给人或环境时最有意义。","tags":["城乡服务"],"essayId":"2ce2c13f-8793-5fbf-89e1-5fa1ac07fc87","sentenceId":"e907d67a-71ce-57c5-8e2c-c76c7cd86ef6","shortNote":"条件评论：用收益与避免代价共同评价增长。","relatedPhraseIds":[],"relatedPatternIds":["ea0e06a4-a2ea-495e-b568-513b4ebb852f"],"type":"example_sentence"}'::jsonb,
    59,
    true
  ),
(
    'fad3163a-55fe-4452-95db-6d9afb7a55e4'::uuid,
    'example_sentence',
    '{"id":"fad3163a-55fe-4452-95db-6d9afb7a55e4","text":"The proportion rose from 8.80% to 25.40%, with growth becoming more pronounced in later years.","translation":"比例由8.80%升至25.40%，后期增长更明显。","tags":["公共信息"],"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"0eb93957-f0eb-5e32-a340-91f78ab91b9a","shortNote":"阶段走势：with结构补充后期增长更显著。","relatedPhraseIds":[],"relatedPatternIds":["ecdb4c76-8a72-4e6e-964c-c3e9729c37d5"],"type":"example_sentence"}'::jsonb,
    60,
    true
  ),
(
    'b800ce6d-cec7-41e6-bea1-bfa2e01d17dc'::uuid,
    'example_sentence',
    '{"id":"b800ce6d-cec7-41e6-bea1-bfa2e01d17dc","text":"Public education can help by using plain language, presenting familiar situations and helping people distinguish sound advice from misleading claims.","translation":"公共教育可以通过使用通俗语言、呈现熟悉情境，并帮助人们区分可靠建议与误导性说法发挥作用。","tags":["公共信息"],"essayId":"bd3d8a78-f92a-5d4b-b5b9-d13de05abc92","sentenceId":"c82bc04f-9d07-5163-a7f8-72ecc53e84bf","shortNote":"具体措施：通俗语言、熟悉情境与辨别训练共同服务理解。","relatedPhraseIds":["6f220f48-70eb-5685-b09c-c43a08e11df9","f0013305-d743-5031-8b23-9d93c5d63c98"],"relatedPatternIds":["b9c56360-e4db-4225-8782-5881d29fe806"],"type":"example_sentence"}'::jsonb,
    61,
    true
  ),
(
    '7aaa54b2-84b2-49df-ae12-e2c52dfa4a8d'::uuid,
    'example_sentence',
    '{"id":"7aaa54b2-84b2-49df-ae12-e2c52dfa4a8d","text":"Acquiring knowledge leads at 91.3%, closely followed by improved practical skills at 84.8%.","translation":"获取知识以91.3%领先，动手技能提升84.8%紧随其后。","tags":["教育成长"],"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"e7adcb25-5376-54f1-a9a2-4fc3ae6ccee8","shortNote":"接近数据：closely followed by适用于差距较小的前两项。","relatedPhraseIds":["018dc601-adf1-59ff-89df-75435a40e68c","5c33dfe8-30dc-5e53-bec3-0cec6bcd9e03"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    62,
    true
  ),
(
    'ed02ab3a-44cd-41c0-bb46-b8e2851ce3c4'::uuid,
    'example_sentence',
    '{"id":"ed02ab3a-44cd-41c0-bb46-b8e2851ce3c4","text":"Cooperation, however, does not arise merely because students work in the same place; it requires shared goals and meaningful dependence on one another.","translation":"但合作不会仅因学生在同一地点工作就产生，它需要共同目标与真实的相互依赖。","tags":["教育成长"],"essayId":"16e5cd87-3f31-5b5b-ab90-e280bc91c923","sentenceId":"9fd67ccb-1fc2-5202-bb4f-1ddf4e59fcf4","shortNote":"必要条件：共处不自动产生合作，须有目标与依赖。","relatedPhraseIds":["327ec3f3-726c-5ba8-9e7f-9f37da9d06eb"],"relatedPatternIds":["541af8d6-ae6e-4713-913a-5a37ad1fa112"],"type":"example_sentence"}'::jsonb,
    63,
    true
  ),
(
    'de729e8e-aa6b-4514-8ef1-44a35dce1bf0'::uuid,
    'example_sentence',
    '{"id":"de729e8e-aa6b-4514-8ef1-44a35dce1bf0","text":"Television is most common at 90.8%, followed by walking at 68.3%.","translation":"看电视最普遍，为90.8%，其次为散步68.3%。","tags":["社区生活"],"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"2afd8885-0d8f-53da-be0b-bc240d5b6280","shortNote":"主要活动：描述最常见与其次的参与率。","relatedPhraseIds":["018dc601-adf1-59ff-89df-75435a40e68c"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    64,
    true
  ),
(
    '2fe5fd58-0a80-46d0-b7da-d61afadca731'::uuid,
    'example_sentence',
    '{"id":"2fe5fd58-0a80-46d0-b7da-d61afadca731","text":"Communities can help by maintaining safe paths, providing comfortable reading spaces and making it easy to find activity partners.","translation":"社区可维护安全步道、提供舒适阅读空间，并让寻找活动伙伴更容易。","tags":["社区生活"],"essayId":"a1e4dd9d-5b4c-5923-879c-2e8e5830258d","sentenceId":"35cfd668-afa6-5f02-a7f0-591f12855dd6","shortNote":"扩大选择：三项具体措施回应空间与同伴需求。","relatedPhraseIds":[],"relatedPatternIds":["b9c56360-e4db-4225-8782-5881d29fe806"],"type":"example_sentence"}'::jsonb,
    65,
    true
  ),
(
    '4dfc2215-bbfd-4b8d-be9c-befce3a6a433'::uuid,
    'example_sentence',
    '{"id":"4dfc2215-bbfd-4b8d-be9c-befce3a6a433","text":"Satisfying curiosity and developing observation skills receive almost identical support, at 54.6% and 54.5%.","translation":"满足好奇心与促进观察力得到几乎相同的支持，分别为54.6%与54.5%。","tags":["家庭探索"],"essayId":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","sentenceId":"79074458-ddc6-5752-a042-6163e9f823ee","shortNote":"近似相等：不夸大仅0.1个百分点的差别。","relatedPhraseIds":[],"relatedPatternIds":["f857ef9a-55f5-4164-bcca-7911de089c0b"],"type":"example_sentence"}'::jsonb,
    66,
    true
  ),
(
    '37b1f7e8-d6fd-4125-918e-ecaa5502a410'::uuid,
    'example_sentence',
    '{"id":"37b1f7e8-d6fd-4125-918e-ecaa5502a410","text":"Choosing safe surroundings, listening to questions and allowing time to observe can make ordinary outings valuable.","translation":"选择安全环境、倾听问题、给足观察时间，可以让普通外出有价值。","tags":["家庭探索"],"essayId":"fd5a894c-934d-5e58-9fd8-e9ed9d703fa9","sentenceId":"533fb6c6-1cc3-5ea1-b36f-459218e1c387","shortNote":"活动设计：安全、倾听与观察共同提升活动价值。","relatedPhraseIds":[],"relatedPatternIds":["cb7a9c6b-f6a9-40a2-8855-059c6c2b66e1"],"type":"example_sentence"}'::jsonb,
    67,
    true
  ),
(
    '5b25a37b-1f41-40ae-abe0-cf695cd51da2'::uuid,
    'example_sentence',
    '{"id":"5b25a37b-1f41-40ae-abe0-cf695cd51da2","text":"Your advice meant a great deal: it helped me understand my options and decide what to do next.","translation":"你的建议意义重大，让我理解了可选道路，并决定下一步行动。","tags":["人际沟通"],"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"d939e2f8-2cf5-4241-b391-6267de20d4fa","shortNote":"感谢价值：把抽象谢意落实为理解选项和决定行动。","relatedPhraseIds":["d7fae502-9caa-5ae4-8f98-b0ae3a77b31a"],"relatedPatternIds":["3835053b-dfe0-4b61-8143-54ef5666a6a6"],"type":"example_sentence"}'::jsonb,
    68,
    true
  ),
(
    '27c0b5a5-eb4e-47df-954b-ef8b5b55e074'::uuid,
    'example_sentence',
    '{"id":"27c0b5a5-eb4e-47df-954b-ef8b5b55e074","text":"In return, I would love to welcome you to China and introduce you to my city.","translation":"作为回报，我很愿意欢迎你来中国，带你了解我的城市。","tags":["人际沟通"],"essayId":"f0d0b9fd-98a5-45a0-a3c0-975d19c157c3","sentenceId":"fba610a8-5bad-4587-a2f2-a97947bd9c33","shortNote":"友好回报：在感谢之后提出可实际兑现的邀请。","relatedPhraseIds":["a28f0052-6203-5a60-bb4d-8416eff1160c"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    69,
    true
  ),
(
    '804a54a6-3c3f-46df-af66-ef75c2850e35'::uuid,
    'example_sentence',
    '{"id":"804a54a6-3c3f-46df-af66-ef75c2850e35","text":"Our cultural presentation day will serve as a platform for students to exchange stories and practise public speaking.","translation":"文化展示日将为学生交流故事、练习公众表达提供平台。","tags":["校园交流"],"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"a5365aee-f281-4f0b-a396-f52f0a6fbf84","shortNote":"活动目的：serve as a platform后说明学生能够做什么。","relatedPhraseIds":["4c5c207b-a6b0-55b6-866c-1c16da37e28a"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    70,
    true
  ),
(
    '0ab52c8a-2d77-4ca3-bb49-8963520a7543'::uuid,
    'example_sentence',
    '{"id":"0ab52c8a-2d77-4ca3-bb49-8963520a7543","text":"Volunteers will welcome visitors, organize materials and create a welcoming atmosphere.","translation":"志愿者将迎接来访者、整理材料并营造友好氛围。","tags":["校园交流"],"essayId":"6ffa395b-fa36-4f0f-bdd7-94fed6aad69e","sentenceId":"384dd920-a125-4566-93b9-a0b2e558e3e9","shortNote":"志愿任务：用迎接、整理与营造氛围具体说明服务。","relatedPhraseIds":["28f110fc-a7c9-5215-b3b7-6e6429028a82"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    71,
    true
  ),
(
    '58b2d447-ddf9-4545-97e0-9c71e2f00c8a'::uuid,
    'example_sentence',
    '{"id":"58b2d447-ddf9-4545-97e0-9c71e2f00c8a","text":"To make steady progress, set realistic goals and build a manageable routine rather than translate long passages occasionally.","translation":"要稳步进步，应设定现实目标、建立可坚持的安排，而非偶尔翻译长文。","tags":["学习方法"],"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"910ff012-bf2c-4bfa-86fb-a8ee59131dd5","shortNote":"目标与日常安排：用rather than对照稳定练习与偶尔用力。","relatedPhraseIds":["91820987-62f8-54c6-9e20-027bc6e602f0","92d02a61-2d4a-5b09-85e3-5735a571feb9","e5ecef63-dc4a-5ca1-9091-6d366e55bbd9","f89d16eb-a0eb-5edb-b201-a49ae356c189"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    72,
    true
  ),
(
    'c1219933-0b3a-4ce7-918b-2fdf62eadb75'::uuid,
    'example_sentence',
    '{"id":"c1219933-0b3a-4ce7-918b-2fdf62eadb75","text":"Seek meaningful feedback to identify your weaknesses, then put what you learn into practice in the next exercise.","translation":"寻求有实际帮助的反馈来发现薄弱处，再把所学用于下一次练习。","tags":["学习方法"],"essayId":"3bc4eb7a-23f5-414b-834b-fd401d2c998f","sentenceId":"7fcb6aca-954f-4403-9e70-92d73c395a65","shortNote":"反馈与应用：先识别薄弱处，再把所学用于下次练习。","relatedPhraseIds":["049411b9-bce9-59f3-8b4d-d6200cc3de39","94514fb7-a4aa-5a1c-8b3b-0a1bfc02cbb0","c4f29ac7-1a98-53a8-b0ab-3b109e8f102c"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    73,
    true
  ),
(
    'c44ea336-7055-4bf0-900d-a5bdd8b0249e'::uuid,
    'example_sentence',
    '{"id":"c44ea336-7055-4bf0-900d-a5bdd8b0249e","text":"Knowing that you have set aside time for me, I sincerely apologize for disrupting your arrangements by changing our meeting.","translation":"知道您已为我留出时间，我为更改会面、打乱您的安排诚恳致歉。","tags":["礼貌沟通"],"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"174f36a4-e7a0-4273-9557-363ef2888d77","shortNote":"改约道歉：先承认对方为会面留出的时间。","relatedPhraseIds":["2026ffff-172c-5d67-9c17-2019de2013f1","db724576-95fb-5ed8-a1e0-4ac4e7cd8e15"],"relatedPatternIds":["c4e7b843-cb2f-42dc-a6c0-fbb7c41d0ad8"],"type":"example_sentence"}'::jsonb,
    74,
    true
  ),
(
    'f6dd4ab1-5344-4a8b-b1b9-0ff8467d2b5d'::uuid,
    'example_sentence',
    '{"id":"f6dd4ab1-5344-4a8b-b1b9-0ff8467d2b5d","text":"If the following week would suit you better, I will gladly meet at your convenience.","translation":"如果下一周对您更合适，我很乐意在您方便时会面。","tags":["礼貌沟通"],"essayId":"a88f5192-a71f-476f-9489-167c8f5e6a77","sentenceId":"2b374885-25e0-44b3-8415-a07dea21f650","shortNote":"替代时段：明确次周选择，并保留对方时间偏好。","relatedPhraseIds":["4e2e62c4-409d-578f-8dec-a33592704a91"],"relatedPatternIds":["603a976c-22b9-44b8-9336-f3675cb00c81"],"type":"example_sentence"}'::jsonb,
    75,
    true
  ),
(
    '8e378ed6-44f1-4c2b-8b8c-64de2dbf8406'::uuid,
    'example_sentence',
    '{"id":"8e378ed6-44f1-4c2b-8b8c-64de2dbf8406","text":"I am writing about your online writing course, which has failed to meet the stated standard.","translation":"我就贵方在线写作课程来信，课程未达到所声明的标准。","tags":["消费沟通"],"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"4c3e68da-b5b8-42b6-9166-b31b3e56fc7d","shortNote":"投诉对象：非限制性定语从句直接点明未达标准。","relatedPhraseIds":["1e25cfc2-6d38-51eb-9355-ac0f8ba1ebb3"],"relatedPatternIds":["67fa104b-d59b-4803-9bc0-55fb3eb183dc"],"type":"example_sentence"}'::jsonb,
    76,
    true
  ),
(
    '4d9aea56-1232-47a6-8bcd-a588a15729b3'::uuid,
    'example_sentence',
    '{"id":"4d9aea56-1232-47a6-8bcd-a588a15729b3","text":"Please resolve the matter by restoring the lessons at no additional cost and providing the promised feedback, or offer an appropriate refund.","translation":"请免费补齐课程并提供承诺的反馈，或作出合理退款，以解决此事。","tags":["消费沟通"],"essayId":"fc9add84-5993-49c7-818b-5e0d0f47fd1c","sentenceId":"7a3e4952-653f-4c7b-8c08-6e302a23b368","shortNote":"补救要求：提出免费补齐与反馈，或合理退款。","relatedPhraseIds":["5f2d1576-30b8-56f4-ab49-39582130a60e","9f193a02-1d0f-5a74-93ca-d5084a45d9fa"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    77,
    true
  ),
(
    'f718dc5e-99e6-40cb-b886-e66f4d75bc58'::uuid,
    'example_sentence',
    '{"id":"f718dc5e-99e6-40cb-b886-e66f4d75bc58","text":"For our investigation, I suggest making field observations and conducting interviews so that we can collect reliable evidence and identify common concerns.","translation":"对于这次调查，我建议开展实地观察与访谈，以便收集可靠依据并找出共同关切。","tags":["合作调查"],"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"3e5b4feb-ccf0-4440-b35f-3c0ecb9dbba1","shortNote":"方法与目的：观察、访谈分别服务证据和共同关切。","relatedPhraseIds":["17e58756-8a69-50be-83a3-ee1067911b02","a9d88f0d-a2f9-5d5e-a8cd-7def6e080c7d","e7956402-0c26-5654-bb12-c240d013014f","ff4e62bd-5214-5481-8adc-289ec193d770"],"relatedPatternIds":["88d67cf6-4d2a-4435-990b-54d09ab5545b"],"type":"example_sentence"}'::jsonb,
    78,
    true
  ),
(
    '67df22f9-047a-487e-b1d0-f26f0cfba324'::uuid,
    'example_sentence',
    '{"id":"67df22f9-047a-487e-b1d0-f26f0cfba324","text":"Let us share responsibilities: I will prepare a draft of the checklist while you design questions about costs and local traditions.","translation":"我们分担职责：我起草记录清单，你设计关于成本和地方传统的问题。","tags":["合作调查"],"essayId":"9249c547-0b6a-41c9-a5db-623a0d74d889","sentenceId":"9586600d-a235-4f75-a565-f62127987355","shortNote":"合作安排：分配清单与问卷任务，而非空喊共同努力。","relatedPhraseIds":["6e7a05c8-31ab-5582-a951-fef6dc7cd531","7aa6bb47-e84f-537a-b7f7-06e04eb1f6d5","87056967-60d1-5520-98d0-b862579f3cf1"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    79,
    true
  ),
(
    '22dc7d45-2f5a-485b-b87d-8aae22937246'::uuid,
    'example_sentence',
    '{"id":"22dc7d45-2f5a-485b-b87d-8aae22937246","text":"Starting at 10%, the rate reached a peak of 60%, with a sharp increase between 2019 and 2020.","translation":"参与率由10%升至60%，2019至2020年间大幅增加。","tags":["公共健康"],"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"8b5762db-926c-417d-bb93-668c5e662e0b","shortNote":"阶段数据：区分区间最高点与增长最明显的阶段。","relatedPhraseIds":["67c45c0b-59ec-5154-9b90-c1719e97e589","de6309da-3206-574a-ae65-cd1032f78be0"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    80,
    true
  ),
(
    '35c6354e-5f6a-42f1-a3af-b01637c9d05b'::uuid,
    'example_sentence',
    '{"id":"35c6354e-5f6a-42f1-a3af-b01637c9d05b","text":"One possible explanation is that more accessible sessions made regular physical activity easier to fit into daily routines.","translation":"一个可能解释是更易参与的课程让规律身体活动更容易融入日常作息。","tags":["公共健康"],"essayId":"bc901145-82a5-4138-8975-70015d8f3a35","sentenceId":"a2357308-fa11-43e2-8c3a-ce819773ee17","shortNote":"可能机制：可达性降低坚持规律活动的门槛。","relatedPhraseIds":["1d61dc00-0162-5568-92ec-f493aa4d2cf4","5bbc6f24-3e8e-5d98-99f6-47392ec1387b","b932c79d-77a2-5425-b5d9-e804816929ea"],"relatedPatternIds":["c9904c86-9ade-4157-ae91-a49c4c7d0d32"],"type":"example_sentence"}'::jsonb,
    81,
    true
  ),
(
    '6341d4ba-d3b6-4834-bdbe-400f6f189d2f'::uuid,
    'example_sentence',
    '{"id":"6341d4ba-d3b6-4834-bdbe-400f6f189d2f","text":"Digital reading rose steadily from two to six hours weekly; the corresponding figure for print declined gradually from six to two.","translation":"电子阅读由每周两小时稳步升至六小时，纸质阅读的对应数值由六小时逐渐降至两小时。","tags":["数字阅读"],"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"1714d6b5-7139-4262-b954-f778b57968d2","shortNote":"相反走势：对应数值需要同样的时长单位。","relatedPhraseIds":["14ef53e9-124f-5aab-a859-aa0bc29d14f7","3312495e-6e72-56e5-bce4-061ce0e2b9e8","734ab494-08d4-5513-8e10-aa92ff548bf6"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    82,
    true
  ),
(
    '9f53d954-7d0b-4759-a8e4-b79852870f58'::uuid,
    'example_sentence',
    '{"id":"9f53d954-7d0b-4759-a8e4-b79852870f58","text":"Yet choosing a screen does not necessarily mean abandoning deep reading, just as choosing paper does not guarantee concentration.","translation":"但选择屏幕未必意味着放弃深入阅读，正如选择纸张也不保证专注。","tags":["数字阅读"],"essayId":"f850c265-1c5d-4508-b90b-4da0bff2406a","sentenceId":"61e2bed7-4153-48b1-af74-c2d95d0ff9c3","shortNote":"限制推断：屏幕与纸张都不能单凭形式保证理解。","relatedPhraseIds":["4fc887f9-521b-53d4-8b46-5bdc19e41390"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    83,
    true
  ),
(
    'bb848f94-878d-4231-93fb-3707e6218640'::uuid,
    'example_sentence',
    '{"id":"bb848f94-878d-4231-93fb-3707e6218640","text":"Food quality ranks first in this survey, selected by 56% of respondents.","translation":"食品质量在此调查中排名第一，56%的受访者选择该项。","tags":["消费服务"],"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"7c75dfbe-0820-4e45-8dec-670aed156df8","shortNote":"调查排名：排名与56%的选择比例共同描述主要理由。","relatedPhraseIds":["c650b34f-1eeb-56ab-a487-dd102f40cbee"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    84,
    true
  ),
(
    'ecd0179e-78d8-4a2e-bc40-93c7272cbcc2'::uuid,
    'example_sentence',
    '{"id":"ecd0179e-78d8-4a2e-bc40-93c7272cbcc2","text":"Training staff, checking ingredients and listening to complaints can make a restaurant more trustworthy.","translation":"培训员工、检查食材并倾听投诉，可以让餐厅更值得信赖。","tags":["消费服务"],"essayId":"c42827eb-d0a1-4b40-85ed-b010a2a056e6","sentenceId":"26432758-5eaa-4691-bd5d-2314b4fb6d4a","shortNote":"服务措施：并列行动与make宾补说明如何建立信任。","relatedPhraseIds":[],"relatedPatternIds":["cb7a9c6b-f6a9-40a2-8855-059c6c2b66e1"],"type":"example_sentence"}'::jsonb,
    85,
    true
  ),
(
    '17e3347d-749a-4935-b647-04d3a6416015'::uuid,
    'example_sentence',
    '{"id":"17e3347d-749a-4935-b647-04d3a6416015","text":"The survey reports gains from a practical course: 82% mention skills, 70% subject knowledge and 45% teamwork.","translation":"调查报告实践课程收获：82%提及技能，70%提及学科知识，45%提及团队合作。","tags":["教育成长"],"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"90062bdc-23ce-4b82-90b7-bda5e1ef7928","shortNote":"多选数据：不同收获比例可重叠，不能相加当总人数。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    86,
    true
  ),
(
    '4ece0bf7-6f6e-4031-b662-65447015ca39'::uuid,
    'example_sentence',
    '{"id":"4ece0bf7-6f6e-4031-b662-65447015ca39","text":"Teachers can design projects and ask students to reflect on both their understanding and their joint responsibilities.","translation":"教师可以设计项目，并请学生同时反思自己的理解与共同责任。","tags":["教育成长"],"essayId":"f78915da-57e5-4dbe-a103-7dab0b654f96","sentenceId":"6d390072-64f2-4b73-b937-1f9cbdcad35a","shortNote":"教学建议：把项目设计与个人理解、共同责任的反思相连。","relatedPhraseIds":[],"relatedPatternIds":["c7709dc2-ad99-442e-9517-d0ce03fee2ed"],"type":"example_sentence"}'::jsonb,
    87,
    true
  ),
(
    'a24a60d6-ca6c-40a0-b555-cd39d51a166f'::uuid,
    'example_sentence',
    '{"id":"a24a60d6-ca6c-40a0-b555-cd39d51a166f","text":"The survey asks what matters most in choosing a future path: interests lead at 48%, followed by development opportunities at 35% and starting income at 17%.","translation":"调查询问未来道路选择中最重要的因素：兴趣48%领先，其次为发展机会35%和起薪17%。","tags":["学习就业"],"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"a0073d89-3ea0-4c09-ae0f-1a198cdf0975","shortNote":"因素排序：交代首要关切及其余两项份额。","relatedPhraseIds":["018dc601-adf1-59ff-89df-75435a40e68c"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    88,
    true
  ),
(
    'dbeb8394-61cd-458a-9e52-0708a77f8924'::uuid,
    'example_sentence',
    '{"id":"dbeb8394-61cd-458a-9e52-0708a77f8924","text":"Practical placements can broaden their perspective, help them assess personal strengths and identify their weaknesses.","translation":"实践岗位可拓宽他们的视野，帮助评估个人优势并发现薄弱处。","tags":["学习就业"],"essayId":"015a7c73-e695-455e-91f2-614330c31d4c","sentenceId":"2838c5ab-6625-4af0-82d7-cb5b3593b1e1","shortNote":"探索机制：岗位体验联系视野、优势与薄弱处。","relatedPhraseIds":["8791b8d0-4dc3-5c10-9d18-4fb52d96a22a","94514fb7-a4aa-5a1c-8b3b-0a1bfc02cbb0","ac184e08-2adb-5507-9e9b-612daf2dd216"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    89,
    true
  ),
(
    'a0f216af-2cfd-4524-ad64-a914d13aed01'::uuid,
    'example_sentence',
    '{"id":"a0f216af-2cfd-4524-ad64-a914d13aed01","text":"The chart distinguishes three abilities: 78% of residents can find health information, 56% can explain it and 34% can apply it to a decision.","translation":"图表区分三项能力：78%居民能找到健康信息，56%能解释，34%能用于决策。","tags":["公共信息"],"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"4134bc67-6a7f-4bc7-86cc-2c40e1bf6ef9","shortNote":"能力差距：获取、理解和应用分开描述。","relatedPhraseIds":[],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    90,
    true
  ),
(
    'c74ff098-f9b9-47ad-97b4-388c433f103d'::uuid,
    'example_sentence',
    '{"id":"c74ff098-f9b9-47ad-97b4-388c433f103d","text":"Health education should therefore use plain language and familiar situations, asking residents to explain how advice applies to a concrete example.","translation":"因此，健康教育应使用通俗语言和熟悉情境，请居民解释建议如何用于具体例子。","tags":["公共信息"],"essayId":"94930d76-65b4-4990-9abc-895b541b4f53","sentenceId":"e0b3e032-f729-46db-8868-b39c578ac752","shortNote":"教育方法：让居民用具体情境说明建议的含义。","relatedPhraseIds":["f0013305-d743-5031-8b23-9d93c5d63c98"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    91,
    true
  ),
(
    '76a0b1f3-e0c3-4b84-90ec-2280ce8a1039'::uuid,
    'example_sentence',
    '{"id":"76a0b1f3-e0c3-4b84-90ec-2280ce8a1039","text":"A survey identifies interruptions as the main reading difficulty for 52% of students, followed by choosing materials at 29% and finding time at 19%.","translation":"调查中，52%学生认为干扰是主要阅读困难，其次为选择材料29%与寻找时间19%。","tags":["数字学习"],"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"5f6bee65-ba58-462c-bf78-a3d2dbfb508b","shortNote":"困难构成：描述主要问题并列出其余比例。","relatedPhraseIds":["018dc601-adf1-59ff-89df-75435a40e68c"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    92,
    true
  ),
(
    '0a10d930-e9e6-4946-a302-3d838ab1abf2'::uuid,
    'example_sentence',
    '{"id":"0a10d930-e9e6-4946-a302-3d838ab1abf2","text":"The same device that provides digital resources also delivers messages and distractions that can put pressure on attention, making sustained attention an essential part of independent learning.","translation":"提供数字资源的同一设备也会带来给注意力造成压力的消息与干扰，因此持续专注成为自主学习的重要部分。","tags":["数字学习"],"essayId":"46d1cf0d-aca3-4777-8752-fc928fa8a615","sentenceId":"6a5e3d29-e47f-4616-bdf0-a184fb1ab707","shortNote":"工具的双重作用：资源便利与消息干扰共同解释专注要求。","relatedPhraseIds":["57e8b719-934f-5e78-8a8e-7c94754f908f","7b27c8a6-f1ef-5344-989a-a5e51a279310","c685ab0a-73d2-54e5-bcc3-071df528a804","d6fe6c6a-33a5-5603-bfb4-8dd37908a1dd"],"relatedPatternIds":["cffa8a41-975e-46fb-b266-2261234bcb76"],"type":"example_sentence"}'::jsonb,
    93,
    true
  ),
(
    '7fc24ba1-c3ec-4954-99bf-38d767d01267'::uuid,
    'example_sentence',
    '{"id":"7fc24ba1-c3ec-4954-99bf-38d767d01267","text":"The survey reports three main benefits of a cultural centre: learning at 65%, social contact at 58% and confidence at 41%.","translation":"调查报告文化中心的三项主要收益：学习65%、社会交往58%、自信41%。","tags":["社区文化"],"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"f6371998-3c70-4279-83b5-9821864661de","shortNote":"多项收益：比例可重叠，不能作互斥份额相加。","relatedPhraseIds":["ceafc3e6-08dd-5e85-b9a5-372ccf8141ee"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    94,
    true
  ),
(
    '3520e741-6537-43f5-807c-fab3aa177298'::uuid,
    'example_sentence',
    '{"id":"3520e741-6537-43f5-807c-fab3aa177298","text":"When adults and children explore together, a family workshop can help them observe closely, exchange questions and strengthen family ties.","translation":"成人与儿童共同探索时，家庭工作坊能帮助他们仔细观察、交流问题并增进家庭联系。","tags":["社区文化"],"essayId":"55f5ba9e-8e81-4bfd-9432-e82ed8b4304f","sentenceId":"cb92e036-dde7-4cf8-a927-8aac38656364","shortNote":"条件与实例：家庭共同探索怎样连接观察和亲子关系。","relatedPhraseIds":["4273b64c-94f7-560e-90c3-0fcc1c610853","8acf9237-fb53-5fba-934a-f7b4c920e034"],"relatedPatternIds":["3287e035-d6aa-42d4-8c62-ccb3fe358e1d"],"type":"example_sentence"}'::jsonb,
    95,
    true
  ),
(
    'a1f2cd52-700a-4fce-a454-8254265a8981'::uuid,
    'example_sentence',
    '{"id":"a1f2cd52-700a-4fce-a454-8254265a8981","text":"The chart shows county deliveries more than doubling from two million parcels in 2020 to five million in 2024, alongside growth in collection points from 40 to 85.","translation":"图表显示县域快递由2020年200万件增至2024年500万件，达到两倍以上；取件点同时由40个增至85个。","tags":["城乡服务"],"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"6f7b2187-0510-4dbf-89ba-131bb89c5780","shortNote":"双指标变化：包裹量与网点数量使用不同单位。","relatedPhraseIds":["6687cd91-7e6d-5f5a-a98c-ba9e2d441d20"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    96,
    true
  ),
(
    'c25a1790-9676-4050-9e77-c86e8b88214b'::uuid,
    'example_sentence',
    '{"id":"c25a1790-9676-4050-9e77-c86e8b88214b","text":"Continued progress should therefore concern lasting benefits, not volume alone.","translation":"因此，持续进步应着眼于持久收益，而不只关注业务量。","tags":["城乡服务"],"essayId":"8703cbe6-ec03-4368-8967-1c45b1ca5703","sentenceId":"b47487d1-ca72-4bb1-80c5-023451dba18c","shortNote":"质量评价：用持久收益评价进步，不止看业务量。","relatedPhraseIds":["4288d327-f745-59b8-b928-8dcaf6d1cdb0"],"relatedPatternIds":["81c3ccde-b1cf-475b-b5e3-25662a2527e2"],"type":"example_sentence"}'::jsonb,
    97,
    true
  ),
(
    'a530d5e5-8993-41a9-ac22-482d5b9c48a1'::uuid,
    'example_sentence',
    '{"id":"a530d5e5-8993-41a9-ac22-482d5b9c48a1","text":"The chart shows gift spending falling to a low of 20% in 2020 before recovering to 25% in 2024, compared with 30% in 2018.","translation":"图表显示礼物支出在2020年降至20%的低点，之后回升至2024年25%，而2018年为30%。","tags":["消费关系"],"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"d8ac9324-a8b3-49cb-8571-0326814717e5","shortNote":"先降后升：低点与恢复后的水平要区分。","relatedPhraseIds":["ad74ec24-a9bf-5233-aabf-5b421d803bd1","f1501abd-99ab-5116-8475-86ce14053c99"],"relatedPatternIds":[],"type":"example_sentence"}'::jsonb,
    98,
    true
  ),
(
    '599c1f3e-020e-4720-aead-e0c91c67209f'::uuid,
    'example_sentence',
    '{"id":"599c1f3e-020e-4720-aead-e0c91c67209f","text":"In my view, festive spending is worthwhile when it respects family priorities without creating financial strain.","translation":"在我看来，节日支出若能尊重家庭优先事项，又不造成经济负担，就是值得的。","tags":["消费关系"],"essayId":"4ab57fd9-5d91-43a1-a5e4-a8af331a4a32","sentenceId":"93cdc3f0-57c6-4928-a06b-c1445948bee8","shortNote":"条件评论：家庭取舍与经济承受能力共同限定值得的支出。","relatedPhraseIds":["5d47b9f3-23e0-5083-9ca4-0247083da071"],"relatedPatternIds":["be257ee8-02bb-4ba0-b4ed-e65e61748a8a"],"type":"example_sentence"}'::jsonb,
    99,
    true
  )
on conflict (id) do update set
  item_type = excluded.item_type,
  item_data = excluded.item_data,
  sort_order = excluded.sort_order,
  is_published = excluded.is_published;

commit;
