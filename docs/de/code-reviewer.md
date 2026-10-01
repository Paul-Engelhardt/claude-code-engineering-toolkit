# code-reviewer

Prüft eine konkrete Änderung oder einen benannten Codestand unabhängig auf Defekte, Regressionen, Sicherheitsprobleme und relevante Testlücken. Repariert nichts, sondern belegt, was er findet.

| | |
|---|---|
| Ändert Projektcode | nein |
| Führt Tests oder Builds aus | ja, soweit sicher und lokal |
| Webzugriff | nein |
| Ergebnis | 1 Review-Report |
| Status | `FINDINGS`, `KEINE_FINDINGS` oder `BLOCKED` |

## Wann verwenden?

- Nach einer Änderung, bevor sie übernommen wird.
- Gegen eine konkrete Vorgabe, etwa einen Plan-Chunk oder Akzeptanzkriterien.
- Für einen lokalen Prototyp, wenn der ganze Stand geprüft werden soll.

## Was braucht der Agent?

Einen **Gegenstand**: lokale Änderungen, einen Vergleich gegen einen Branch oder eine Revision, eine Patch-Datei, benannte Dateien oder ausdrücklich den gesamten Projektstand. Eine Versionsverwaltung ist nicht zwingend.

Optional einen **Prüfmaßstab**. Mit Maßstab prüft er zusätzlich, ob umgesetzt ist, was verlangt war. Ohne Maßstab bewertet er keine Vollständigkeit und sagt das im Report auch so.

Selbstauskünfte wie „Tests sind grün“ übernimmt er nicht ungeprüft.

## Was liefert er?

Einen Report `agent-artifacts/code-reviewer/review-<name>.md` mit:

- Status, Umfang der Prüfung und ausgeführten Prüfungen,
- Findings mit Schweregrad (`BLOCKER`, `ISSUE`, `NOTE`), Beleg, Auswirkung und möglicher Behebungsrichtung,
- Beobachtungen, die nicht als Defekt belegt sind.

`KEINE_FINDINGS` heißt nur: Im geprüften Umfang wurde nichts Konkretes gefunden. Es heißt nicht, dass der Code korrekt oder freigegeben ist.

`BLOCKED` gibt es nur, wenn kein Gegenstand bestimmbar ist. Ein fehlender Prüfmaßstab ist kein Grund dafür.

## Wichtige Grenzen

- Der Reviewer verändert keinen Projektcode. Ein fehlschlagender Test wird gemeldet, nicht gefixt.
- Lokale Tests, Typechecks, Linter und Builds sind nur zulässig, wenn sie sicher und ohne verbotene Seiteneffekte ausführbar sind. Netzwerk, Installationen, Migrationen und Container bleiben ausgeschlossen.
- Geschmacksfragen sind keine Findings. Jedes Finding braucht eine konkrete Auswirkung.
- Kein Architektur- oder Qualitätsaudit, auch nicht bei einem ganzen Prototyp.

## Beispiele

```text
@code-reviewer
Reviewe die lokalen Änderungen.
```

```text
@code-reviewer
Reviewe die lokalen Änderungen gegen Chunk 2 aus
agent-artifacts/implementation-planner/20260915-103000/implementation-plan.md.
```

```text
@code-reviewer
Reviewe den Stand gegenüber main.
```

```text
@code-reviewer
Reviewe den gesamten Projektstand, es ist ein lokaler Prototyp.
```

## Abgrenzung zu ähnlichen Rollen

- **Reviewer vs. Inspector:** Der Reviewer untersucht eine konkrete Änderung auf Defekte. Der Inspector analysiert den bestehenden Systemzustand.
- **Reviewer vs. Developer:** Der Reviewer findet und belegt Probleme. Behoben werden sie in einem neuen Auftrag.

---

Vollständige Definition: [`agents/de/code-reviewer.md`](../../agents/de/code-reviewer.md)
