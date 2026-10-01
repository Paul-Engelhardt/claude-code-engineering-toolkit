# software-developer

Implements a clearly scoped, already decided task with the smallest reasonable change. Fits into existing conventions and creates neither new scope nor new architecture.

| | |
|---|---|
| Changes project code | yes, within the task |
| Runs tests or builds | local checks of its own change |
| Web access | no |
| Output | change in the project, report in the chat |

## When to use it

- The what is settled and only a clean implementation is needed.
- A chunk from an implementation plan should be implemented.
- A small, clearly scoped change including matching tests.

## What it needs

A clear task, directly in the prompt or as a file you explicitly name. It reads the project context it needs, such as code, conventions and tests, on its own.

If you hand it a plan, it stops at the plan's stop points.

## What it delivers

The change in the working directory and a short report:

- what was built and which files were touched,
- which checks ran and which did not,
- assumptions made,
- problems it noticed but deliberately left alone.

The developer writes no artifacts to `agent-artifacts/` and does not commit.

## Key limits

- Minimal diff. No unrequested refactoring, cleanup or modernization.
- No abstractions or dependencies just in case.
- Existing tests are not weakened just to make the change pass.
- If the task contradicts the code or would break an existing interface, it stops and reports instead of changing course on its own.
- Local checks such as compilers, type checks, linters and unit tests only if they run without forbidden side effects. Network access, installations, deployments, running migrations and containers are excluded.
- It writes migrations when the task requires a data model change. Deployment or container files only when explicitly requested. It never runs either.

## Examples

```text
@software-developer
Add a status filter to the invoice list.
```

```text
@software-developer
Implement agent-artifacts/implementation-planner/20260915-103000/implementation-plan.md.
```

```text
@software-developer
Add the column cancelled_at to the invoice table, including the migration.
```

## How it differs from similar roles

- **Developer vs. planner:** The planner breaks down and orders the work. The developer implements it.
- **Developer vs. reviewer:** The developer changes code and checks its own change. The reviewer checks independently and fixes nothing.

---

Full definition: [`agents/en/software-developer.md`](../../agents/en/software-developer.md)
