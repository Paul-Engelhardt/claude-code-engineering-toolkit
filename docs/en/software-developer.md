# software-developer

Implements a clearly scoped, already decided task with the smallest possible intervention. Fits into existing conventions and creates neither new scope nor new architecture.

| | |
|---|---|
| Changes project code | yes, within the task |
| Runs tests or builds | local checks of its own change |
| Web access | no |
| Output | change in the project, report in the chat, backups if needed |

## When to use it?

- The what is decided, all that remains is a clean implementation.
- A chunk from an implementation plan should be implemented.
- A small, clearly delimited change including suitable tests.

## What does the agent need?

A clear task, directly in the invocation or as a file that you explicitly name. It reads the necessary project context such as code, conventions and tests itself.

If you hand over a plan, it stops at the plan's stop points.

Existing local changes in the task area are its starting state, not a directive. It may develop them further or replace them, unless the task requires keeping the existing approach.

## What does it deliver?

The change in the working directory and a short report:

- what was built and which files were touched,
- which existing work in the task area it substantially replaced,
- whether and where backups were created,
- which checks ran and which did not,
- assumptions made,
- problems it noticed but deliberately did not touch.

**Backups:** Before it changes or deletes an existing file for the first time whose content cannot be restored from version control, it stores a copy under `agent-artifacts/software-developer/<name>/`, with the suffix `.bak` appended, for example `src/foo.py.bak`. To restore it, copy it back and remove the suffix. If no name is provided, the current date is used. It does not overwrite existing backups. If several invocations run under the same name or on the same day, this preserves the state before the first intervention. Changes you make afterwards to files that were already backed up are not backed up again. The backups are intended to help you restore files. It does not restore anything from them itself. You should exclude the folder `agent-artifacts/software-developer/` from version control.

Apart from the backups, the developer writes nothing under `agent-artifacts/`. It does not commit.

## Important limits

- Minimal diff. No unrequested refactorings, cleanups or modernizations.
- No speculative abstractions or dependencies.
- Existing tests are not weakened just so that the change passes.
- If the task contradicts the code or would break an existing interface, it stops and reports instead of re-deciding on its own.
- It does not discard or overwrite existing changes outside the task area.
- Local checks such as compilers, typechecks, linters and unit tests only if they run without forbidden side effects. Network, installations, deployments, executed migrations and containers are excluded.
- It writes or changes migration definitions if they are explicitly requested or a requested change to the persistent data model would be incomplete without them. Deployment or container files only on explicit request. It never executes either.

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
Add the column cancelled_at to the invoice table, including migration.
```

## Distinction from similar roles

- **Developer vs. planner:** The planner breaks down and orders. The developer implements.
- **Developer vs. reviewer:** The developer changes code and checks its own change. The reviewer checks independently and repairs nothing.
- **Developer vs. bug investigator:** The developer implements a decided task. The bug investigator starts from a misbehavior with an unknown cause and fixes only what is substantiated.

---

Full definition: [`agents/en/software-developer.md`](../../agents/en/software-developer.md)
