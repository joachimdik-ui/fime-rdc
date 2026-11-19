-- Table et policies pour gerer la photo de couverture du site.
create table if not exists public.site_media (
  id text primary key check (id = 'hero'),
  image_url text not null,
  updated_at timestamptz not null default now()
);

grant usage on schema public to anon, authenticated;
grant select on public.site_media to anon;
grant select, insert, update, delete on public.site_media to authenticated;

alter table public.site_media enable row level security;

drop policy if exists "Lecture publique du media du site" on public.site_media;
create policy "Lecture publique du media du site"
on public.site_media for select
to anon, authenticated
using (true);

drop policy if exists "Gestion authentifiee du media du site" on public.site_media;
create policy "Gestion authentifiee du media du site"
on public.site_media for all
to authenticated
using (true)
with check (true);
