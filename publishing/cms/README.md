# CMS page metadata

This directory contains the web-publishing projection for each canonical manuscript page. It does not replace or modify manuscript front matter, story canon, or prose.

## Structure

Each Markdown source has one matching JSON sidecar under `pages/`:

```text
manuscript/001-a-botanists-world.md
publishing/cms/pages/001-a-botanists-world.json
```

The sidecar `id` must equal the stable manuscript ID. The package builder rejects missing, extra, mismatched, or unsupported sidecars so metadata cannot silently drift to another chapter.

## Editorial red line

- `summary` previews the chapter’s emotional promise, setting, or immediate pressure. It may connect from the previous chapter, but must not reveal the resolution, repeat the title, or summarize the entire plot.
- `seoTitle` is a concise discovery label. This repository uses a 51-character editorial budget even though Driftya’s generic CMS permits up to 160 characters.
- `metaDescription` introduces the chapter’s premise in search results without giving away its outcome.
- `coverImageAlt` describes the visible content and context of an actual promoted cover image. It is required only when that manuscript page has such an image; it must not contain SEO keyword stuffing.

Current package budgets are configured in `publishing/cms-collection.json`:

| Field | Maximum characters |
| --- | ---: |
| Summary | 320 |
| SEO title | 51 |
| Meta description | 165 |
| Cover image alt | 165 |

AI-assisted drafts must be reviewed against the target chapter and canon before publication. A sidecar is publishing metadata, not new story canon.

## Ordered manuscript images

Every local manuscript image uses a contiguous two-digit prefix in Markdown order: `01-`, `02-`, and so on. `01-...` must be the first standalone image. The package builder promotes it to `coverMedia`, uses the sidecar `coverImageAlt`, and removes that one occurrence from packaged Markdown. Remaining images stay inline in their original positions and are emitted as ordered `relatedMedia`. This prevents the cover from appearing twice while preserving multi-image chapter layout.

The builder also removes the front matter's `## Table of Contents` section from `pages/collection.md`. The source manuscript keeps its canonical linked contents, while the CMS supplies collection navigation without duplicating or publishing stale chapter links.

Only inline Markdown image syntax pointing to approved local files under `manuscript/images/` is accepted. External URLs, protocol-relative URLs, embedded `data:` sources, fragments, reference-style images, and raw HTML image elements are rejected before a package is created. Driftya applies the same internal-image policy during ZIP parsing, ordinary CMS saves, and final rendering.
