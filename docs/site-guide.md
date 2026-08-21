# Site Guide

## Purpose

`tracedowney.com` is a Jekyll portfolio that brings professional systems work, software, visual work, and hands-on craft into one site. The public site is deliberately curated: pages should explain the work clearly and show original work with enough context to be credible.

## Architecture

- Jekyll source pages are route-level `index.html` files. Their YAML front matter controls title, description, layout, body class, background treatment, and indexing.
- `_layouts/default.html` supplies the document head, navigation, footer, and shared header behavior.
- `_layouts/project-lane.html` renders every project-lane page from its page front matter plus `_data/project_lanes.yml`.
- `_includes/lane-menu.html` renders the shared project-lane navigation.
- `assets/css/site.css` contains all styling, including the reusable project hero and gallery components.
- `_data/project_lanes.yml` is the source of truth for shared lane summaries, cards, features, and the App Development AuditOS preview.

## Content Boundaries

- Page-specific prose and gallery markup belong in that page's route-level `index.html`.
- Shared project-lane copy belongs in `_data/project_lanes.yml`.
- Never put generated `_site/` or `tmp/` output under version control.
- Keep `drafts/` out of public builds unless intentionally promoted to a source page.
- `docs/` is internal repository documentation and is excluded from the public build.

## Images And Media

- Original source images are kept outside the repository in `/Users/tracedowney/Downloads/Website Photots/Photo Work/`.
- Site copies live under `assets/images/projects/<lane>/` and use descriptive filenames, maximum 2400px edge, JPEG optimization, and non-destructive import.
- Use factual captions and accurate alt text. Do not represent reference or inspiration images as original work.
- Gallery patterns are documented in `docs/portfolio-gallery-notes.md`.

## Reusable Gallery Components

- `project-hero-card` is the leading editorial image-and-copy treatment.
- `project-gallery-grid` is the responsive 12-column gallery system.
- Gallery cards use `project-gallery-card` plus `--wide`, `--tall`, or `--square` to shape the sequence.
- `project-screenshot-preview` is the compact screenshot strip used on the App Development lane.
- On narrow screens, gallery grids collapse to a single column. Always review responsive output before publishing.

## Local Review And Publishing

1. Run `bundle exec jekyll build -d tmp/localpreview/_site` to validate the build.
2. Run `./script/serve` and review `http://127.0.0.1:4000/` for local presentation.
3. For substantial visual work, show a local mockup before publishing.
4. Stage only confirmed source files and their directly referenced assets.
5. GitHub Pages deploys from `main`; confirm the Pages build after pushing.

## Documentation Map

- `docs/portfolio-gallery-notes.md`: image provenance and gallery decisions.
- `docs/pages/`: one maintenance note for every public source page.
- `docs/pages/README.md`: route index and maintenance conventions.

## Current Maintenance Priority

- Jewelry has a local, unpublised collection-gallery expansion waiting for review and push.
- Quilting should eventually gain a larger expandable collection gallery beneath its curated showcase.
- Future image additions should preserve the distinction between a curated showcase and a broader collection.
