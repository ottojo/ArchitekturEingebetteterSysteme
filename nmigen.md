\clearpage
# Zusatzthema: nMigen

M-Labs: https://m-labs.hk/gateware/nmigen/
GitHub: https://github.com/m-labs/nmigen
Tutorial: http://blog.lambdaconcept.com/doku.php?id=nmigen:tutorial
Towards a Hardware DSL Ecosystem: RubyRTL and Friends https://arxiv.org/pdf/2004.09858.pdf
LiteX: an open-source SoC builder and library based on Migen Python DSL https://arxiv.org/pdf/2005.02506.pdf

## Motivation
Schon seit den 1980er bzw. 1990er Jahren existieren die uns bekannten Sprachen
zur Hardwarebeschreibung VHDL [@vhdl_1987] und Verilog [@verilog_1995]. Wir
haben in VHDL die Möglichkeiten, einen Schaltkreis sowohl anhand dessen
Struktur, also der direkten Verschaltung und Verknüpfung von Komponenten und
Signalen, als auch über das gewünschte Verhalten des Schaltkreises zu
beschreiben. Es ist möglich, Teile eines Gesamtsystems in Komponenten
auszulagern, welche auch mehrfach wiederverwendet beziehungsweise instanziiert
werden können. Möglichkeiten zur Metaprogrammierung sind vorhanden mit
Konstrukten wie `generic` und `generate` [(Übung)](#carry-ripple-addierer).

Dennoch wäre es wünschenswert, Hardwarebeschreibung mittels bereits bekannter,
etablierter Programmiersprachen zu realisieren, die auch für wiederkehrende
Probleme wie Dependency-Management, das Wiederverwenden von Code (Libraries),
etc. bereits eine Lösung bereithalten. Ein nicht von der Hand zu weisender
Vorteil ist auch, dass viele Entwickler bereits Erfahrung in einer dieser
Sprachen besitzen, was auch zur wachsenden Popularität dieser Lösungen beiträgt.

Mehrere Projekte, die Hardwarebeschreibung in Form von *domain specific
languages (DSL)* innerhalb anderer Programmiersprachen realisieren, existieren.
Einige Beispiele, mit definierenden Features und Highlights sind:

* RubyRTL [@rubyrtl_2020]:  Erstmals präsentiert in [@lann2020hardware] (2020),
  baut RubyRTL auf die Programmiersprache Ruby auf, unter anderem weil es in
  Ruby möglich ist, der Sprache scheinbar neue keywords hinzuzufügen.
* MyHDL [@jaic2015]: Motiviert von der weiten Verbreitung und der umfassenden
  Standardbibliothek, setzt MyHDL auf Python. Ein Fokus liegt auf code reuse und
  Abstraktion von Interfaces, was schnelles Prototyping ermöglichen soll.
* Chisel [@bachrach2012]: Chisel ist in Scala implementiert, und unterstützt
  Generierung von sowohl Verilog als auch C++ Code für Simulation des Designs.

Dies sind nur einige Beispiele von vielen verschiedenen DSLs, hier nur zu
erwähnen sind noch PyRTL [@clow2017], CLasH [@baaij2009], SysPy [@logaray2010]
und SpinalHDL [@spinalhdl]. Die hier näher betrachtete Lösung ist *nMigen*
[@nmigen].

## Hintergrund
nMigen ist die zweite Version der Migen Bibliothek für Hardware Design in
python. 
