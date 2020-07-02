## Logic Fabrics
### Entwurfsprozess
* Y-Diagramm
  * Achsen Struktur, Verhalten, Geometrie
* Festlegen der Algorithmen: Verhalten
* Bindung zur Struktur Achse (Prozessor)
* Algorithmus -> Registertransferbeschreibung -> Register/Operationen -> Schaltalgebra -> Gatter
-> Transistorschaltung -> Transistorlayout -> Zellen -> SOC Komponenten
* BSP: Regler
  * Algorithmus in VHDL (`process`)
  * Speicher in Strukturebene
  * -> Ausführbare Spezifikation
  * Weitere Architecture in Registertransferebene/Gatterebene/...
    * Kann getestet werden mit Testbench, die anhand der Verhaltensbeschreibung konstruiert wird
  * -> Schrittweise Verfeinerung

### Synthese digitaler Schaltungen
* Verhalten -> Boolsche Gleichung
  * RTL Synthese
* Boolsche Gleichung -> Gatter Netzliste
  * Logiksynthese
    * Erst zu logischen Komponenten (minimierung), dann Gatter (Technologie)
* Silicon Synthese
  * Automatische Erzeugung des Layouts

### Chip Technologie
#### Full-Custom-Entwurf
* Layout und Schaltung spezifiziert
## Semi-Custom-Entwurf
* Nutzen von Standardzellen (z.B. Addierer als fertige Komponente)
* ASIC
* Gate Arrays / Sea of Gates
* FPGA

### ASIC Entwurf
#### Standardzellenentwurf
* Komponenten aus Bibliotheken (vorgefertigte Layouts)
* Bibliotheken enthalten auch Verhaltensbeschreibungen zur Simulation

#### Gate Array
* Array von Logikgattern
* Durch entsprechende Verdrahtungen (mittels Layoutsynthese) entstehen Schaltungen
* Braucht mehr Fläche als Full-Custom-Entwurf

#### Sea of Gates
* Metallisierung nicht zwischen Gates, sondern beliebig über Gates

#### Zusammenfassung
* Tradeoff Fläche<->Komplexität

### FPGAs
Field Programmable Gate Array
* Zusammengesetzt aus Arraystrukturen
* In Arrayelementen befindet sich programmierbare Schaltung
* n -> 1 Auswahllogik, Speicher realisiert LUT

