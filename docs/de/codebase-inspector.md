# codebase-inspector

Analysiert eine bestehende Codebasis read-only und dokumentiert ihren tatsächlichen Zustand. Jede Aussage ist am Code belegt. Was sich nicht belegen lässt, wird als „nicht ermittelt“ ausgewiesen.

| | |
|---|---|
| Ändert Projektcode | nein |
| Führt Tests oder Builds aus | nein |
| Webzugriff | nein |
| Ergebnis | 3 Report-Dateien je Lauf |

## Wann verwenden?

- Einstieg in eine fremde oder ältere Codebasis
- Bestandsaufnahme vor einem größeren Umbau
- Technische Triage: Welche Schulden sollten zuerst angegangen werden?

Der Anlass ändert nicht den Umfang der Analyse.

## Was braucht der Agent?

Das Repository als Arbeitsverzeichnis. Mehr nicht.

Optional: einen Laufnamen. Frühere Inspector-Läufe nutzt er nur, wenn sie im Auftrag ausdrücklich als Vergleich genannt werden.

## Was liefert er?

Drei Dateien in `agent-artifacts/codebase-inspector/<lauf-id>/`:

| Datei | Inhalt |
|---|---|
| `architecture-audit.md` | Leselandkarte „Start here“, Aufbau, Daten- und Kontrollflüsse, Befunde, Testbarkeit, priorisierte Schulden, Reduction-Kandidaten |
| `security-findings.md` | Security-Befunde mit Schweregrad und Belegstärke. Ausdrücklich kein Compliance-Nachweis. |
| `open-questions.md` | Was sich aus dem Code allein nicht klären lässt |

Jeder Befund nennt Fundstelle, Auswirkung, Confidence und den nächsten sinnvollen Schritt. Die Schulden werden in Worten priorisiert, ohne Score.

## Wichtige Grenzen

- Liest nur im Arbeitsverzeichnis und ändert nichts am Code.
- Führt keine Tests, Builds oder Projektskripte aus. Testbarkeit wird statisch bewertet.
- Kein Netzwerk. Ob Dependencies veraltet oder verwundbar sind, beurteilt er nur, wenn im Projekt ein Beleg dafür liegt.
- Zahlen nur, wenn gemessen. Kein Health-Score.
- Empfiehlt keinen Neubau, solange die Architektur nicht nachweisbar grundlegend kaputt ist.

## Beispiele

```text
@codebase-inspector
Analysiere dieses Repository.
```

```text
@codebase-inspector
Analysiere dieses Repository. Laufname: vor-refactoring.
```

```text
@codebase-inspector
Analysiere das Repository erneut, Laufname: nach-refactoring.
Vergleiche mit agent-artifacts/codebase-inspector/vor-refactoring/architecture-audit.md.
```

## Abgrenzung zu ähnlichen Rollen

- **Inspector vs. Reviewer:** Der Inspector analysiert den bestehenden Systemzustand. Der Reviewer untersucht eine konkrete Änderung auf Defekte.
- **Inspector vs. Architect:** Der Inspector beschreibt, was ist. Der Architect entwirft, was werden soll.

---

Vollständige Definition: [`agents/de/codebase-inspector.md`](../../agents/de/codebase-inspector.md)
