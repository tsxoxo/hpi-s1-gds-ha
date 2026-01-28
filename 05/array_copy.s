.data
offset: .word 64
size: .word 8
array: .byte 1, 2, 3, 4, 5, 6, 7, 8

.text
la t0 array    # Beginn des Arrays
lw t1 size     # Groeße des Arrays
add t1 t1 t0    # Ende des Arrays
lw t2 offset    # Offset beim Kopieren
add t2 t2 t0    # Beginn des kopierten Arrays

loop:
    bge t0 t1 end
    lb t3 0(t0)
    sb t3 0(t2)
    addi t0 t0 1
    addi t2 t2 1
    j loop
end:
    nop
