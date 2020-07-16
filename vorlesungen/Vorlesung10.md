## Echtzeitsysteme
### Beispiel: Steuercomputer eines Flugzeugs
* Mehrere Sensoren:
  * z.B. Beschleunigung, mit Signalverarbeitung:
    * A/D Wandlung
    * z.B. Integration zu Geschwindigkeit, Ort
  * analog dazu Drehratensensor
  * Drucksensor
    * Signalverarbeitung: Umrechnung zur Höhe
    * Geschwindigkeit mittels differenzieller Messung

Diese Sensordaten werden teils direkt auf Instrumente geführt, aber
im Allgemeinen auf einen gemeinsamen Systembus geführt. Auf diesen
Systembus werden auch die Nutzereingabe von z.B Steuerknüppel und Pedalen
geführt.

Ein Zustandsregler erzeugt daraus Steuerdignale, die mittels D/A Wandler
an Triebwerke und Klappen geführt werden.

Man stellt fest, dass hier viele voneinander unabhängige Operationen
spezifiziert wurden. Diese nennen wir *Tasks*, die ständig voneinander
unabhängig laufen.

Eine Anforderung an das Gesamtsystem ist, dass die gesamte Zeit von Eingang
zum Ausgang begrenzt ist. Diese Begrenzung ergibt sich aus der Dynamik des
Physikalischen systems, ein Überschreiten kann zur Instabilität führen.

Die Dynamik des Flugzeugs beeinflusst das Zeitverhalten des Rechensystems.

Der Rechner muss also so schnell wie nötig sein, allerdings wirken andere
Anforderungen wie Größe und Kosten dem entgegen.

Ein solcher Rechner heißt *Echtzeitsystem*.

### Zeit und Echtzeitsysteme
Ein Programm in einem Rechner läuft i.A. sequentiell ab.
Diese Ausführung wird von einem Takt vorgegeben.
Hier wird von *Logischer Zeit* gesprochen.
Bei einer *Logischen Uhr* wird nur gefordert, dass die Ursache eines
Ereignisses vor dessen Wirkung stattfindet.

In der reellen Welt wird durch die Zeit z.B. eine Bewegung beschrieben.
Zur Messung der Zeit benötigen wir eine Uhr, die z.B. auf einer
periodischen Bewegung basieren.

Ein Ereignis (in der VL dargestellt durch einen Blitz ⚡) ist ein zeitloser
Zustandswechsel.

Die echte Zeit nennen wir *Realzeit* oder *Echtzeit*.
Diese läuft unabhängig von den Vorgängen im Rechner.

Innerhalb unseres Rechners (zwischen A/D und D/A) herrscht die *Logische Zeit*. Wir definieren eine Frist, in der die Berechnung abgeschlossen sein
muss.

#### Echtzeitssystem
Ein einegebetter Rechner, der durch externe Ereignisse ausgelöste
Berechnungnen rechtzeitig ausführt.
Das beinhaltet sowohl das Bereitstellen von Ergebnissen zu festen,
vorgegebenen Zeitpunken als auch die rechtzeitige Fertigstellung von
Berechnungen.

Diese Rechtzeitigkeit ist vorgegeben durch die *Reale Zeit*, nicht die
*Logische Zeit* im Rechner.

Wir unterscheiden zwischen harten und weichen Echtzeitsystemen.

#### Harte Echtzeitsysteme
Keine Echtzeitverletzung wird toleriert.

Beispiele:

* ABS
* Steuerung eines AKW
* Flugzeugregelung

#### Weiche Echtzeitsysteme
Kostenfunktion für Berechnungsdauer fällt langsam, flach ab.
Rechnungen, die das Zeitlimit überschreiten sind nicht immer problematisch.

Beispiele:

* Telefonnetz
* Streaming

### Nebenläufigkeit in Echtzeitsystemen
* Zeitgesteuertes Echtzeitsystem
  * Englisch: *Time triggered System*
  * Ereignisse werden von periodischen Zeitimpulsen ausgelöst

* Ereignisgesteuertes Echtzeitsystem
  * Ereignisse treten sporadisch auf

Wir erinnern uns daran, dass wir viele zeitlich unabhängige
Abläufe spezifiziert haben.
Das Ausführungsmodell der Tasks ist *Nebenläufig*.

* Wahre Nebenläufigkeit
  * Aufgaben können gleichzeitig ausgeführt werden
  * Dies ist nicht unbedingt immer der Fall
* Scheinbare Nebenläufigkeit
  * Zeitlich unabhängige Aufgaben, die scheinbar gleichzeitig ausgeführt
    werden
* Sequentielle Abarbeitung

Es soll eine scheinbare Nebenläufigkeit auf einem sequentiellen Prozessor
implementiert werden.

Ein *Ablaufplan* legt die Ausführungsreihenfolge der Aufgaben fest.
Dieser kann fest einprogrammiert sein, oder durch Regeln spezifiziert sein.
Ersteres nennt man ein *statisches*, zweiteres ein *dynamisches
Echtzeitsystem*.

Ein dynamisches System können Aufgaben unterbrechbar (*preemptive*) sein,
so kann flexibel auf externe Ereignisse reagiert werden.

Es muss eine Ablaufreihenfolge festgelegt werden. Dafür werden den Aufgaben
*Prioritäten* zugewiesen, die wiederum statisch oder dynamisch sein können.

### Ausführungsmodelle
Wie synchronisieren wir den Rechenablauf mit der externen Zeit*

#### Physical execution time programming *PET*
* Für jedes Ereignis wird eine feste Menge Programmzeit $c$ angefordert.
* Ein Ereignis bei $t_\epsilon$ ist zum Zeitpunkt $t_\epsilon + c$
  fertig.
* Nachteil: Software ist nicht portabel, z.B. auf einen langsameren
  Prozessor.

#### Logical execution time programming *LET*
* Synchronisation zur Realzeit mittels Timer
* Task wird immer zu fester Zeit (periodisch) ausgeführt
* Lesen und Schreiben immer bei Zeit $n \cdot T$

#### Zero execution time programming *ZET*
* Annahme: Prozessor ist sehr schnell vgl. zur Anwendung
* Ausführung eines Tasks in immer genau 1 Zeitschritt


Bei *LET* und *ZET* können statische Ablaufpläne erstellt werden.

#### Bounded execution time programming *BET*
* Sporadische Ereignisse
* Nach Eintreffen eines Ereignisses startet Ausführungsfrist

Ausführungsplan des scheinbar nebenläufigen Systems ist *vorhersehbar*!

#### RTOS
Nebenläufigkeitsmodelle werden durch einen **Scheduler** implementiert.
Zwischen Tasks und ISA liegt ein *OS* oder *RTOS*.

Ein *RTOS* hat die Eigenschaften:

* Geringe Interruptlatentz
* Vorhersehbarkeit
* Deterministische Ablaufpläne
