# technical-researcher

Researches clearly scoped technical questions using project context and external sources. Delivers an evidence-based basis for a decision, with a reasoned recommendation where the evidence supports it. The decision itself stays with a human.

| | |
|---|---|
| Changes project code | no |
| Runs tests or builds | only side-effect-free local checks |
| Web access | yes, read-only |
| Output | 1 research report |
| Status | `RESEARCHED` or `BLOCKED` |

## When to use it

- **Verification:** Is a specific claim about an API, a limit or a behavior true?
- **Exploration:** Which practical approaches exist for a problem?
- **Comparison:** Which of several specific options fits the requirements better?
- **Make-or-buy:** Build it yourself, open source, SaaS or a mix?

## What it needs

A specific question. Requirements, hard constraints, known candidates and exclusions help.

It reads project files if you name them or if the question directly concerns the state of the project. It does not invent missing information. It researches what it can and states what could still change the result.

## What it delivers

A report `agent-artifacts/technical-researcher/research-<name>.md` with the research question, findings, options, comparison and recommendation where relevant, open points and sources with retrieval date.

Every important statement carries an evidence status: Documented, Verified locally, Derived, Assumption or Not verified / unknown. Anything that can only be settled in practice, for example in a vendor sandbox, is listed under validation needed before decision.

`RESEARCHED` means there is a usable result. It does not mean everything was verified in practice or decided.

## Key limits

- External sources are read-only. No accounts, trials, logins, purchases or uploads of project data.
- Its own prior knowledge about versions, prices or limits only counts as evidence once a current source confirms it.
- No invented assumptions about team, budget, deadlines or growth. No scores without given weightings.
- Local checks only without side effects. No installations and no self-written test programs.
- It recommends, but does not decide.

## Examples

```text
@technical-researcher
Does payment provider X retry failed webhooks automatically, and if so, how often?
```

```text
@technical-researcher
What approaches exist for generating PDF invoices on the server? Must work without an external service.
```

```text
@technical-researcher
Compare library A and B for streaming CSV parsing.
Take into account the version of A installed in the project.
```

```text
@technical-researcher
Make-or-buy for full-text search in the invoice management.
Context: agent-artifacts/software-architect/invoice-v1/open-questions.md
```

## How it differs from similar roles

- **Researcher vs. architect:** The researcher answers external technology questions and can give a conditional recommendation. The architect turns that into a design if you pass the result on as input.
- **Researcher vs. requirements engineer:** The researcher clarifies technical facts. The requirements engineer clarifies what is needed.

---

Full definition: [`agents/en/technical-researcher.md`](../../agents/en/technical-researcher.md)
