=== Aufgabe 4: Cache-Kohärenz (Ring-Modell)

Gegeben ist ein 4-Core-System, bei dem Cache-Änderungen über einen Ring
weitergegeben werden. Pro passierendem Kern wird ein Takt benötigt, und jeder
empfangende Kern leitet die Änderung nach rechts weiter. Es wird jeweils der
„aktuellere“ Wert übernommen. \

==== Erfüllt das Modell sequentielle Kohärenz?

Nein, nicht in allen Fällen.

Das Modell kann die Forderung *Write serialization* verletzen:
Wenn zwei Kerne (nahezu) gleichzeitig auf dieselbe Adresse schreiben, können die
beiden Updates bei verschiedenen Kernen in unterschiedlicher Reihenfolge
ankommen (abhängig von der Ring-Distanz). Dadurch könnten zwei Kerne die Writes
in verschiedener Reihenfolge beobachten, was nach dem Modell der sequentiellen
Kohärenz nicht erlaubt ist (Write serialization).

==== Was muss man ändern?

Man benötigt eine *globale Serialisierung* von Writes (total order),
damit alle Kerne dieselbe Reihenfolge der Schreiboperationen sehen.

Eine einfache Lösung ist ein *Token*-Mechanismus:
Nur der Kern, der aktuell das Token besitzt, darf schreiben.
Nach einer Schreiboperation wird das Token weitergereicht.
Damit werden alle Writes automatisch in eine eindeutige Reihenfolge gebracht.

Alternative: Jede Schreiboperation bekommt eine globale Sequenznummer
(z.B. durch das Token oder einen zentralen Zähler). Updates werden von allen
Kernen strikt nach dieser Nummer angewendet (ggf. mit Puffern/Warten), sodass
alle Kerne dieselbe Reihenfolge sehen.

Damit wird insbesondere *Write serialization* eingehalten und das Modell kann
sequentielle Kohärenz erfüllen.
