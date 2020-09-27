## Kurseinlage zur Vorlesung "Echtzeitbetriebssysteme"
Zur Veranschaulichung der Konzepte von Scheduling und insbesondere Scheduling im
Realtime Kontext, habe ich mir angeschaut, wie das bei einem RTOS gelöst ist,
mit dem ich bereits im Microcontroller-Praktikum in Kontakt gekommen bin,
FreeRTOS (TODO CITE).


Das Scheduling wird in der Dokumentation im Kapitel
[RTOS Fundamentals](https://www.freertos.org/implementation/a00002.html)
erklärt. Zur Einführung wird wiederholt, dass hier auf Multitasking
eingegangen wird, was nicht zwingend auch eine tatsächliche gleichzeitige
Ausführung impliziert, wie es in einem System mit mehreren Prozessoren
möglich wäre. FreeRTOS ist populär besonders auf Microcontroller-Systemen, wo
meist nur ein einziger Prozessorkern zur Verfügung steht. Aus diesem Grund
implementiert FreeRTOS einen Scheduler, der mehrere scheinbar gleichzeitig
ausführende Tasks auf einem Kern ausführt.


Der FreeRTOS Kernel kann Prozesse anhalten, um einen anderen Task auszuführen,
ein Prozess kann aber auch freiwillig die Kontrolle an das Betriebssystem
abgeben, zum Beispiel wenn dieser Prozess einen delay braucht oder auf ein Event
(z.B. ein Tastendruck) oder eine Resource (z.B. Serial-port) gewartet wird.
Dies wird in der Dokumentation mit einem Ablaufdiagramm veranschaulicht,
welches sowohl ein Unterbrechen eines Tasks aufgrund der aktuellen scheduling
policy (fair), als auch ein Unterbrechen durch den Task selbst.
Diese Scheduling Variante hat noch keine Prioritäten.

Den kurzen Einschub zu Context Switching, der in der Doku an dieser Stelle
steht, überspringe ich hier.


Der nächste Abschnitt betrifft Realtime Applikationen.
Das Beispiel, welches von den Entwicklern gegeben ist, besteht aus zwei Tasks:
Der erste Task ist für user-input zuständig. Er wartet, bis ein Tastendruck
erkannt wird, und gibt dann das Resultat auf einem Display aus. Die maximale
Latenz zwischen Tastendruck und Feedback auf dem Bildschirm beträgt 100ms.


Der zweite Task implementiert einen Regler, der alle 2ms, mit einer Toleranz
von 0.5ms, ausgeführt werden muss.
Da die Deadline des zweiten Tasks früher als die des ersten ist, sollte diesem
eine höhere Priorität zugewiesen werden. Außerdem könnte ein Überschreiten der
Deadline beim zweiten Task schwerwiegendere Auswirkungen haben.


Wenn die Tasks wie beschrieben geordnet sind, ändert sich das Scheduling
Verhalten: Wenn eine Taste gedrückt wird, während der Regler rechnet, wird
dieses Event zurückgestellt, bis der Regler fertig ist.
Wenn das Zeitfenster für den Regler erreicht wird, während aber gerade ein
Tastendruck verarbeitet wird, wird diese Verarbeitung unterbrochen.


Ein weiteres Konzept, was hier hinzukommt, ist der sogenannte "Idle Task",
der vom RTOS selbst angelegt wurde, und ausgeführt wird solange der Regler
nicht rechnet, und keine Taste gedrückt wird.


Interessant an dieser Erklärung ist, dass die Anforderungen des Reglers nur
durch geschicktes Wählen der Prioritäten eingehalten werden. Wie das dann aber
aussieht, wenn mehrere Zeitkritische Tasks laufen, die z.B. unterschiedliche
Toleranzen hinsichtlich der Ausführungszeit haben, wird hier nicht erläutert.
Der Scheduling Algorithmus wurde hier nicht über die expliziten Zeitschranken
informiert, und könnte z.B. nicht eine Verarbeitung eines Tastendrucks
unterbrechen, um dafür eine fristgerechte Verarbeitung einer währenddessen
gedrückten Taste zu gewährleisten.
Dennoch hilft dieses praktische Beispiel dem Verständnis und der Intuition
bezüglich Scheduling und Echtzeitanforderungen.
