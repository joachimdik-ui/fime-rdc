-- A executer si le schema est deja installe.
-- Accorde les privileges SQL necessaires; RLS continue de limiter les lignes.

grant usage on schema public to anon, authenticated;
grant select on public.actualites to anon;
grant select, insert, update, delete on public.actualites to authenticated;
grant insert on public.newsletter to anon, authenticated;
grant select on public.newsletter to authenticated;
grant usage, select on sequence public.actualites_id_seq to authenticated;
grant usage, select on sequence public.newsletter_id_seq to anon, authenticated;
