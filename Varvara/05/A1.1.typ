= Aufgabe 1: Metriken

== 1. Konfigurationen
Wir haben neben der Basisversion vier weitere Varianten des Programms `primesum.c` erstellt und getestet. Die Varianten unterscheiden sich durch den verwendeten Datentyp (`int64_t` vs. `__int128`), die Modulo-Berechnung und die Compiler-Optimierung.

- *v1_base:* `int64_t`, Modulo $10^9+7$, *-O0* (Basisversion).
- *v2_opt:* `int64_t`, Modulo $10^9+7$, *-O3*.
- *v3_fastmod:* `int64_t`, Modulo $16^8$ (bzw. `0x100000000`), *-O3*.
- *v4_int128:* `__int128`, Modulo $10^9+7$, *-O3*.
- *v5_no_opt:* `int64_t`, Modulo $16^8$, *-O0*.

== 2. Hypothesen (Erwartungen)
Vor der Messung hatten wir folgende Erwartungen:
+ *Optimierung:* Wir erwarten, dass `v2_opt` deutlich schneller ist als `v1_base`, da `-O3` effizienteren Maschinencode erzeugt.
+ *Modulo:* Wir erwarten, dass `v3_fastmod` die schnellste Variante sein wird. Die Modulo-Operation mit einer Zweierpotenz ($16^8$) kann durch eine schnelle bitweise UND-Operation (`&`) ersetzt werden, was viel effizienter ist als eine Division.
+ *Datentyp:* Wir erwarten, dass `v4_int128` am langsamsten ist, da unser Prozessor (64-Bit) 128-Bit-Zahlen emulieren muss und der Speicherbedarf für den Cache doppelt so hoch ist.

== 3. Ergebnisse & Auswertung
Die Messungen wurden mit `hyperfine` durchgeführt. Hier sind die Ergebnisse:

#image("a1.1_1.png", width: 80%)

- *v2_opt (616 ms)* war die schnellste Version (~1.32x schneller als Basis).
- *v3_fastmod (620 ms)* war überraschenderweise *nicht schneller* als `v2_opt`.
- *v4_int128 (910 ms)* war die langsamste Version (sogar langsamer als die Basisversion ohne Optimierung).

#image("a1.1.png", width: 80%)

*Analyse:*
+ *Compiler-Optimierung (-O3):* Hat wie erwartet einen großen Einfluss und bringt etwa 30% Leistungssteigerung.
+ *Memory Bound (Speicherlimitierung):* Dass `v3_fastmod` nicht schneller war, zeigt, dass das Programm nicht durch die Rechenleistung der CPU (ALU), sondern durch den *Speicherzugriff* begrenzt ist. Die CPU wartet auf Daten aus dem RAM, daher bringt eine schnellere Division keinen Vorteil ("Latency Hiding").
+ *__int128 Problem:* Die Variante `v4_int128` ist langsam, weil sie die *räumliche Lokalität (Spatial Locality)* verschlechtert. Da ein `int128` doppelt so groß ist wie `int64`, passen nur halb so viele Elemente in eine Cache-Line. Das führt zu mehr Cache-Misses und höherem Speicherverkehr.