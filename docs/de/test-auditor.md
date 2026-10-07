# test-auditor

Bewertet, wie gut die vorhandenen Tests eines Bereichs das relevante Verhalten tatsächlich absichern. Belegt das durch Ausführung, temporäre Probe-Tests und, in einem benannten Bereich, gezielte Mutationsstichproben am Produktivcode. Hinterlässt keine dauerhaften Änderungen an Projektcode oder Tests.

| | |
|---|---|
| Ändert Projektcode | nur eigene temporäre Änderungen; diese werden zurückgebaut |
| Führt Tests oder Builds aus | ja, soweit sicher und lokal |
| Webzugriff | nein |
| Ergebnis | 1 Bewertungsreport mit Befunden und Testaufgaben |
| Status | `FINDINGS`, `KEINE_FINDINGS` oder `BLOCKED` |

## Wann verwenden?

- Die Tests eines Bereichs sind grün, aber unklar ist, ob sie Fehler tatsächlich bemerken würden.
- Vor einem Umbau soll klar sein, wie belastbar die Testabsicherung ist.
- Ein Bereich hat kaum Tests, und es braucht konkrete Testaufgaben.
- Auf Wunsch: eine Teststrategie oder E2E-Szenarien.

## Was braucht der Agent?

Einen Bereich: ein Feature, ein Modul, eine Schnittstelle oder eine Änderung. Optional Anforderungen oder Akzeptanzkriterien, die du ausdrücklich als Quelle der Erwartung nennst.

Ohne benannten Bereich bewertet er die Testlandschaft im Überblick, statisch und mit Ausführung der vorhandenen Tests. Probe-Tests und Mutationen setzt er nur in einem ausdrücklich benannten Bereich ein.

Mutationen setzt er nur an Dateien, die versioniert und lokal unverändert sind. Ohne Versionsverwaltung bleibt es bei statischer Bewertung, Ausführung und Probe-Tests.

## Was liefert er?

Einen Report `agent-artifacts/test-auditor/test-<name>.md` mit:

- der Ausgangsbasis: welche Tests laufen, fehlschlagen oder instabil sind,
- Befunden, etwa wirkungslose, schwache oder instabile Tests und Lücken, jeweils mit Belegart,
- Mutationsergebnissen, ausdrücklich als Stichprobe benannt,
- Testaufgaben, die jemand ohne Kenntnis des Laufs umsetzen kann,
- offenen Fragen, wo die Erwartung nicht belegt ist.

Testaufgaben gibt es in zwei Typen. **Spezifikation** sichert belegtes erwartetes Verhalten ab und nennt die Quelle. **Charakterisierung** hält beobachtetes Ist-Verhalten fest und trifft ausdrücklich keine Aussage über Korrektheit.

`KEINE_FINDINGS` gilt nur für den bewerteten Umfang und die eingesetzten Mittel. Es ist keine Qualitätsgarantie.

## Wichtige Grenzen

- Schreibt keine dauerhaften Tests und keinen dauerhaften Code. Testaufgaben beschreiben, was ein Test leisten soll, ohne fertigen Testcode.
- Verändert bestehende Tests auch nicht vorübergehend.
- Jede temporäre Änderung steht vorher im Journal und wird zurückgebaut. Mit Versionsverwaltung prüft er danach, dass der Projektzustand dem Ausgangszustand entspricht.
- Erfindet keine Erwartungen. Wirkt das Ist-Verhalten fragwürdig, wird daraus eine offene Frage, kein Test, der einen möglichen Fehler festschreibt.
- Defekte, auf die er stößt, meldet er, behebt sie aber nicht.
- Wählt keinen Test-Runner und kein Werkzeug aus. Fehlt Testinfrastruktur, ist das eine offene Entscheidung.
- Kein externes Netzwerk, keine Installationen, Migrationen oder Container.

## Beispiele

```text
@test-auditor
Bewerte die Tests für die Rechnungsberechnung in src/billing/.
```

```text
@test-auditor
Bewerte die Tests für den Rechnungsfilter. Erwartetes Verhalten:
agent-artifacts/requirements-engineer/invoice-filter/result-requirements-briefing.md
```

```text
@test-auditor
Verschaff dir einen Überblick über die Testlandschaft dieses Projekts.
```

```text
@test-auditor
Bewerte die Tests der Zahlungsanbindung und schlag eine Teststrategie vor.
```

## Abgrenzung zu ähnlichen Rollen

- **Test Auditor vs. Reviewer:** Der Reviewer prüft eine Änderung auf Defekte. Der Test Auditor prüft, ob die vorhandenen Tests Fehler überhaupt bemerken würden.
- **Test Auditor vs. Developer:** Der Test Auditor beschreibt Testaufgaben. Umgesetzt werden sie in einem eigenen Auftrag, etwa durch den Developer.
- **Test Auditor vs. Bug Investigator:** Der Bug Investigator klärt einen konkreten Fehler. Der Test Auditor bewertet die Absicherung eines ganzen Bereichs.

---

Vollständige Definition: [`agents/de/test-auditor.md`](../../agents/de/test-auditor.md)
