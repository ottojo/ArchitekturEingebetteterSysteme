## Latches + flip-flop: Beschreibung als Process
In diesem Teil wird wieder das D-Latch verwendet. Hier ist allerdings eine
Implementierung angegeben, also wird nicht auf die vorherigen Aufgaben
zurückgegriffen. Der Flipflop soll im gleichen Stil implementiert werden.
Neu ist hier die Funktion
`rising_edge ( signal s : std_ulogic ) return boolean`, die an der Stelle
verwendet wird, wo beim Latch `Clk = '1'` geprüft wird:

```vhdl
ENTITY flipflop IS
    PORT (
        D, Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC);
END flipflop;
ARCHITECTURE Behavior OF flipflop IS
BEGIN
    PROCESS (D, Clk)
    BEGIN
        IF RISING_EDGE(Clk) THEN
            Q <= D;
        END IF;
    END PROCESS;
END Behavior;
 ```

 Der Technology Map Viewer zeigt für das Latch einen Block `LOGIC_CELL_COMB`
 und für die Flipflops tatsächlich nur einen Block der dem Schaltbild eines
 Flipflops entspricht. Dies deutet darauf hin, dass tatsächlich die im FPGA
 enthaltenen Flipflops verwendet wurden.
 