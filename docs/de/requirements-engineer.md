# requirements-engineer

Macht aus einer rohen Idee oder einem Änderungswunsch einen prüfbaren Requirements-Stand. Trennt dabei strikt, was beauftragt ist, was noch offen ist und was nur sein eigener Vorschlag ist.

| | |
|---|---|
| Ändert Projektcode | nein |
| Führt Tests oder Builds aus | nein (keine Shell) |
| Webzugriff | nein |
| Ergebnis | 3 Dateien je Vorhaben, fortführbar |
| Status | `READY` oder `NEEDS_INPUT` |

## Wann verwenden?

- Eine Idee ist noch unscharf, auch ganz ohne Code.
- Ein Änderungswunsch soll vor Architektur oder Umsetzung sauber geklärt werden.
- Ein Vorhaben soll über mehrere Runden geklärt werden, indem offene Fragen beantwortet werden.

## Was braucht der Agent?

Deine Beschreibung des Vorhabens. Optional eine Vorhaben-ID, sonst wählt er selbst eine.

Weitere Dateien nutzt er nur, wenn du sie nennst. Dabei kannst du sagen, welche Rolle sie haben: etwa Anforderungsquelle, harte Vorgabe oder nur Kontext. Ein technischer Befund aus einem Report wird dadurch nicht automatisch zur Anforderung.

## Was liefert er?

Drei Dateien in `agent-artifacts/requirements-engineer/<vorhaben-id>/`:

| Datei | Inhalt |
|---|---|
| `result-requirements-briefing.md` | Ziel, Scope, Anforderungen (`REQ`), Randbedingungen, Akzeptanzkriterien (`AC`), Status |
| `result-requirements-open-questions.md` | Offene Fragen (`Q`), deren Antwort Ziel oder Scope verändert, und bereits erledigte Fragen |
| `result-requirements-suggestions.md` | Eigene Vorschläge (`SUG`), ausdrücklich nicht beauftragt, bis du sie übernimmst |

`READY` heißt: Ziel, Scope und Randbedingungen sind klar genug. `NEEDS_INPUT` heißt: Mindestens eine Frage entscheidet noch über die Richtung. Ein ehrliches `NEEDS_INPUT` ist gewollt und besser als ein `READY` mit erfundenen Details.

Die IDs bleiben über Fortsetzungen stabil, damit du dich in Antworten direkt darauf beziehen kannst.

## Wichtige Grenzen

- Beschreibt gewünschtes Verhalten, keine technische Lösung und keine Architektur.
- Erfindet keine Anforderungen wie Skalierbarkeit, Mandantenfähigkeit oder Performance-Ziele, wenn du sie nicht nennst.
- Keine Aufwandsschätzungen, keine Scores, keine Priorisierungsschemata.
- Stellt nur Fragen, die die Richtung verändern. Kein Fragenkatalog.
- Existiert eine automatisch gewählte Vorhaben-ID schon, fragt er nach, statt etwas zu überschreiben.

## Beispiele

```text
@requirements-engineer
Kunden sollen Rechnungen nach Status und Zeitraum filtern können.
Vorhaben-ID: invoice-filter.
```

```text
@requirements-engineer
Neues Vorhaben invoice-stabilization.
docs/kundenmail.md ist die Anforderungsquelle, der letzte Inspector-Report nur Kontext:
agent-artifacts/codebase-inspector/20260910-101500/architecture-audit.md
```

```text
@requirements-engineer
Bei invoice-stabilization: Q-001 beantworten wir mit „nur finalisierte Rechnungen“.
SUG-002 nehmen wir mit auf, SUG-003 nicht.
```

```text
@requirements-engineer
Wir machen bei invoice-stabilization weiter. Berücksichtige zusätzlich kundenantworten.md.
```

```text
@requirements-engineer
Starte invoice-stabilization neu.
```

## Abgrenzung zu ähnlichen Rollen

- **Requirements Engineer vs. Architect:** Der Requirements Engineer klärt, was gebraucht wird. Der Architect entwirft, wie es technisch gebaut wird.
- **Requirements Engineer vs. Researcher:** Der Requirements Engineer klärt Absicht und Scope. Der Researcher klärt technische Fragen mit externen Quellen.

---

Vollständige Definition: [`agents/de/requirements-engineer.md`](../../agents/de/requirements-engineer.md)
