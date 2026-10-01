# code-reviewer

Independently checks a specific change or a named state of the code for defects, regressions, security issues and relevant test gaps. Fixes nothing, but backs up what it finds with evidence.

| | |
|---|---|
| Changes project code | no |
| Runs tests or builds | yes, where safe and local |
| Web access | no |
| Output | 1 review report |
| Status | `FINDINGS`, `NO_FINDINGS` or `BLOCKED` |

## When to use it

- After a change, before it is accepted.
- Against specific review criteria, such as a plan chunk or acceptance criteria.
- For a local prototype, when the whole state should be checked.

## What it needs

A **subject**: local changes, a comparison against a branch or revision, a patch file, named files or explicitly the entire project. Version control is not required.

Optionally **review criteria**. With review criteria it also checks whether what was required has been implemented. Without them it does not assess completeness and says so in the report.

It does not take claims such as "tests are green" at face value.

## What it delivers

A report `agent-artifacts/code-reviewer/review-<name>.md` with:

- status, scope of the review and the checks that were run,
- findings with severity (`BLOCKER`, `ISSUE`, `NOTE`), evidence, impact and a possible direction for a fix,
- observations that are not backed as defects.

`NO_FINDINGS` only means nothing specific was found within the reviewed scope. It does not mean the code is correct or approved.

`BLOCKED` only happens when no subject can be determined. Missing review criteria are never a reason for it.

## Key limits

- The reviewer does not change project code. A failing test is reported, not fixed.
- Local tests, type checks, linters and builds are only allowed if they can run safely and without forbidden side effects. Network access, installations, migrations and containers remain excluded.
- Matters of taste are not findings. Every finding needs a concrete impact.
- No architecture or quality audit, not even for a whole prototype.

## Examples

```text
@code-reviewer
Review the local changes.
```

```text
@code-reviewer
Review the local changes against chunk 2 of
agent-artifacts/implementation-planner/20260915-103000/implementation-plan.md.
```

```text
@code-reviewer
Review the current state against main.
```

```text
@code-reviewer
Review the entire project, it is a local prototype.
```

## How it differs from similar roles

- **Reviewer vs. inspector:** The reviewer examines a specific change for defects. The inspector analyzes the existing state of the system.
- **Reviewer vs. developer:** The reviewer finds and documents problems. Fixing them is a new task.

---

Full definition: [`agents/en/code-reviewer.md`](../../agents/en/code-reviewer.md)
