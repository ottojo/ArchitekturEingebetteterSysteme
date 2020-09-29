\clearpage
# Zusatzthema: nMigen

## Motivation
Schon seit den 1980er bzw. 1990er Jahren existieren die uns bekannten Sprachen
zur Hardwarebeschreibung VHDL [@vhdl_1987] und Verilog [@verilog_1995]. Wir
haben in VHDL die Möglichkeiten, einen Schaltkreis sowohl anhand dessen
Struktur, also der direkten Verschaltung und Verknüpfung von Komponenten und
Signalen, als auch über das gewünschte Verhalten des Schaltkreises zu
beschreiben. Es ist möglich, Teile eines Gesamtsystems in Komponenten
auszulagern, welche auch mehrfach wiederverwendet beziehungsweise instanziiert
werden können. Möglichkeiten zur Metaprogrammierung sind vorhanden mit
Konstrukten wie `generic` und `generate` [(Übung)](#carry-ripple-addierer).

Dennoch wäre es wünschenswert, Hardwarebeschreibung mittels bereits bekannter,
etablierter Programmiersprachen zu realisieren, die auch für wiederkehrende
Probleme wie Dependency-Management, das Wiederverwenden von Code (Libraries),
etc. bereits eine Lösung bereithalten. Ein nicht von der Hand zu weisender
Vorteil ist auch, dass viele Entwickler bereits Erfahrung in einer dieser
Sprachen besitzen, was auch zur wachsenden Popularität dieser Lösungen beiträgt.

Mehrere Projekte, die Hardwarebeschreibung in Form von *domain specific
languages (DSL)* innerhalb anderer Programmiersprachen realisieren, existieren.
Einige Beispiele, mit definierenden Features und Highlights sind:

* RubyRTL [@rubyrtl_2020]:  Erstmals präsentiert in [@lann2020hardware],
  baut RubyRTL auf die Programmiersprache Ruby auf, unter anderem weil es in
  Ruby möglich ist, der Sprache scheinbar neue Keywords hinzuzufügen.
* MyHDL [@jaic2015]: Motiviert von der weiten Verbreitung und der umfassenden
  Standardbibliothek, setzt MyHDL auf Python. Ein Fokus liegt auf Code reuse und
  Abstraktion von Interfaces, was schnelles Prototyping ermöglichen soll.
* Chisel [@bachrach2012]: Chisel ist in Scala implementiert, und unterstützt
  Generierung von sowohl Verilog als auch C++ Code für Simulation des Designs.

Dies sind nur einige Beispiele von vielen verschiedenen DSLs, hier nur zu
erwähnen sind noch PyRTL [@clow2017], CLasH [@baaij2009], SysPy [@logaray2010]
und SpinalHDL [@spinalhdl]. Die hier näher betrachtete Lösung ist *nMigen*
[@nmigen].

Im Folgenden soll ein beispielorientierter Überblick über die wichtigsten
Konzepte in nMigen gegeben werden, um einen Eindruck von der Bibliothek zu
bekommen. Mein Ziel ist es auch zu testen, wie vergleichbar das Ganze mit VHDL
ist, und ob die oben genannten Ziele erfüllt werden.

## Hintergrund
nMigen ist die zweite Version der Migen Bibliothek für Hardware Design in
Python. Die gesamte Software ist Open Source, gehostet auf
[GitHub](https://github.com/m-labs/nmigen). Auf GitHub werden 25 Autoren
gelistet, die initiale Entwicklung stammt aber von der Firma
[M-Labs](https://m-labs.hk/), welche auch initialer Autor des Vorgängers *Migen*
ist. Zusätzlich an der Entwicklung beteiligt ist die Firma
[LambdaConcept](https://lambdaconcept.com/), welche wie M-Labs Migen und nMigen
in eigenen Produkten einsetzen.


## Board Definition
In nMigen (genauer: im Modul
[nmigen-boards](https://github.com/m-labs/nmigen-boards)) sind viele FPGA-Boards
von unterschiedlichen Herstellern, mit freien und proprietären Toolchains,
bereits definiert. Das *DE2-115* fehlt zwar, kann aber mit vergleichsweise wenig
Aufwand hinzugefügt werden, da bereits mehrere *DE0* und *DE10* Boards
existieren: Eine neue Klasse `DE2115Platform` wird erstellt, diese erbt von
`IntelPlatform`, was bereits die meisten relevanten Einstellungen enthält. Hier
ein Ausschnitt der entsprechenden Datei, hier werden die vorhandenen Clocks,
LEDs, Buttons, Schalter und eine serielle Schnittstelle definiert:


```python
class DE2115Platform(IntelPlatform):
    device = "EP4CE115"  # Cyclone IV
    package = "F29"
    speed = "C8"
    default_clk = "clk50"
    resources = [
        Resource("clk50", 0, Pins("Y2", dir="i"),
                 Clock(50e6), Attrs(io_standard="3.3-V LVTTL")),
        Resource("clk50", 1, Pins("AG14", dir="i"),
                 Clock(50e6), Attrs(io_standard="3.3-V LVTTL")),
        Resource("clk50", 2, Pins("AG15", dir="i"),
                 Clock(50e6), Attrs(io_standard="3.3-V LVTTL")),

        *LEDResources(pins="E21 E22 E25 E24 H21 G20 G22 G21",
                      attrs=Attrs(io_standard="2.5 V")),

        *ButtonResources(pins="M23 M21 N21 R24",
                         attrs=Attrs(io_standard="2.5 V")),

        *SwitchResources(pins="AB28 AC28 AC27 AD27 AB27 AC26 AD26 AB26 AC25 "
                              "AB25 AC24 AB24 AB23 AA24 AA23 AA22 Y24 Y23",
                         attrs=Attrs(io_standard="2.5 V")),

        UARTResource(0,
                     rx="G12", tx="G9", rts="J13", cts="G14",
                     attrs=Attrs(io_standard="3.3-V LVTTL")),
    ]
```

Um anderen Nutzern von nMigen das Verwenden des DE2-115 einfacher zu machen,
wurde ein [Pull-Request](https://github.com/m-labs/nmigen-boards/pull/54) auf
GitHub für die Boarddefinition erstellt.

## Hello World
Das klassische "Hello World" der Hardware Welt ist sicher das "Blinky" Programm,
das nichts weiter tut, als eine LED zu blinken. So auch im nMigen Tutorial
[@nmigen_tutorial], dem in den nachfolgenden Kapiteln gefolgt wird:


```python
from nmigen import *
from nmigen.cli import main
 
 
class Blinky(Elaboratable):
    def __init__(self):
        self.led = Signal()
 
    def elaborate(self, platform):
        m = Module()
        counter = Signal(3)
        m.d.sync += counter.eq(counter + 1)
        m.d.comb += self.led.eq(counter[2])
        return m
 
 
if __name__ == "__main__":
    top = Blinky()
    main(top, ports=[top.led])
```

Klassen, die synthetisierbare Module erzeugen, erben immer von `Elaboratable`.
Die Funktion `elaborate()` der Klasse erzeugt dann das entsprechende Modul.
Signale werden im Konstruktor angelegt.

Hier kann natürlich auf sämtliche Python Features zurückgegriffen werden, mit
Hilfe der `math` Bibliothek beispielsweise wird der Counter auf ca. 1Hz
eingestellt, und die tatsächliche Frequenz wird ausgegeben:
```python
counter_width = round(log2(platform.default_clk_frequency))
actual_freq = platform.default_clk_frequency / (2 ** counter_width)
print(f"creating {counter_width}-bit counter, "
      f"resulting frequency will be {actual_freq}Hz")

counter = Signal(counter_width)
m.d.sync += counter.eq(counter + 1)
m.d.comb += self.led.eq(counter[-1])
```

Das `Blinky` Modul ist noch nicht mit Pins auf dem Board verbunden, dafür wurde
ein zweites Modul geschrieben, um `Blinky` nicht darauf zu beschränken, direkt
Hardware Pins anzusteuern:
```python
class Blinker(Elaboratable):
    def __init__(self):
        self.blinky = Blinky()

    def elaborate(self, platform):
        m = Module()
        m.submodules.blinky = self.blinky
        led_pin = platform.request("led", 0)
        m.d.comb += led_pin.o.eq(self.blinky.led)

        return m
```

In diesem Modul wird ein `Blinky` instanziiert und als Submodul verwendet.
Mittels `platform.request` wird der als `"led0"` definierte Pin des jeweiligen
Boards verwendet.

Um das Programm auf das Board zu schreiben genügt:
```python
top = Blinker()
DE2115Platform().build(top, do_program=True)
```

In diesem Fall ist der Output von nMigen Verilog Code, welcher dann mit der
Quartus Toolchain von Intel/Altera synthetisiert und auf den FPGA geladen wird.
Für FPGAs der *iCE40* und *ECP5* Serie von Lattice wird eine vollständig freie
Open Source Toolchain (Yosys+nextpnr [@yosys_nexpnr]) verwendet.

## Kombinatorische und Synchrone Logik
Die eigentliche Spezifikation der Logik im Blink Beispiel passiert in der
Funktion `elaborate`:
```python
def elaborate(self, platform):
    m = Module()
    counter = Signal(3)
    m.d.sync += counter.eq(counter + 1)
    m.d.comb += self.led.eq(counter[2])
    return m
```
Wie auch VHDL kennt nMigen kombinatorische und synchrone Logik. Mit
```python
m.d.sync += counter.eq(counter + 1)
```
wird der counter in jedem Taktzyklus inkrementiert, in der nächsten Zeile
```python
m.d.comb += self.led.eq(counter[2])
```
wird die LED aber fest mit dem höchstwertigem Bit des Zählers verbunden,
unabhängig von der Clock (Kombinatorische Logik).

## Hierarchische Designs
Im vorherigen Kapitel wurde bereits ein hierarchisches Design verwendet, ohne
genauer darauf einzugehen. Um dieses Prinzip genauer zu verstehen, soll eine ALU
(*Arithmetic Logic Unit*) aufgebaut werden, die zwei Eingänge abhängig von einem
Kontrollsignal addiert oder subtrahiert.

Im ersten schritt wird ein Addierer und ein Subtrahierer geschrieben:
```python
class Adder(Elaboratable):
    def __init__(self, width):
        self.a = Signal(width)
        self.b = Signal(width)
        self.o = Signal(width)

    def elaborate(self, platform):
        m = Module()
        m.d.comb += self.o.eq(self.a + self.b)
        return m
```

```python
class Subtractor(Elaboratable):
    def __init__(self, width):
        self.a = Signal(width)
        self.b = Signal(width)
        self.o = Signal(width)

    def elaborate(self, platform):
        m = Module()
        m.d.comb += self.o.eq(self.a - self.b)
        return m
```

Diese Module enthalten beide jeweils zwei Eingänge `a` und `b` und einen Ausgang
`o`. Die Addition und Subtraktion wird in Form von kombinatorischer Logik
angegeben. Anzumerken ist hier aber, dass dem Konstruktor ein weiteres Argument
`width` hinzugefügt wurde. Dies ist die Breite der Ein- und Ausgangssignale, und
kann frei gewählt werden. Die ALU wird auch ein entsprechendes Argument erhalten
und dann den passenden Addierer/Subtrahierer instanziieren:

```python
class ALU(Elaboratable):
    def __init__(self, width):
        self.op  = Signal()
        self.a   = Signal(width)
        self.b   = Signal(width)
        self.o   = Signal(width)
 
        self.add = Adder(width)
        self.sub = Subtractor(width)
 
    def elaborate(self, platform):
        m = Module()
        m.submodules.add = self.add
        m.submodules.sub = self.sub
        m.d.comb += [
            self.add.a.eq(self.a),
            self.sub.a.eq(self.a),
            self.add.b.eq(self.b),
            self.sub.b.eq(self.b),
        ]
        with m.If(self.op):
            m.d.comb += self.o.eq(self.sub.o)
        with m.Else():
            m.d.comb += self.o.eq(self.add.o)
        return m
```

Im Konstruktor wird der Addierer und Subtrahierer instanziiert und als
Membervariable zugewiesen. In der `elaborate` Funktion werden diese dem Modul
als Submodul hinzugefügt, und die Ein- und Ausgänge der Module werden mit den
entsprechenden Signalen der ALU verbunden. Das zusätzliche Signal `op` wählt die
Funktion der ALU aus. Da das resultierende Design ja beide Modi enthalten muss,
kann hier kein python-`if` verwendet werden, sondern in einer etwas abweichenden
Syntax:
```python
with m.If(self.op):
    m.d.comb += self.o.eq(self.sub.o)
with m.Else():
    m.d.comb += self.o.eq(self.add.o)
```

## Testing
nMigen unterstützt Integration in Pythons standard Unit-Testing tools, und
integriert Möglichkeiten zur Simulation. Natürlich kann auch ohne Hilfe von
Unit-Test Bibliotheken ein Test geschrieben werden:
```python
width = 4
alu = ALU(width)
sim = Simulator(alu)
with sim.write_vcd("alu.vcd"):
    def process():
        for a, b in itertools.product(range(2 ** width), range(2 ** width)):
            yield alu.a.eq(a)
            yield alu.b.eq(b)
            yield alu.op.eq(0)
            yield Delay()
            print(f"{a}+{b}={(yield alu.o)}")
            assert (a + b) % (2 ** width) == (yield alu.o)
            yield alu.op.eq(1)
            yield Delay()
            print(f"{a}-{b}={(yield alu.o)}")
            assert (a - b) % (2 ** width) == (yield alu.o)
```
Für den Simulator wird die `process` Funktion definiert, die mittels `yield` die
Simulierten Eingänge generiert, und dann zum verifizieren der Ergebnisse mit
`assert` die Korrektheit prüft.

## Evaluation
Nach einigem Ausprobieren und Testen bin ich der Ansicht, dass HDLs wie nMigen
gut nutzbar und eine echte Alternative zu VHDL sind. Dass die Integration in
Python nicht nur eine Fülle an Möglichkeiten zur Metaprogrammierung liefert,
sondern auch die Wiederverwendung von Modulen vereinfacht, ist ein enormer
Vorteil. Für den Vorgänger von nMigen, `Migen`, existiert das LiteX Projekt
[@kermarrec2020litex], eine Open-Source Bibliothek, die alle Bestandteile
enthält um einen eigenen SoC (*System On Chip*) im Baukastensystem aufzubauen.
Neben verschiedenen Softcores sind Schnittstellen wie Ethernet, PCIe, DRAM und
mehr verfügbar, für Videoverarbeitung existieren im LiteVideo Projekt HDMI Ein-
und Ausgang sowie Module zur Konvertierung zwischen Farbräumen.

Die verfügbare Dokumentation zu nMigen lässt momentan noch zu Wünschen übrig,
das [Manual](https://m-labs.hk/migen/manual/index.html) zum Vorgänger Migen ist
aber ausführlich. Auf GitHub sind außerdem einige Projekte und Beispiele zu
finden, teils auch für spezifische Boards.

Abschließend lässt sich sagen, dass besonders mit Python Vorkenntnissen nMigen
einen einfacheren Einstieg bietet als VHDL, die Hardware-Kompatibilität und
Dokumentation für den Produktiven Einsatz aber besser werden muss.
