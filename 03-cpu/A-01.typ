== 1.

=== 1.2

*Pseudo*
- `lh t0 zahl` für `la t0 zahl; lw t0 0 t0;` (79) 
  - NOTE: aber `la` auch PI? (98)
- `nop` für `addi x0, x0, 0`

- QUESTION: `lh t0, zahl` is first translated into `auipc t2, <start of data segment>` -- does `auipc` always use <start of data segment> or only when translating from pseudo-op form `lh rd, <label>`? where is this documented?

=== 1.3. 

Was machen die einzelnen Segmente dieses Programmes? Welche Bedeu-
tung haben die jeweiligen Register dabei? Welche Funktion wird durch das
Programm berechnet?

*Lösung*: 

`.data`: Der symbolische Name `zahl` wird deklariert und initialisiert.

`.text`: Register werden vorgeladen, eine Addition wird in einer Schleife ausgeführt bis eine Schlussbedingung erreicht wird

*Funktion der Register*
`t0` wird mit dem Input geladen und ist der Counter für unserer Schleife
`t1` Enthält die Konstante 0 und dient dazu, die Schleife zu beenden
`t2` speichert das Ergebnis der Addition

*Funktion des Programms* 
Sei $h$ die Funktion, die die unteren 16 Bits einer binären Zahl ausgibt (half word). 
Dann ist unser Programm die Funktion $f(x) = Sigma_(n=1)^(floor(h(x) / 16)) n$ mit $x = "zahl"$.

Umgangssprachlich formuliert, summiert das Programm die natürlichen Zahlen bis zu 
einer gewissen Zahl.

=== 1.4.
Das Programm erhält einen Wert als Eingabe und gibt einen Wert als Aus-
gabe zurück. Stehen Ein- und Ausgabe in Registern oder im Speicher? An
welcher Stelle?

*Lösung:*
Die Eingabe des Programms ist der symbolische Name `zahl`, der im
`.data`-Segment deklariert wird. Dies geschieht im Speicher. Diese primäre
Eingabe wird im Segment `beginning` ins Register `t0` geladen und modifiziert.
Der Inhalt von `t0` am Ende von `beginning` ist die Ausgangsposition beim Start
der Additions-Schleife -- man könnte diesen State auch als Input sehen.

Das Register `t2` interpretieren wir als Ausgabe.

=== 1.6
Schreiben Sie das Programm so um, dass weniger Instruktionen und tempo-
räre Register benötigt werden.

*Lösung*
- Wir können mit `x0` vergleichen, das die Konstante 0 enthält, statt `t1` auf 0 zu setzen.

.data
zahl: word 0x09fa00ce

.text
beginning:
lh t0 zahl
srli t0 t0 4

middle:
add t2 t2 t0
addi t0 t0 -1
bne t0 x0 middle

end:
nop

---

input: 11
11 & input = input
00 & input = 00
10 & input = 10


xxxx xxxx xxxx xxxx
^^^^ ^^^^ ^^^^ ----
1111 1111 1111 0000

