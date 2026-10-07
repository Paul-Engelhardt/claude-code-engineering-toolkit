# bug-investigator

Investigates a concretely observed misbehavior, looks for the cause and fixes the defect with minimal intervention if expected behavior and cause are sufficiently substantiated. A reliable diagnosis without a fix is also a valid result.

| | |
|---|---|
| Changes project code | yes; permanently only a substantiated fix, with a regression test where a stable one is feasible |
| Runs tests or builds | yes, where safe and local |
| Web access | no |
| Output | 1 investigation report, fix in the working tree if needed |
| Status | `FIXED`, `DIAGNOSED`, `NO_DEFECT`, `INCONCLUSIVE` or `BLOCKED` |

## When to use it?

- A concrete misbehavior with an unclear cause: an exception, a wrong value, a failing test, a hang, sporadic behavior.
- When not only the cause but also a minimal, substantiated fix is wanted.
- When it is unclear whether the reported behavior is an error at all.

## What does the agent need?

A description of the misbehavior: what happens, where and under which conditions. Error messages, logs or a failing test help. A particular format is not necessary.

What the correct behavior is, is determined by the task or a directive that you explicitly name. Code, tests and docs count as evidence, not automatically as a requirement.

If the investigation needs a local environment, for example a running application or database, it must be available. The agent starts nothing itself and uses the environment only if it is clear that it is not production.

## What does it deliver?

A report `agent-artifacts/bug-investigator/bug-<name>.md` with expected behavior, reproduction, diagnosis with checked hypotheses, change journal, validation, incidental findings and limits.

In addition to the overall status, it states a reproduction status: `REPRODUCED`, `PARTIALLY_REPRODUCED`, `NOT_REPRODUCED` or `NOT_ATTEMPTED`.

| Status | Meaning |
|---|---|
| `FIXED` | Substantiated defect, fixed locally. No approval for merge or deployment. |
| `DIAGNOSED` | Cause substantiated, but deliberately no fix, for example because a product or contract decision is missing |
| `NO_DEFECT` | The reported behavior corresponds to the substantiated expected behavior |
| `INCONCLUSIVE` | Investigated, but the evidence is not sufficient for a reliable diagnosis |
| `BLOCKED` | A concrete prerequisite is missing |

With `FIXED`, the fix remains in the working tree, with a regression test where a stable one is feasible. Pure diagnostic changes such as logging or test variants are rolled back before completion based on its journal.

## Important limits

- No fix without substantiated expected behavior and substantiated cause. Better `INCONCLUSIVE` than a plausible story.
- Makes no product, architecture or contract decisions and introduces no new dependency unless this is explicitly authorized.
- Changes an existing test expectation only if the expectation is authorized, and justifies every change in the report.
- Reports incidental findings but does not fix them.
- Every change is in the journal before it is carried out. Changes that do not originate from it remain untouched.
- Local checks only if they are safe. No external network, no installations, migrations, containers or server starts.
- No web access. If the diagnosis depends on an external system, it formulates an external verification question instead of answering from prior knowledge.

## Examples

```text
@bug-investigator
The export with an empty date filter aborts with an error. Stack trace: logs/export-error.txt.
```

```text
@bug-investigator
tests/test_invoice_totals.py has been failing since the last change. Find the cause.
```

```text
@bug-investigator
Invoices with a discount show a total that is off by one cent.
Rounding per line item is expected according to docs/rounding-rules.md (binding directive).
Name: discount-rounding.
```

## Distinction from similar roles

- **Bug investigator vs. developer:** The developer implements a decided task. The bug investigator starts from a symptom with an unknown cause and leaves only a substantiated fix.
- **Bug investigator vs. reviewer:** The reviewer checks a change and repairs nothing. The bug investigator traces a concrete misbehavior to its cause and may fix it.
- **Bug investigator vs. test auditor:** The test auditor assesses how well tests secure an area. The bug investigator clarifies a concrete error.

---

Full definition: [`agents/en/bug-investigator.md`](../../agents/en/bug-investigator.md)
