# requirements-engineer

Turns a rough idea or change request into a reviewable set of requirements. Keeps a strict separation between what has been requested, what is still open and what is only its own suggestion.

| | |
|---|---|
| Changes project code | no |
| Runs tests or builds | no (no shell) |
| Web access | no |
| Output | 3 files per initiative, can be continued |
| Status | `READY` or `NEEDS_INPUT` |

## When to use it

- An idea is still vague, even with no code at all.
- A change request should be clarified properly before architecture or implementation.
- An initiative should be clarified over several rounds by answering open questions.

## What it needs

Your description of the initiative. Optionally an initiative ID, otherwise it picks one itself.

It only uses other files if you name them. You can say what role they play, for example requirements source, hard constraint or context only. A technical finding from a report does not automatically become a requirement this way.

## What it delivers

Three files in `agent-artifacts/requirements-engineer/<initiative-id>/`:

| File | Content |
|---|---|
| `result-requirements-briefing.md` | Goal, scope, requirements (`REQ`), constraints, acceptance criteria (`AC`), status |
| `result-requirements-open-questions.md` | Open questions (`Q`) whose answers change goal or scope, plus questions already resolved |
| `result-requirements-suggestions.md` | Its own suggestions (`SUG`), explicitly not part of the scope until you adopt them |

`READY` means goal, scope and constraints are clear enough. `NEEDS_INPUT` means at least one question still decides the direction. An honest `NEEDS_INPUT` is intended and better than a `READY` with invented details.

IDs stay stable across continuations, so you can refer to them directly in your answers.

## Key limits

- Describes desired behavior, not a technical solution and not an architecture.
- Does not invent requirements such as scalability, multi-tenancy or performance targets unless you state them.
- No effort estimates, no scores, no prioritization schemes.
- Only asks questions that change the direction. No questionnaire.
- If an automatically chosen initiative ID already exists, it asks instead of overwriting anything.

## Examples

```text
@requirements-engineer
Customers should be able to filter invoices by status and date range.
Initiative ID: invoice-filter.
```

```text
@requirements-engineer
New initiative invoice-stabilization.
docs/customer-email.md is the requirements source, the latest inspector report is context only:
agent-artifacts/codebase-inspector/20260910-101500/architecture-audit.md
```

```text
@requirements-engineer
For invoice-stabilization: our answer to Q-001 is "finalized invoices only".
We adopt SUG-002, not SUG-003.
```

```text
@requirements-engineer
Let's continue with invoice-stabilization. Also take customer-answers.md into account.
```

```text
@requirements-engineer
Restart invoice-stabilization.
```

## How it differs from similar roles

- **Requirements engineer vs. architect:** The requirements engineer clarifies what is needed. The architect designs how it is built technically.
- **Requirements engineer vs. researcher:** The requirements engineer clarifies intent and scope. The researcher answers technical questions using external sources.

---

Full definition: [`agents/en/requirements-engineer.md`](../../agents/en/requirements-engineer.md)
