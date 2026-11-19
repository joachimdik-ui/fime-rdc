# FIME RDC

Site web de la Fondation Iyeli Molangi Eddy. Le site est statique et utilise Supabase pour les actualites, les medias, la photo de couverture et les inscriptions a la newsletter.

## Mise en route

1. Renseigner l’URL du projet et la clé `anon`/`publishable` dans `supabase-config.js`. Ne jamais y placer une clé `service_role`.
2. Pour un nouveau projet Supabase, exécuter `supabase-schema.sql` dans le SQL Editor.
3. Pour une base déjà créée, exécuter les migrations nécessaires (`supabase-permissions-fix.sql`, `supabase-multiple-images.sql`, `supabase-inline-media.sql`, `supabase-hero-image.sql`).
4. Exécuter `supabase-articles-seed.sql` pour ajouter les articles de départ.
5. Créer le compte administrateur dans Supabase Authentication, puis ouvrir `admin.html`.
6. Déployer le contenu de la racine sur un hébergement de site statique.

Les clés publishable/anon sont destinées au navigateur et sont limitées par les politiques RLS. Ne publiez jamais de clé `service_role`.

## Application d’administration (PWA)

Servez le site en HTTPS, ouvrez `admin.html`, puis utilisez le bouton d’installation du navigateur. Sur iPhone/iPad, dans Safari, choisissez **Partager → Ajouter à l’écran d’accueil**. Le cache PWA conserve uniquement l’interface statique ; connexion, publications et envois de médias nécessitent Internet et Supabase.
