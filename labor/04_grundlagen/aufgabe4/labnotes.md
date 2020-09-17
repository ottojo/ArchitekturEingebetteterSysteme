## Volladdierer

Der Volladdierer konnte ohne Probleme implementiert werden:
```vhdl
ENTITY fulladder IS
    PORT (
        a : IN std_logic;
        b : IN std_logic;
        ci : IN std_logic;
        s : OUT std_logic;
        co : OUT std_logic
    );
END fulladder;

ARCHITECTURE LogicFunction OF fulladder IS
    SIGNAL ab : std_logic;
BEGIN
    ab <= a XOR b;
    s <= ab XOR ci;
    co <= (ab AND ci) OR (a AND b);
END LogicFunction;
```

Und dann zum Testen mit LEDs verbunden:
```vhdl
adder : work.fulladder
PORT MAP(
    a => SW(0),
    b => SW(1),
    ci => SW(2),
    s => LEDG(0),
    co => LEDG(1));
```

## Carry-Ripple-Addierer

Hier war ein 3-bit Carry-Ripple-Addierer gefragt, da ich aber in der Einführung schon mal
Generics verwendet habe, habe ich mich dazu entschieden den Addierer hinsichtlich der
Wortbreite zu parametrisieren. Das Instantiieren der einzelnen Addierer hat mit einem
`FOR ... GENERATE` statement funktioniert, auf der Suche nach Dokumentation bin ich dann
auf einen [Artikel auf allaboutcircuits.com](https://www.allaboutcircuits.com/technical-articles/how-to-use-vhdl-components-to-create-a-neat-hierarchical-design/)
gestoßen, der auch genau dieses Beispiel zur Veranschaulichung nutzt.
Neben dem `FOR ... GENERATE` wurde noch ein Vektor `c_inputs` für die carry Signale zwischen den
Addierern eingefügt.

```vhdl
gen : FOR i IN 0 TO BIT_WIDTH - 1 GENERATE
        adder : work.fulladder PORT MAP(a => a(i), b => b(i), ci => c_inputs(i), s => s(i), co => c_inputs(i + 1));
    END GENERATE;
    c_inputs(0) <= ci;
    co <= c_inputs(BIT_WIDTH);
```
