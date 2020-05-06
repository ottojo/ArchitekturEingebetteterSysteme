# Architektur der Komponenten
## Instruction Set Processor ISP
* Struktur:
  * Mikroarchitektur
    * Register
    * ALU
    * Speicher
* Verhalten
  * Befehle
    * `add z, x, y`
    * `load`, `store`
  * Befehlszyklus
    * Instruction Fetch
    * Instruction Decode
    * Operand Fetch
    * Execute
    * Store to Memory
    * Operand Store

## Application Specific Instructionset Processor ASIP
* z.B. Vektorrechner (SIMD), DSP
* Applikationsspezifische Befehle
* Spezifische Komponenten
  * Hardware Multiplizierer

## Application Specific Processor ASP
* Fur eine genz bestimmte Operation gebaut, z.B. FFT
* Mikroarchitektur
  * Special Purpose Register
  * Special Purpose Hardware
  * Durch Operation spezifiziert
* Verhalten
  * Keine Befehle
