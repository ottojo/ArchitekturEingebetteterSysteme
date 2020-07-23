## Echtzeitbetriebssysteme
### Aufgaben eines RTOS
#### Kernel Implementierung eines RTOS
* Nebenläufigkeit
* Ein Prozess wird hier *task* genannt.
* Ein Prozess ist ein Programm und die dazugehörigen Daten.
* Leichtgewichtige Prozesse heißen threads
* Resourcenverwaltung:
  * Zeit (Prozessorzeit, Echtzeit durch Timer-Baustein)
    * Timer erzeugt Interrupt, ISR wird ausgeführt, unterbricht aktuellen Task
    * Externe Ereignisse erzeugen Interrupts


Ziel ist Unterstützung von nested Interrupts.
Nach der ISR kann der Scheduler aufgerufen werden.
Nach dem Scheduler wird der Dispatcher aufgerufen, welcher feststellt, welcher
Task als nächstes ausgeführt werden soll.

Besonders in Echtzeitbetriebssystemen kann ein Task einen zusätzlichen Zustand "Zombie"
annehmen, welcher z.B. angenommen wird, wenn der Task Fristen (Echtzeitbedingung)
nicht einhält.

#### Echtzeitkernel
* Task Control Block
  * PID
  * Registerinhalt (*Prozessorkontext*)
    * Register
    * PC
    * SP
    * ...
  * Zustand (*State*: Ready, Idle, ...)
  * Memory
  * Priority
  * Deadline
  * ...
  * Next Pointer
  * Previous Pointer

* Ready List als (Doubly) Linked List von TCBs
* Analog Idle List, Zombie List, etc

* Scheduling:
  * Round Robin
  * Earliest Deadline First
    * Sortierung der Tasks im Scheduler

Mit statischen Prioritäten:
* Mehrere Ready Lists (für jede Priorität)
* Komische redundante Datenstruktur (Bitmap) zum cachen der belegten Einträge

IPC mit Mailboxen für jede PID und Ringbuffer
