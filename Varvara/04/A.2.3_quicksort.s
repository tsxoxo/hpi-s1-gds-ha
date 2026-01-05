.data
lo:
    .word 0xff
    .word 0x17
    .word 0x38
    .word 0x25
    .word 0xa3
    .word 0xc8
    .word 0x84
    .word 0x91
    .word 0x47
    .word 0xb3
    .word 0x91
    .word 0x71
    .word 0xb4
    .word 0xf3
    .word 0x00
hi:
    .word 0x05  # das letzte Element

.text
.globl main

# ---------------------------------------------------------
# MAIN PROGRAMM
# ---------------------------------------------------------
main:
    la a0, lo       # a0 = Start-Adresse (lo)
    la a1, hi       # a1 = End-Adresse (hi)

    jal ra, quicksort

    # Ende des Programms
    li a7, 10
    ecall

# ---------------------------------------------------------
# SWAP (a0, a1)
# Tauscht die Werte an den Adressen a0 und a1
# Leaf-Function (braucht keinen Stack)
# ---------------------------------------------------------
swap:
    lw t0, 0(a0)    # t0 = *a0
    lw t1, 0(a1)    # t1 = *a1
    sw t1, 0(a0)    # *a0 = t1
    sw t0, 0(a1)    # *a1 = t0
    ret

# ---------------------------------------------------------
# PARTITION (a0 = lo, a1 = hi)
# Hoare Partition Scheme
# Rückgabe: a0 = p (Pivot-Position, Pointer)
# ---------------------------------------------------------
partition:
    addi sp, sp, -20    # Stack reservieren (ra + s-Register)
    sw ra, 16(sp)
    sw s0, 12(sp)       # s0 = pivot value
    sw s1, 8(sp)        # s1 = i (pointer)
    sw s2, 4(sp)        # s2 = j (pointer)
    sw s3, 0(sp)        # s3 = tmp value for checks

    # Pivot wählen: Wir nehmen einfach das erste Element (*lo)
    lw s0, 0(a0)        # s0 = pivot
    
    # i = lo - 4 (Wir starten eins vor dem Anfang)
    addi s1, a0, -4
    
    # j = hi + 4 (Wir starten eins nach dem Ende)
    addi s2, a1, 4

part_loop:
    # ------------------------------------------
    # Do i++ while (*i < pivot)
    # ------------------------------------------
i_loop:
    addi s1, s1, 4      # i += 4 (nächstes Wort)
    lw s3, 0(s1)        # lade *i
    # Wenn *i < pivot (unsigned Vergleich bltu oder signed blt), weiter
    # Wir sortieren hier signed integers (lt)
    blt s3, s0, i_loop  

    # ------------------------------------------
    # Do j-- while (*j > pivot)
    # ------------------------------------------
j_loop:
    addi s2, s2, -4     # j -= 4 (vorheriges Wort)
    lw s3, 0(s2)        # lade *j
    # Wenn *j > pivot, weiter
    blt s0, s3, j_loop  # pivot < *j entspricht *j > pivot

    # ------------------------------------------
    # Check if i >= j
    # ------------------------------------------
    bge s1, s2, part_done # Wenn i >= j, sind wir fertig

    # ------------------------------------------
    # swap(i, j)
    # ------------------------------------------
    # Wir müssen Register sichern, da swap a0/a1 braucht
    # Aber a0/a1 werden in partition nicht mehr gebraucht als lo/hi
    # Wir nutzen a0=s1(i), a1=s2(j) für den Aufruf
    mv a0, s1
    mv a1, s2
    jal ra, swap

    # Wiederhole Loop
    j part_loop

part_done:
    # return j (in a0, weil Rückgabewert)
    mv a0, s2           # a0 = j (Das ist unser 'p')

    # Stack wiederherstellen
    lw s3, 0(sp)
    lw s2, 4(sp)
    lw s1, 8(sp)
    lw s0, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    ret

# ---------------------------------------------------------
# QUICKSORT (a0 = lo, a1 = hi)
# Rekursiver Aufruf
# ---------------------------------------------------------
quicksort:
    # Base Case: If lo >= hi, return
    bge a0, a1, qs_end

    # Stack Frame erstellen (Wir müssen lo, hi und ra speichern)
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)        # s0 = speichert 'lo'
    sw s1, 4(sp)        # s1 = speichert 'hi'
    sw s2, 0(sp)        # s2 = speichert 'p' (Rückgabe von partition)

    mv s0, a0           # lo sichern
    mv s1, a1           # hi sichern

    # 1. p = partition(lo, hi)
    # a0 und a1 sind noch korrekt gesetzt
    jal ra, partition
    mv s2, a0           # p sichern (in s2)

    # 2. quicksort(lo, p)
    mv a0, s0           # a0 = lo
    mv a1, s2           # a1 = p
    jal ra, quicksort

    # 3. quicksort(p + 1, hi) -> In Bytes: p + 4
    addi a0, s2, 4      # a0 = p + 4
    mv a1, s1           # a1 = hi
    jal ra, quicksort

    # Stack aufräumen
    lw s2, 0(sp)
    lw s1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16

qs_end:
    ret