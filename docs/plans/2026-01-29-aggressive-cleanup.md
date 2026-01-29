# Aggressive Cleanup Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers-zh:executing-plans to implement this plan task-by-task.

**Goal:** Clean up the project by removing temporary artifacts, obsolete documentation, and example projects, while preserving platform guides (.codex, .opencode).

**Architecture:** Standard file deletion operations targeting specific directories identified as clutter.

**Tech Stack:** Shell (PowerShell/Bash)

---

### Task 1: Clean up `skills/systematic-debugging`

**Files:**
- Remove: `skills/systematic-debugging/test-pressure-*.md`
- Remove: `skills/systematic-debugging/test-academic.md`
- Remove: `skills/systematic-debugging/CREATION-LOG.md`
- Remove: `skills/systematic-debugging/find-polluter.sh` (Assuming this is a helper script not part of the core skill definition)
- Remove: `skills/systematic-debugging/condition-based-waiting-example.ts` (Example code)

**Step 1: List files to verify targets**

Run: `ls skills/systematic-debugging`
Expected: Should see the files to be deleted.

**Step 2: Remove the files**

Run: `rm skills/systematic-debugging/test-pressure-*.md skills/systematic-debugging/test-academic.md skills/systematic-debugging/CREATION-LOG.md skills/systematic-debugging/find-polluter.sh skills/systematic-debugging/condition-based-waiting-example.ts`

**Step 3: Verify removal**

Run: `ls skills/systematic-debugging`
Expected: Should ONLY contain `SKILL.md`, `root-cause-tracing.md`, `defense-in-depth.md`, `condition-based-waiting.md`.

**Step 4: Commit**

```bash
git add skills/systematic-debugging
git commit -m "chore: remove temporary artifacts from systematic-debugging skill"
```

---

### Task 2: Clean up `docs/plans`

**Files:**
- Remove: `docs/plans/2025-11-22-opencode-support-design.md`
- Remove: `docs/plans/2025-11-22-opencode-support-implementation.md`
- Remove: `docs/plans/2025-11-28-skills-improvements-from-user-feedback.md`

**Step 1: List files to verify targets**

Run: `ls docs/plans`

**Step 2: Remove the files**

Run: `rm docs/plans/*.md`

**Step 3: Verify removal**

Run: `ls docs/plans`
Expected: Directory should be empty (or contain only this plan).

**Step 4: Commit**

```bash
git add docs/plans
git commit -m "chore: remove obsolete planning documents"
```

---

### Task 3: Clean up `tests/subagent-driven-dev`

**Files:**
- Remove Directory: `tests/subagent-driven-dev/go-fractals`
- Remove Directory: `tests/subagent-driven-dev/svelte-todo`

**Step 1: List files to verify targets**

Run: `ls tests/subagent-driven-dev`

**Step 2: Remove the directories**

Run: `rm -r tests/subagent-driven-dev/go-fractals tests/subagent-driven-dev/svelte-todo`

**Step 3: Verify removal**

Run: `ls tests/subagent-driven-dev`
Expected: Should ONLY contain `run-test.sh` (or other core test scripts).

**Step 4: Commit**

```bash
git add tests/subagent-driven-dev
git commit -m "chore: remove generated example projects from tests"
```
