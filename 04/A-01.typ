== Aufgabe 1: RISC-V Konventionen

=== 1. Mögliche Konventionen
*Registersicherung*:

+ aufgerufenes Unterprogramm sichert Register auf Stack vor Benutzung (10.72), stellt vor Rücksprung Register wieder her.
+ Register werden unterschieden: dürfen / dürfen nicht vom Unterprogramm verändert werden (saved vs temporary)

*Alignment*: 

(s. 08.93) Daten/Instruktionen dürfen nur auf Adressen abgelegt werden die

+ ein Vielfaches einer Zweierpotenz sind
+ ein Vielfaches der Größe des zugegriffenen Datums sind (natural alignment)

*Stack*: 

+ Stapel von oben nach unten (Stapelzeiger zeigt auf die niedrigste belegt Adresse)
+ Stapel von unten nach oben (...größte...)
+ Parameter liegen auf Stack vor Rücksprungadresse/nach Rücksprungadresse

*Parameterübergabe*: 

+ call-by-value (ein Wert wird übergeben)
+ call-by-reference (eine Referenz wird übergeben)
+ call-by-name // (TODO: ???)

=== 2. RISC-V Konventionen

*Registersicherung*: 

Register werden grob unterschieden: 
+ saved registers `s0 - s11`: Aufrufer darf vertrauen, dass Unterprogramm diese nicht verändert hat
+ temporary registers `t0 - t6`: Unterprogramm darf beliebig überschreiben
// TODO: so wie oben steht es in Folien, aber anders in riscv-calling.pdf
+ Details hängen von genauer Architektur ab (32-Bit, 64-bit, I oder G Extension). Siehe `Table 18.2` in `RISC-V Calling Convention`.
// Dont think this is relevant: Stackpointer in `x2` (alias `sp`); bei `jal`: Register `x1` (alias `ra`) für Rücksprungadresse nutzen;

*Alignment*: 

+ Instruction Alignment: Vielfache von 4
+ Data Alignment: Keine Vorgabe, aber Konsequenzen, falls nicht naturally aligned (siehe vorherige Hausaufgabe, A-02c)

*Stack*: 

+ Stapel von oben nach unten (Stapelzeiger zeigt auf die niedrigste belegt Adresse)
+ stack pointer is always kept 16-bute aligned (TODO: ???)
+ Parameter haben den Stack vor Rücksprungadresse/nach Rücksprungadresse;
// TODO: riscv-calling.pdf: what is 'RVG'?
// not sure: Rücksprungadresse auf Stack ist Verantwortung des Unterprogramms

*Parameterübergabe*:

Hauptquelle ist `RISC-V Calling Convention`:

+ Parameterübergabe wenn möglich in Registern, also by-value.
+ Integer-Register `a0-a7` und floating-point Register `fa0-fa7`
+ Genaue Übergabe hängt wieder von spezifischer Architektur ab
+ Argumente kleiner als ein 'pointerword' werden in den least significant bits des entsprechenden Registers bzw. in kleineren Adressen auf dem Stack übergeben (wegen little-endian)
+ Auch Regel für Argumente mit doppelter Größe von pointer-word
+ Noch größere Argumente werden als Referenz übergeben, also by-reference
+ Ähnliche Regeln für Rückgabe
// TODO: pointer-word?

z.B. call-by-value (ein Wert wird übergeben), call-by-reference (eine Referenz wird übergeben), call-by-name (TODO: ???).
