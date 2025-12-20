.data 
zahl: .word 0x09fa00ce

.text
beginning:
        lh t0 zahl
        srli t0 t0 4
        li t1 0
middle:
        add t2 t2 t0
        addi t0 t0 -1
        bne t0 t1 middle
end:
        nop
