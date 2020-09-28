\clearpage
## Kurseinlage zu Vorlesung 10: "Analog-Digital Umsetzer"

In der Zehnten Vorlesung wurden die Analog-Digital Umsetzer (*ADC*) vorgestellt,
als essenzieller Baustein zwischen jeder Art von Sensor und einem digitalen
System zur Verarbeitung, wie einem Mikroprozessor. 

Es gibt viele verschiedene Arten, einen ADC zu realisieren, die alle unterschiedliche Vor- und Nachteile aufweisen und für verschiedene Anwendungsbereiche geeignet sind:

Zuerst wurden die **Parallelverfahren** vorgestellt, hier wird im einfachsten
Fall mir genau so vielen Komparatoren wie Quantisierungsstufen das Signal
abgeglichen, wobei die Komparatoren beispielsweise von einer Widerstandskette
Referenzspannungen in gleichen Abständen erhalten. Diese Art von ADC hat den
Vorteil, in einem einzelnen Taktzyklus das Signal zu digitalisieren, hat aber
den größten Hardwareaufwand von allen Typen. Ähnliche Umsetzer, die aber
mehrstufig aufgebaut sind, finden zum Beispiel in schnellen Oszilloskopen
Anwendung.

Eine Variante, die mit weniger Hardwareaufwand auskommt, ist das
**Wägeverfahren**. Hierbei wird nur ein einziger Komparator genutzt, die
Vergleichsspannung muss allerdings von einem DAC (Digital-Analog Wandler)
erzeugt werden. Durch bitweises annähern der Vergleichsspannung an die
Eingangsspannung, kann so der Wert dieser Digitalisiert werden. Da in dieser
Variante die Zeit der Messung direkt proportional ist zur Anzahl der zu
messenden Bits, wird üblicherweise eine Sample-and-Hold Schaltung benötigt, die
die Eingangsspannung während der Messung konstant hält.

Die **Zählverfahren** arbeiten nach dem Prinzip, die Analogspannung in eine
Frequenz oder eine Abfolge von Impulsen umzuwandeln, welche dann mit einem
digitalen Zähler gezählt werden können. Dafür muss die Spannung zuerst in eine
Zeitdauer umgewandelt werden, in dieser zu zählende Pulse generiert werden.
Typischerweise wird dies realisiert, indem die Eingangsspannung mit einem
Sägezahnsignal verglichen wird, beziehungsweise eine solche Rampe im Dual-Slope
Verfahren ein Rampenförmiges Signal abhängig von der Eingangsspannung innerhalb
vorgegebener Zeit erzeugt wird.

Im **Sigma-Delta Verfahren** ist die Herangehensweise, das Signal mittels des
Sigma-Delta Modulators in einen Bitstream umzuwandeln, in dem das Verhältnis von
Einsen und Nullen proportional zur Eingangsspannung ist. Da mir dieses Prinzip
in der Vorlesung nicht ganz klar wurde, habe ich zuerst einen Artikel von TI
[@baker2011] gefunden, welcher das Verfahren der Sigma-Delta Modulation noch mal
Schritt für Schritt auflistet. In letzten Teil wird auch kurz auf das
Noise-Shaping eingegangen, und mit einem Diagramm der unterschiedlichen
Rauschdichten verdeutlicht, warum Sigma-Delta ADCs höherer Ordnung nochmals
deutlich geringeres Rauschen aufweisen. Die Notwendigkeit der anschließenden
digitalen Filterung des Signals wird zwar angesprochen, für Details wird aber
auf einen anderen Artikel verwiesen. Eine weitere Resource, die besonders für
das Verständnis, wie der vom Modulator kommende Bitstream genau zu
interpretieren ist, war das interaktive Tutorial von Analog Devices
[@analog_adc_tutorial], welches das Eingeben von Eingangs- und Referenzspannung
erlaubt und dann für jeden einzelnen Schritt die Spannungswerte an den relevanten
Stellen darstellt.
