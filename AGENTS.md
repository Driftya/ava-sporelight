# Agent Working Agreement

This file governs work throughout the *Ava: Sporelight* repository.

## Prime Constraint

**`canon/` constrains `manuscript/`, including `manuscript/images/`.**

Manuscript prose may add scene-level texture, dialogue, sensory detail, and characterization, but it must not contradict canonical biology, chronology, identities, relationships, locations, technology, or author decisions.

When a proposed manuscript change conflicts with canon:

1. Do not silently rationalize the conflict.
2. Identify the exact canon rule and affected chapter.
3. Preserve the existing manuscript until the conflict is deliberately resolved.
4. If the author approves a continuity change, update canon first or in the same change.
5. Record the decision and its reason in `canon/internal/07-decisions-and-continuity-ledger.md`.

An explicit current instruction from the author may change canon. Agent inference may not.

## Required Reading

Before changing any manuscript file, read:

1. `README.md`
2. `canon/README.md`
3. The canon document governing the proposed change

Before generating, selecting, editing, or placing a manuscript image, also read:

4. The target chapter
5. `canon/internal/visual/01-ava-sporelight-image-guideline.md`
6. Only the concept references relevant to that image

Use this routing table:

| Change concerns | Required canon reference |
| --- | --- |
| Plot order, chapter placement, or time | `canon/public/01-story-and-timeline.md` |
| Character identity, motive, or relationship | `canon/public/02-characters-and-relationships.md` |
| Spores, Ava’s immunity, transformation, blood, or vaccine | `canon/public/03-spores-mutation-and-ava.md` |
| Mutant anatomy, abilities, or naming | `canon/public/03b-mutant-bestiary.md` |
| Setting, society, location, or economy | `canon/public/04-world-locations-and-society.md` |
| Haven’s Vanguard, rescue procedure, equipment, or combat | `canon/public/05-ship-rescue-and-combat.md` |
| Voice, terminology, mature content, or continuity checks | `canon/internal/06-continuity-and-writing-guide.md` |
| Prose voice, viewpoint, dialogue, rhythm, or line editing | `canon/internal/08-prose-style-guide.md` |
| Uncertainty, resolved contradictions, or prior decisions | `canon/internal/07-decisions-and-continuity-ledger.md` |
| Chapter illustration, character appearance, visual mood, composition, or image placement | `canon/internal/visual/01-ava-sporelight-image-guideline.md` plus the story-canon documents governing the depicted content |

## Manuscript Invariants

- The novel contains 35 continuously numbered chapters, followed by nonchapter back-cover material.
- Stable chapter IDs use `ava-sporelight-chapter-NNN` and must not change when titles or filenames change.
- `manuscript/000-front-matter.md` contains the canonical epigraph, teaser, copyright notice, and linked table of contents.
- `manuscript/back-cover.md` contains canonical marketing copy and is not chapter 36.
- Chapter files must not contain `source:` metadata fields.
- *A Fragile Sanctuary* is integrated into chapters 15–16.
- *Scavengers in the Shadows* occupies chapters 19–32 and occurs after the love confession.
- Harrow’s betrayal and the surviving hospital research precede Dr. Elias Karrow’s proposal.
- Haven’s Vanguard is a terrestrial/atmospheric Titan-class hover carrier, not a spacecraft.
- Ava survives ordinary mutation degradation but is not immune to transformation. Her mutation continues progressing and can lead to permanent monstrous loss of control.
- Harrow and Dr. Elias Karrow are separate, unrelated characters.
- Do not soften violence, sexual intimacy, profanity, fear, or emotional intensity from the source material.

## Image Invariants

- Cover and front-matter images live under `manuscript/images/000/`.
- Approved chapter-specific images live under `manuscript/images/NNN/`, where `NNN` is the chapter’s zero-padded number from `001` through `035`.
- Every manuscript image filename starts with its two-digit order within the consuming manuscript page: `01-`, `02-`, and so on. The sequence is contiguous and the Markdown references use the same order.
- The first image (`01-...`) is the manuscript page’s cover image and must be a standalone Markdown image. CMS packaging promotes it to the cover and removes that one Markdown occurrence so it is not rendered twice; `02-...` and later images remain inline.
- `manuscript/images/shared/` is only for assets intentionally reused across multiple manuscript sections.
- `concepts/` contains generation anchors and development references. Its files are not publishable manuscript images and do not establish story canon by themselves.
- Story canon and the target chapter govern depicted facts. The visual guideline governs their rendering. A concept image or generated image may not override either.
- Images must depict the correct chapter moment, character state, mutation stage, relationships, location, equipment, and technology.
- Haven’s Vanguard must remain a terrestrial/atmospheric Titan-class hover carrier, never a spacecraft.
- Generated candidates become publishable assets only after continuity and visual-consistency review.
- Chapter Markdown must reference images with relative links, for example `images/007/01-example-scene.png` followed by `images/007/02-second-scene.png`.
- Manuscript images must use inline Markdown image syntax and resolve to approved files under `manuscript/images/`. External, protocol-relative, embedded `data:`, fragment, reference-style, and raw-HTML image sources are not publishable.

## Canon Boundaries

Do not assume that external drafts, prior versions, game material, sequel plans, alternate names, or brainstorming ideas are part of this repository’s continuity.

The author may provide outside reference material in a prompt. Use it only for the requested task. Material becomes canonical only through an explicit author decision and a corresponding update under `canon/`.

## Editing Rules

- Preserve existing source files unless the task explicitly calls for source maintenance.
- Prefer the smallest prose change that restores continuity.
- Do not remove mature or harsh language merely to make it gentler.
- Remove genuine repetition without erasing intentional thematic echoes.
- Keep one Markdown file per numbered chapter.
- Use UTF-8 and preserve typographic punctuation.
- Keep Markdown links relative inside repository documents.
- When adding a canon document, add it to `canon/README.md`.
- When changing chapter titles or filenames, update the front-matter table of contents in the same change.
- Keep chapter image directory numbers aligned with stable chapter numbers even if a chapter title or filename changes.
- Do not add visual-development notes or generation prompts to chapter prose.

## Verification

After manuscript or canon changes, verify:

- chapter numbers run from 1 through 35 without gaps or duplicates;
- all stable IDs are present and unique;
- every table-of-contents link resolves;
- no `source:` metadata has returned to manuscript files;
- files contain no corrupted UTF-8 sequences or replacement characters;
- changed prose complies with the relevant canon documents;
- every added manuscript image is in `000/` for front matter, the correct numbered chapter directory, or `shared/` when genuinely reused; has the correct contiguous `NN-` order prefix; resolves from its Markdown link in that order; and complies with the target text, story canon, and visual guideline;
- concept references remain under `concepts/` rather than being treated as publishable chapter assets;
- new decisions are recorded in `canon/internal/07-decisions-and-continuity-ledger.md` with a clear status: established, author-decided, supporting canon, unknown, or reserved.
