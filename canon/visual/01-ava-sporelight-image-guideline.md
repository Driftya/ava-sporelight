# Ava: Sporelight — Image Consistency Guideline

> **Purpose**  
> This document defines the visual and production guardrails for image generation in **Ava: Sporelight**.
> Its primary production use is creating consistent illustrations for the novel under `manuscript/images/`; it also governs future concept art, keyframes, promotional art, and reusable assets.

---

## Authority and Documentation Red Line

Visual work uses two connected layers:

1. **Story canon and chapter prose** define what is true and what occurs.
2. **Visual / production canon** defines how that material is rendered consistently.

The production red line is:

```text
README.md and canon/README.md
              ↓
 target chapter + governing story canon
              ↓
       this visual guideline
              ↓
   relevant concepts/ references
              ↓
 generation → review → approved chapter image
              ↓
       manuscript/images/NNN/
```

If any visual reference conflicts with written canon or the target chapter, the written source wins. Do not silently reconcile the conflict in the prompt or image. Flag it and preserve the existing manuscript until the author resolves it.

Files in `concepts/` are visual anchors, not independent story canon. A generated image is a production candidate, not a new canonical fact. Only an approved image that passes the checks in this document belongs under `manuscript/images/`.

---

## Core Rule

Do **not** reinterpret Sporelight from scratch for each image.

Every image must feel like it belongs to the **same official visual bible**.

When in doubt:

- preserve identity over novelty
- preserve world tone over spectacle
- preserve continuity over variation

---

## Recommended Folder Structure

```text
canon/
  visual/
    01-ava-sporelight-image-guideline.md
concepts/
  ava_definitive_character_turnaround.png
  ava_expressions_and_emotional_range.png
  ava_reference_sheet_5_forms.png
  gabriel_character_sheet.png
  jenna_character_sheet.png
  ava_botanist_before_the_fall.png
  subject_017_laboratory_origins.png
  haven_s_vanguard_interior_bible.png
  sporelight_world_concepts.png
  spore_creature_taxonomy_field_guide.png
  the_spore_visual_language_guide.png
  ava_gabriel_bond_body_language.png
  ava_cryopod_scene.png.png
manuscript/
  images/
    000/
    001/
    002/
    ...
    035/
    shared/
```

Create numbered image directories as chapters receive approved artwork; empty placeholder directories are not required.

---

## Reference Library

These are the current recommended anchor references.

### Visual Direction References
- [Ava — Visual Direction](../../concepts/ava_visual_direction.png)

### Primary Character References

- [Ava — Definitive Character Turnaround](../../concepts/ava_definitive_character_turnaround.png)
- [Ava — Expression & Emotional Range](../../concepts/ava_expressions_and_emotional_range.png)
- [Ava — Mutation Progression / 5 Forms](../../concepts/ava_reference_sheet_5_forms.png)
- [Ava — Before the Fall](../../concepts/ava_botanist_before_the_fall.png)
- [Gabriel — Character Sheet](../../concepts/gabriel_character_sheet.png)
- [Jenna — Character Sheet](../../concepts/jenna_character_sheet.png)

### Relationship / Story References

- [Ava + Gabriel — Bond & Body Language](../../concepts/ava_gabriel_bond_body_language.png)
- [Ava — Cryopod Scene](../../concepts/ava_cryopod_scene.png.png)
- [Subject 017 — Laboratory Origins](../../concepts/subject_017_laboratory_origins.png)

### World / Environment References

- [Sporelight — World Concepts](../../concepts/sporelight_world_concepts.png)
- [Haven’s Vanguard — Interior Bible](../../concepts/haven_s_vanguard_interior_bible.png)

### Creature / Threat References

- [Spore Creature Taxonomy](../../concepts/spore_creature_taxonomy_field_guide.png)
- [The Spore — Visual Language Guide](../../concepts/the_spore_visual_language_guide.png)

---

## Reference Authority and Selection

Apply this authority order:

1. **Written story canon** — chronology, identities, biology, world, equipment, relationships, and author decisions.
2. **Target chapter prose** — the moment, location, emotional state, clothing, injuries, and action actually depicted.
3. **This guideline** — production style, placement, prompting, and review requirements.
4. **Ava — Visual Direction** — overall visual language and rendering direction.
5. **Subject-specific concept references** — identity, anatomy, costume, environment, creature, or relationship anchors relevant to the image.

Use the smallest useful reference set. Within a subject, prefer the most specific reference: the mutation sheet for Ava’s form, the definitive turnaround for her identity, the expression sheet for emotion, a named character sheet for Gabriel or Jenna, the carrier bible for its interior, and the taxonomy or Spore guide for infected biology.

When two same-level concept references disagree, do not invent a compromise. Follow the reference most specific to the depicted chapter state and record the ambiguity for author review if it could alter continuity.

---

## Style Lock

All new Sporelight images must remain visually aligned with the established project style.

### Required style traits

- rough **pencil / graphite / oil-painted** concept-art feeling
- hand-crafted look rather than polished commercial gloss
- grounded **post-apocalyptic science-fantasy** tone
- muted **sepia, charcoal, gray-blue** base palette
- **warm amber glow** used with intent for Ava and spore-reactive biology
- distressed, artbook-like presentation for sheets and concept pages
- cinematic mood for story scenes
- layered environments with weathering, decay, and survival detail

### Presentation modes

#### 1. Concept Sheet Mode
Use when making:
- character sheets
- world sheets
- creature sheets
- equipment sheets
- visual bibles

Characteristics:
- parchment paper background is allowed and encouraged
- labeled panels
- close-ups and callouts
- small supporting notes
- artbook / dossier layout

#### 2. Story Keyframe Mode
Use when making:
- scene illustrations
- novel illustrations
- emotional moments
- action scenes

Characteristics:
- no need for parchment layout
- cinematic framing
- focus on mood, story, and emotion
- still uses the same painting / graphite identity

#### 3. Game / VN Asset Mode
Use when making:
- sprites
- portraits
- cleaner reusable assets

Characteristics:
- simplified shapes allowed
- keep the same core identity
- prioritize readability and reusability
- do **not** drift into generic anime unless explicitly intended for a separate asset pipeline

---

## Negative Style Guardrails

### Never drift into:

- bright generic anime look
- clean cel-shaded manga style unless intentionally creating a separate asset set
- glossy plastic CGI look
- hyper-modern superhero style
- neon cyberpunk palette
- sleek pristine sci-fi disconnected from survival themes
- random fantasy-monster interpretation that ignores Sporelight biology

### Avoid:

- oversexualized presentation unless the scene explicitly requires sensuality and still fits tone
- excessively cute or youthful character redesigns
- glamorized mutation that looks decorative instead of biological
- environments that feel too clean, luxurious, or technologically perfect

---

## Character Canon Locks

## Ava Canon Lock

Ava must remain recognizable in all forms.

### Post-awakening Ava

Required traits:

- young woman
- pale skin
- long messy dark-brown hair with lighter silver / ashen streaks
- amber eyes
- slim but resilient build
- practical survival wear or fitted tactical bodysuit
- subtle or visible amber vein patterns depending on stress state
- emotional tone often includes guardedness, fatigue, fear, resilience, vulnerability, or quiet hope

### Pre-Fall Ava

Required traits:

- clearly the same person
- healthier appearance
- green / emerald eyes
- dark hair **without** silver streaks
- botanist / explorer identity
- practical field gear, notebook, specimens, research tools
- more curiosity and openness in expression

### Mutation Rules

Mutation must feel:

- painful
- biological
- escalating
- identity-linked
- visually consistent across stages

Required mutation traits:

- bone-like / thorn-like / organic spikes
- ember / amber glow that feels internal, not decorative
- cracked skin, vein resonance, emergence sites are allowed
- advanced mutation must still read as **Ava**, not a random monster
- partial mutation must preserve strong human recognition

### Ava Must Not Drift Into

- cute school-anime heroine
- generic fantasy warrior woman
- polished superheroine
- fully anonymous monster lacking Ava’s face or emotional trace

---

## Gabriel Canon Lock

Required traits:

- rugged adult man
- messy brown hair
- light beard / stubble
- dependable protector presence
- practical survival / rescue / tactical clothing
- grounded equipment
- serious, steady, calm energy
- warmth without losing realism

Gabriel must feel like:

- protector
- survivor
- leader under pressure
- human anchor in a broken world

### Gabriel Must Not Drift Into

- clean fashion model soldier
- exaggerated action-hero caricature
- futuristic elite supersoldier look
- bland anonymous military NPC

---

## Jenna Canon Lock

Required traits:

- adult woman
- red hair
- glasses
- scientist / captain / virologist identity
- practical, controlled, intelligent demeanor
- field-science and command aesthetic
- clean but lived-in presentation

Jenna must feel like:

- protective intellect
- composed authority
- grounded scientific competence

### Jenna Must Not Drift Into

- glamorous sci-fi doctor stereotype
- overly ornamental uniform fantasy
- generic office-worker appearance detached from survival context

---

## World Lock

Sporelight environments must feel like a single coherent universe.

### Core world qualities

- ruined civilization reclaimed by nature
- survival-focused science-fantasy
- remnants of old technology still functioning imperfectly
- beauty and danger existing together
- decay, overgrowth, dust, rust, spores, and endurance

### Haven’s Vanguard

Must feel like:

- a mobile sanctuary
- a practical and worn hover carrier
- not luxurious, but life-sustaining
- organized, human, and functional
- a place of refuge, command, repair, transport, and community

### Cryopods

Must feel like:

- ancient, rare, and precious
- almost mythic surviving technology
- cold, sterile, eerie, and medically severe
- beyond current ordinary human manufacturing capability

---

## Spore / Creature Lock

The Spore is not just an effect. It is a core visual language.

### The Spore must feel like:

- ecological
- invasive
- biological
- adaptive
- beautiful in a dangerous way
- systemic, not decorative

### Visual traits

- suspended particulate / airborne threat
- mycelial filaments
- infected tissue and biomass
- bloom release after death
- contamination of plant, animal, human, and ruin space

### Spore creatures must feel like:

- twisted remnants of prior life
- anatomically suggestive of their origin
- internally consistent
- threatening but not random
- shaped by infection logic rather than cool-monster rule alone

### Creature drift to avoid

- generic zombies
- generic demons
- random alien bug monsters disconnected from spore logic
- overdesigned horror creatures with no readable anatomy

---

## Color Language

### Default palette

- parchment beige
- charcoal gray
- weathered brown
- muted blue-gray
- cold fog tones
- rust / old metal neutrals

### Accent palette

- **amber / ember glow** = Ava biology, mutation energy, reactive blood effect
- **soft pale blue** = pre-Fall bioluminescent fungus, scientific wonder, rarer mystery tone
- **sick green / gray-green haze** = ambient spore threat when needed

### Color rule

Accent colors should be **rare and meaningful**.  
Do not turn the world into a neon palette.

---

## Composition Rules

## For Character Scenes

Always preserve:

- face identity
- body language
- costume logic
- silhouette readability
- emotional clarity

Preferred qualities:

- cinematic framing
- expressive pose
- clear focal point
- believable intimacy / danger / tension

## For Concept Sheets

Include when useful:

- multiple views
- labeled panels
- gear details
- close-ups
- texture references
- small environment snippets

Do not overload the page with text.

## For Story Keyframes

Prioritize:

- scene readability
- atmosphere
- emotional truth
- location identity
- character continuity

Not every image should look like a reference sheet.

---

## Reference Selection Workflow

For each generation:

### Step 1 — Identify image type
Choose one:

- character sheet
- expression sheet
- mutation sheet
- creature sheet
- world sheet
- relationship sheet
- story keyframe
- VN / sprite asset
- promotional art

### Step 2 — Choose anchor references
Use only the most relevant ones.

### Step 2.5 — Define Spatial and Temporal Isolation
Before drafting any image prompt, the agent must explicitly answer these internal guardrail checks:
1. Does this scene take place in the same physical room/environment as the previous image? (If NO: Add a strict negative prompt banner forbidding all environmental elements from the previous image).
2. What is the single, exact second of action being frozen from the text? (Ignore all actions, characters, or assets that occur before or after this specific second).

#### For Ava scenes
Use:
- `Ava turnaround`
- `Ava expressions`
- `Ava mutation sheet` if mutation is involved

#### For pre-Fall Ava
Use:
- `Ava before the Fall`
- optionally `Ava turnaround` to preserve identity

#### For Gabriel scenes
Use:
- `Gabriel character sheet`
- `Ava + Gabriel bond sheet` if both appear

#### For Jenna scenes
Use:
- `Jenna character sheet`
- `Haven’s Vanguard interior bible` if on-ship

#### For ship scenes
Use:
- `Haven’s Vanguard interior bible`
- `Sporelight world concepts`

#### For spore threat or creature scenes
Use:
- `Spore creature taxonomy`
- `The Spore visual language guide`

### Step 3 — State what must remain consistent
Explicitly define:

- character identity
- clothing / gear
- mutation stage
- world style
- tone
- palette
- presentation mode

### Step 4 — State what is new
Explicitly define:

- pose
- action
- scene
- emotion
- camera angle
- lighting
- environmental situation

### Step 5 — Review against the chapter

Before approval, compare the candidate with the target chapter and governing story canon. Confirm that it does not reveal a later event, use a later mutation stage, relocate a scene, change a relationship beat, or turn a visual invention into an implied story fact.

## Chapter Illustration Placement

- Put approved cover and front-matter art in `manuscript/images/000/` and link it relative to the consuming Markdown file.
- Put each approved chapter-specific image in `manuscript/images/NNN/`, using the chapter’s three-digit stable number.
- Use `manuscript/images/shared/` only when the same asset is intentionally used in multiple manuscript sections.
- Prefix descriptive lowercase kebab-case filenames with their two-digit display order inside the manuscript page, such as `01-ava-wakes-in-cryopod.png`, `02-ava-sees-the-rescue-team.png`, and so on; the parent directory already carries the chapter number.
- Start each illustrated manuscript page at `01` and keep the sequence contiguous. Markdown image references must appear in the same order as their prefixes.
- Treat `01-...` as the page’s cover image and place it as the first standalone Markdown image. The CMS package promotes it to the cover and strips that single Markdown occurrence to prevent double rendering; images `02-...` and later remain inline.
- Link from the chapter Markdown with a relative path such as `images/009/01-ava-wakes-in-cryopod.png`.
- Keep generation prompts, rejected candidates, and production notes out of numbered chapter files.
- Do not move a chapter image merely because its chapter title or Markdown filename changes; the stable chapter number controls its directory.

An illustration may interpret framing, lighting, pose, and incidental texture, but it must not add a consequential event, character, object, injury, transformation, or location that the chapter and canon do not support.

---

## Prompt Template

Use this prompt structure for future image work:

```text
Create a new Ava: Sporelight image.

Image type: [character sheet / keyframe / creature sheet / world concept / etc.]
Primary references: [list the exact anchor references]

[COMPOSITIONAL ARCHITECTURE & ANTI-REPETITION MANDATE]
- Compositional Mode: Story Keyframe Mode. Prioritize atmospheric depth, focal clarity, and emotional truth over asset density.
- Asset Budgeting: Limit active subjects. If a crowd or background elements are mentioned, render only 2 to 3 distinct, non-identical silhouettes to establish scale. Do not tile, duplicate, or clone character models or poses.
- Text & Signage Rule: ABSOLUTE TEXT BAN BY DEFAULT. Completely omit floating digital overlays, labels, or repeating warning signs unless an exact string of text is explicitly requested in quotes (e.g., "TEXT"). Any requested text must be rendered exactly once as a weathered, stenciled, or integrated environmental asset.
- Camera & Framing: Use a wide-angle 24mm anamorphic lens perspective with a distinct cinematic aspect ratio (e.g., 16:9 or 21:9). Establish three distinct planes of depth: a clear foreground anchor, a sharply focused middleground focal subject, and a atmospheric background.
- Rendering Style: Hard focus on the primary subject. Apply a shallow depth of field to naturally blur background details, preventing visual noise and keeping the environment clean.

[Border & Presentation]: The image is enclosed in a heavy, rough charcoal and graphite sketch vignette border. The outer edges resemble distressed, weathered paper with visible cross-hatched pencil lines and smudged dark borders, framing the scene like an artbook illustration.

[STRICT TASK COMPARTMENTALIZATION / CONTEXT FLUSH]
- Treat every chapter illustration as an entirely isolated project. 
- You must NEVER carry over environments, weather, props, or background assets from a previous chapter generation to the next, unless the current text explicitly states the characters are still in the exact same location.
- Before writing a new image prompt, completely flush your memory of the previous background. Rebuild the set design entirely from scratch using ONLY the spatial boundaries defined in the current target text.

Preserve:
- [character identity]
- [costume / mutation stage / environment identity]
- [core style]
- [palette]
- [tone]

New content:
- [what is happening]
- [pose / scene / action]
- [emotion]
- [location]
- [lighting]

Style:
- rough graphite / oil-painted concept art
- grounded post-apocalyptic science-fantasy
- muted sepia / charcoal / gray-blue palette
- warm amber highlights where biologically appropriate
- cinematic and emotionally readable

Avoid:
- generic anime drift
- glossy CGI look
- neon cyberpunk palette
- off-model character redesign
```

---

## Consistency Review Checklist

Before approving an image, check:

### Character identity
- Does Ava still look like Ava?
- Does Gabriel still look like Gabriel?
- Does Jenna still look like Jenna?

### Style identity
- Does it still feel like Sporelight?
- Is the rendering language aligned with the established visual bible?
- Did the image accidentally drift into a different genre?

### World identity
- Does the environment feel like the same world?
- Does technology look worn, scarce, and grounded?
- Does the Spore feel biological and dangerous?

### Mutation identity
- Are the spikes and transformation biologically consistent?
- Does mutation still preserve Ava’s identity when appropriate?
- Is the amber glow meaningful rather than decorative?

### Composition identity
- Is the scene readable?
- Is the emotion readable?
- Is the intended image type clear?

If the answer is **no** to any of the above, revise or regenerate.

---

## Versioning Recommendation

Use version names to keep canon stable.

Suggested names:

- `sporelight_style_core_v1`
- `ava_core_identity_v1`
- `gabriel_core_identity_v1`
- `jenna_core_identity_v1`
- `spore_taxonomy_v1`
- `havens_vanguard_v1`
- `sporelight_image_guideline_v1`

If you make major revisions later, increment to `v2` rather than silently replacing the original.

---

## Practical Rule of Thumb

If you already have enough concept references, stop making more concept sheets unless they solve a real gap.

From this point onward, the preferred order is:

1. lock core references  
2. follow this visual guideline  
3. generate key scenes  
4. only create new concept sheets when production actually needs them

---

## Short Summary

This file is the **visual guardrail document** for Ava: Sporelight.

It should:

- live near canon
- be treated as **visual / production canon**
- guide all future image generation
- prevent character drift
- prevent style drift
- keep the world coherent across scenes and formats

If the written lore defines **what Sporelight is**, this guideline defines **what Sporelight looks like**.
