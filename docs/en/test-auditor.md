# test-auditor

Assesses how well the existing tests of an area actually secure the relevant behavior. Substantiates this through execution, temporary probe tests and, in a named area, targeted mutation samples in production code. Leaves no permanent changes to project code or tests.

| | |
|---|---|
| Changes project code | only its own temporary changes; these are rolled back |
| Runs tests or builds | yes, where safe and local |
| Web access | no |
| Output | 1 assessment report with findings and test tasks |
| Status | `FINDINGS`, `NO_FINDINGS` or `BLOCKED` |

## When to use it?

- The tests of an area are green, but it is unclear whether they would actually notice errors.
- Before a restructuring, it should be clear how reliable the test safety net is.
- An area has hardly any tests, and concrete test tasks are needed.
- On request: a test strategy or E2E scenarios.

## What does the agent need?

An area: a feature, a module, an interface or a change. Optionally requirements or acceptance criteria that you explicitly name as the source of the expectation.

Without a named area, it assesses the test landscape as an overview, statically and by running the existing tests. It uses probe tests and mutations only in an explicitly named area.

It places mutations only in files that are versioned and locally unchanged. Without version control, it stays with static assessment, execution and probe tests.

## What does it deliver?

A report `agent-artifacts/test-auditor/test-<name>.md` with:

- the baseline: which tests run, fail or are unstable,
- findings, for example ineffective, weak or unstable tests and gaps, each with its kind of evidence,
- mutation results, explicitly named as a sample,
- test tasks that someone without knowledge of the run can implement,
- open questions where the expectation is not substantiated.

Test tasks come in two types. **Specification** secures substantiated expected behavior and names the source. **Characterization** records observed current behavior and explicitly makes no statement about correctness.

`NO_FINDINGS` applies only to the assessed scope and the means used. It is not a quality guarantee.

## Important limits

- Writes no permanent tests and no permanent code. Test tasks describe what a test should achieve, without finished test code.
- Does not change existing tests, not even temporarily.
- Every temporary change is in the journal beforehand and is rolled back. With version control, it then checks that the project state corresponds to the starting state.
- Invents no expectations. If the current behavior seems questionable, this becomes an open question, not a test that locks in a possible error.
- Reports defects it comes across but does not fix them.
- Selects no test runner and no tool. If test infrastructure is missing, that is an open decision.
- No external network, no installations, migrations or containers.

## Examples

```text
@test-auditor
Assess the tests for the invoice calculation in src/billing/.
```

```text
@test-auditor
Assess the tests for the invoice filter. Expected behavior:
agent-artifacts/requirements-engineer/invoice-filter/result-requirements-briefing.md
```

```text
@test-auditor
Get an overview of the test landscape of this project.
```

```text
@test-auditor
Assess the tests of the payment integration and propose a test strategy.
```

## Distinction from similar roles

- **Test auditor vs. reviewer:** The reviewer checks a change for defects. The test auditor checks whether the existing tests would notice errors at all.
- **Test auditor vs. developer:** The test auditor describes test tasks. They are implemented in a separate task, for example by the developer.
- **Test auditor vs. bug investigator:** The bug investigator clarifies a concrete error. The test auditor assesses the safety net of an entire area.

---

Full definition: [`agents/en/test-auditor.md`](../../agents/en/test-auditor.md)
