## D-Latch
In diesem Teil der Übung soll ein gated D-Latch implementiert werden.
Hier wird vor dem Testen auf dem Board wieder auf die Simulation
zurückgegriffen, die hier zwar keine Bugs im code findet, aber das VHDL
Attribut `KEEP` einführt. Es scheint etwas undurchsichtig an welchen Stellen
die proprietäre Intel Software im Synthetisierungsprozess optimiert, es wirkt
aber so, als ob interne Signale nicht bestehen bleiben müssen, was an den
Kompilierprozess von z.B C++ Code erinnert, wo zum Debuggen oftmals die
entsprechenden Optimierungen deaktiviert werden (`gcc -Og`).
