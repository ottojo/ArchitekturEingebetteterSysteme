## Software CRC
Das Implementieren der CRC in C lief ähnlich wie die Implementierung in VHDL,
mit dem Unterschied dass sich die C-Implementierung deutlich einfacher lokal
testen lies. Nachdem der Abgleich mit diversen Online-CRC-Tools widersprüchliche
Ergebnisse lieferte, wurde die Programmausgabe Schritt für Schritt mit dem
manuell gerechneten Beispiel auf [Wikipedia](https://en.wikipedia.org/w/index.php?title=Cyclic_redundancy_check&oldid=979058159#Computation)
verglichen, und mittels CRC-Berechnung, Prüfung, und Prüfung nach Flippen 
eines Bits das erforderliche Vertrauen in die Korrektheit der Implementierung
gewonnen.
