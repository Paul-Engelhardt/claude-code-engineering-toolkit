# software-architect

Designs a technical direction for a new system, module, feature or refactoring. Delivers a deliberately rough design with the key decisions, risks and open questions, not a full specification.

| | |
|---|---|
| Changes project code | no |
| Runs tests or builds | no |
| Web access | no |
| Output | 4 files per run |
| Status | `BLOCKED` if the intent is not sufficient for a design |

## When to use it

- A new project is to be built from scratch.
- A feature, module or refactoring should fit cleanly into existing code.
- The key decisions and open questions should be visible before building starts.

The agent determines from the repository itself whether it is dealing with a new or an existing project.

## What it needs

A stated intent: what should be built or changed, why, and which hard constraints apply. This can be in the task itself or in files you explicitly name as the briefing. Files you name as context only provide background, not intent.

For a new project, the task text is often enough.

**The gate:** Before designing anything, the agent checks whether the intent is sufficient without guessing. If something is missing that would fundamentally change the design, it produces no design but a `BLOCKED` result with the questions that need answers first. Smaller gaps are bridged with explicitly stated assumptions.

## What it delivers

Four files in `agent-artifacts/software-architect/<run-id>/`:

| File | Content |
|---|---|
| `architecture-design.md` | Classification, assumptions, rough design, what is deliberately not built, deferred decisions, ADRs, rough implementation order |
| `risks.md` | Evidence-backed risks that do not belong to a single decision |
| `open-questions.md` | Open questions and all assumptions made |
| `claude-draft.md` | Proposal for a `CLAUDE.md`, or only the necessary changes if a `CLAUDE.md` already exists |

The agent never touches the real `CLAUDE.md`. The different file name keeps Claude Code from loading the proposal automatically.

A `BLOCKED` run also writes all four files, with the reasoning instead of a design.

## Key limits

- Does not change project code and runs no tests or project scripts.
- Prefers the simplest solution that meets the known requirements. No layers or dependencies just in case.
- Does not optimize for quality goals you have not stated.
- Does not silently break existing interfaces or data formats. It names the break and a transition path.
- No effort estimates, not even as small, medium or large.

## Examples

```text
@software-architect
New CLI tool that validates invoice CSVs and reports errors per line.
Must run offline.
```

```text
@software-architect
Design the new export module. Briefing: docs/export-initiative.md.
Use the latest inspector report as context:
agent-artifacts/codebase-inspector/20260910-101500/architecture-audit.md
```

```text
@software-architect
Use agent-artifacts/requirements-engineer/invoice-stabilization/result-requirements-briefing.md
as the briefing. Run name: invoice-v1.
```

## How it differs from similar roles

- **Architect vs. inspector:** The inspector describes the existing state. The architect designs what should be and reads existing code only as far as the design requires.
- **Architect vs. planner:** The architect decides the direction. The planner breaks a decided direction into implementable steps.
- **Architect vs. researcher:** The researcher answers external technology questions with sources. The architect has no web access and works with what is backed by evidence or given.

---

Full definition: [`agents/en/software-architect.md`](../../agents/en/software-architect.md)
