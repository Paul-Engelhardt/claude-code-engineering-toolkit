# technical-researcher

Recherchiert klar umrissene technische Fragen anhand von Projektkontext und externen Quellen. Liefert eine belegte Entscheidungsgrundlage, auf Wunsch mit einer begründeten Empfehlung. Die Entscheidung selbst bleibt beim Menschen.

| | |
|---|---|
| Ändert Projektcode | nein |
| Führt Tests oder Builds aus | nur zustandsneutrale lokale Prüfungen |
| Webzugriff | ja, nur lesend |
| Ergebnis | 1 Research-Report |
| Status | `RESEARCHED` oder `BLOCKED` |

## Wann verwenden?

- **Verifikation:** Stimmt eine konkrete Aussage über eine API, ein Limit oder ein Verhalten?
- **Exploration:** Welche praktikablen Ansätze gibt es für ein Problem?
- **Vergleich:** Welche von mehreren konkreten Optionen passt besser zu den Anforderungen?
- **Make-or-buy:** Selbst bauen, Open Source, SaaS oder eine Mischform?

## Was braucht der Agent?

Eine konkrete Frage. Hilfreich sind Anforderungen, harte Randbedingungen, bekannte Kandidaten und Ausschlüsse.

Projektdateien liest er, wenn du sie nennst oder wenn die Frage den Projektzustand direkt betrifft. Fehlende Informationen erfindet er nicht. Er recherchiert, was möglich ist, und benennt, was das Ergebnis noch verändern könnte.

## Was liefert er?

Einen Report `agent-artifacts/technical-researcher/research-<name>.md` mit Forschungsfrage, Erkenntnissen, gegebenenfalls Optionen, Vergleich und Empfehlung, offenen Punkten und Quellen mit Abrufdatum.

Jede wichtige Aussage hat einen Evidenzstatus: Dokumentiert, Lokal verifiziert, Abgeleitet, Annahme oder Nicht verifiziert / unbekannt. Was sich nur praktisch klären lässt, etwa in einer Anbieter-Sandbox, steht unter Validierungsbedarf vor Entscheidung.

`RESEARCHED` heißt: verwertbares Ergebnis. Es heißt nicht, dass alles praktisch verifiziert oder entschieden ist.

## Wichtige Grenzen

- Externe Quellen nur lesend. Keine Accounts, Trials, Logins, Käufe oder Uploads von Projektdaten.
- Eigenes Vorwissen zu Versionen, Preisen oder Limits gilt erst als belegt, wenn eine aktuelle Quelle es bestätigt.
- Keine erfundenen Annahmen über Team, Budget, Termine oder Wachstum. Keine Scores ohne vorgegebene Gewichtung.
- Lokale Prüfungen nur ohne Seiteneffekte. Keine Installationen und keine eigenen Testprogramme.
- Empfiehlt, entscheidet aber nicht.

## Beispiele

```text
@technical-researcher
Wiederholt Zahlungsanbieter X fehlgeschlagene Webhooks automatisch, und wenn ja, wie oft?
```

```text
@technical-researcher
Welche Ansätze gibt es, PDF-Rechnungen serverseitig zu erzeugen? Muss ohne externen Dienst laufen.
```

```text
@technical-researcher
Vergleiche Bibliothek A und B für CSV-Parsing mit Streaming.
Berücksichtige die Version von A, die im Projekt installiert ist.
```

```text
@technical-researcher
Make-or-buy für Volltextsuche in der Rechnungsverwaltung.
Kontext: agent-artifacts/software-architect/invoice-v1/open-questions.md
```

## Abgrenzung zu ähnlichen Rollen

- **Researcher vs. Architect:** Der Researcher klärt externe Technologiefragen und kann eine bedingte Empfehlung geben. Der Architect trifft daraus einen Entwurf, wenn du das Ergebnis als Input übergibst.
- **Researcher vs. Requirements Engineer:** Der Researcher klärt technische Fakten. Der Requirements Engineer klärt, was gebraucht wird.

---

Vollständige Definition: [`agents/de/technical-researcher.md`](../../agents/de/technical-researcher.md)
