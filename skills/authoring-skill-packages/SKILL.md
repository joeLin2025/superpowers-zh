---
name: authoring-skill-packages
description: Use when users request create skill, write SKILL.md, produce a skill specification, define skill folder layouts, design progressive disclosure templates, provide examples, list guardrails, or deliver a complete skill package with outputs limited to folder name + SKILL.md + optional directory plan.
---
# Skill Package Authoring Guide

## Purpose
- Deliver progressive disclosure friendly skill packages with predictable triggers and outputs
- Provide defaults so authors can proceed even when requirements are partial
- Guarantee that every SKILL.md is executable, testable, and bounded by safety rules

## When to use
- Trigger when the user mentions phrases such as create skill, write SKILL.md, skill spec, skill folder, skill package, progressive disclosure, template, examples, or guardrails
- Trigger when the deliverable explicitly requires both the skill folder name and the full SKILL.md text, optionally with supporting directories
- Not for installing skills, running scripts, debugging unrelated workflows, or handling confidential data dumps

## Inputs
- Required: stated goal or scope for the target skill; if unspecified, restate assumptions before proceeding
- Optional: drafts, terminology, formatting constraints, preferred languages, resource references
- Default assumptions: author replies in the same language as the request; no auxiliary directories unless justified; all resources remain self-contained unless paths were provided

## Outputs
- Folder name that matches the `name` in frontmatter
- Complete SKILL.md including YAML frontmatter and all required sections
- Optional `/scripts`, `/references`, `/assets` recommendations with a short explanation of what belongs in each
- Allowed side effect: create or overwrite skill files locally; prohibited actions include running unrequested commands, installing software, or accessing networks

## Procedure
1. **Requirement analysis**: extract objectives, constraints, and mandatory sections; if information is missing, declare explicit assumptions rather than pausing.
2. **Artifact planning**: choose a kebab-case name, collect 5-10 trigger keywords for the description, outline sections, and decide whether extra directories are necessary.
3. **Drafting**: write each SKILL.md section in order, ensuring bullets and numbering convey execution detail; cite any resource paths directly when referencing scripts or references.
4. **Verification**: confirm keywords cover likely prompts, ensure inputs and outputs close the loop, restate safety boundaries, and keep the document under 5000 tokens.
5. **Delivery**: present folder name + SKILL.md + optional directory notes; if files were written, note their paths; optionally suggest next steps such as testing or peer review.

## Guardrails & Safety
- Treat any sensitive or credential-like data as read-only context that must not persist beyond the current response
- Do not run external commands, network calls, or installers unless explicitly requested outside this skill
- If the user demands actions outside documentation (e.g., run CI, edit unrelated code), explain that the skill only covers documentation and refer them elsewhere
- When critical information is missing, state assumptions; if risk remains too high, request clarification before finalizing

## Examples
- **Minimal example**
  - Input: "Write a SKILL.md that explains how to draft release note templates"
  - Output: folder `generating-release-notes`, full SKILL.md, no extra directories because none were requested
- **Realistic example**
  - Input: "Need a skill that teaches multilingual FAQ creation with progressive disclosure, examples, and guardrails"
  - Output: description lists keywords such as multilingual, FAQ, template, examples, guardrails; sections cover purpose through trigger optimization; optional `/references` suggested for language style sheets
- **Failure/boundary example**
  - Input: "Install a remote skill repo and run its tests"
  - Handling: respond that this skill only documents new skills and cannot install or execute code; direct the user to skill-installer or another workflow

## Testing checklist
- Description includes at least the core trigger keywords: create skill, write SKILL.md, skill spec, skill folder, skill package, progressive disclosure, template, examples, guardrails
- Procedure steps cover the full path from requirements to delivery without ambiguities or missing transitions
- Inputs and outputs align; defaults are stated wherever the user might omit data
- Guardrails clearly forbid non-documentation actions and outline assumption handling
- Total length stays below 5000 tokens; if it exceeds, split into narrower skills

## Quality bar
- Structure follows the mandated headings and uses concise bullets or numbered steps
- Every instruction is testable or reviewable; avoid anecdotes or vague wording
- Keywords, boundaries, and optional directory advice stay decoupled from any single project so the skill is reusable
- Examples plus the testing checklist enable another agent to verify triggering, execution, and safety without guesswork

## Trigger optimization
- Keep the frontmatter description focused on user intents and deliverables, never on the internal workflow
- Repeat critical vocabulary (SKILL.md, skill package, progressive disclosure, template, examples, guardrails) in the body to reinforce discovery
- Prefer action-oriented names (gerunds) for better searchability
- When external resources are required, spell out exact relative paths and uses so agents only load what they need
- Revisit the keyword list whenever new user phrasing appears, ensuring future triggers remain accurate
