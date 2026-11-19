-- A executer dans Supabase SQL Editor pour inserer les actualites initiales.
-- Cette requete est idempotente: elle n'insere pas de titre deja present.

insert into public.actualites (titre, theme, resume, contenu, publie, created_at)
select seed.titre, seed.theme, seed.resume, seed.contenu, true, seed.created_at::timestamptz
from (values
  (
    'Formation en coupe et couture à Ngiri-Ngiri',
    'Femmes',
    'Une nouvelle session accompagne les femmes vers une activité génératrice de revenus.',
    'La Fondation FIME organise des activités pratiques de coupe, de couture et d’initiation à l’entrepreneuriat. Les participantes bénéficient d’un encadrement communautaire pour transformer leurs compétences en projets durables.',
    '2026-11-10T08:00:00Z'
  ),
  (
    'Curage des caniveaux : le quartier se mobilise',
    'Salubrité',
    'Habitants, bénévoles et encadreurs travaillent ensemble pour assainir les avenues.',
    'À Ngiri-Ngiri, les actions de salubrité renforcent la sensibilisation aux bonnes pratiques d’entretien. Le curage des caniveaux aide à réduire les eaux stagnantes et améliore le cadre de vie.',
    '2026-11-06T08:00:00Z'
  ),
  (
    'Rentrée : soutien aux enfants',
    'Éducation',
    'Encadrement scolaire et accompagnement communautaire pour préparer la rentrée.',
    'La FIME soutient les enfants et leurs familles dans leur parcours éducatif, notamment par l’information, l’encadrement et la mobilisation des ressources locales.',
    '2026-10-28T08:00:00Z'
  )
) as seed(titre, theme, resume, contenu, created_at)
where not exists (
  select 1 from public.actualites existing where existing.titre = seed.titre
);
