# Claude Code Engineering Toolkit

[Deutsche Version](README.de.md)

Focused Claude Code agents for software engineering workflows with clear responsibilities, bounded authority and deliberately controlled handoffs.

The toolkit is for people who want to use AI assistance in software projects without handing control over scope, decisions, context and handoffs to autonomous agents or orchestrators.

Each agent takes on a clearly delimited role. The agents do not start each other. In the intended flow, a human decides which agent works, which information counts as input and when a result is used further.

## Why this toolkit?

Agentic workflows are currently moving toward more autonomy. An orchestrator breaks down the task, starts further agents and passes context between them. For tasks that break down well, this can be very powerful.

But every automatic handoff is also a point where something can shift. Context can be summarized, assumptions can be carried forward. A recommendation can turn into a directive, a finding into new scope. Or the other way around: a hard constraint reaches the next step only as a note.

Good orchestration can catch this. This toolkit takes a different approach. The agents do not start each other. In the intended flow, a human decides which agent works next and with which input.

This deliberately takes autonomy out of the flow. In return, it stays clear who did what and on what basis.

**Clear roles.** Requirements, code analysis, architecture, planning, implementation, review, bug analysis, test assessment and technical research are different tasks. They are not merged into a single role.

**Bounded authority.** Each agent acts within its task and its defined rights. Project files, reports, documentation or earlier agent artifacts do not automatically extend the task.

**Explicit handoffs.** The agents do not form an automatic chain among themselves. Whether a result is passed on and which agent receives it as input is decided explicitly. No agent takes over context or artifacts from previous steps on its own.

## The agents

| Agent | Task |
|---|---|
| [`requirements-engineer`](docs/en/requirements-engineer.md) | Clarifies rough ideas and change requests into a reviewable requirements state. Separates requirements, open questions and its own suggestions. |
| [`codebase-inspector`](docs/en/codebase-inspector.md) | Analyzes existing codebases read-only and documents architecture, data and control flows, technical debt, testability and reliable security findings. |
| [`software-architect`](docs/en/software-architect.md) | Designs a technical direction for new systems, features or refactorings and documents key decisions, risks and open questions. |
| [`implementation-planner`](docs/en/implementation-planner.md) | Turns an already decided technical direction into concrete, scoped implementation steps with dependencies and stop points. |
| [`software-developer`](docs/en/software-developer.md) | Implements clearly scoped changes with the smallest possible footprint, without creating new scope or new architecture on its own. |
| [`code-reviewer`](docs/en/code-reviewer.md) | Independently checks specific changes for defects, regressions, risks, security and relevant test gaps, without fixing the problems it finds. |
| [`bug-investigator`](docs/en/bug-investigator.md) | Investigates a concrete misbehavior, looks for the cause and fixes the defect minimally if expected behavior and cause are substantiated. Otherwise it documents the substantiated state of the investigation. |
| [`test-auditor`](docs/en/test-auditor.md) | Assesses how well existing tests actually secure an area and delivers substantiated findings and actionable test tasks. Leaves no permanent changes to project code or tests. |
| [`technical-researcher`](docs/en/technical-researcher.md) | Researches clearly scoped technical questions using project context and external sources and delivers an evidence-based basis for decisions. |

### Capabilities at a glance

| Agent | Changes project code | Runs tests or builds | Web access | Output |
|---|---|---|---|---|
| `requirements-engineer` | no | no (no shell) | no | 3 files per initiative, can be continued |
| `codebase-inspector` | no | no | no | 3 report files per run |
| `software-architect` | no | no | no | design with ADRs, risks, open questions, `claude-draft.md` |
| `implementation-planner` | no | no | no | implementation plan, open questions |
| `software-developer` | yes, within the task | local checks of its own change | no | change in the project, report in the chat, backups if needed |
| `code-reviewer` | no | yes, where safe and local | no | review report |
| `bug-investigator` | yes; permanently only a substantiated fix, with a regression test where a stable one is feasible | yes, where safe and local | no | investigation report, fix if needed |
| `test-auditor` | only its own temporary changes; these are rolled back | yes, where safe and local | no | assessment report with test tasks |
| `technical-researcher` | no | only state-neutral local checks | yes, read-only | research report |

According to the agent definitions, the following also applies: No agent commits, pushes or opens pull requests. No agent installs dependencies, runs migrations or starts containers. No agent opens recognizable secret stores or files that are recognizably used to store credentials. How far these rules hold technically is described under [Security and limits](#security-and-limits).

## Which role do I pick?

What matters is the starting situation, not the topic.

| Starting situation | Role |
|---|---|
| An idea or change request is still vague. | `requirements-engineer` |
| A codebase is unfamiliar to you, or you need an inventory. | `codebase-inspector` |
| What is to be built is clear, the technical direction is not yet. | `software-architect` |
| The technical direction is set and should be broken down into actionable steps. | `implementation-planner` |
| What is to be changed is decided. Only the implementation is missing. | `software-developer` |
| A concrete change should be checked independently. | `code-reviewer` |
| A concrete misbehavior is observable, but the cause is unknown. | `bug-investigator` |
| It is unclear whether the existing tests would notice errors at all. | `test-auditor` |
| A technical question needs external sources, for example about an API, a library or make-or-buy. | `technical-researcher` |

Three edge cases come up more often:

**Developer or bug investigator?** If it is decided what is to be changed, it is a task for the developer. If it first has to be clarified why something goes wrong or whether it is an error at all, it is a case for the bug investigator. "Handle the case of an empty date filter in the export function" goes to the developer. "The export aborts with an empty date filter" goes to the bug investigator.

**Reviewer or test auditor?** The reviewer checks a concrete change, including the tests that belong to it. The test auditor checks whether the existing tests of an area would notice errors at all.

**Architect or planner?** If the technical direction is still open, it is a task for the architect. If it is set, the planner breaks it down into steps. If the planner lacks a decision in the process, it stops instead of making the decision itself.

## Example workflow

The agents can be used individually. They do not form a mandatory pipeline.

One possible flow for a new feature:

```text
Rough idea or change request
        |
        v
requirements-engineer
        |
        | human review and approval
        v
software-architect
        |
        | human review and decision
        v
implementation-planner
        |
        | explicit handoff of the plan
        v
software-developer
        |
        | change in the project
        v
code-reviewer
```

The order is only an example. None of these transitions happens automatically.

Other combinations work just as well:

```text
Unknown legacy codebase
        |
        v
codebase-inspector
        |
        | selected findings as context
        v
software-architect
```

```text
Unclear external technology question
        |
        v
technical-researcher
        |
        | human decision
        v
software-architect
```

```text
Concrete misbehavior
        |
        v
bug-investigator
        |
        | fix in the working tree
        v
code-reviewer
```

```text
Green tests, but unclear safety net
        |
        v
test-auditor
        |
        | selected test tasks
        v
software-developer
```

## Installation

You need [Claude Code](https://code.claude.com/docs). Claude Code loads subagents per user or per project.

**Per user**, for agents that should be available in all projects:

```text
~/.claude/agents/
├── requirements-engineer.md
├── software-developer.md
├── code-reviewer.md
└── ...
```

**Per project**, for agents that should only be available in one specific project:

```text
my-project/
└── .claude/
    └── agents/
        ├── requirements-engineer.md
        ├── software-developer.md
        └── code-reviewer.md
```

The agent files are in the repository under `agents/en/`. You do not have to install all agents. The roles can be used independently of each other.

Install only one language version per agent. Claude Code identifies agents by the `name` in the frontmatter. If two files with the same name are in the agents folder, only one of them is loaded.

### Installation script (optional)

The repository contains an `install.sh` for installation. It copies the agent files of one language version to the right place. The script is purely a convenience. The manual installation above works just as well.

```bash
# per user to ~/.claude/agents/
./install.sh --lang en

# per project to /path/to/project/.claude/agents/
./install.sh --project /path/to/project --lang en

# only individual agents
./install.sh --lang en code-reviewer software-developer
```

The script only needs Bash and standard tools (`cp`, `cmp`, `awk`). It does not overwrite existing files. If a file with the same name in the target folder differs, it reports a conflict and leaves the file untouched. The same applies if another file there already uses the same `name` in the frontmatter. At the end, the output shows what was installed, unchanged or skipped.

With `--force`, the script replaces differing files with the same name, for example when updating to a new version or switching the language version. Your own customizations to these files are lost in the process. `./install.sh --help` shows all options.

## Usage

The agents are meant to be called directly and explicitly. In Claude Code, type `@` and the agent name and pick the agent from the suggestion list:

```text
@requirements-engineer
Clarify this change request into a reviewable requirements state:
...
```

```text
@codebase-inspector
Analyze this repository.
```

The examples are abbreviated.

An existing agent artifact is handed over explicitly as input:

```text
@software-developer
Implement agent-artifacts/implementation-planner/20260915-103000/implementation-plan.md.
```

The @ mention ensures that exactly this agent takes on the work. The actual task for the agent is formulated by the main session from your message. So name existing artifacts explicitly as input by file path instead of relying on the earlier chat.

Without @, Claude Code can also select an agent on its own based on its description. The descriptions are designed for explicit invocation, but they cannot technically prevent this.

## Artifacts and handoffs

The agents write their results to a shared folder in the working directory, with one subfolder per agent. The developer only stores backups there:

```text
agent-artifacts/
├── requirements-engineer/<initiative-id>/
├── codebase-inspector/<run-id>/
├── software-architect/<run-id>/
├── implementation-planner/<run-id>/
├── software-developer/<name>/
├── code-reviewer/review-<name>.md
├── bug-investigator/bug-<name>.md
├── test-auditor/test-<name>.md
└── technical-researcher/research-<name>.md
```

How artifacts are named depends on the role. Without a given name, most agents use a timestamp. The bug investigator and the test auditor first derive a short name from the task, the developer's backups carry the current date. The requirements engineer works with an initiative ID and only updates an existing initiative if the task explicitly asks to continue it. All other agents never overwrite earlier results.

The artifacts provide traceability and support deliberate handoffs between work steps. Their existence does not make them the task, the truth or authorized input for any agent. If a result should be used further, it is explicitly named as input in the next task.

This makes it possible to trace:

* what was originally requested,
* which role produced which statement,
* which decisions a human adopted,
* and which information deliberately went into the next step.

The artifacts show up in your version control status. Whether they are versioned, kept or excluded via `.gitignore` is your decision.

**Developer backups.** Before the developer changes or deletes an existing file for the first time whose content cannot be restored from version control, it stores a copy under `agent-artifacts/software-developer/`, with the suffix `.bak` appended, for example `src/foo.py.bak`. To restore it, copy it back and remove the suffix. It does not overwrite existing backups. If several invocations run under the same name or on the same day, this preserves the state before the first intervention. Changes you yourself make afterwards to files that were already backed up are not backed up again by the developer. The backups are intended to help you restore files, not to replace version control. You should exclude the folder `agent-artifacts/software-developer/` from version control.

Existing local changes in the task area are the starting state for the developer, but not automatically the solution approach. It may replace them and names this in its report. If an existing approach should be kept, say so in the task.

**Change journal.** The bug investigator and the test auditor keep a journal in their report. Every change to the project is recorded there before it is carried out. They roll back temporary changes based on this journal, never based on a diff. If a run is aborted, temporary changes can remain. The journal in the report shows which ones.

## Design principles

**No invented intent.** Agents should not create product goals, requirements or additional scope just because something seems technically plausible.

**Evidence over assumption.** Statements about existing code, dependencies, contracts or external technologies should be based on evidence that was actually examined. If something cannot be determined reliably, that uncertainty stays visible.

**Minimal scope.** The developer and the bug investigator in particular should make the smallest sensible change that fulfills the authorized task. No unrequested refactoring, modernization or additional features.

**Existing artifacts are not automatically authoritative.** README files, reports, TODOs, comments, earlier agent results or agent-facing files such as `CLAUDE.md` and `AGENTS.md` can provide context or evidence. They do not extend the task just by existing.

**Human decisions remain human decisions.** Research, requirements, architecture proposals, findings, reviews, diagnoses and test assessments are meant to prepare decisions. They do not replace approval by a human.

**Stack-independent.** No agent assumes a particular stack, framework or version control system.

## Security and limits

The agent definitions contain deliberately restrictive rules for file operations, network access, version control, secrets and tool use.

Technically, the frontmatter of each agent definition restricts which tools an agent receives. Claude Code and the session configuration can restrict the tool set further. In this toolkit, this is also how agents are prevented from starting other agents.

The remaining rules of the agent definitions are at prompt level. They are behavioral instructions to the model, not a hard technical security boundary.

If reliable security guarantees are required, critical restrictions should also be enforced technically, for example through:

* Claude Code permissions,
* hooks,
* sandboxing or isolated runtime environments,
* file system and process permissions,
* network restrictions,
* separate credentials and secret stores,
* your own CI and review rules.

Two points deserve particular attention:

* The `technical-researcher` is the only agent that has both web access and access to local project files. If you run individual agents in a sandbox, it should be this one first.
* No agent checks whether packages newly added to project files exist and are the right ones. This check before the first installation is up to you.

Prompt rules can be part of a security concept. They do not replace technical access control. For sensitive or production environments, do not assume a restriction is technically guaranteed just because it is written in an agent definition.

## What this toolkit deliberately is not

This project is not an autonomous multi-agent system. It contains no orchestrator that decides on its own:

* which agent runs next,
* which artifacts are passed on,
* which decisions are adopted,
* or how long an agent loop keeps running.

It is also not a replacement for existing engineering processes, reviews, CI/CD, permission concepts or security controls.

If maximum agent autonomy is the primary goal, this way of working is probably not the right one. If it matters more that you can trace and control who did what and on what basis, that is exactly the central design idea of this toolkit.

## Status

Current version: **v1.1**

v1.1 is deliberately conservative. The agents were developed iteratively and tested on the author's own test projects. They are meant as configurable starting points, not as a security boundary and not as a universal software engineering standard. Different projects, teams and risk profiles need different rules, permissions and technical safeguards.

Results vary between runs and models. The technical-researcher receives web content through Claude Code's web tools, sometimes only as processed excerpts rather than full pages.

Further specialized agents are planned and are intended to follow the same principles: clear scope, bounded authority and deliberate human handoffs.

## Documentation

Each agent has more detailed documentation covering use cases, input, output, limits and examples:

* [requirements-engineer](docs/en/requirements-engineer.md)
* [codebase-inspector](docs/en/codebase-inspector.md)
* [software-architect](docs/en/software-architect.md)
* [implementation-planner](docs/en/implementation-planner.md)
* [software-developer](docs/en/software-developer.md)
* [code-reviewer](docs/en/code-reviewer.md)
* [bug-investigator](docs/en/bug-investigator.md)
* [test-auditor](docs/en/test-auditor.md)
* [technical-researcher](docs/en/technical-researcher.md)

The agent files define the actual behavior. The documentation explains usage and limits in simplified form.

The German version is the canonical source for agent definitions and documentation. The English version is derived from it.

## License

This project is licensed under the [MIT License](LICENSE).

## Author

Created and maintained by Paul Engelhardt / Digifinity.

Freelance software development: maintainable custom software for businesses, with AI as a tool.

* Website: [digifinity.de](https://digifinity.de)
* LinkedIn: [paul-engelhardt](https://www.linkedin.com/in/paul-engelhardt)
