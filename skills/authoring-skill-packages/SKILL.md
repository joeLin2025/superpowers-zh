---
name: authoring-skill-packages
description: "Use when users request create skill, write SKILL.md, produce a skill specification, define skill folder layouts, or provide examples/guardrails for new skills."
---
# Authoring Skill Packages

## Overview
**Standardizes the creation of new skills to ensure they are executable, testable, and safe.**

This skill defines the strict schema and workflow for generating `SKILL.md` files and their containing folders, ensuring all new skills meet the project's quality bar.

## When to Use
- User asks to "create a skill" or "write a SKILL.md"
- User provides a skill specification or requirements
- User asks for "progressive disclosure templates" or "skill guardrails"
- You need to structure a new capability for future reuse

**Do NOT use for:**
- Installing external skills (use a skill-installer if available)
- Running arbitrary scripts
- Debugging existing skills (unless rewriting them)

## Core Pattern: The Standard Skill Structure

Every skill package MUST follow this layout:

```text
skill-name-kebab-case/
  SKILL.md              # The single source of truth
  scripts/              # Optional: helper scripts
  templates/            # Optional: reusable templates
```

## SKILL.md Specification

The `SKILL.md` file MUST adhere to this structure:

| Section | Content Requirement |
|---------|---------------------|
| **Frontmatter** | Valid YAML. `name` (kebab-case) and `description` (double-quoted "Use when..." trigger). |
| **Overview** | 1-2 sentences defining the core principle. |
| **When to Use** | Bullet points of symptoms/triggers. Explicit "When NOT to use". |
| **Procedure** | Step-by-step logic, "Core Pattern", or "TDD Mapping". |
| **Examples** | At least one concrete, runnable example. |
| **Guardrails** | Safety checks, strict prohibitions, and "Red Flags". |

## Procedure

1.  **Analyze Requirements**: Identify the goal, triggers ("When to use"), and safety constraints.
2.  **Select Name**: Use `kebab-case` (e.g., `writing-skills`, not `SkillWriting`).
3.  **Draft Content**:
    *   Write the **YAML frontmatter** first. Ensure `description` focuses on *triggers*, not *process*.
    *   Write the **Overview** and **When to Use** sections to lock in scope.
    *   Define the **Procedure/Core Pattern**.
    *   Add **Guardrails** and **Examples**.
4.  **Verify**: Check against the **Quality Bar** (below).
5.  **Output**: Present the folder name and the full `SKILL.md` content.

## Common Mistakes

| Mistake | Correction |
|---------|------------|
| **Broken YAML** | Always use double quotes for `description` to handle colons/special chars safely. |
| **Workflow Description** | Description should match *symptoms* ("Use when tests fail"), not *steps* ("Use to run tests"). |
| **Vague Steps** | Instructions must be verifiable. "Improve code" -> "Refactor using pattern X". |
| **Missing Context** | Assumptions must be explicit. If a tool is needed, list it in requirements. |
| **Narrative Fluff** | Avoid "This skill helps you...". Use imperative "Use when...". |

## Quality Bar & Red Flags

**STOP and Refine if:**
- [ ] Description describes *what it does* instead of *when to use it*.
- [ ] Name contains spaces or special characters.
- [ ] Instructions rely on user interpretation ("do what makes sense").
- [ ] No "When NOT to use" section.
- [ ] Example is missing or generic.

## Example Artifact

**Input:** "Create a skill for generating git commit messages."

**Output:**
Folder: `generating-commit-messages`

File: `SKILL.md`
```markdown
---
name: generating-commit-messages
description: "Use when users ask to commit changes, stage files, or write commit messages for a set of changes."
---
# Generating Commit Messages

## Overview
Generates semantic, conventional commit messages based on staged changes.

## When to Use
- User asks to "commit" or "save changes"
- You need to summarize work for the log

## Procedure
1. Run `git diff --staged` to see changes.
2. Analyze the nature of changes (feat, fix, refactor, docs).
3. Draft a message following Conventional Commits (`type(scope): description`).

## Examples
**Diff:** `modified: src/app.ts` (added logging)
**Message:** `feat(core): add debug logging to startup sequence`
```
