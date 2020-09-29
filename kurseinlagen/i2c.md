\clearpage
## Kurseinlage zu Vorlesung 11: "Programmierung eingebetteter Systeme"

Ab dieser Vorlesung wird sich nicht mehr mit der Hardware, sondern der Software
und der Schnittstelle zwischen Hard- und Software befasst.



Eine populäre Methode zur Anbindung von Peripherie an einen Prozessorkern ist
das zugänglich machen von Registern mittels *Memory Mapped IO*. Hier kann das
Gerät in einer Weise vom Prozessor angesprochen werden, die sich nicht von
"normalen" Speicherzugriffen unterscheidet. Dafür werden üblicherweise vom
Treiber Datenstrukturen definiert, die das Interface zur Peripherie so abbildet,
dass es für andere Programme benutzbar ist. Der Treiber bietet oft auch
Funktionen zum interagieren mit dem Gerät an, welche die Abstraktionsebene
anheben und z.B. verschiedene Varianten eines Gerätetyps ansprechen können oder
Fehlerbehandlung beherrschen.

Besonders für Sensoren, dessen Messungen mit wenig Verzögerung verarbeitet
werden sollen, sind *Interrupts* ein wichtiges Konzept. Hier wird der Prozessor
(durch den *Interrupt Controller*) in der Ausführung unterbrochen, und eine
vorher definierte *Interrupt Service Routine* wird ausgeführt, welche dann z.B.
die Verarbeitung des Sensorwerts anstoßen kann.


Ein verbreitetes Kommunikationsprotokoll zwischen Prozessoren und
Ein-/Ausgabegeräten ist **I2C**. Hier sind mehrere Geräte an einem geteilten Bus
verbunden, und ein oder mehrere dieser Geräte können als Initiator den Bus für
die Kommunikation mit einem anderen, durch eine eindeutige Adresse
spezifiziertem Gerät nutzen. Aus aktuellem Eigenbedarf und zum verdeutlichen der
Prinzipien eines Gerätetreibers soll hier die Benutzung von I2C Geräten unter
Linux betrachtet werden. Dies unterscheidet sich etwas von der Art, wie
entsprechende Geräte z.B. auf Mikrocontrollern angesprochen werden, da bereits
einige Schichten an Abstraktion vom Betriebssystem zur Verfügung gestellt
werden.

In der aktuellen Kernel Dokumentation [@kernel] im Kapitel ["I2C and SMBus
Subsystem"](https://www.kernel.org/doc/html/latest/driver-api/i2c.html) werden
die Funktionen und Datenstrukturen definiert, mit denen Gerätetreiber im Linux
Kernel das I2C Subsystem verwenden können. Ein spezifisches I2C Gerät wird
beispielsweise durch den `i2c_client` struct repräsentiert:
```c
struct i2c_client {
  unsigned short flags;
  unsigned short addr;
  char name[I2C_NAME_SIZE];
  struct i2c_adapter *adapter;
  struct device dev;
  int init_irq;
  int irq;
  struct list_head detected;
#if IS_ENABLED(CONFIG_I2C_SLAVE);
  i2c_slave_cb_t slave_cb;
#endif;
};
```
Die hier dokumentierte API richtet sich allerdings an Entwickler, welche einen
Kernel-Treiber für ein Gerät schreiben. Es ist auch möglich, I2C Geräte vom
userspace zu nutzen, ohne einen speziellen Treiber zu benötigen (Kapitel
["Implementing I2C device drivers in
userspace"](https://www.kernel.org/doc/html/latest/i2c/dev-interface.html)):
Hier wird jedem I2C Interface vom Kernel eine spezielle Datei `/dev/i2c-0` (bzw
`-1` usw.) zugewiesen, auf die je nach System Konfiguration auch von
nicht-superuser Benutzern zugegriffen werden kann. Nach dem öffnen der Datei
kann mittels `ioctl` [@ioctl] die Target-Adresse gesetzt, und danach mit den
üblichen `write()` und `read()` Systemaufrufen I2C-Transaktionen durchgeführt
werden. Obwohl die Dokumentation ein Beispiel in `C` liefert, kann dies
natürlich aus jeder Programmiersprache geschehen, die I/O und `ioctl` unter
Linux unterstützt. Da ich gerne `C++` nutze, habe ich diese Methoden in einer
`C++` [Bibliothek](https://github.com/ottojo/I2C) zusammengefasst. Ein I2C Bus
wird so mit
```c++
i2c::Bus bus{"/dev/i2c-0"};
```
initialisiert. Danach kann vom Gerät gelesen und zum Gerät geschrieben werden.
Hier im Beispiel werden zuerst 3 Bytes geschrieben und dann 7 Bytes gelesen:
```c++
constexpr auto DEVICE_ADDRESS = 0x40;
using namespace std;
i2c::Bus bus{"/dev/i2c-0"};
bus.lock(DEVICE_ADDRESS).write<3>({byte{0xA}, byte{0xB}, byte{0xC}});
auto dataFromDevice = bus.lock(DEVICE_ADDRESS).read<7>();
```
Dabei wird der Bus vor jeder Transaktion gelockt und nach Abschluss automatisch
wieder unlocked, was das Benutzen des Bus von mehreren Threads ermöglicht. Soll
eine Transaktion mit mehreren Read- und Write Aufrufen am Stück, ohne
eventuelles verwenden des Bus von anderen Threads, durchgeführt werden, wird der
Bus nur ein mal für das gesamte Scope gelockt:
```c++
constexpr auto DEVICE_ADDRESS = 0x40;
using namespace std;
i2c::Bus bus{"/dev/i2c-0"};
{
    auto lockedBus = bus.lock(DEVICE_ADDRESS);
    lockedBus.write<3>({byte{0xA}, byte{0xB}, byte{0xC}});
    auto dataFromDevice = lockedBus.read<7>();
}
```
Für ein Spezielles Gerät kann nun eine Klasse definiert werden, welche eine
Referenz auf den Bus enthält, und die Funktionen des Geräts bereitstellt. Im
oben verlinkten Repository ist beispielsweise eine Klasse für den `PCA9685` PWM
Controller enthalten.

Im Linux Treiber sind einige Probleme ersichtlich geworden, die in der Vorlesung
nicht direkt erwähnt wurden: Ein Gerätetreiber ist üblicherweise in ein
komplexes System integriert. Es können mehrere Interfaces zu diesem Treiber
existieren, hier zum Beispiel das `/dev/`- und das Kernel-Interface. Ein Treiber
muss auch nicht immer den gesamten Stack zwischen Applikation und Hardware
abdecken, in Linux gibt es ein I2C Subsystem, auf welches die diversen
Gerätetreiber dann aufbauen, ohne das I2C Interface an sich selbst zu
implementieren. Außerdem kommen in Mehrbenutzersystemen oder Multithreaded
Applikationen die üblichen Probleme des gleichzeitigen Zugriffs hinzu, die im
Treiber bedacht werden müssen.
