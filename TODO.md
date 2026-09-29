# TODO — Story and canon redline for the last two commits

Review date: 2026-09-29. Suggestions only; manuscript, canon, images, and publishing files have not been edited.

## Scope and verdict

Reviewed both commits individually and their combined result against parent `039430b`:

- `ce3ed9164da3aca9c02aafe378620857f66b5438` — Enhance narrative depth by adding emotional context and character reflections in multiple chapters.
- `6fb571b989ca4f1ff540ec07c9961a43164c7c1a` — Enhance emotional depth and character development across multiple chapters.

**The additions broadly fit the story’s red line, but several local continuity repairs are recommended before accepting the prose as finished.** The core sequence remains origin → rescue → belonging → fighting together → love → betrayal and discovery → chosen sacrifice → shared future. The strongest additions give Ava scientific ambition and private desire, make prejudice persist unevenly, and let her return to shared spaces by choice.

Read the ten changed chapters in full, the relevant surrounding scenes, the repository instructions, and the timeline, character, biology, setting, carrier/rescue, continuity, decision-ledger, and prose-style canon. Findings below concern the final combined text at `6fb571b`; problems already repaired by the second commit are not presented as outstanding.

Keep these elements:

- Chapter 1’s scientific humiliation and unnamed longing elaborate Ava’s adult human life without contradicting her origin. Pell and Ellis remain minor recollection details; they do not establish a connection to her captors.
- Chapter 4’s fragment of her mother’s voice fits the permitted private recollections; it does not settle her parents’ identities or fate. Her anger and bodily violation belong in the book.
- Chapter 16’s sexual fantasy stays private. The almost-kiss remains interrupted, and confession, first kiss, and first sexual intimacy remain in chapter 18.
- Continued crew hostility in chapters 15–17 and 32 fits gradual, uneven acceptance. Preserve Cole’s earlier compost contribution and the uncertainty about who damaged the seedling; do not convert suspicion into proven guilt.
- The child’s cup provides a small, earned change in trust across chapters 21–22. Keep that payoff and the extraction procedure.
- Chapter 32’s persistent hand changes preserve the progressive mutation threat. Intimacy does not cure it.
- Chapter 34’s grief during a chosen pregnancy fits the family ending. The limited vaccine, two-year jump, chapter 33 consent safeguards, and daughter’s unknown inheritance remain intact.

The second commit correctly moved the chapter 32 insult and intimacy out of the middle of Malik’s unfinished examination and changed the quarters reference to the couple’s shared quarters. Keep those repairs.

## How to use the redline

“Fix” marks concrete continuity or copy problems; “Revise” marks a canon-related implication or characterization concern; “Optional” marks a craft preference. Each current block is copied verbatim from the reviewed HEAD. Proposed blocks are drafting suggestions, not new canon or author decisions. Line numbers refer to that HEAD and will shift after editing. Apply the two chapter 16 blocks together. No canon change is needed for these proposals; an intentional change to a biological or character rule would instead require author approval and a ledger entry.

## 1. Fix — location continuity — Keep the garage scene off the carrier

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/021-comfort-in-shadows.md, line 37](manuscript/021-comfort-in-shadows.md#L37) (current lines 37–37).

**Introduced by:** `ce3ed91`, retained in `6fb571b`.

**Finding:** The characters are sheltering in a barricaded garage. “This carrier” slips the narration into a different physical location inside the fantasy. Make the imagined quarters explicit while preserving the sexual wanting and the child’s reaction.

**Basis:** [Story and Timeline, hospital mission](canon/public/01-story-and-timeline.md#part-iv--scavengers-in-the-shadows); chapter 21, lines 11–19.

**Current block:**

```markdown
The thought went further than sleep. She wanted the weight of him, his mouth slow at her throat, his hand under her shirt where no one on this carrier was allowed to look at her like a problem. She wanted to be wanted in a room with a door. The wanting sat beside a quieter hurt: the child across the garage had flinched from Ava’s shadow at dusk and then pretended she had only been cold. Ava had smiled so the mother would not have to apologize. The smile still ached.
```

**Proposed replacement:**

```markdown
The thought went further than sleep. She wanted the weight of him, his mouth slow at her throat, his hand under her shirt. Back in their quarters aboard the carrier, they could shut the door. Here, the child across the garage had flinched from Ava’s shadow at dusk and then pretended she had only been cold. Ava had smiled so the mother would not have to apologize. The smile still ached.
```

## 2. Fix — rescue sequence — Complete the survivor handoff before departure

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/022-distant-allies.md, line 19](manuscript/022-distant-allies.md#L19) (current lines 19–19).

**Introduced by:** `6fb571b`.

**Finding:** The new paragraph sends Ava and Gabriel toward the hospital before the detail leader gives the extraction plan and Gabriel confirms the headcount. The existing paragraph at line 23 then has him depart a second time. Keep the arm contact, but hold them at the garage until the existing handoff finishes.

**Basis:** [Rescue Doctrine](canon/public/05-ship-rescue-and-combat.md#rescue-doctrine); [ledger: Rescue transitions and hospital handoffs](canon/internal/07-decisions-and-continuity-ledger.md), 2026-09-13; chapter 22, lines 21–23.

**Current block:**

```markdown
The girl went with her mother. Gabriel, waiting at the radio, saw Ava’s face when she turned back and did not ask her to explain. He only shifted the pack on his shoulder so their arms touched as they started for the hospital. Love, just then, was letting the small victory stay small.
```

**Proposed replacement:**

```markdown
The girl went with her mother. Gabriel, waiting at the radio, saw Ava’s face when she turned back and did not ask her to explain. He shifted the pack on his shoulder, letting his arm brush hers while they waited for the detail leader.
```

## 3. Fix — scene blocking — Return Ava to the greenhouse before Gabriel finds her there

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/032-safe-harbor.md, line 79](manuscript/032-safe-harbor.md#L79) (current lines 79–89).

**Introduced by:** Quarters scene added in `ce3ed91`, rewritten and moved in `6fb571b`.

**Finding:** The latest commit repairs the earlier interruption of Malik’s examination, but a smaller transition problem remains: Ava leaves the greenhouse for their quarters, then Gabriel arrives “here” and the planting table reappears without Ava returning. His mobility also deserves a visible support while they touch. Keep the intimacy and add the missing movement; the existing lines 91–103 can then follow unchanged.

**Basis:** [Prose Style Guide, Action and Romance](canon/internal/08-prose-style-guide.md); [ledger: Training, injuries, and recovered research](canon/internal/07-decisions-and-continuity-ledger.md), 2026-09-13; chapter 31’s leg/head injuries and chapter 32, lines 91–103.

**Current block:**

```markdown
She found Gabriel in their quarters afterward, temple dressing half undone, trying to be patient with his own hands. She finished the unwrap for him. Then she kissed the unhurt skin beside the bruise, and the corner of his mouth. He made a low sound and drew her in by the hip. The corridor’s word was still in her ears. His hands were also on her, careful, wanted, sure of welcome. She laughed against his shoulder when her cramped fingers refused a button, and he held them until they eased, smiling as if the ordinary trouble delighted him.

“I told Malik the truth,” she said.

“I know. I watched you correct him.”

“And I liked the beans. Someone kept them alive.”

“Marcus. He was very proud. Try not to let it go to his head.”

She kissed him again, slower, happiness and love arriving in the same room as the insult and not asking it to leave first. The pain in her hand did not vanish. She trusted him with it anyway. That was the part she meant to keep.
```

**Proposed replacement:**

```markdown
She found Gabriel sitting on their bed afterward, his crutches against the wall and his temple dressing half undone. She finished the unwrap for him. Then she kissed the unhurt skin beside the bruise, and the corner of his mouth. He made a low sound and drew her in by the hip. The corridor’s word was still in her ears. His hands were also on her, careful, wanted, sure of welcome. She laughed against his shoulder when her cramped fingers refused a button, and he held them until they eased.

“I told Malik the truth,” she said.

“I know. I watched you correct him.”

“And I liked the beans. Someone kept them alive.”

“Marcus. He was very proud. Try not to let it go to his head.”

She kissed him again, slower. Her hand still hurt when she rested it against his chest. She left him sitting on the bed, took the watering cans from outside their door, and returned to the greenhouse.
```

## 4. Revise — biological implication — Do not make willpower power the cryopod

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/006-the-world-beyond.md, line 37](manuscript/006-the-world-beyond.md#L37) (current lines 37–37).

**Introduced by:** Frozen experience added in `ce3ed91`; survival explanation added in `6fb571b`.

**Finding:** “Strength, alone, was enough to keep the light on” reads as a causal explanation for survival. Canon attributes that survival to functioning cryogenic technology and a biological equilibrium, not refusal or emotional strength. The passage also asserts a fixed inner experience throughout suspension that the story has not established. This is a misleading implication rather than an explicit new ability; revise it so the grief remains without making consciousness or willpower a cryogenic mechanism.

**Basis:** [Ava’s Exception](canon/public/03-spores-mutation-and-ava.md#avas-exception); [Technology Level](canon/public/04-world-locations-and-society.md#technology-level); chapter 5 ends with Ava saying her name before the cold takes the alarms.

**Current block:**

```markdown
Inside the pod she did not dream of centuries. The cold held her at the last moment of the laboratory: glass in her palms, a scream that had nowhere to go, the shame of having asked them to stop. If any part of her still felt, it felt that. The world above learned new griefs. Hers stayed exactly as large as the room they had locked her in. What the cold could not take was the refusal already in her: she had not consented to end. The green light on the pod was a machine’s report of that fact. It was not hope yet. Hope would need another person. Strength, alone, was enough to keep the light on.
```

**Proposed replacement:**

```markdown
Before the cold took the room from her, Ava had managed to say her name. There had been no answer. Above her, families lived and died, children inherited keys, and the plants she had studied vanished from their old places. Beneath the frost, the machine kept her alive. No one came to hear her name.
```

## 5. Fix — object continuity and copy — Track one destroyed seedling and its replacements consistently

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/016-unspoken.md, line 327](manuscript/016-unspoken.md#L327) (current lines 327–331).

**Introduced by:** `ce3ed91`, retained in `6fb571b`.

**Finding:** “Monster’s garden” contains two words. One dead seedling then becomes an empty row and a group of salvageable plants without showing wider damage. Calling this seedling the first thing she kept alive also blurs it with the first bean established in chapter 15; chapter 16 already has growing beans, lettuce, and herbs. Keep the cruelty, identify the single gap, and sow replacements rather than implying the dead plant can be saved.

**Basis:** Chapter 15, lines 185–245; chapter 16, lines 11–21; [Story and Timeline, belonging takes root](canon/public/01-story-and-timeline.md#part-iii--a-fragile-sanctuary).

**Current block:**

```markdown
The next morning she found a dead seedling on the greenhouse threshold. Someone had pulled it up by the roots and left it where her boot would find it. On the tray behind it, written in the condensation with a finger, were three words: *monster’s garden*.

Ava stood with the little plant in her palm until the soil dried against her skin. It was only a seedling. It was also the first thing on the carrier that had been entirely hers to keep alive. She did not cry in the corridor, where anyone passing could decide what the tears meant. She cried later, bent over the empty row, one hand pressed to the old seam under her ribs because the grief had decided to live there.

She replanted what could be saved. She did not tell Jenna who she suspected. Cole’s friends had stopped lowering their voices when she entered a room. Naming them would turn a small cruelty into a hearing, and she was tired of hearings.
```

**Proposed replacement:**

```markdown
The next morning she found a dead seedling on the greenhouse threshold. Someone had pulled it up by the roots and left it where her boot would find it. On the tray behind it, written in the condensation with a finger, were two words: *monster’s garden*.

Ava stood with the little plant in her palm until the soil dried against her skin. She remembered checking it before bed, touching the soil to see whether it needed water. She did not cry in the corridor, where anyone passing could decide what the tears meant. She cried later, bent over the gap in the row, one hand pressed to the old seam under her ribs.

She sowed two seeds in the gap. She did not tell Jenna who she suspected. Cole’s friends had stopped lowering their voices when she entered a room. That did not tell her who had pulled the plant. She was tired of explaining herself to a room.
```

**Companion replacement for lines 343–351:** Apply this with the block above. The writing moves from a tray to glass in the current version; keep it on the tray, and distinguish new shoots from saved plants.

**Current block:**

```markdown
She accepted the mug. Then, because trust had to be practiced on something that still hurt, she told him about the seedling and the words in the condensation. She did not ask him to find out who had written them.

Gabriel was quiet long enough that she thought he might refuse the limit. “What do you want done?” he asked.

“The row stays. I replanted it. If you pull Cole into a hearing, the garden becomes their story.”

“All right.” He looked toward the beds, not toward the door. “Show me which ones you saved.”

They stood over the thin replacements. Two had already lifted a pale hook of stem. Ava laughed once, surprised by it, and did not take the laugh back. The cruel words were still on the glass if the lamps fogged again. The living row was also true. Gabriel stayed beside it, as if the second fact were allowed to count.
```

**Proposed replacement:**

```markdown
She accepted the mug and told him about the seedling and the words on the tray. “I don’t know who did it,” she said. “I don’t want you going after Cole because I’m angry.”

Gabriel was quiet. “What do you want done?”

“Come and look. I planted the gap again.”

“All right.” He followed her between the beds.

Two pale hooks of stem had lifted through the soil. Ava laughed once, surprised by it. By the door, the words showed again where condensation gathered on the tray. She turned back to the new shoots and pointed out the one still caught in its seed coat. Gabriel bent to look.
```

## 6. Fix — physical sequence — Seat Gabriel before he stays seated

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/015-hope.md, line 155](manuscript/015-hope.md#L155) (current lines 155–161).

**Introduced by:** `6fb571b`.

**Finding:** Ava watches to see whether Gabriel will “stand up” and he “stayed where he was,” but he only sits on the deck after that exchange. Put his existing sitting action first. The emotional choice then has a physical basis.

**Basis:** [Prose Style Guide, Sentence and Paragraph Rhythm](canon/internal/08-prose-style-guide.md#sentence-and-paragraph-rhythm); chapter 15, lines 149–161.

**Current block:**

```markdown
“In the corridor they told each other not to let me touch the food.” She watched his face to see whether he would stand up and make it worse. He stayed where he was. The tightness in his jaw was real. So was the choice not to spend it. “I didn’t hide my hands,” she added.

“Good,” he said.

He did not promise to fix the mess hall. She was not ready to walk back into it, and she was grateful he could tell. Trust, if it came, would have to survive longer than this room.

He sat on the deck opposite her. He did not tell her Cole was wrong. That would have been too simple, and both of them knew it.
```

**Proposed replacement:**

```markdown
He sat on the deck opposite her.

“In the corridor they told each other not to let me touch the food.” She watched his face to see whether he would stand up and make it worse. He stayed where he was. The tightness in his jaw was real. So was the choice not to spend it. “I didn’t hide my hands,” she added.

“Good,” he said.

He did not promise to fix the mess hall. She was not ready to walk back into it, and she was grateful he could tell. Trust, if it came, would have to survive longer than this room.

He did not tell her Cole was wrong. That would have been too simple, and both of them knew it.
```

## 7. Revise — character guardrails — Keep Ava’s agency and Jenna’s command responsibility visible

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/032-safe-harbor.md, line 63](manuscript/032-safe-harbor.md#L63) (current lines 63–63).

**Introduced by:** `6fb571b` expands the aftermath of the insult added in `ce3ed91`.

**Finding:** “Gabriel had let her” makes Ava’s self-assertion sound permitted by him. Jenna hearing the abuse and doing nothing is presented as the ideal response, although she previously directed concerns away from public tribunals and remains responsible for her crew. She can stop the harassment without making Ava defend herself at a hearing. This is a characterization concern, not proof that continued prejudice violates canon.

**Basis:** [Gabriel and Jenna](canon/public/02-characters-and-relationships.md); [Character Guardrails](canon/internal/06-continuity-and-writing-guide.md#character-guardrails); Jenna’s mess-hall boundary in chapter 15, line 127.

**Current block:**

```markdown
He looked at the floor. The other man pulled him down the corridor. The insult stayed. So did the pain in her fingers, a wrongness no apology was going to put back. What also stayed was the choice she had just made: she had spoken, and Gabriel had let her. Jenna, still in the doorway, had heard every word and did not reopen it into a hearing. Ava was grateful for the restraint. Strength, today, was being believed without being displayed.
```

**Proposed replacement:**

```markdown
He looked at the floor. Jenna stepped into the doorway. “Enough. Back to your posts.” The other man pulled him down the corridor. She did not ask Ava to explain herself. Gabriel was still beside her, his wrist beneath her hand. He had not spoken over her. The pain in her fingers remained; so did the insult. Ava released his wrist when she was ready to walk.
```

## 8. Revise — emotional framing — Let the child learn trust without implying Ava owes an apology

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/021-comfort-in-shadows.md, line 83](manuscript/021-comfort-in-shadows.md#L83) (current lines 83–83).

**Introduced by:** `6fb571b`.

**Finding:** The child has been frightened by Ava’s appearance, but Ava has not harmed her. “Forgiveness” implies an offense and a debt that this scene does not establish. The child’s fear and slow acceptance both fit canon; frame them as trust. Also change “the row Ava poured” to a row of cups she filled so the object is clear.

**Basis:** [Ava’s character center and crew acceptance](canon/public/02-characters-and-relationships.md); chapter 20’s encounter with these survivors; the cup payoff in chapter 22.

**Current block:**

```markdown
The child would not take a cup from Ava’s hand. She took it from her mother, who had taken it from the row Ava poured. Ava let that distance stand. Forcing the girl to be brave would only repeat the flinch, and Ava was not owed a quicker forgiveness than the child could give.
```

**Proposed replacement:**

```markdown
The child would not take a cup from Ava’s hand. She took it from her mother, who had lifted it from the row of cups Ava had filled. Ava let that distance stand. The girl drank without looking at her. That was enough for now.
```

## 9. Optional — rhythm and chronology — Ground the mess-hall return without another thematic explanation

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/017-the-price-of-survival.md, line 145](manuscript/017-the-price-of-survival.md#L145) (current lines 145–145).

**Introduced by:** `6fb571b`.

**Finding:** The return to the long table is a good payoff for chapter 15 and should stay. Its final explanation repeats the new additions’ recurring formula: the hurt is still true, happiness is also true, and Gabriel’s restraint proves trust. The concrete acts already communicate this. A shorter closing gives the factory mission more momentum.

**Basis:** [Prose Style Guide, Emotion and Cliché and Repetition Pass](canon/internal/08-prose-style-guide.md); this is an editorial preference, not a canon conflict.

**Current block:**

```markdown
Cole did not apologize. He also did not leave. Ava ate. The corridor sentence was still true, and so was this: she had come back in the open, and the man she trusted had let the crew watch him share the table. Happiness was too large a word. She was proud of the smaller one. She had stayed.
```

**Proposed replacement:**

```markdown
Cole did not apologize. He also did not leave. Ava took a mouthful while Rhea complained about the caf. Nobody stopped her. She reached for another.
```

**Small companion change, optional:** At line 139, change `On the next rescue assignment, she checked the route herself before Gabriel asked.` to `Before the next rescue assignment, she checked the planned route herself before Gabriel asked.` This makes it preparation rather than briefly jumping into the mission before returning to the previous evening.

## 10. Optional — flashback clarity and repetition — Return cleanly to Jenna’s conversation

- [x] Review and apply the proposed replacement if accepted.

**Location:** [manuscript/034-a-new-dawn.md, line 33](manuscript/034-a-new-dawn.md#L33) (current lines 33–39).

**Introduced by:** `6fb571b`.

**Finding:** “In that morning” is awkward wording. “By the time Jenna found her” reintroduces an arrival already shown at lines 17–19, after a long flashback inside their conversation. The extra “She’s strong” exchange also anticipates Gabriel’s existing version at line 69. Keep the grief, chosen pregnancy, kiss, and shared delight, but give the reader a clear return to the present and let the later exchange retain its force.

**Basis:** [Prose Style Guide, Sentence and Paragraph Rhythm and Romance and Intimacy](canon/internal/08-prose-style-guide.md); chapter 34, lines 17–21 and 63–89; no change to the daughter’s unknown long-term biology.

**Current block:**

```markdown
In that morning she told him. Not all of it. Enough: the scar, her parents, the word *weapon*, and the fact that she still wanted their daughter. He listened without sanding the story into something easier. Then the baby kicked his forearm where it lay across her, a blunt ordinary thump, and Ava laughed because joy had shoved its way into the same minute as the mourning. Gabriel laughed with her, helpless and bright.

“She’s strong,” Ava said.

“So are you,” he answered.

She let the sentence stand. The night’s grief remained true. So did this: she trusted him with both, and the happiness did not have to win by erasing what hurt. It only had to be allowed in the room. By the time Jenna found her in the lounge, Ava was still carrying all of it, and she was glad.
```

**Proposed replacement:**

```markdown
The next morning she told him. Not all of it. Enough: the scar, her parents, the word *weapon*, and the fact that she still wanted their daughter. He listened. Then the baby kicked his forearm, a blunt ordinary thump, and Ava laughed. Gabriel laughed with her, leaving his arm where it was.

Now, in the lounge, she smoothed the folded list on her knee and looked up at Jenna.
```

## Verification

Read-only checks passed for the reviewed manuscript:

- 35 numbered chapters, exactly 1–35, with 35 unique matching stable chapter IDs.
- All 35 front-matter table-of-contents links resolve.
- All 26 manuscript image links resolve and use the expected directories and contiguous filename order. Neither reviewed commit changes images or their references; this check verifies placement and links, not a fresh visual-art review.
- No `source:` metadata or Unicode replacement characters in manuscript Markdown; all files decode as UTF-8.
- `git diff --check HEAD~2 HEAD` passed.

Only this report has been written. The replacement prose has not been applied or recorded as a canon decision.
