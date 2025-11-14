format: foo [chapter, slide number]
Example: `[04, 11]` means look for 'Folie 11' (see lower right corner) in '04_ch_seqLogik.pdf'

== Latch

Speicherelement, das ein Bit speichern kann.

== RS-Latch

- IN: 2 Bits: Set, Reset
- OUT: P, Q=NOT P
- Da mit S=1 Q=1, betrachtet man Q als OUT und ignoriert P

== Flip-Flop

Ein Latch mit Zusatzeingang für Takt.

OUT: Q, P

== Typ: RS

Wenn S=1: ‘‘1 einspeichern’’, wenn R=1: ‘‘0 einspeichern’’, beide 0: ‘‘halten’’, beide
1: verboten

== Takt

=== Vorderflankentaktung, Rückflankentaktung

Eingänge werden relevant beim Wechsel des Taktsignals von 0 auf 1 [04, 20]

relevant: A-03

== Schaltwerk
Schaltung mit Rückkopplung, ermöglicht Datenspeicherung
synonym: 'sequentielle Schaltung'

== Zustand

Sprechweise (z.B.): Der Automat geht im Zustand s1 bei Eingabe e unter Ausgabe
a in den Zustand s2 über

== A-01

=== What's a eingabe-flip-flop?


== A-02

=== ?

- Sind Zustände Ein/Aus Zustände UND Ausgaben? s. [05, 29]
  - Brauchen wir 'An'?
- Versthee nicht wo 'Start' sein soll

=== NB

"Z.B. Moore-Automat; siehe Übung, siehe VL Modellierung!" [05, 23]

=== Alphabet

=== Was ändert sich, wenn manche Phasen sehr lange dauern?


== A-03

== Zwischenschritte [05, 31]

- Zustände, Eingaben, Ausgaben darstellen
  - FlipFlops für Zustandsspeicherung
- Zustandsübergangsfunktion als Wahrheitstafel
  - Daraus: Ansteuerung der FlipFlops für Zustandsspeicherung
- Ausgabefunktion als Wahrheitstafel [05, 37]
- Dann weiter wie in Kapitel 3

== ? Teilaufgabe 2, 3

- Wie Tabelle 1 ausfüllen?
- Was sind DEF?

== ?

- Adressen und Minterme und Dekoder? Huh? Folie [04, 42]
- Zustände speichern durch verschiedene Flipflops? (RS, JK, T...) [05, 34]

=== NB

- ALU vorderflankengetaktet
- Register hinterflankengetaktet

=== RTE-Architektur

=== Register

=== Mikroinstruktion
