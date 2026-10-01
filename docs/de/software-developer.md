# software-developer

Setzt eine klar umrissene, bereits entschiedene Aufgabe mit möglichst kleinem Eingriff um. Fügt sich in vorhandene Konventionen ein und erzeugt keinen neuen Scope und keine neue Architektur.

| | |
|---|---|
| Ändert Projektcode | ja, im Rahmen des Auftrags |
| Führt Tests oder Builds aus | lokale Prüfungen der eigenen Änderung |
| Webzugriff | nein |
| Ergebnis | Änderung im Projekt, Rückmeldung im Chat |

## Wann verwenden?

- Das Was steht fest, es geht nur noch um die saubere Umsetzung.
- Ein Chunk aus einem Umsetzungsplan soll umgesetzt werden.
- Eine kleine, klar abgegrenzte Änderung inklusive passender Tests.

## Was braucht der Agent?

Eine klare Aufgabe, direkt im Auftrag oder als Datei, die du ausdrücklich nennst. Den nötigen Projektkontext wie Code, Konventionen und Tests liest er selbst.

Übergibst du einen Plan, hält er an dessen Stopp-Punkten an.

## Was liefert er?

Die Änderung im Arbeitsverzeichnis und eine kurze Rückmeldung:

- was gebaut wurde und welche Dateien berührt sind,
- welche Prüfungen gelaufen sind und welche nicht,
- getroffene Annahmen,
- Probleme, die ihm aufgefallen sind, die er aber bewusst nicht angefasst hat.

Der Developer schreibt keine Artefakte unter `agent-artifacts/` und committet nicht.

## Wichtige Grenzen

- Minimaler Diff. Keine ungefragten Refactorings, Aufräumarbeiten oder Modernisierungen.
- Keine Abstraktionen oder Dependencies auf Vorrat.
- Bestehende Tests werden nicht abgeschwächt, nur damit die Änderung durchläuft.
- Widerspricht die Aufgabe dem Code oder würde sie eine bestehende Schnittstelle brechen, stoppt er und meldet, statt selbst umzuentscheiden.
- Lokale Prüfungen wie Compiler, Typechecks, Linter und Unit-Tests nur, wenn sie ohne verbotene Seiteneffekte laufen. Netzwerk, Installationen, Deployments, ausgeführte Migrationen und Container sind ausgeschlossen.
- Migrationen schreibt er, wenn der Auftrag eine Änderung am Datenmodell verlangt. Deployment- oder Container-Dateien nur auf ausdrücklichen Auftrag. Ausführen tut er beides nie.

## Beispiele

```text
@software-developer
Ergänze in der Rechnungsliste einen Filter nach Status.
```

```text
@software-developer
Setze agent-artifacts/implementation-planner/20260915-103000/implementation-plan.md um.
```

```text
@software-developer
Füge der Rechnungstabelle die Spalte cancelled_at hinzu, inklusive Migration.
```

## Abgrenzung zu ähnlichen Rollen

- **Developer vs. Planner:** Der Planner zerlegt und ordnet. Der Developer setzt um.
- **Developer vs. Reviewer:** Der Developer ändert Code und prüft seine eigene Änderung. Der Reviewer prüft unabhängig und repariert nichts.

---

Vollständige Definition: [`agents/de/software-developer.md`](../../agents/de/software-developer.md)
