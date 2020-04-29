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
Komponenten sind `entity`s. Schnittstelle wird mit `port` spezifiziert.
Port spezifiziert mehrere Eingänge `in`, an die Eingangssignale angeschlossen werden.
Eingangssignale müssen spezifiziertem Typ (z.B. `bit`) entsprechen.
Port spezifikation enthält auch Ausgänge `out` und Ein/Ausgänge `inout`.
```VHDL
entity Name is
  port (i1, i2, i3: in Bit;
        o1, o2:     out Bit;
        io1:        inout Bit
       );
end;
```

Komponenten können aus Unterkomponenten bestehen, die miteinander verbunden sind.
Diese Unterkomponenten können aus einer Bibliothek kommen.

Bibliothek wird genutzt mit
```VHDL
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
```

Der Inhalt einer Komponente wird spezifiziert mit der Anweisung `architecture`:
```VHDL
architecture behavior of Name is
Begin



End
```

Komponente kann mit Verhaltens- oder Strukturbeschreibung spezifiziert sein.
```VHDL
architecture structure of Name is
Begin

End;
```

Eine Entity kann aus mehreren Architekturen aufgebaut werden. Zuerst wird das
Verhalten spezifiziert. Dieses Verhalten wird getestet, durch eine Testbench Entity.
Dann kann die Komponente "gebaut" werden, also die Strukturbeschreibung.

Das Verhalten stellt die Spezifikation dar, die Struktur stellt die Implementierung dar.

```VHDL
configuration name of Entity is

end configuration
```

## Verhalten
Das Konzept `process` kapselt algorithmisches Verhalten.

Beispiel Multiplexer:
```VHDL
MX: process (a,b,s)
Begin

  if s='1' then
    o<=a;
  else
    o<=b;
  endif;

end process;
```
Auch Schleifenkonstrukte wie `for`, `while` sind möglich.

Ein `process` spezifiziert beliebige Algorithmen.

Auch auf der Registertransferebene lässt sich Verhalten spezifizieren:
```VHDL
architecture...
begin

o<=a when s='1' else
   b

end...
```
Dies ist eine Datenflussbeschreibung.

## Struktur
Spezifizieren einer Komponente aus Bibliothek:
```VHDL
component NAND
  port (
    a,b: in  bit;
    c:   out bit
  );
end component;
```

Aufrufen der Komponente:
```VHDL
nand1: NAND portmap(t, s, o)
                   (a=>t, b=>s, c=>o)
```

## Datentypen
* Numerische Datentypen
  * Integer, Real
* Boolean `true`/`false`
* Character
* String
* Time (fps oder s,h)
* Bit `'1'`/`'0'`
* Bit_Vector `"10001"`

### IEEE
* std_logic
  * Mehr logische Werte: `U, X, 0, 1, Z, L, H, W, -`
* std_ulogic
* std_logic_vector

### Userdefiniert
```VHDL
type int0 is range 0 to 100;
type int1 is range -100 to 1000;
```

### Subtypes
"Vererbung":
```VHDL
subtype int5 is Integer range -5 to 5;
```

### Aufzählungen
```VHDL
type state is (locked, unlocked, ...);
```

### Komplexere Datentypen
4-bit breiter Bus:
```VHDL
type BUS is array(0 to 3) of bit;
```

Äquivalent zu c-struct:
```VHDL
type INTERFACE is record
  bus: BUS;
  ctrl: BIT;
  date: BUS;
end record;
```

## Simulationssemantik

## Beispiel

## Zusammenfassung

