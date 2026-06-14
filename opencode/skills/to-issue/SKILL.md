---
name: to-issues
description: Break a PRD into phase-based issue files written as local markdown. Use when user sends the "/to-issue" command.

---

# To Issues

Break a PRD into independently-grabbable issue files using vertical slices (tracer bullets). Each issue is written as a local markdown file under the PRD folder — NOT published to GitHub.

## Output

Issues are written under the same PRD folder:

```
docs/prd/<kebab-case-title>/
  00-grill-me-summary.md
  01-prd.md
  02-issues/
    phase-1-<slug>.md
    phase-2-<slug>.md
    ...
```


## Process

### 1. Gather context

Read the PRD from `docs/prd/<kebab-case-title>/01-prd.md`. If the user passes a path, read from there instead.

### 2. Explore the codebase (optional)

If you have not already explored the codebase, do so to understand the current state of the code. Issue titles and descriptions should use the project's domain glossary vocabulary, and respect ADRs in the area you're touching.

### 3. Draft vertical slices

For each phase in the PRD, create one issue file. Each issue is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice, show:

- **Title**: short descriptive name
- **Filename**: `phase-N-<slug>.md`
- **Blocked by**: which other slices (if any) must complete first
- **User stories covered**: which user stories this addresses (if the source material has them)

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split further?

Iterate until the user approves the breakdown.

### 5. Write the issue files

Create the `02-issues/` directory inside the PRD folder. For each approved slice, write a markdown file using the issue template below. Name files in dependency order (blockers first) so that later files can reference earlier ones.

After writing all issue files, update the **Issues** section in `01-prd.md` with the summary table — one row per issue, listing the filename, phase, and one-line summary.

<issue-template>
## Parent

Reference to the PRD file (e.g., `../01-prd.md`).

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation.

Avoid specific file paths or code snippets — they go stale fast. Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it here and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- Reference to the blocking issue file (e.g., `phase-1-auth.md`)

Or "None - can start immediately" if no blockers.

</issue-template>

