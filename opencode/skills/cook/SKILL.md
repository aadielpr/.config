---
name: cook
description: Execute a plan by reading a PRD and its issues, then implementing them in dependency order. Use when user sends the "/cook" command.
---

# Execute Plan

Read a PRD and its associated issue files, then implement them end-to-end in dependency order.

## Input

The user may provide:
- A path to a PRD folder: `docs/prd/<kebab-case-title>/`
- A path to a specific issue: `docs/prd/<kebab-case-title>/02-issues/phase-N-<slug>.md`
- Nothing — in which case, discover the most recent PRD folder under `docs/prd/`.

## Process

### 1. Discover and read

Read the PRD (`01-prd.md`) and all issue files (`02-issues/*.md`). If a `CONTEXT.md` exists in the project root or nearby, read that too for domain glossary and ADRs. Build a dependency graph from the **Blocked by** sections. Identify the execution order (topological sort — blockers first).

### 2. Confirm scope with user

Present the execution plan:

```
Found N issues in <prd-title>:
1. phase-1-auth — no blockers
2. phase-2-api — blocked by #1
...

Start with issue #1?
```

Wait for user confirmation before writing code.

### 3. Grill before executing (conditional)

Before writing code for an issue, assess clarity:

- Are acceptance criteria precise and testable?
- Do terms match the codebase glossary (`CONTEXT.md`)?
- Are edge cases addressed?
- Is the scope clear (no overlapping responsibilities with other issues)?

If underspecified — load and execute the **grill-with-docs** skill. Grill the user one question at a time, resolving the issue's ambiguities and documenting decisions as they crystallize. Continue until both agent and user are satisfied with the shared understanding. Then proceed to implementation.

### 4. Execute issues in order

For each issue:

#### 4a. Read the issue file
Note its acceptance criteria, what to build, and any blockers.

#### 4b. Explore relevant code
Understand the current state of the codebase in the area being touched. Respect ADRs and domain glossary from `CONTEXT.md`.

#### 4c. Implement the vertical slice
Write the minimal code to satisfy the issue's **What to build** and **Acceptance criteria**. A vertical slice means touching every layer needed (schema, API, UI, tests) — but only what's required for this narrow slice.

Follow existing code style. Do not refactor unrelated code.

#### 4d. Verify
Run relevant tests. If the acceptance criteria mention specific behavior, verify it works. If tests fail, fix before proceeding.

#### 4e. Update the issue file
Append a progress section or check off acceptance criteria:

```markdown
## Progress

- [x] Acceptance criterion 1 — verified by <test-name>
- [x] Acceptance criterion 2 — verified manually
- [ ] Acceptance criterion 3 — pending
```

#### 4f. Report to user
Summarize what was done, what tests passed, and what the next issue is. Ask whether to continue to the next issue or stop.

### 5. Completion

When all issues are done, update the PRD's **Issues** table to mark all rows complete. Summarize the overall changes for the user.

## Rules

- **Never skip blockers.** If issue B is blocked by A, do not start B until A is fully done and verified.
- **One slice at a time.** Finish an issue completely before starting the next.
- **Minimal changes.** Only touch code related to the current issue. Don't refactor adjacent areas.
- **Verify continuously.** Run tests after each meaningful change. Don't batch 10 changes then test.
- **Preserve issue files.** Do not delete issue files after completing them. Update them in place.
