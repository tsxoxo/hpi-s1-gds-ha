= 3. Load-Store Architektur

1. Die folgenden Instruktionen stammen aus einer Speicher-Speicher-Architektur und werden nicht in einer Load-Store Architektur unterstützt. Schreiben Sie äquivalente Programme in der RISC-V ISA. [A],[B],[C] sind Speicheradressen.

a) MUL [A], [B], [C] (Multiplizieren der Werte an den Speicheradressen [B] und [C]; Schreiben des Ergebnisses in [A])
b) MOV [A], [B] (Kopie zwischen zwei Speicheradressen)
c) REDUCE_SUM [A], [B], [C] (Addieren der Werte im Speicherbereich zwischen [B] und [C] und schreiben des Ergebnisses nach [A])

2. Welche Vor- und Nachteile hat eine Load-Store Architektur in diesem Kontext? Diskutieren Sie!

3. Welche architektonischen Änderungen wären an der RISC-V Architektur
nötig, um MOV [A], [B] in einer Instruktion zu ermöglichen?

== Lösung

=== 1a: `MUL [A], [B], [C]` 

TODO: nvim-surround i dont want spaces between brackets: vS[

Wir gehen von einer einfachen Multiplikation aus, die 2 32-Bit Werte
als Operanden nimmt, und die niedrigen 32 Bits ausgibt.

```asm
# 1a
.data
# Initialize [A], [B], [C] with dummy values
A: .word 0x00
B: .word 0x15
C: .word 0x02

.text
lw t1, B
lw t2, C
mul t3, t1, t2

la t0, A
sw t3, 0 t0
```

=== 1b: `MOV [A], [B]`

```asm
#1b
.data
# Initialize [A], [B] with dummy values
A: .word 0x00
B: .word 0x15

.text
la t0, A
lw t1, B
sw t1, 0 t0
```

=== 1c: `REDUCE_SUM [A], [B], [C]`

Wir interpretieren den Speicherbereich zwischen [B] und [C] als Folge von Words und iterieren in Word-Schritten von B bis einschließlich C.

```asm
.data
A: .word 0x00
B: .word 0x15
X: .word 0x01
Y: .word 0x01
Z: .word 0x01
C: .word 0x02

.text
# t1 = current addr
# t2 = end of addr range
# t3 = accumulator, i.e. result
# t4 = current value, i.e. [t1]
la t1, B
la t2, C
add t3, x0, x0

loop:
bgtu t1, t2, done
lw t4, 0 t1
add t3, t3, t4
# go to next address (word = 4 bytes)
addi t1, t1, 4
j loop

done:
# Write to A
la t5, A
sw t3, 0 t5
```

=== 2.
Eine Load-Store-Architektur hat die Konsequenz, dass wir Speicheroperationen immer explizit durchführen (`load` und `store`) -- es werden mehr Register und Instruktionen gebraucht. Der Vorteil ist, dass unser instruction set vereinfacht wird. Arithmetische Operationen benutzen ausschließlich Register. Das vereinheitlicht das Instruktionsformat und erleichtert dadurch die Dekodierung.

=== 3.
==== my version going into details:
Die Instruktion `MOV [A], [B]` arbeitet mit 3 Daten gleichzeitig: Zwei Addressen und dem Wert in `B`. Um dies in einer Instruktion auszuführen, müssten wir in der Lage sein, den ausgelesenen Wert in `B` aus dem Speicher an eine andere Addresse `A` in einem Zug zu schreiben. Dafür benötigen wir z.B. einen zweiten, separaten Address-Port am Speicher, der nur für Speicheroperationen zuständig ist. Wir müssten darüber hinaus sichergehen, dass das Schreiben nach dem Lesen passiert -- z.B. per Vorder- und Hinterflankentaktung. Eine Load-Store-Architektur umgeht diese Komplexität, indem sie nur einen maximal einen Addressen-Operanden erlaubt. 

==== chatgpt version with different scope:
Eine Load-Store-Architektur erlaubt höchstens einen Speicheroperanden pro Instruktion. Die Instruktion `MOV [A], [B]` besitzt zwei Speicheroperanden. Damit müsste eine einzelne Instruktion gleichzeitig aus dem Speicher lesen und in den Speicher schreiben. Das Instruktionsformat und die Dekodierung würden komplizierter ausfallen: wir müssten uns zumindest überlegen, wie wir die Speicheroperationen miteinander koordinieren, wie wir die Speicherarchitektur anpassen (Zusatzport?) und wie wir das Instruktionsformat variabel machen (welchen Typ hat ein Operand?, wie gehen wir mit zwei 32-Bit Speicheraddressen um in einem Schema mit 32-Bit Instruktionen?).
