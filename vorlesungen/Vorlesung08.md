## ADC/DAC
### Abtasttheorem
* TODO (oder auch nicht)

### DAC - Digital-Analog-Umsetzer
#### Parallele Verfahren
* Spannungsteiler:
  * Viele in Reihe geschaltete Widerstände erzeugen mehrere verschiedene Spannungen
  * Auswahl der passenden Spannung (genau eine)

#### Wägeverfahren
1. * Referenzspannung $U_0$
   * Widerstandsnetzwerk (parallel) erzeugt Ströme proportional zu den Wertigkeiten der Bits (2R, 4R, 8R, 16R, ...)
   * Schließen der Schalter entsprechend der Bits
   * Umwandeln des (summierten) Stroms in Spannung mittels OPV (Addierschaltung)
   * Nachteil: Potentialveränderung zwischen benachbarten Widerständen
2. * Modifizierte Version:
   * Wechselschalter (durch "Transmission Gates") zu GND statt einzelner Schalter, sodass Strom durch Widerstände konstant ist
3. Leiternetzwerk:
   * Gleiche Widerstände
   * TODO: Bild
   * Widerstandswert kürzt sich raus -> Schaltung nicht empfindlich gegenüber Schwankungen


#### Zählverfahren


### ADC
#### Parallele Verfahren
"Word at a time"

* Spannungsteiler mit vielen Widerständen
* Vergleichen der Spannungspegel mit der zu messenden Spannung $U_x$ mittels Komparatoren
* "Schablonenumsetzer"
* Register mit Clock nach Auslese zur Zeitdiskretisierung
* Nachteile:
  * Viele Komparatoren benötigt
* Alternative: Kaskadenverfahren
  * Sample and Hold
  * ADC (Schablonenumsetzer)
  * DAC
  * Subtraktion vom Eingangssignal
  * Verstärkung
  * ADC
  * Durch Überlappung der Messbereiche Fehlerkorrektur möglich
  * Pipelineverfahren möglich:
    * Mehrere Stufen nach gleichem Verfahren
    * Anlegen neuen Messwertes an ersten Stufen während spätere Stufen alten Messwert verarbeiten

#### Wägeverfahren
"Digit at a time"

* Sample and Hold
* Komparator
* Vergleichsspannung mittels DAC
* Iteration über alle Bits, beginnend mit MSB
* Entscheidungsbaum mittels Komparator-Ausgang
* Vorteil:
  * Entscheidungsverfahren in Software spart Hardware

#### Zählverfahren
"Level at a time"

* Prinzip: Erhöhung der Genauigkeit durch Messung einer Frequenz 
1. Sägezahnumsetzer
   * Sägezahngenerator generiert $U_s$
   * $U_s$ an Fensterkomparator zwischen 0V und $U_x$
   * Zeitmessung (durch Zähler) des Ausgangs
2. Dual Slope
   * $U_x$ an Wechselschalter mit $+U_0$ und $-U_0$
   * Integratorschaltung
   * Komparator
   * Steuerschaltung steuert Wechselschalter mittels Komparatorausgang:
     * Integration über feste Zeit
     * Integration konstanter Referenzspannung (mit anderem Vorzeichen als $U_x$) bis    Ausgangsspannung 0 ist
     * Messung der Zeitdauer der zweiten Integration

#### Delta-Sigma
* Eingangsspannung $U_x$
* Subtraktion $U_x-U_{DAC} = \Delta$
* Integration ($\Sigma$)
* ADC (n-bit)
* n-bit DAC erzeugt daraus $U_{DAC}
* Abtastrate der Wandler mit hoher Abtastrate
* Tiefpassfilter
