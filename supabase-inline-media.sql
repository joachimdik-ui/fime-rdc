-- Active la position des images et videos dans le corps des articles.
alter table public.actualites
add column if not exists media_items jsonb not null default '[]'::jsonb;
