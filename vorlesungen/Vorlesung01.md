# Was ist ein Eingebettetes System
## Aufgaben
### Bitte beschreiben Sie kurz was ein eingebettetes System ist.
Ein eingebettetes System ist ein Rechnersystem, bei dem alle Komponenten hochintegriert und eng miteinander verbunden sind. Es wurden ja schon FPGAs erwähnt, ich denke da ist von einem eingebetteten System die Rede, wenn auf einem Chip sowohl ein Prozessorkern als auch diverse (evtl Applikationsspezifische) Peripherie untergebracht ist. Ein Eingebettetes System kann auch ein Microcontroller mit fest verbundenem Speicher und Peripherie sein.

Die charakteristischen Eigenschaft eines eingebetteten Systems ist die enge Verknüpfung eines Prozessors mit Peripherie, welche ein sehr Anwendungsspezifisches Computersystem realisiert.

Eingebettete Systeme bieten durch die enge Integration Vorteile wie Energieeffizienz und reduzierte Herstellungskosten, oder erhöhte Performance durch wegfallen von generischen Schnittstellen, bringen aber den Nachteil der geringeren Flexibilität (außer im oben genannten FPGA Beispiel z.B.).

Ein eingebettetes System kann aber auch ein klassischer PC sein, der z.B. durch besonders kleine Bauform in andere Anwendungen integriert ist, z.B. in industriellen Steuerungsanlagen oder Maschinen. Hier bezieht sich "eingebettet" auf den Kontext des Systems und nicht auf die einzelnen Rechnerkomponenten.

## Vorlesungsnotizen
### Zeitleiste
* ABS beim Flugzeug
 * Verhindern des Blockieren der Räder beim Landen auf nasser Piste
  * 1927 entwickelt
  * Realisierungstechnik: Mechanisches System
  * Setzt sich auf Grund von Kosten nicht beim Auto durch
* Konrad Zuse
  * 1936: Mechanische Rechenanlagen
  * Später mit Relais
* Raketentechnik 1940-1950
  * A4: Steuerung erst durch Uhr
  * Funkstation (Röhren) am Boden steuert Rakete
    * Funktechnik versagt aufgrund von Vibrationen in Rakete
* Transistor: 1947
* Computer mit Röhren (ENIAC)
* Transistoren erhöhen Zuverlässigkeit und ermöglichen mehr Komplexität
* Kalter Krieg: 1950
  * Minuteman Projekt: Interkontinentalrakete
    * Fernsteuerung funktioniert nicht aufgrund von Funkschatten
    * Miniaturisierung eines Rechners (mit Transistoren) zur Integration in Rakete
    * Integrierte Schaltung (IC)
* Mondlandeprogramm
  * Benötigt integrierte Steuerung
  * Navigationscomputer AGC aus ICs (NOR-Gatter)
    * Nicht gelötet, sondern Wire-Wrap für Vibrationsschutz
    * Prototyp jedes heutigen Eingebetteten Systems
* Kampfflugzeuge mit AGC
  * Technisches System (Rakete, Flugzeug, Auto) + Computer

### Definition
* Computer bekommt Messdaten von Sensoren, steuert Aktoren
> Ein Eingebettetes System ist ein Computer der steuert, regelt, und in einen technischen Kontext eingebunden ist.
* Heutige Computer (z.B. ABS, Airbag) gehen direkt auf AGC zurück

