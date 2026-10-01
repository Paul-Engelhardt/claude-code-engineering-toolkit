# codebase-inspector

Analyzes an existing codebase read-only and documents its actual state. Every statement is backed by the code. Anything that cannot be backed is reported as not determined.

| | |
|---|---|
| Changes project code | no |
| Runs tests or builds | no |
| Web access | no |
| Output | 3 report files per run |

## When to use it

- Getting into an unfamiliar or older codebase
- Taking stock before a larger rework
- Technical triage: which debt should be tackled first?

The reason for the analysis does not change its scope.

## What it needs

The repository as the working directory. Nothing else.

Optional: a run name. It only uses earlier inspector runs if the task explicitly names them for comparison.

## What it delivers

Three files in `agent-artifacts/codebase-inspector/<run-id>/`:

| File | Content |
|---|---|
| `architecture-audit.md` | "Start here" reading map, structure, data and control flows, findings, testability, prioritized debt, reduction candidates |
| `security-findings.md` | Security findings with severity and confidence. Explicitly not a compliance statement. |
| `open-questions.md` | What cannot be resolved from the code alone |

Each finding states its location, impact, confidence and a sensible next step. Debt is prioritized in words, without a score.

## Key limits

- Reads only inside the working directory and changes nothing in the code.
- Runs no tests, builds or project scripts. Testability is assessed statically.
- No network. It only judges whether dependencies are outdated or vulnerable if the project itself contains evidence for it.
- Numbers only when measured. No health score.
- Does not recommend a rewrite unless the architecture is demonstrably broken at its core.

## Examples

```text
@codebase-inspector
Analyze this repository.
```

```text
@codebase-inspector
Analyze this repository. Run name: before-refactoring.
```

```text
@codebase-inspector
Analyze the repository again, run name: after-refactoring.
Compare with agent-artifacts/codebase-inspector/before-refactoring/architecture-audit.md.
```

## How it differs from similar roles

- **Inspector vs. reviewer:** The inspector analyzes the existing state of the system. The reviewer examines a specific change for defects.
- **Inspector vs. architect:** The inspector describes what is. The architect designs what should be.

---

Full definition: [`agents/en/codebase-inspector.md`](../../agents/en/codebase-inspector.md)
