## Entwurfsraum
Im ersten Schritt soll die Laufzeit der Software- und Hardware CRC bestimmt
werden. Aus Frustration mit Intel-Tools wird dies nicht mir sicher irgendwo
vorhandenen Profiling Tools gemacht, sondern mittels an- und ausschalten einer
LED und einer Stoppuhr.

Die Berechnung von $10^6$ CRCs mittels Hardware-CRC dauert ca. 9.8s, was bei
einer Taktfrequenz von 50MHz ca. 490 Taktzyklen pro CRC entspricht.
Bei der reinen Software Implementierung dauert eine CRC Berechnung ganze 7750
Taktzyklen.

Das Hinzufügen des CRC Moduls in QSys führt zu einem Anstieg der genutzten
Logikelemente von 2171 auf 2410, statt 1328 Registern werden 1436 gebraucht.

In diesem konkreten Fall ist die Implementierung der CRC in Hardware sicherlich
sinnvoll, da die Anzahl der benötigten Logikelemente besonders im Vergleich zu
den bereits benötigten Elementen für den Prozessor gering ist. Die Laufzeit der
Hardware CRC ist bedeutend kleiner, was allerdings auch der Tatsache geschuldet
ist, dass die Software CRC keine optimale Implementierung darstellt. Vor einer
Entscheidung müsste hier noch eine optimierte Softwareimplementierung getestet
werden. Die Software-Variante hat darüber hinaus den enormen Vorteil, dass sie
jederzeit ausgetauscht werden kann, auch wenn die Konfiguration des Chips nicht
mehr geändert werden kann. Gibt es an die CRC Berechnung allerdings harte
Echtzeitanforderungen, muss dies zusätzlich sichergestellt werden, die VHDL
Implementierung läuft unabhängig von anderen Tasks auf dem Prozessor immer in
gleicher Zeit.
