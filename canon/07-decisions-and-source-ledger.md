# Decisions and Source Ledger

## Table of Contents

1. [Author-Decided Canon](#author-decided-canon)
2. [Resolved Contradictions](#resolved-contradictions)
3. [Duplicate Handling](#duplicate-handling)
4. [Promoted Sources](#promoted-sources)
5. [Reserved or Excluded Sources](#reserved-or-excluded-sources)

## Author-Decided Canon

These decisions come directly from the author’s clarification and govern future work:

1. **Haven’s Vanguard is not a spacecraft.** It is a terrestrial/atmospheric Titan-class hover carrier. Star and void language in the manuscript is night imagery.
2. **Ava is immune to the ordinary fatal mutation process, not to transformation.** Her body survives and integrates the mutation, but she continues becoming more monstrous over time and can lose control. Ordinary mutants degrade; Ava’s anomaly lets her survive the progression, which creates its own risk of a permanent monster state.
3. **`canon/` is authoritative.** The old dataset is development input, not an equal source of truth.

## Resolved Contradictions

| Topic | Conflicting development claims | Canon resolution |
| --- | --- | --- |
| Ava’s origin | “Engineered being” versus naturally human botanist | Ava was born human, became infected, and was then subjected to forced experiments. |
| Ava’s immunity | “Immune to mutation” versus visibly transformed | She is immune to ordinary fatal rejection/degradation but not to ongoing mutation or loss of control. |
| Mutation stability | Permanently stabilized versus episodic danger | Cryosleep created a survivable equilibrium, not a cure. Transformation remains progressive and stress-reactive. |
| The carrier | Atmospheric Titan-class versus prose about stars and void | Haven’s Vanguard is a hover carrier; celestial language is descriptive night imagery. |
| Fortress name | Generic fortress versus “Icehold Citadel” | The novel establishes only “the fortress.” Icehold Citadel remains reserved. |
| Ava’s journal | Used before Gabriel gives it; one side-story line credits Marcus | Canon order has Gabriel give the journal first; the mistaken Marcus attribution was corrected in chapter 16. |
| Hospital research | No link to Karrow in the original proof material | The surviving hospital notes lead Jenna toward the blood analysis that supports Karrow’s proposal. |
| Dodge and guard | Identical descriptions in combat notes | Dodge is evasion; guard is bracing or shielding. |
| Harrow/Karrow | Similar names risk implied identity or relation | They are distinct, unrelated characters with different roles. |

## Duplicate Handling

- `.odt` and `._utf8.txt` pairs under `temp_source/dataset` are alternate representations of the same proof material. Canon does not duplicate both.
- `MutationConstraints._tf8.txt` and `MutationConstraints._utf8.txt` have identical content; the only file-level difference is a byte-order mark. The UTF-8 version was treated as the input.
- Old tables of contents, page numbers, version histories, prompts, and export artifacts were not promoted.
- Overlapping summaries in `OverviewDetails`, `Premises`, `Outlines`, `World`, and `Sporelight_Index` were replaced by the single narrative timeline and this source ledger.
- Repeated character entries in `Profiles` were consolidated by character and restricted to the cast of this novel.
- Speculative combat suggestions were separated from established techniques.

## Promoted Sources

| Development input | Canon destination | Treatment |
| --- | --- | --- |
| `temp_source/stories/MERGE_REFERENCE.md` | `01-story-and-timeline.md`, this ledger | Reading order and merge decisions retained. |
| `Alien._utf8.txt` | `03-spores-mutation-and-ava.md` | Infection and spore rules consolidated; overbroad immunity wording corrected. |
| `MutationConstraints._utf8.txt` | `03-spores-mutation-and-ava.md` | Progressive mutation model retained and reconciled with author clarification. |
| `AvaCombat._utf8.txt` | `05-ship-rescue-and-combat.md` | Established techniques separated from speculative/game moves; duplicate defense entries fixed. |
| `Constraints._utf8.txt` | `02-characters-and-relationships.md`, `06-continuity-and-writing-guide.md` | Converted from controlling “would not let” language into reciprocal character pressures and autonomy guardrails. |
| `Profiles._utf8.txt` | `02-characters-and-relationships.md` | Main-novel cast consolidated; sequel cast excluded. |
| `Outlines._utf8.txt`, `OverviewDetails._utf8.txt`, `Premises._utf8.txt` | `01-story-and-timeline.md` | Replaced obsolete separate-book numbering with the unified 35-chapter sequence. |
| `World._utf8.txt`, `WorldDynamic._utf8.txt`, `Locations._utf8.txt` | `04-world-locations-and-society.md` | Only manuscript-established locations and nonconflicting macro-world rules promoted. |
| `Ship._utf8.txt`, `Technolgy._utf8.txt`, `OperationManual._utf8.txt` | `05-ship-rescue-and-combat.md` | Carrier and rescue doctrine merged; spacecraft interpretation rejected. |
| `MutationEnemies._utf8.txt` | `03-spores-mutation-and-ava.md`, `05-ship-rescue-and-combat.md` | Biological grounding retained; named bestiary remains optional until used in prose. |
| `Insperations._utf8.txt`, blacklist files | `06-continuity-and-writing-guide.md` | Treated as editorial guidance, never in-world fact. |

## Reserved or Excluded Sources

| Material | Status | Reason |
| --- | --- | --- |
| `Communication._utf8.txt` | Excluded | A social/review-writing playbook, not novel canon. |
| `Currency._utf8.txt` | Reserved | Rations and power cells fit the setting but are not established as universal currency in this manuscript. |
| `Sporelight_Index._utf8.txt` | Superseded | It lists the old proof-of-concept books rather than the unified novel. |
| `SporelightGabriel.Outline.*` | Separate work | Gabriel’s separate novel does not belong inside this manuscript. |
| `chapter_revisions/daughter of the new dawn/*` | Separate work | Sequel draft material. |
| `instructions/sporelight_sequel.txt` | Separate work | Sequel planning, not current-novel authority. |
| `prompts/images.txt` | Excluded | Generation prompt material, not story fact. |
| `temp_source/dataset/game/**` | Reserved | Game systems, factions, locations, items, and missions require explicit promotion before entering novel canon. |
| `AI_Blacklist_Phrases.csv` and blacklist instructions | Editorial only | Useful for revision, but not world or story canon. |

Raw source files remain in `temp_source/` as provenance. Their continued presence does not make conflicting statements canonical; this directory is the resolved authority.
