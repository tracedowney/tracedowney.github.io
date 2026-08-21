# Portfolio Gallery Notes

This note records the presentation decisions for the original-work galleries so future updates stay consistent and do not accidentally reintroduce reference material.

## Source And Image Rules

- Original source photos live in `/Users/tracedowney/Downloads/Website Photots/Photo Work/`.
- Import web copies into `assets/images/projects/<lane>/` with descriptive filenames. Keep the source export untouched.
- Current web copies are resized to a maximum edge of 2400px and exported as JPEGs for site performance.
- Do not present inspiration, reference, or third-party work as original portfolio work.
- Specifically, `jewelry-bonsai-bloom.jpg` was an inspiration image for the white tree, not an original piece. It was removed from the site and repository and must not be restored to a gallery.

## Shared Presentation System

- Reusable gallery and hero styles live in `assets/css/site.css` under `project-hero-card` and `project-gallery-*`.
- Gallery cards support `--wide`, `--tall`, and `--square` variants. They collapse to one column on small screens.
- Keep hero images to one strong original piece. Use gallery sections to show range, process, and detail without repeating the hero image.

## Current Page Direction

### Quilting

- The page is a curated showcase of finished quilts and block studies.
- Future direction: add a separate, larger "from the collection" gallery beneath the showcase, similar to the Jewelry collection section. This should be expandable as more quilts are photographed and selected.

### Jewelry

- The upper page is the curated showcase: sculptural wire work followed by wearable pieces.
- The pending local update adds a separate "More from the collection" gallery with four additional original pieces. It is intentionally designed as the expandable collection area for future photographs.
- The green-stone wire tree replaced the removed inspiration bonsai card and is original work.

### Upholstery

- The page is structured around the Emerson chair before-and-after story, followed by a leather wingback and tufted sofa to show range.
- The live page uses seven selected original images. Additional upholstery photos are available in the source folder but are not currently part of the published gallery.

### Photography And Drone Footage

- Photography is organized into Spain travel/architecture and closer domestic/detail studies.
- Drone footage keeps the curated video reels first, with original raw field stills below to show the source material.

### App Development

- The App Development lane includes a compact AuditOS screenshot preview that links into the full AuditOS case study.
- The full AuditOS page remains the place for the complete, expandable screenshot gallery.

## Update Workflow

1. Choose only original work and confirm its provenance before adding it.
2. Create optimized copies with descriptive names under the relevant project image folder.
3. Add cards using the shared gallery classes and write factual, non-inflated captions.
4. Verify locally with `bundle exec jekyll build -d tmp/localpreview/_site` and `http://127.0.0.1:4000/`.
5. Show a local mockup before publishing a substantial gallery change.
6. Stage only the changed page, its new assets, and this note when relevant. Do not include unrelated untracked files.
