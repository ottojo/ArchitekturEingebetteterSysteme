## Kurseinlage zu Vorlesung 4: "Logic Fabrics: Technologie und Entwurf"
In dieser Vorlesung wurde das Prinzip des Designs eines eingebetteten Systems
behandelt.

Oft kann durch kombinieren eines programmierbaren Prozessors mit
applikationsspezifischer Hardware ein Mehrwert erzeugt werden. Der Designprozess
eines solchen Systems ist jedoch komplex. Die Herangehensweise beim Entwurf, die
verwendete Technologie, und das Zusammenspiel derer sind wichtige Fragen beim
Design eines eingebetteten Systems.

Gerade beim IC Design existieren eine Vielzahl unterschiedlicher
Abstraktionsebenen, von der physikalischen Beschreibung der Transistoren, über
elektrische und logische Schaltbilder bis hin zu Verhaltensbeschreibungen. Je
tiefer die Abstraktionsebene gewählt wird, desto höher die Flexibilität:

Bei einem sogenannten "Full Custom" Entwurf, also dem direkten Spezifizieren der
Halbleiterschichten des ICs, kann zum Beispiel das Layout einzelner
Schaltungselemente so angepasst werden, wie es für die spezielle Anwendung ideal
ist.

Der sogenannte *Semi Custom* Entwurf entscheidet sich vom *Full Custom* Entwurf
darin, dass hier nicht der Physikalische Aufbau des Chips und der genaue
Fertigungsprozess interessiert, sondern die resultierende Logikfunktion der
Schaltung. Der Entwurf beschränkt sich hier also darauf, Logikgatter
zusammenzufügen. Einzelne Funktionen wie z.B. die Addition, können bereits als
fertige Komponenten in einer Bibliothek vorliegen, die vom Entwickler direkt
verwendet werden können.

Beide dieser Ansätze resultieren in *ASIC*s, also applikationsspezifischen
integrierten Schaltungen. Weitere Entwurfsmöglichkeiten sind z.b. *Gate Arrays*
bzw. *Sea of Gates* oder  *Field Programmable Gate Arrays*.

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


