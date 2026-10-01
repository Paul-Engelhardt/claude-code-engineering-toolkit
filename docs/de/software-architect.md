# software-architect

Entwirft eine technische Stoßrichtung für ein neues System, ein neues Modul, ein Feature oder ein Refactoring. Liefert einen bewusst groben Entwurf mit tragenden Entscheidungen, Risiken und offenen Fragen, keine Vollspezifikation.

| | |
|---|---|
| Ändert Projektcode | nein |
| Führt Tests oder Builds aus | nein |
| Webzugriff | nein |
| Ergebnis | 4 Dateien je Lauf |
| Status | `BLOCKED`, wenn die Absicht für einen Entwurf nicht reicht |

## Wann verwenden?

- Ein neues Projekt soll auf leerer Fläche entstehen.
- Ein Feature, Modul oder Refactoring soll sauber in bestehenden Code eingefügt werden.
- Vor dem Bauen sollen die tragenden Entscheidungen und die offenen Fragen sichtbar werden.

Ob es sich um ein neues oder ein bestehendes Projekt handelt, erkennt der Agent selbst am Repository.

## Was braucht der Agent?

Eine erklärte Absicht: Was soll gebaut oder geändert werden, warum, und welche harten Randbedingungen gelten. Das kann im Auftrag selbst stehen oder in Dateien, die du ausdrücklich als Briefing nennst. Dateien, die du nur als Kontext nennst, liefern Hintergrund, aber keine Absicht.

Bei einem neuen Projekt reicht oft der Auftragstext.

**Das Tor:** Bevor er entwirft, prüft der Agent, ob die Absicht ohne Raten reicht. Fehlt etwas, das den Entwurf grundlegend verändern würde, entsteht kein Entwurf, sondern ein `BLOCKED`-Ergebnis mit den Fragen, die zuerst zu klären sind. Kleinere Lücken überbrückt er mit ausdrücklich benannten Annahmen.

## Was liefert er?

Vier Dateien in `agent-artifacts/software-architect/<lauf-id>/`:

| Datei | Inhalt |
|---|---|
| `architecture-design.md` | Einordnung, Annahmen, grober Entwurf, was bewusst nicht gebaut wird, vertagte Entscheidungen, ADRs, grobe Reihenfolge der Umsetzung |
| `risks.md` | Belegte Risiken, die keiner einzelnen Entscheidung gehören |
| `open-questions.md` | Offene Fragen und alle getroffenen Annahmen |
| `claude-draft.md` | Vorschlag für eine `CLAUDE.md`, bei bestehender `CLAUDE.md` nur die nötigen Änderungen |

Die echte `CLAUDE.md` fasst der Agent nicht an. Der abweichende Dateiname verhindert, dass Claude Code den Vorschlag automatisch lädt.

Auch ein `BLOCKED`-Lauf schreibt alle vier Dateien, dann mit Begründung statt Entwurf.

## Wichtige Grenzen

- Ändert keinen Projektcode und führt keine Tests oder Projektskripte aus.
- Bevorzugt die einfachste Lösung, die die bekannten Anforderungen erfüllt. Keine Schichten oder Dependencies auf Vorrat.
- Optimiert keine Qualitätsziele, die du nicht genannt hast.
- Bricht bestehende Schnittstellen und Datenformate nicht stillschweigend, sondern benennt Bruch und Übergangsweg.
- Keine Aufwandsschätzungen, auch nicht als klein, mittel oder groß.

## Beispiele

```text
@software-architect
Neues CLI-Tool, das Rechnungs-CSVs validiert und Fehler pro Zeile meldet.
Muss offline laufen.
```

```text
@software-architect
Entwirf das neue Export-Modul. Briefing: docs/vorhaben-export.md.
Den letzten Inspector-Report nimm als Kontext:
agent-artifacts/codebase-inspector/20260910-101500/architecture-audit.md
```

```text
@software-architect
Nimm agent-artifacts/requirements-engineer/invoice-stabilization/result-requirements-briefing.md
als Briefing. Laufname: invoice-v1.
```

## Abgrenzung zu ähnlichen Rollen

- **Architect vs. Inspector:** Der Inspector beschreibt den bestehenden Zustand. Der Architect entwirft, was werden soll, und liest bestehenden Code nur so weit, wie der Entwurf es braucht.
- **Architect vs. Planner:** Der Architect entscheidet die Richtung. Der Planner zerlegt eine entschiedene Richtung in umsetzbare Schritte.
- **Architect vs. Researcher:** Der Researcher klärt externe Technologiefragen mit Quellen. Der Architect hat keinen Webzugriff und arbeitet mit dem, was belegt oder vorgegeben ist.

---

Vollständige Definition: [`agents/de/software-architect.md`](../../agents/de/software-architect.md)
