## Programmierung eingebetteter Systeme
### Programmieren von Treibern in C
#### Architektur
* Instruction Set Processor
* Speicher
* Datenbus
* Port-mapped I/O: I/O wird über spezielle Befehle realisiert
* Memory-mapped I/O: I/O wird über spezielle Speicherbereiche angesteuert
* I/O Baustein hat Status-register
* I/O Baustein hat Control-register

#### C-Programm
```C
sSlaveDev struct {
  uint8_t status;
  uint8_t control;
  uint8_t tx;
  uint8_t rx;
}
```

```C
#define STS_NOP_TX 0xF0
#define STS_NOP_RX 0x0F
#define STS_FULL_TX 0xF0
#define STS_EMPTY_TX 0x00
#define SUCCESS 0
#define FAIL 1
```
(`NOP` = "Number Of Packets")

```C
const int size = 100;
uint8_t rxBuf[size];
uint8_t txBuf[size];
sSlaveDev *devPtr = 0x8000;
```

```C
int put(sSlaveDev *dev, uint8_t *txBuf){
  if (dev->status < STS_FULL_TX) {
    def->tx = txBuf;
    return SUCCESS;
  } else {
    return FAIL;
  }
}
```
usw (`put`, `write`, `read`) , kann man sich ja vorstellen oder auch lieber nicht.

### Unterbrechungen
Damit man nicht pollen muss, sollte das I/O Gerät sich melden, sobald es z.B. Daten empfangen hat.

#### Architektur
* +Interrupt Controller
  * Kann mehrere Interrupt-fähige Geräte an einen Prozessor anschließen
  * Tabelle Interrupt Nummer -> ISR

#### C
```C
void isr0(){
  iodev->ctrl = ...;
  status = iodev->status;
  ...
}
```

```C
void main(){
  initInterruptHandler(&isr0, 0); // Initialisiert oben erwähnte Tabelle
  ...
}
```
Dies nennt man auch *Foreground/Background* System:
Main-Loop im Hintergrund, Interrupts im Vordergrund.

### Programmieren von Treibern in ADA
Mangels Motivation und aufgrund von Unwillen, die Software des Eurofighters näher zu betrachten, bleibt dieser Abschnitt leer.

### EA Architekturen
1. I2C
* ADC an I2C Baustein (Target)
* Interrupt Controller mit I2C Initiator verbunden
* I2C Initiator Baustein hängt am Microcontroller Bus
  * Sende- und Empfangswarteschlange
  * Zusammenfassen von Messungen in Pakete
  * -> Interrupt nicht bei jedem empfangenen Byte
* I2C erlaubt z.B. Konfiguration des ADC

2. +DMA
* Prozessor programmiert DMA Controller
* ISA hat Cache und kann unabhängig vom Bus laufen
