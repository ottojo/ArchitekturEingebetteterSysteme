## Counter
Die erste Herausforderung in dieser Aufgabe war es, die 50MHz Clock zu einer
1Hz Clock umzuwandeln, mit der dann gezählt wird.
Dafür wurde in jedem 50MHz-cycle eine Zählvariable erhöht, und wenn der Wert
25000000 erreicht, also alle 0.5s, der Clock-output invertiert:
```vhdl
-- Make a 1 Hz, 50% duty cycle clock
PROCESS (CLOCK_50, clk_1)
    VARIABLE count : INTEGER RANGE 0 TO 25000000;
BEGIN
    IF RISING_EDGE(CLOCK_50) THEN
        IF count = 25000000 THEN
            clk_1 <= NOT clk_1;
            count := 0;
        ELSE
            count := count + 1;
        END IF;
    END IF;
END PROCESS;
```

Mit dieser 1Hz Clock konnte dann das eigentlich Zählen ganz änhlich
implementiert werden:
```vhdl
-- Increment the number each clock cycle
PROCESS (clk_1)
    VARIABLE number : INTEGER RANGE 0 TO 9;
BEGIN
    IF RISING_EDGE(clk_1) THEN
        IF number = 9 THEN
            number := 0;
        ELSE
            number := number + 1;
        END IF;
    END IF;
    number_signal <= conv_std_logic_vector(number, 4);
END PROCESS;
```
Hier war noch eine Konvertierung von `integer` zu `std_logic_vector` nötig, da
das Modul für die 7-Segment Codierung ein Signal dieses Datentyps erwartet, und
eine `integer` Variable für den Zähler gewählt wurde.
