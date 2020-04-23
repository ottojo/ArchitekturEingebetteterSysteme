# VHDL
## Einführung
* Verhaltensbeschreibung einer Schaltung
* Simulation der Schaltung

## Motivation
* GdRA: Boolsche Funktionen mittels Wahrheitstabelle
* Umsetzung der Funktion mittels Gatter
* 2 Varianten der Schaltungsbeschreibung
  * Schaltalgebraische Formel: **Verhaltensbeschreibung**
  * Schaltung aus Gattern: **Strukturbeschreibung**
* Abstraktionsebenen, Verhaltensbeschreibung <=> Struktubreschreibung:
  * Algorithmusebene: Algorithmus <=> Speicher, Prozessor
  * RTL (Registertransfer-Ebene): Datenfluss <=> Operatoonen, Register
  * Logische Ebene: Boolsche Gleichung <=> Gatterschaltung
  * Transistorebene: DGL <=> Transistor-Schaltplan
-> Y-Diagramm

### VHDL - Very High Speed Hardware Description Language
#### Signale
  * Signalzuweisung: `f <= ((not a) and b and c) or (...` -> Verhaltensbeschreibung der boolschen Funktion
    * Auch: Datenflussbeschreibung
#### Entity
Schnittstelle:
```VHDL
entity DECO is
  port (a,b,c: in bit;
        f    : out bit);
end DECO
```

Implementierung
```VHDL
architecture BEHAVIOR of DECO is
begin
  f <= ((not a) and b and c) or ...;
end BEHAVIOR;
```

Struktur
```VHDL
architecture STRUCTURE of DECO is
component AND
  port (a,b,c: in bit;
            f: out bit);
end component;

component OR
  port (a,b,c: in bit;
            f: out bit);
end component;

begin
  signal ia, ib: bit;
  signal ao1: bit;
  I1: INV port map(a, ia);
  A1: AND port map(ia,b,c,ao1);
  O:  OR port map(...
end
```


## Komponenten

## Verhalten

## Struktur

## Datentypen

## Simulationssemantik

## Beispiel

## Zusammenfassung

