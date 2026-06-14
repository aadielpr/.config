---
name: to-prd
description: Turn the current conversation context into a PRD and publish it to the project issue tracker. Use when user sends the "/to-prd" command.
---

This skill grills the user on their plan (if not already done), then synthesizes the results into a phase-chunked PRD.

## Output

All output goes into a single folder per feature:

```
docs/prd/<kebab-case-title>/
  00-grill-me-summary.md
  01-prd.md
```

## Process

1. **Grill the user (if not already done).** Check if the user has already been grilled in this conversation (e.g., via `/grill-me`). If they have, skip this step and use the existing context. If they haven't, conduct a grill session following the `grill-me` skill: interview the user relentlessly about every aspect of their plan, one question at a time, resolving each branch of the decision tree. For each question, provide your recommended answer. If a question can be answered by exploring the codebase, explore the codebase instead. Write the grill summary to `00-grill-me-summary.md`.

2. Explore the repo to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary throughout the PRD, and respect any ADRs in the area you're touching.

3. Sketch out the major modules you will need to build or modify to complete the implementation. Actively look for opportunities to extract deep modules that can be tested in isolation.

A deep module (as opposed to a shallow module) is one which encapsulates a lot of functionality in a simple, testable interface which rarely changes.

Check with the user that these modules match their expectations. Check with the user which modules they want tests written for.

4. Write the PRD to `01-prd.md` using the template below. Chunk the PRD into phases — each phase gets its own description and user stories.

<prd-template>

## Problem Statement

The problem that the user is facing, from the user's perspective.

## Solution

The solution to the problem, from the user's perspective.

## Phases

Break the implementation into numbered phases. Each phase is an independently valuable increment.

### Phase N: <phase name>

One sentence summary of what this phase delivers.

**Description:** What this phase covers and why it comes before/after other phases.

**User Stories:**

1. As an <actor>, I want a <feature>, so that <benefit>
2. ...

## User Stories (cross-cutting)

Any user stories that span multiple phases or don't belong to a single phase.

## Implementation Decisions

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it within the relevant decision and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

## Issues

A summary list of all issues derived from this PRD's phases. Updated when `/to-issue` creates the issue files.

| # | File | Phase | Summary |
|---|------|-------|---------|
| 1 | `02-issues/phase-1-<slug>.md` | Phase 1: <name> | One-line summary of what this issue delivers |
| 2 | `02-issues/phase-2-<slug>.md` | Phase 2: <name> | One-line summary of what this issue delivers |

## Out of Scope

A description of the things that are out of scope for this PRD.

## Further Notes

Any further notes about the feature.

</prd-template>
