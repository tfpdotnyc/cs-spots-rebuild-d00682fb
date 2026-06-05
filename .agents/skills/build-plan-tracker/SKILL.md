---
name: build-plan-tracker
description: Create and maintain a human-readable, QA-ready BUILD_PLAN.md inside the project repo to track every phase of a multi-stage build. Trigger when the user says "create a build plan", "track this build", "skillify the build plan", "add breadcrumbs for QA", or asks for a living plan artifact backed up to GitHub.
---

# Build Plan Tracker

Produce and keep current a single in-repo markdown artifact (`docs/<project>/BUILD_PLAN.md`) that serves as the human QA checklist and audit trail for a multi-phase build. Because the file lives in the project, it auto-syncs to GitHub via Lovable's GitHub integration — no separate backup needed.

## When to invoke

- User asks for a build plan, roadmap document, QA checklist, or "breadcrumbs to follow".
- A multi-phase project needs visible progress tracking across sessions.
- User wants the plan committed to GitHub.

## Locked format rules

1. **Path:** `docs/<project-slug>/BUILD_PLAN.md`. One file per project.
2. **Title block:** `# <Project> — Build Plan`, then `Version: X.Y.Z`, then `Last Updated: YYYY-MM-DD`.
3. **Versioning (semver):**
   - patch — any status/checkbox change.
   - minor — add/remove a phase or item.
   - major — restructure (rename phases, change format).
4. **Legend line** directly after the title block defining `Status`, `Owner`, and the `[dep]` / `[del]` tags.
5. **Phases:** one `## Phase N — <Name>` per phase, ordered by **system-group**: Data Model → Migration → Storage → Sync → UI → Ops. Skip groups that don't apply.
6. **Items within a phase:** every item is a checkbox. Sort `[dep]` (dependency-linked) items first, `[del]` (deliverable) items last. Within each tag, keep authoring order.
7. **Item line format:**
   `- [ ] **[dep|del]** <Title> · Owner: <Lovable|User|Both> · Status: <todo|in-progress|done|blocked> · QA: <one-line visual check>`
8. **No header/footer crosslinks.** No nav, no "back to index", no breadcrumbs in the doc — the doc *is* the breadcrumb.
9. **Audit Trail:** final `## Audit Trail` H2 listing every executed step with `YYYY-MM-DD — <action>. Outcome: <result>.` Append-only.

## Authoring procedure

1. **Seed the audit trail.** Use `chat_search--search_chat_history` and `chat_search--recall_chat_history` to recover executed steps. Convert each to a single dated line with an outcome.
2. **Draft phases.** Group todo items by system-group; tag each `[dep]` or `[del]`; sort dep-first, del-last; add a one-line QA check that a non-technical reviewer could perform.
3. **Write the file** with `code--write` to `docs/<slug>/BUILD_PLAN.md`.
4. **Confirm GitHub sync.** If the project is not connected to GitHub, tell the user to use the Plus (+) → GitHub flow so the artifact backs up automatically.

## Update protocol

- On every status change: rewrite the file, bump **patch** version, update `Last Updated`, append a new Audit Trail line.
- On adding/removing a phase or item: bump **minor**.
- On structural changes: bump **major**.
- Never delete Audit Trail entries — only append.

## Template

See `references/template.md` for a copy-ready skeleton.
