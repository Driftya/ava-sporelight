# Ava: Sporelight

This repository contains the canonical Markdown edition of *Ava: Sporelight*: a post-apocalyptic science-fiction light novel combining Ava’s origin, awakening, sanctuary, field missions, romance, betrayal, research, and future into one continuous 35-chapter story.

## Start Here

- Read the novel from [`manuscript/000-front-matter.md`](manuscript/000-front-matter.md).
- Consult authoritative story rules from [`canon/README.md`](canon/README.md).
- Read contributor and agent constraints in [`AGENTS.md`](AGENTS.md).

## Repository Structure

| Path | Purpose | Authority |
| --- | --- | --- |
| `manuscript/` | The publishable novel: front matter, 35 numbered chapters, and back-cover copy. | Canonical prose, constrained by `canon/`. |
| `canon/` | Authoritative chronology, characters, biology, world, combat, continuity rules, and decision history. | Governs manuscript changes. |

## Canon and Manuscript Relationship

Canon is a constraint system for the novel:

```text
explicit author decision
          ↓
       canon/
          ↓
     manuscript/
```

The manuscript can dramatize and elaborate canon, but it cannot silently contradict it. If an intentional story revision changes a canonical fact, update the relevant canon document and the decision ledger before or alongside the manuscript revision.

External drafts, game material, sequel plans, alternate profiles, and brainstorming ideas do not sit in this authority chain. They become canonical only when the author explicitly promotes them and the relevant canon document is updated.

## Novel Reading Order

| Part | Chapters | Story movement |
| --- | ---: | --- |
| I — The Last Experiment | 1–6 | Ava’s life, infection, experimentation, transformation, and cryogenic suspension. |
| II — The Rescue | 7–14 | Gabriel’s discovery of Ava, quarantine, the fortress disaster, and escape. |
| III — A Fragile Sanctuary | 15–18 | Crew mistrust, the greenhouse, combat training, partnership, and love. |
| IV — Scavengers in the Shadows | 19–32 | The hospital mission, Ava’s advancing transformation, and Harrow’s betrayal. |
| V — A New Dawn | 33–35 | Karrow’s proposal, consensual blood research, the vaccine, and a shared future. |

The narrative red line is:

**origin → rescue → belonging → fighting together → love → betrayal and discovery → chosen sacrifice → a future together**

## Current Canon Essentials

- Ava was born human and worked as a botanist before infection and forced experimentation.
- She is immune to the ordinary fatal degradation of mutation, but not to transformation itself. Her mutation continues progressing and can make her permanently monstrous.
- Her fresh blood and body fluids neutralize mutant life forms without ordinary spore release.
- Gabriel is a former firefighter and current rescue operative who becomes Ava’s partner.
- Jenna is both commander and scientist.
- EHC-17 *Haven’s Vanguard* is a terrestrial/atmospheric Titan-class hover carrier, not a spacecraft.
- Harrow the scavenger and Dr. Elias Karrow the scientist are different people.
- Ava’s consent is the ethical dividing line between the experiments that violated her and the later research she chooses.

## Editing Workflow

1. Identify the chapter or canon topic being changed.
2. Read the relevant document linked from `canon/README.md`.
3. Check `canon/07-decisions-and-continuity-ledger.md` for earlier conflict resolutions.
4. Make the smallest change that satisfies the story goal without breaking canon.
5. Update canon and its decision ledger if the author intentionally changes continuity.
6. Verify numbering, stable IDs, links, encoding, and the manuscript invariants in `AGENT.md`.

## External Reference Material

The author may supply earlier drafts or reference material directly in a task prompt. Treat that material as context for the requested work, not as automatic canon. Any lasting continuity decision should be recorded in `canon/` so the repository remains self-contained.

## License

See [`LICENSE`](LICENSE) for repository licensing information. The novel’s copyright notice appears in its front matter.
