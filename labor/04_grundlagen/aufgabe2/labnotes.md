## Fancy Multiplexer
Hier war der Ansatz, so weit wie möglich den Ansatz aus Aufgabe 1 zu übernehmen.
Im Wesentlichen war es nur nötig, den Datentyp der Eingänge zu `STD_LOGIC_VECTOR` zu machen.
Das `SELECT` Statement konnte übernommen werden, wobei für den select Eingang jeweils
der passende Binärvektor notiert wurde:
```vhdl
SEL : IN std_logic_vector(2 DOWNTO 0);
```
```vhdl
WITH SEL SELECT
    RESULT <= IN1 WHEN "000",
    IN2 WHEN "001",
    IN3 WHEN "010",
    IN4 WHEN "011",
    IN5 WHEN "100",
    IN1 WHEN OTHERS;
```
Für Verwirrung beim Testen hat gesorgt, dass die Vektor-literals hier in anderer Reihenfolge als
erwartet sind.
Kurzes Testen:
```vdhl
LEDG(3 TO 7) <= "11100";
```
Das Ergebnis ist, dass LEDs 3 bis 5 leuchten. Die Literals im Multiplexer werden also umgedreht.
In Übung 2 ist das Problem wohl nicht aufgetreten, da das `SEL` Signal da mit `DOWNTO` statt `TO`
deklariert war, was hier aber das Problem auch nicht gelöst hat...

### Finaler VHDL Code

```vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY aufgabe2 IS
	PORT (
		SW : IN std_logic_vector(0 TO 17);
		LEDR : OUT std_logic_vector(0 TO 17);
		LEDG : OUT std_logic_vector(0 TO 7));
END aufgabe2;

ARCHITECTURE LogicFunction OF aufgabe2 IS
BEGIN
	LEDR(0 TO 17) <= SW(0 TO 17);
	my_mux : ENTITY work.multiplexer(LogicFunction)
		PORT MAP(
			IN1 => SW(0 TO 2),
			IN2 => SW(3 TO 5),
			IN3 => SW(6 TO 8),
			IN4 => SW(9 TO 11),
			IN5 => SW(12 TO 14),
			SEL => SW(15 TO 17),
			RESULT => LEDG(0 TO 2));
END LogicFunction;
```

```vhdl
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexer IS
    PORT (
        IN1 : IN std_logic_vector(0 TO 2);
        IN2 : IN std_logic_vector(0 TO 2);
        IN3 : IN std_logic_vector(0 TO 2);
        IN4 : IN std_logic_vector(0 TO 2);
        IN5 : IN std_logic_vector(0 TO 2);
        SEL : IN std_logic_vector(0 TO 2);
        RESULT : OUT std_logic_vector(0 TO 2)
    );
END multiplexer;

ARCHITECTURE LogicFunction OF multiplexer IS
BEGIN
    WITH SEL SELECT
        RESULT <= IN1 WHEN "000",
        IN2 WHEN "100",
        IN3 WHEN "010",
        IN4 WHEN "110",
        IN5 WHEN "001",
        IN1 WHEN OTHERS;
END LogicFunction;
```

