\clearpage
## Kurseinlage zu Vorlesung 7: "Sensoren und Aktoren II"

In diesem Kapitel wird als Beispiel für einen Sensor im eingebetteten System das
Staurohr eines Flugzeugs betrachtet. Ziel des Sensors ist es, die
Geschwindigkeit des Flugzeugs relativ zur umgebenden Luft zu bestimmen. Wenn
mittels einer Sonde sowohl der Staudruck als auch der statische Druck außerhalb
des Flugzeugs gemessen werden, kann aus der Differenz der beiden Werte die
Geschwindigkeit ermittelt werden. Da nur die Differenz von Staudruck und
statischem Druck interessiert, kann der Sensor in Form einer Membran zwischen
zwei Volumina, in denen der jeweilige Druck herrscht, realisiert werden. Ein
Dehnungsmessstreifen auf der Membran verändert seinen Widerstand je nach Wölbung
der Membran. Die Messung des Widerstands geschieht mit einer Messbrücke.

Ein anderer im Flugzeug benötigter Sensor ist der Drehratensensor am Fahrwerk.
Die gemessene Drehrate kann zum Beispiel als Eingang für ein Antiblockiersystem
verwendet werden. Zur Messung der Drehrate gibt es verschiedene Messmethoden.
Die erste vorgestellte Methode ist ein optischer Sensor, der durchsichtige und
undurchsichtige Bereiche einer sich drehenden Scheibe erkennt. Durch Zählen der
Ausgangsfrequenz kann die Drehrate bestimmt werden. Eine andere Möglichkeit ist,
Magnete so am sich drehenden Teil zu befestigen, dass diese sich an einem
stationären Hallsensor vorbeibewegen, welcher das Magnetfeld misst. Wie beim
optischen Sensor kann dann die Drehrate bestimmt werden. Ein Unterschied ist,
dass beim (analogen) Hallsensor das sinusförmige Ausgangssignal zuerst in eine
Impulsfolge umgewandelt werden muss, was mit einem Schmitt Trigger möglich ist.

Im Flugzeug-Beispiel ist neben der Sensorik auch die Aktorik vertreten. Die
Klappen werden heutzutage elektrisch angesteuert, der Aktor kann direkt an der
Klappe angebracht sein, und es sind nur elektronische Leitungen zum
Steuercomputer notwendig. In der Vorlesung wird als Steuersignal PWM
vorgestellt. Da PWM als nicht sehr resistent gegenüber Elektromagnetischer
Interferenz bekannt ist, und natürlich keinerlei Fehlererkennung und -korrektur
beinhaltet, wirkte es etwas verwunderlich, dass ein PWM Signal für eine solche
sicherheitsrelevante Aufgabe über längere Strecken benutzt wird. Im nächsten
Teil der Vorlesung wurden dann auch SPI, I2C und UART als digitale Protokolle
zwischen Sensor-, Aktor-, und Prozessorkomponenten in einem System vorgestellt,
auf LVDS wurde detaillierter eingegangen. Nach kurzer Recherche bin ich auf
`AFDX` gestoßen, ein auf Ethernet aufbauendes Netzwerk, welches von Airbus
speziell für Flugzeugsysteme entwickelt wurde.

Ein Überblick ist in [@yanik2007] gegeben. AFDX wurde entwickelt, da bestehende
Netzwerktechnologien im Flugzeugbereich nicht die ausreichenden Datenraten
unterstützten. Das Paper erklärt zuerst, dass bei traditionellem Ethernet
Übertragungen kollidieren können, was dazu führen kann dass manche Pakete nie
übertragen werden, oder nur mit großer Verzögerung. Daher ist es notwendig,
Full-Duplex Switched Ethernet zu verwenden, bei dem ein Link nur einen einzigen
Host mit einem Switch verbindet. AFDX Ethernet Frames enthalten wie normale
Ethernet Frames eine Checksumme, die Start- und Zieladressen sind allerdings
genau spezifiziert und enthalten eine "Virtual Link ID", welche zum Routen der
Pakete verwendet wird. Ein AFDX Payload wird in einem UDP Paket verschickt,
welches im UDP Header eine weitere Prüfsumme enthält. Nach dem Payload wird
allerdings noch eine Sequenznummer angefügt, was bei UDP normalerweise nicht der
Fall ist. In [@yanik2007] wird auch ein 20 Byte IP Header, was auf eine
Verwendung von IPv4 schließen lässt, obwohl das nicht explizit angegeben ist.
Warum hier UDP Pakete mit Sequenznummer im Payload verwendet wird, und nicht
TCP, wird nicht ganz klar. Das charakteristische Feature sind die oben erwähnten
"Virtual Links", die mit einer maximalen Bandbreite spezifiziert sind. Die
Switches kennen die Spezifikation aller Virtual Links, und können eintreffende
Pakete, die das Limit überschreiten verwerfen, um die Bandbreite für andere
Links zu garantieren.
