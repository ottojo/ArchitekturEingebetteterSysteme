## Counter bis 999
Der Counter an sich ist gleich wie im vorherigen Programm, für die höhere
Frequenz wurde einfach das maximum des Counters entsprechend angepasst, sodass
der Counter jetzt eine Clock mit 10Hz statt 1Hz erzeugt.
Für die Anzeige als Dezimalzahl ist eine Umwandlung in BCD hilfreich, hier wurde
der "Double dabble" Algorithus verwendet. Viele Implementierungen existieren,
hier wurde die auf Wikipedia gegebene verwendet, die zwar nicht optimal aber gut
verständlich und kommentiert ist.
Die Verwendung von BCD erlaubt es dann, für die einzelnen Zehnerstellen den
7-Segment Encoder der vorherigen Aufgaben vier mal zu verwenden:
```vhdl
Digit0 : ENTITY work.htb(LogicFunction) PORT MAP (ones, HEX0);
Digit1 : ENTITY work.htb(LogicFunction) PORT MAP (tens, HEX1);
Digit2 : ENTITY work.htb(LogicFunction) PORT MAP (hundreds, HEX2);
Digit3 : ENTITY work.htb(LogicFunction) PORT MAP (thousands, HEX3);

bcd : ENTITY work.bin2bcd_12bit(Behavioral)
    PORT MAP(number_signal, ones, tens, hundreds, thousands);
```
