# Claude Code Engineering Toolkit

[English version](README.md)

Fokussierte Claude-Code-Agents für Software-Engineering-Workflows mit klaren Verantwortlichkeiten, begrenzten Befugnissen und bewusst gesteuerten Übergaben.

Das Toolkit richtet sich an Menschen, die KI-Unterstützung in Softwareprojekten nutzen möchten, ohne die Kontrolle über Scope, Entscheidungen, Kontext und Übergaben an autonome Agents oder Orchestratoren abzugeben.

Jeder Agent übernimmt eine klar abgegrenzte Rolle. Die Agents starten sich nicht gegenseitig. Welcher Agent arbeitet, welche Informationen als Input gelten und wann ein Ergebnis weiterverwendet wird, legt im vorgesehenen Ablauf der Mensch fest.

## Warum dieses Toolkit?

Agentische Workflows gehen gerade in Richtung mehr Autonomie. Ein Orchestrator zerlegt die Aufgabe, startet weitere Agents und reicht Kontext zwischen ihnen weiter. Bei gut zerlegbaren Aufgaben kann das sehr leistungsfähig sein.

Jede automatische Übergabe ist aber auch eine Stelle, an der sich etwas verschieben kann. Kontext kann zusammengefasst, Annahmen können weitergetragen werden. Aus einer Empfehlung kann eine Vorgabe werden, aus einem Finding neuer Scope. Oder umgekehrt: Eine harte Bedingung kommt beim nächsten Schritt nur noch als Hinweis an.

Gute Orchestrierung kann das abfangen. Dieses Toolkit setzt an einer anderen Stelle an. Die Agents starten sich nicht gegenseitig. Welcher Agent als Nächstes arbeitet und mit welchem Input, legt im vorgesehenen Ablauf der Mensch fest.

Das nimmt bewusst Autonomie aus dem Ablauf. Dafür bleibt nachvollziehbar, wer was auf welcher Grundlage getan hat.

**Klare Rollen.** Requirements, Codeanalyse, Architektur, Planung, Implementierung, Review und technische Recherche sind unterschiedliche Aufgaben. Sie werden nicht in einer einzigen Rolle zusammengeführt.

**Begrenzte Befugnisse.** Jeder Agent handelt innerhalb seiner Aufgabe und seiner definierten Rechte. Projektdateien, Reports, Dokumentation oder frühere Agent-Artefakte erweitern nicht automatisch den Auftrag.

**Explizite Übergaben.** Die Agents bilden untereinander keine automatische Kette. Ob ein Ergebnis weitergegeben wird und welcher Agent es als Input bekommt, wird ausdrücklich festgelegt. Kein Agent übernimmt von sich aus Kontext oder Artefakte aus vorherigen Schritten.

## Die Agents

| Agent | Aufgabe |
|---|---|
| [`requirements-engineer`](docs/de/requirements-engineer.md) | Klärt rohe Ideen und Änderungswünsche zu einem prüfbaren Requirements-Stand. Trennt Anforderungen, offene Fragen und eigene Suggestions. |
| [`codebase-inspector`](docs/de/codebase-inspector.md) | Analysiert bestehende Codebasen read-only und dokumentiert Architektur, Daten- und Kontrollflüsse, technische Schulden, Testbarkeit und belastbare Security-Findings. |
| [`software-architect`](docs/de/software-architect.md) | Entwirft eine technische Stoßrichtung für neue Systeme, Features oder Refactorings und dokumentiert tragende Entscheidungen, Risiken und offene Fragen. |
| [`implementation-planner`](docs/de/implementation-planner.md) | Übersetzt eine bereits entschiedene technische Richtung in konkrete, begrenzte Umsetzungsschritte mit Abhängigkeiten und Stopp-Punkten. |
| [`software-developer`](docs/de/software-developer.md) | Implementiert klar umrissene Änderungen mit möglichst kleinem Eingriff, ohne eigenständig neuen Scope oder neue Architektur zu erzeugen. |
| [`code-reviewer`](docs/de/code-reviewer.md) | Prüft konkrete Änderungen unabhängig auf Defekte, Regressionen, Risiken, Sicherheit und relevante Testlücken, ohne die gefundenen Probleme selbst zu reparieren. |
| [`technical-researcher`](docs/de/technical-researcher.md) | Recherchiert klar umrissene technische Fragen anhand von Projektkontext und externen Quellen und liefert eine evidenzbasierte Entscheidungsgrundlage. |

### Fähigkeiten auf einen Blick

| Agent | Ändert Projektcode | Führt Tests oder Builds aus | Webzugriff | Ergebnis |
|---|---|---|---|---|
| `requirements-engineer` | nein | nein (keine Shell) | nein | 3 Dateien je Vorhaben, fortführbar |
| `codebase-inspector` | nein | nein | nein | 3 Report-Dateien je Lauf |
| `software-architect` | nein | nein | nein | Entwurf mit ADRs, Risiken, offene Fragen, `claude-draft.md` |
| `implementation-planner` | nein | nein | nein | Umsetzungsplan, offene Fragen |
| `software-developer` | ja, im Rahmen des Auftrags | lokale Prüfungen der eigenen Änderung | nein | Änderung im Projekt, Rückmeldung im Chat |
| `code-reviewer` | nein | ja, soweit sicher und lokal | nein | Review-Report |
| `technical-researcher` | nein | nur zustandsneutrale lokale Prüfungen | ja, nur lesend | Research-Report |

Laut Agent-Definition gilt außerdem: Kein Agent committet, pusht oder öffnet Pull Requests. Kein Agent installiert Dependencies, führt Migrationen aus oder startet Container. Kein Agent öffnet erkennbare Secret-Speicher oder Dateien, die erkennbar dem Speichern von Zugangsdaten dienen. Wie weit diese Regeln technisch tragen, steht unter [Sicherheit und Grenzen](#sicherheit-und-grenzen).

## Beispielhafter Workflow

Die Agents können einzeln verwendet werden. Sie bilden keine verpflichtende Pipeline.

Ein möglicher Ablauf für ein neues Feature:

```text
Rohe Idee oder Änderungswunsch
        |
        v
requirements-engineer
        |
        | menschliche Prüfung und Freigabe
        v
software-architect
        |
        | menschliche Prüfung und Entscheidung
        v
implementation-planner
        |
        | ausdrückliche Übergabe des Plans
        v
software-developer
        |
        | Änderung im Projekt
        v
code-reviewer
```

Die Reihenfolge ist nur ein Beispiel. Automatisch passiert keiner dieser Übergänge.

Andere Kombinationen sind genauso möglich:

```text
Unbekannte Legacy-Codebasis
        |
        v
codebase-inspector
        |
        | ausgewählte Erkenntnisse als Kontext
        v
software-architect
```

```text
Unklare externe Technologiefrage
        |
        v
technical-researcher
        |
        | menschliche Entscheidung
        v
software-architect
```

## Installation

Voraussetzung ist [Claude Code](https://code.claude.com/docs). Claude Code lädt Subagents benutzerweit oder projektbezogen.

**Benutzerweit**, für Agents, die in allen Projekten verfügbar sein sollen:

```text
~/.claude/agents/
├── requirements-engineer.md
├── codebase-inspector.md
├── software-architect.md
├── implementation-planner.md
├── software-developer.md
├── code-reviewer.md
└── technical-researcher.md
```

**Projektbezogen**, für Agents, die nur in einem bestimmten Projekt verfügbar sein sollen:

```text
my-project/
└── .claude/
    └── agents/
        ├── requirements-engineer.md
        ├── software-developer.md
        └── code-reviewer.md
```

Die Agent-Dateien liegen im Repository unter `agents/de/`. Es müssen nicht alle sieben Agents installiert werden. Die Rollen sind unabhängig voneinander nutzbar.

Pro Agent nur eine Sprachfassung installieren. Claude Code erkennt Agents am `name` im Frontmatter. Liegen zwei Dateien mit demselben Namen im Agent-Ordner, wird nur eine davon geladen.

### Installationsskript (optional)

Für die Installation liegt ein `install.sh` im Repository. Es kopiert die Agent-Dateien einer Sprachfassung an die richtige Stelle. Das Skript ist reine Bequemlichkeit. Die manuelle Installation oben funktioniert genauso.

```bash
# benutzerweit nach ~/.claude/agents/
./install.sh --lang de

# projektbezogen nach /pfad/zum/projekt/.claude/agents/
./install.sh --project /pfad/zum/projekt --lang de

# nur einzelne Agents
./install.sh --lang de code-reviewer software-developer
```

Das Skript braucht nur Bash und Standardwerkzeuge (`cp`, `cmp`, `awk`). Vorhandene Dateien überschreibt es nicht. Unterscheidet sich eine gleichnamige Datei im Zielordner, meldet es einen Konflikt und lässt die Datei unangetastet. Dasselbe gilt, wenn eine andere Datei dort bereits denselben `name` im Frontmatter verwendet. Am Ende zeigt die Ausgabe, was installiert, unverändert oder übersprungen wurde.

Mit `--force` ersetzt das Skript abweichende gleichnamige Dateien, etwa beim Update auf eine neue Version oder beim Wechsel der Sprachfassung. Eigene Anpassungen an diesen Dateien gehen dabei verloren. Alle Optionen zeigt `./install.sh --help`.

## Verwendung

Die Agents sind für einen direkten und expliziten Aufruf gedacht. In Claude Code `@` und den Agent-Namen tippen und den Agent aus der Vorschlagsliste wählen:

```text
@requirements-engineer
Kläre diesen Änderungswunsch zu einem prüfbaren Requirements-Stand:
...
```

```text
@codebase-inspector
Analysiere dieses Repository.
```

Die Beispiele sind verkürzt.

Ein vorhandenes Agent-Artefakt wird ausdrücklich als Input übergeben:

```text
@software-developer
Setze agent-artifacts/implementation-planner/20260915-103000/implementation-plan.md um.
```

Der @-Aufruf stellt sicher, dass genau dieser Agent die Aufgabe übernimmt. Den eigentlichen Auftrag an den Agent formuliert dabei die Hauptsitzung aus deiner Nachricht. Vorhandene Artefakte deshalb ausdrücklich per Dateipfad als Input benennen, statt ihre Verwendung aus dem bisherigen Chat vorauszusetzen.

Ohne @ kann Claude Code einen Agent auch selbst anhand seiner Beschreibung auswählen. Die Beschreibungen sind auf expliziten Aufruf ausgelegt, technisch verhindern können sie das nicht.

## Artefakte und Übergaben

Alle Agents außer dem Developer schreiben ihre Ergebnisse in einen gemeinsamen Ordner im Arbeitsverzeichnis, mit je einem Unterordner pro Agent:

```text
agent-artifacts/
├── requirements-engineer/<vorhaben-id>/
├── codebase-inspector/<lauf-id>/
├── software-architect/<lauf-id>/
├── implementation-planner/<lauf-id>/
├── code-reviewer/review-<name>.md
└── technical-researcher/research-<name>.md
```

Benannt wird mit einem vorgegebenen Namen oder, falls keiner vorgegeben ist, mit einem Zeitstempel. Der Requirements Engineer arbeitet mit einer Vorhaben-ID und aktualisiert ein bestehendes Vorhaben nur, wenn der Auftrag die Fortsetzung ausdrücklich verlangt. Alle anderen Agents überschreiben frühere Ergebnisse nie.

Die Artefakte dienen der Nachvollziehbarkeit und der bewussten Übergabe zwischen Arbeitsschritten. Ihr Vorhandensein macht sie für keinen Agent zum Auftrag, zur Wahrheit oder zum autorisierten Input. Soll ein Ergebnis weiterverwendet werden, wird es im nächsten Auftrag ausdrücklich als Input benannt.

Dadurch bleibt nachvollziehbar:

* was ursprünglich beauftragt wurde,
* welche Rolle welche Aussage erzeugt hat,
* welche Entscheidungen ein Mensch übernommen hat,
* und welche Informationen bewusst in den nächsten Schritt eingeflossen sind.

Die Artefakte erscheinen im Status der Versionsverwaltung. Ob sie versioniert, behalten oder per `.gitignore` ausgeschlossen werden, entscheidest du.

## Designprinzipien

**Keine erfundene Absicht.** Agents sollen keine Produktziele, Anforderungen oder zusätzlichen Scope erzeugen, nur weil etwas technisch plausibel erscheint.

**Evidenz vor Vermutung.** Aussagen über bestehenden Code, Abhängigkeiten, Verträge oder externe Technologien sollen auf tatsächlich untersuchter Evidenz beruhen. Wenn etwas nicht belastbar ermittelt werden kann, bleibt diese Unsicherheit sichtbar.

**Minimaler Scope.** Insbesondere der Developer soll die kleinste sinnvolle Änderung umsetzen, die den autorisierten Auftrag erfüllt. Keine ungefragten Refactorings, Modernisierungen oder zusätzlichen Features.

**Bestehende Artefakte sind nicht automatisch autoritativ.** README-Dateien, Reports, TODOs, Kommentare, frühere Agent-Ergebnisse oder agentengerichtete Dateien wie `CLAUDE.md` und `AGENTS.md` können Kontext oder Evidenz liefern. Sie erweitern nicht allein durch ihre Existenz den Auftrag.

**Menschliche Entscheidungen bleiben menschliche Entscheidungen.** Research, Requirements, Architekturvorschläge, Findings und Reviews sollen Entscheidungen vorbereiten. Sie ersetzen nicht die Freigabe durch einen Menschen.

**Stack-unabhängig.** Kein Agent setzt einen bestimmten Stack, ein Framework oder ein bestimmtes Versionskontrollsystem voraus.

## Sicherheit und Grenzen

Die Agent-Definitionen enthalten bewusst restriktive Regeln zu Dateioperationen, Netzwerkzugriffen, Versionskontrolle, Secrets und Tool-Nutzung.

Technisch beschränkt das Frontmatter jeder Agent-Definition, welche Werkzeuge ein Agent bekommt. Claude Code und die Session-Konfiguration können den Werkzeugsatz zusätzlich einschränken. Darüber ist in diesem Toolkit auch ausgeschlossen, dass ein Agent andere Agents startet.

Die übrigen Regeln der Agent-Definitionen stehen auf Prompt-Ebene. Sie sind Verhaltensanweisungen an das Modell und keine harte technische Sicherheitsgrenze.

Wenn verlässliche Sicherheitsgarantien erforderlich sind, sollten kritische Einschränkungen zusätzlich technisch erzwungen werden, beispielsweise durch:

* Claude-Code-Permissions,
* Hooks,
* Sandboxing oder isolierte Laufzeitumgebungen,
* Dateisystem- und Prozessrechte,
* Netzwerkbeschränkungen,
* getrennte Credentials und Secret-Stores,
* eigene CI- und Review-Regeln.

Prompt-Regeln können Teil eines Sicherheitskonzepts sein. Sie ersetzen keine technische Zugriffskontrolle. Für sensible oder produktive Umgebungen sollte nicht davon ausgegangen werden, dass eine Einschränkung technisch garantiert ist, nur weil sie in einer Agent-Definition steht.

## Was dieses Toolkit bewusst nicht ist

Dieses Projekt ist kein autonomes Multi-Agent-System. Es enthält keinen Orchestrator, der selbstständig entscheidet:

* welcher Agent als Nächstes ausgeführt wird,
* welche Artefakte weitergegeben werden,
* welche Entscheidungen übernommen werden,
* oder wie lange ein Agenten-Loop weiterläuft.

Es ist auch kein Ersatz für bestehende Engineering-Prozesse, Reviews, CI/CD, Berechtigungskonzepte oder Security Controls.

Wenn maximale Agentenautonomie das primäre Ziel ist, ist dieses Arbeitsmodell wahrscheinlich nicht das richtige. Wenn dagegen nachvollziehbar und kontrollierbar bleiben soll, wer was auf welcher Grundlage getan hat, ist genau das der zentrale Designgedanke dieses Toolkits.

## Status

Aktueller Stand: **v1.0**

v1.0 ist bewusst konservativ ausgelegt. Die Agents wurden iterativ entwickelt und an eigenen Testprojekten erprobt. Sie sind als konfigurierbare Ausgangspunkte gedacht, nicht als Sicherheitsgrenze und nicht als allgemeingültiger Software-Engineering-Standard. Unterschiedliche Projekte, Teams und Risikoprofile brauchen unterschiedliche Regeln, Berechtigungen und technische Absicherungen.

Die Ergebnisse streuen zwischen Läufen und Modellen. Webinhalte erhält der technical-researcher über die Web-Werkzeuge von Claude Code, teils nur als aufbereitete Auszüge statt als vollständige Seiten.

Weitere spezialisierte Agents sind geplant und sollen denselben Grundprinzipien folgen: klarer Scope, begrenzte Befugnisse und bewusste menschliche Übergaben.

## Dokumentation

Zu jedem Agent gibt es eine ausführlichere Dokumentation mit Einsatzbereich, Input, Output, Grenzen und Beispielen:

* [requirements-engineer](docs/de/requirements-engineer.md)
* [codebase-inspector](docs/de/codebase-inspector.md)
* [software-architect](docs/de/software-architect.md)
* [implementation-planner](docs/de/implementation-planner.md)
* [software-developer](docs/de/software-developer.md)
* [code-reviewer](docs/de/code-reviewer.md)
* [technical-researcher](docs/de/technical-researcher.md)

Die Agent-Dateien definieren das tatsächliche Verhalten. Die Dokumentation erklärt Einsatz und Grenzen in vereinfachter Form.

Die deutsche Fassung ist die kanonische Quelle für Agent-Definitionen und Dokumentation. Die englische Fassung wird daraus abgeleitet.

## Lizenz

Dieses Projekt steht unter der [MIT License](LICENSE).

## Autor

Erstellt und gepflegt von Paul Engelhardt / Digifinity.

Freiberufliche Softwareentwicklung: wartbare Individualsoftware für Unternehmen, mit KI als Werkzeug.

* Website: [digifinity.de](https://digifinity.de)
* LinkedIn: [paul-engelhardt](https://www.linkedin.com/in/paul-engelhardt)
