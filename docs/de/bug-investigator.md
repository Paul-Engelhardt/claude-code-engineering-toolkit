# bug-investigator

Untersucht ein konkret beobachtetes Fehlverhalten, sucht die Ursache und behebt den Defekt mit minimalem Eingriff, wenn erwartetes Verhalten und Ursache ausreichend belegt sind. Eine belastbare Diagnose ohne Fix ist ebenfalls ein gültiges Ergebnis.

| | |
|---|---|
| Ändert Projektcode | ja; dauerhaft nur ein belegter Fix, wo stabil möglich mit Regressionstest |
| Führt Tests oder Builds aus | ja, soweit sicher und lokal |
| Webzugriff | nein |
| Ergebnis | 1 Untersuchungsreport, bei Bedarf Fix im Working Tree |
| Status | `FIXED`, `DIAGNOSED`, `NO_DEFECT`, `INCONCLUSIVE` oder `BLOCKED` |

## Wann verwenden?

- Ein konkretes Fehlverhalten mit unklarer Ursache: eine Exception, ein falscher Wert, ein fehlschlagender Test, ein Hänger, sporadisches Verhalten.
- Wenn nicht nur die Ursache, sondern auch ein minimaler, belegter Fix gewünscht ist.
- Wenn unklar ist, ob das gemeldete Verhalten überhaupt ein Fehler ist.

## Was braucht der Agent?

Eine Beschreibung des Fehlverhaltens: was passiert, wo und unter welchen Bedingungen. Fehlermeldungen, Logs oder ein fehlschlagender Test helfen. Ein bestimmtes Format ist nicht nötig.

Was das richtige Verhalten ist, bestimmt der Auftrag oder eine Vorgabe, die du ausdrücklich nennst. Code, Tests und Doku zählen als Evidenz, nicht automatisch als Anforderung.

Braucht die Untersuchung eine lokale Umgebung, etwa eine laufende Anwendung oder Datenbank, muss sie bereitstehen. Er startet nichts selbst und nutzt sie nur, wenn klar ist, dass sie nicht produktiv ist.

## Was liefert er?

Einen Report `agent-artifacts/bug-investigator/bug-<name>.md` mit erwartetem Verhalten, Reproduktion, Diagnose mit geprüften Hypothesen, Änderungsjournal, Validierung, Beifunden und Grenzen.

Neben dem Gesamtstatus nennt er einen Reproduktionsstatus: `REPRODUCED`, `PARTIALLY_REPRODUCED`, `NOT_REPRODUCED` oder `NOT_ATTEMPTED`.

| Status | Bedeutung |
|---|---|
| `FIXED` | Belegter Defekt, lokal behoben. Keine Freigabe für Merge oder Deployment. |
| `DIAGNOSED` | Ursache belegt, aber bewusst kein Fix, etwa weil eine Produkt- oder Vertragsentscheidung fehlt |
| `NO_DEFECT` | Das gemeldete Verhalten entspricht dem belegten erwarteten Verhalten |
| `INCONCLUSIVE` | Untersucht, aber die Evidenz reicht nicht für eine belastbare Diagnose |
| `BLOCKED` | Eine konkrete Voraussetzung fehlt |

Bei `FIXED` bleibt der Fix im Working Tree, wo stabil möglich mit Regressionstest. Reine Diagnoseänderungen wie Logging oder Testvarianten baut er vor Abschluss anhand seines Journals zurück.

## Wichtige Grenzen

- Kein Fix ohne belegtes erwartetes Verhalten und belegte Ursache. Lieber `INCONCLUSIVE` als eine plausible Geschichte.
- Trifft keine Produkt-, Architektur- oder Vertragsentscheidungen und führt keine neue Dependency ein, wenn das nicht ausdrücklich autorisiert ist.
- Ändert eine bestehende Testerwartung nur, wenn die Erwartung autorisiert ist, und begründet jede Änderung im Report.
- Beifunde meldet er, behebt sie aber nicht.
- Jede Änderung steht vor ihrer Ausführung im Journal. Änderungen, die nicht von ihm stammen, fasst er nicht an.
- Lokale Prüfungen nur, wenn sie sicher sind. Kein externes Netzwerk, keine Installationen, Migrationen, Container oder Server-Starts.
- Kein Webzugriff. Hängt die Diagnose von einem externen System ab, formuliert er eine externe Verifikationsfrage, statt aus Vorwissen zu antworten.

## Beispiele

```text
@bug-investigator
Der Export mit leerem Datumsfilter bricht mit einem Fehler ab. Stacktrace: logs/export-error.txt.
```

```text
@bug-investigator
tests/test_invoice_totals.py schlägt seit der letzten Änderung fehl. Finde die Ursache.
```

```text
@bug-investigator
Rechnungen mit Rabatt zeigen eine um einen Cent falsche Summe.
Erwartet ist Rundung pro Position laut docs/rundungsregeln.md (verbindliche Vorgabe).
Name: rabatt-rundung.
```

## Abgrenzung zu ähnlichen Rollen

- **Bug Investigator vs. Developer:** Der Developer setzt eine entschiedene Aufgabe um. Der Bug Investigator beginnt bei einem Symptom mit unbekannter Ursache und hinterlässt nur einen belegten Fix.
- **Bug Investigator vs. Reviewer:** Der Reviewer prüft eine Änderung und repariert nichts. Der Bug Investigator verfolgt ein konkretes Fehlverhalten bis zur Ursache und darf es beheben.
- **Bug Investigator vs. Test Auditor:** Der Test Auditor bewertet, wie gut Tests einen Bereich absichern. Der Bug Investigator klärt einen konkreten Fehler.

---

Vollständige Definition: [`agents/de/bug-investigator.md`](../../agents/de/bug-investigator.md)
