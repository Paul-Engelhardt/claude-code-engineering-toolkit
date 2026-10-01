# implementation-planner

Breaks an already decided intent, such as an architecture design, into small, ordered implementation steps with clear stop points. Designs nothing new and writes no code.

| | |
|---|---|
| Changes project code | no |
| Runs tests or builds | no |
| Web access | no |
| Output | 2 files per run |
| Status | `READY` or `BLOCKED` |

## When to use it

- A design or decision is settled and should be broken into reviewable steps.
- An older planning basis should be checked against the current code before implementation.

## What it needs

The planning basis: the intent to plan, in the task itself or as a file you explicitly name. No particular format is required. The file has to be inside the working directory.

If code already exists, the agent first checks whether the planning basis still fits the current state. For a new project it only checks whether the planning basis is internally consistent.

If the breakdown would require an open architecture, product or interface decision, or if the planning basis fundamentally no longer fits the code, it stops with `BLOCKED` and open questions instead of deciding itself.

## What it delivers

Two files in `agent-artifacts/implementation-planner/<run-id>/`:

| File | Content |
|---|---|
| `implementation-plan.md` | Status, comparison with the code, assumptions, ordered chunks |
| `open-questions.md` | Open points, assumptions and issues outside the plan |

Each chunk has a goal, scope, a verifiable completion criterion, dependencies, contracts to preserve and a stop point where you decide how to proceed.

If a change cannot be split cleanly, for example a signature change across many call sites, it is named as one block instead of being split artificially.

## Key limits

- No redesign. If a decision is missing, it stops.
- Problems in the code that are not part of the intent become open questions, not additional plan steps.
- No code in the plan. It describes the what and the boundaries, not the how.
- No effort estimates.

## Examples

```text
@implementation-planner
Plan the implementation of agent-artifacts/software-architect/invoice-v1/architecture-design.md.
```

```text
@implementation-planner
Plan the implementation: the invoice export should also deliver CSV.
The format is defined in docs/export-format.md.
```

```text
@implementation-planner
docs/payment-design.md is three months old. Plan the implementation and check it against the current code.
```

## How it differs from similar roles

- **Planner vs. architect:** The architect decides the direction. The planner turns a decided direction into steps and makes no new decisions.
- **Planner vs. developer:** The planner describes what needs to be done within which boundaries. The developer implements it.

---

Full definition: [`agents/en/implementation-planner.md`](../../agents/en/implementation-planner.md)
