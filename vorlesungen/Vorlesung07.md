## Sensoren und Aktoren II
### Komparator
* Kennlinie $\approx sgn(U_e)$
* Auch Vergleich zu Referenzspannung, statt direkt Differenz zu vergleichen

#### Fensterkomparator
* 2 OPVs mit verundetem Ausgang realisieren Vergleich, ob Spannung in einem bestimmten Bereich liegt.
* Bereich kann auch symmetrisch um $0V$ gelegt werden.
* Ersetzen des Und-Gatters durch RS fliopflop realisiert hysterese-verhalten (**Schmitt-Trigger**)
  * Einschalten und Ausschalten des Ausgangs bei unterschiedlichen Spannungswerten

### Sensor zur Geschwindigkeitsmessung
* Messen des statischen Drucks und des dynamischen Staudrucks: $p_s, p_d$
* Bernoulli Gleichung ergibt: $v_d = \sqrt{\frac{2 \cdot \Delta p}{\rho}}$
* Differentieller Drucksensor
  * Membran zwischen beiden Bereichen
  * Membran enthält Dehnungsmessstreifen mit längenabhängigem Widerstand $\implies$ Messbrücke

### Drehratensensor
* Lichtschranken durch sich drehende, teils transparente Scheibe
* Magnetfeldsensor und sich drehende Magneten
  * Sinusförmiges Signal -> Schmitttrigger -> Pulszähler

### Radar
* Aussenden eines gepulsten Funksignal

### Sonar
* Messen von reflektierten Schallwellen (z.B. mit Piezoelement)
* Richtungsmessung durch Bewegen der Antenne oder durch Laufzeitunterschiede bei vielen Empfängern

### Aktoren
* Fly By Wire
* Messung der Klappenstellung mit Potentiometer, Regelung der Position

### Anschluss von Sensoren
* Problem: Position der A/D, D/A Wandler
  * Neben Chip, Im Chip integriert
    * Analoge Übertragung hat Problem des Spannungsabfalls
    * Lösung: 4-Wire Messung
    * Low Voltage Differential Signaling LVDS:
      * Sender: H-Brücke
      * Differentielle Übertragung
  * Beim Sensor (digitale Übertragung zum Controller)
