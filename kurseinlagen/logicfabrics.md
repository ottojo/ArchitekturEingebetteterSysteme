## Kurseinlage zu Vorlesung 4: "Logic Fabrics: Technologie und Entwurf"
In dieser Vorlesung wurden einige Varianten der Realisierung eines eingebetteten
Systems gezeigt:

Gerade beim IC Design existieren eine Vielzahl unterschiedlicher
Abstraktionsebenen, von der physikalischen Beschreibung der Transistoren, über
elektrische und logische Schaltbilder bis hin zu Verhaltensbeschreibungen. Je
tiefer die Abstraktionsebene gewählt wird, desto höher die Flexibilität:

#### Full Custom
Bei einem sogenannten "Full Custom" Entwurf, also dem direkten Spezifizieren der
Halbleiterschichten des ICs, kann zum Beispiel das Layout einzelner
Schaltungselemente so angepasst werden, wie es für die spezielle Anwendung ideal
ist.

#### Semi Custom
Der *Semi Custom* Entwurf unterscheidet sich vom *Full Custom* Entwurf darin,
dass hier nicht der Physikalische Aufbau des Chips und der genaue
Fertigungsprozess interessiert, sondern die resultierende Logikfunktion der
Schaltung. Der Entwurf beschränkt sich hier also darauf, Logikgatter
zusammenzufügen. Einzelne Funktionen wie z.B. die Addition, können bereits als
fertige Komponenten in einer Bibliothek vorliegen, die vom Entwickler direkt
verwendet werden können.

#### Standardzellenentwurf
Beim Standardzellenentwurf werden vorgefertigte Komponenten verwendet, welche
beim Design zusammengefügt werden. Jede Komponente enthält bereits ein Layout,
welches somit nicht selbst entworfen werden muss. Zusätzlich können Komponenten
Verhaltensbeschreibungen zur Simulation enthalten.

#### Gate Arrays
Beim Gate Array Entwurf werden Gates verwendet, die bereits in einem Raster
angeordnet sind, und dann verbunden werden. Die Anordnung der Gates ist also
vorgegeben, die Verbindungen dazwischen aber nicht. Diese werden üblicherweise
auch nicht manuell, sondern mittels eines Synthesetools generiert.

Ein Nachteil des Gate Arrays im Vergleich zum Full-Custom oder
Standardzellenentwurf ist ein größerer Flächenbedarf des Chips.

Die Verdrahtung des Gate Arrays kann auch in Form einer Metallisierungsebene
permanent auf ein sogenanntes Sea-of-Gates aufgebracht werden, was ein
kompakteres Design ermöglicht.

#### Field Programmable Gate Arrays (FPGA)
Auf modernen FPGAs kann ein ganzes eingebettetes System inklusive mehrerer
Prozessorkerne realisiert werden. FPGAs enthalten auch eine Anordnung von
vordefinierten Modulen, welche aber programmierbar sind, zum Bespiel in Form
einer lookup table und Flipflops.



Zur Verdeutlichung der Vorlesungsinhalte habe ich nach einem zusammenfassenden
Text gesucht, der insbesondere die einzelnen Methoden vergleichend
gegenüberstellt, und mehr Unterschiede als Kosten und Flexibilität aufzählt.
Einen guten Überblick habe ich in einem Beitrag auf der Website "Numato Lab"
[@numato_fpga_asic] gefunden. Der Artikel wiederholt Anfangs kurz, was ein FPGA
und was ein ASIC ist, und zählt dann relevante Unterschiede auf. Ein
interessanter Unterschied ist, dass ASICs deutlich energieeffizienter arbeiten
als FPGAs, und gleichzeitig bei gleichem Produktionsprozess viel höhere
Frequenzen in digitalen Schaltkreisen ermöglichen. Außerdem wird noch hervorgehoben, dass in ASICs auch Analogkomponenten oder HF Schaltkreise realisiert werden können.

Der Artikel nennt als Gemeinsamkeit von FPGA und ASIC, dass beide mittels HDLs
wir Verilog und VHDL entworfen werden. Das wirft die Frage auf, wie das beim
ASIC Workflow funktioniert, ob hier Verilog mit Hilfe eigener Bausteine für
Gates direkt zu einem Maskenlayout synthetisiert wird, was natürlich im Kontrast
zur oben genannten Flexibilität, einzelne Gates genau anzupassen, steht. Eine
weitere interessante Frage, der hier aber nicht weiter nachgegangen wird, ist
auch, wie ein Analogdesign in solch einen Chip integriert wird, und ob hier auch
Beschreibungssprachen wie für digiale Logik existieren.
