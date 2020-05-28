# Sensoren und Aktoren I
Beispiel Flugzeug:
* Sensoren
* ADC
* Eingebetteter Computer
* DAC
* Aktoren

## Sensoren
* z.B. Gyroskop um Lage und Drehbeschleunigung eines Objektes zu messen
* z.B. Staurohr für Airspeed Messung
* Wandelt physikalische in elektrische Größe um (Strom, Spannung)
* Umwandlung folge einem *Messprinzip*:
  * Resistiv
  * Kapazitiv
  * Induktiv
  * Magnetfeld (z.B. Hallsensor)
  * Piezoelektrischer Effekt
  * Temperatur (-> Leitfähigkeit)
  * Optoelektronisch (z.B. Photodiode)
  * CCD Kamera
  * Radar, Sonar
* Messwandler:
  * z.B. Transformator
* Messumformer, Messverstärker -> OPV
* Messumsetzer: ADC

## Aktoren
* Klappen
* Triebwerke
* z.B. Elektrischer Motor

## Bauteile
### Operationsverstärker
* Verstärkt Differenzspannung
* Eingangswiderstand unendlich -> Eingangsstrom = 0
* Meist rückgekoppelte Beschaltung, damit Realisierung verschiedener mathematischer Operationen

### Komparator
* Ausgang = sgn(Eingang)

## Verstärkerschaltungen
* Invertierende und Nichtinvertierende Verstärker
* Integrierer, Differenzierer
* Addierer, Subtrahierer

## Brückenschaltung
* Häufiges Problem: Genaue Messung eines veränderlichen Widerstands (Sensor)
* Wheatstone Brücke wandelt Widerstandsänderung in größere Spannungsdifferenz um als einfache Spannungsteiler-Schaltung.
* Auslesen der Wheatstone Brücke mit OPV möglich
