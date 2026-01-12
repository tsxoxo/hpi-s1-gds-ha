== Aufgabe 1: RISC-V Konventionen

=== 1. Mögliche Konventionen
*Registersicherung*:

+ Register sind unterteilt in: caller-saved vs. callee-saved (wer sichert und restauriert)
+ Gewisse Register dürfen / dürfen nicht vom Unterprogramm verändert werden (saved vs temporary)

*Alignment*: 

(s. 08.93) Daten/Instruktionen dürfen nur auf Adressen abgelegt werden die

+ ein Vielfaches einer Zweierpotenz sind
+ ein Vielfaches der Größe des zugegriffenen Datums sind (natural alignment)

*Stack*: 

+ Stapel wächst von oben nach unten (Stapelzeiger zeigt auf die niedrigste belegt Adresse) oder umgekehrt
+ Parameter liegen auf Stack vor oder nach Rücksprungadresse
+ Stapelzeiger zeigt auf letztes Element oder erste freie Speicheradresse

*Parameterübergabe*: 

+ call-by-value (ein Wert wird übergeben)
+ call-by-reference (eine Referenz wird übergeben. In der Praxis: eine Adresse)
+ call-by-name (ein Ausdruck wird bei Aufruf des Unterprogramms neu ausgewertet)

=== 2. RISC-V Konventionen

*Registersicherung*: 

Register werden grob unterschieden: 
+ saved registers `s0 - s11`: Aufrufer darf vertrauen, dass Unterprogramm diese nicht verändert hat.
+ temporary registers `t0 - t6`: Unterprogramm darf beliebig überschreiben.
+ Details hängen von genauer Architektur ab (32-Bit, 64-bit, I oder G Extension). Siehe `Table 18.2` in `RISC-V Calling Convention`.

*Alignment*: 

+ Instruction Alignment: Vielfache von 4
+ Data Alignment: Keine Vorgabe, aber Konsequenzen, falls nicht naturally aligned (siehe vorherige Hausaufgabe, A-02c). Konsequenz: nautral alignment wird empfohlen.

*Stack*: 

+ Stapel von oben nach unten (Stapelzeiger zeigt auf die niedrigste belegt Adresse)
+ Stack pointer ist auf 16 Bytes aligned
+ Rücksprungadresse auf Stack zu legen ist Verantwortung des non-leaf Unterprogramms
+ Bei Spill in Paramterübergabe zeigt der stack pointer auf das erste auf dem Stack liegende Argument

*Parameterübergabe*:

Hauptquelle ist `RISC-V Calling Convention`.
ibid.: _pointer-word_: register-width, also 32 Bits bei RV32.

+ Parameterübergabe wenn möglich in Registern und by-value.
+ Bei zu vielen Argumenten: Übergabe über Stack.
+ Integer-Register `a0-a7` und floating-point Register `fa0-fa7`
+ Genaue Übergabe hängt wieder von spezifischer Architektur ab
+ Argumente kleiner als ein pointer-word werden in den least significant bits des entsprechenden Registers bzw. in kleineren Adressen auf dem Stack übergeben (wegen little-endian)
+ Argumente größer als doppelte Größe von pointer-word werden by-reference übergeben
+ Ähnliche Regeln für Rückgabe

