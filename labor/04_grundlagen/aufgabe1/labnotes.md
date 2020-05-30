## Einfacher Multiplexer
Zur besseren Strukturierung habe ich mich dazu entschieden, den eigentlichen Multiplexer als
eigene Entity zu beschreiben, die nicht die Top-Level entity ist (Danke Dominik für den Hinweis!).
Das ist anders als in der vorherigen Übung, in der direkt die Bezeichnungen des Boards verwendet wurden.
Das erlaubt mir, den Eingangs- und Ausgangssignalen sinnvolle Namen zu geben, die nicht direkt
mit dem Board zusammenhängen (`IN_1` statt `SW(1)` oder so).
Außerdem ist es damit möglich, mehrere Instanzen der entity zu verwenden (was hier aber noch nicht
gemacht wird).

Beim instanziieren des Multiplexers ist das Problem aufgetreten, dass `multiplexer` nicht gefunden wurde.
Kurzes recherchieren hat ergeben dass `work.multiplexer` das Problem löst, wobei an Stelle von
`work` normalerweise der Name einer Bibliothek steht, `work` ist hier speziell und bedeutet "aktuelle Bibliothek".
