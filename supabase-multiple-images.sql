-- Migration pour activer plusieurs images par article.
alter table public.actualites
add column if not exists image_urls text[] not null default '{}'::text[];
