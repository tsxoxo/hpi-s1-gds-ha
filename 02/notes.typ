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


== A1

=== What's a eingabe-flip-flop?

