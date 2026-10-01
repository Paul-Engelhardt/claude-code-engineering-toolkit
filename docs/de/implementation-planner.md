# implementation-planner

Zerlegt eine bereits entschiedene Absicht, etwa einen Architekturentwurf, in kleine, geordnete Umsetzungsschritte mit klaren Stopp-Punkten. Entwirft nichts neu und schreibt keinen Code.

| | |
|---|---|
| Ändert Projektcode | nein |
| Führt Tests oder Builds aus | nein |
| Webzugriff | nein |
| Ergebnis | 2 Dateien je Lauf |
| Status | `READY` oder `BLOCKED` |

## Wann verwenden?

- Ein Entwurf oder eine Entscheidung steht fest und soll in reviewbare Schritte zerlegt werden.
- Eine ältere Vorlage soll vor der Umsetzung gegen den aktuellen Code geprüft werden.

## Was braucht der Agent?

Die zu planende Absicht: im Auftrag selbst oder als Datei, die du ausdrücklich nennst. Ein bestimmtes Format ist nicht nötig. Die Datei muss im Arbeitsverzeichnis liegen.

Liegt bereits Code vor, prüft der Agent zuerst, ob die Vorlage noch zum aktuellen Stand passt. Bei einem neuen Projekt prüft er nur, ob die Vorlage in sich schlüssig ist.

Erfordert die Zerlegung eine noch offene Architektur-, Produkt- oder Schnittstellenentscheidung, oder passt die Vorlage grundlegend nicht mehr zum Code, stoppt er mit `BLOCKED` und offenen Fragen, statt selbst zu entscheiden.

## Was liefert er?

Zwei Dateien in `agent-artifacts/implementation-planner/<lauf-id>/`:

| Datei | Inhalt |
|---|---|
| `implementation-plan.md` | Status, Abgleich mit dem Code, Annahmen, geordnete Chunks |
| `open-questions.md` | Offene Punkte, Annahmen und Auffälligkeiten außerhalb des Plans |

Jeder Chunk hat Ziel, Umfang, ein prüfbares Fertig-Kriterium, Abhängigkeiten, zu wahrende Verträge und einen Stopp-Punkt, an dem du entscheidest, wie es weitergeht.

Lässt sich eine Änderung nicht sauber teilen, etwa eine Signaturänderung über viele Aufrufstellen, wird sie als ein Block benannt statt künstlich zerlegt.

## Wichtige Grenzen

- Kein Neuentwurf. Fehlt eine Entscheidung, stoppt er.
- Probleme im Code, die nicht zur Absicht gehören, werden offene Fragen, keine zusätzlichen Planschritte.
- Kein Code im Plan. Er beschreibt das Was und den Rahmen, nicht das Wie.
- Keine Aufwandsschätzungen.

## Beispiele

```text
@implementation-planner
Plane die Umsetzung von agent-artifacts/software-architect/invoice-v1/architecture-design.md.
```

```text
@implementation-planner
Plane die Umsetzung: Der Rechnungsexport soll zusätzlich CSV liefern.
Das Format steht in docs/export-format.md.
```

```text
@implementation-planner
docs/zahlungs-design.md ist drei Monate alt. Plane die Umsetzung und prüfe sie gegen den aktuellen Code.
```

## Abgrenzung zu ähnlichen Rollen

- **Planner vs. Architect:** Der Architect entscheidet die Richtung. Der Planner setzt eine entschiedene Richtung in Schritte um und trifft keine neuen Entscheidungen.
- **Planner vs. Developer:** Der Planner beschreibt, was in welchem Rahmen zu tun ist. Der Developer setzt es um.

---

Vollständige Definition: [`agents/de/implementation-planner.md`](../../agents/de/implementation-planner.md)
