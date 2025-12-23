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
    .word 0x05
    
.text
j main

# Swap words [a] with [b]
# IN:
# a0 = a
# a1 = b
swap:
# t0 = [a]
lw t0 0 a0
# t1 = [b]
lw t1 0 a1
# [b] = [a]
sw t0 0 a1
# [a] = [b]
sw t1 0 a0

ret

# Partition array around pivot using Hoare's method
# IN:
# a0 = start address
# a1 = end address
# OUT:
# a0 = pivot address
partition:
# s0 = i addr
# s1 = j addr
# s2 = [i]
# s3 = [j]
# s4 = pivot value
# s5 = lo addr
# s6 = hi addr

# pivot = first element
lw s4 0 a0
# initialize i, j
addi s0 a0 -4
addi s1 a1 4
# initialize lo, hi
mv s5 a0
mv s6 a1

loop:

                inc_i:
                beq s0 s6 skip_i
                addi s0 s0 4
                lw s2 0 s0
                blt s2 s4 inc_i
                skip_i:

                dec_j:
                beq s1 s5 skip_j
                addi s1 s1 -4
                lw s3 0 s1
                bgt s3 s4 dec_j
                skip_j:

                bgeu s0 s1 done_partition

                # swap(i, j)
                mv a0 s0
                mv a1 s1
# save ra on stack
                addi sp sp -16
                sw ra 12 sp
                call swap

#restore ra
                lw ra 12 sp
                addi sp sp 16

                j loop

done_partition:

mv a0 s1
ret

# Perform quicksort on array of word-sized integers
# MUTATES
# 
# IN:
# a0 = start address
# a1 = end address
quicksort: 
                bgeu a0 a1 done_quicksort

# Save ra, start address, end address on stack 
# First, allocate space on stack aligned to 128 bits as per RISC-V ABI
                addi sp sp -16
                sw ra 12 sp
                sw a0 8 sp
                sw a1 4 sp

                call partition

# State after returning from partition():
# a0 = address of pivot (return value of partition())
                sw a0 0 sp

# Quicksort high array (values greater than pivot)
# -> quicksort(pivot+1, end)
                addi a0 a0 4
                lw a1 4 sp
                call quicksort 

# Quicksort low array (values smaller than pivot)
# -> quicksort(start, pivot)
                lw a0 8 sp
                lw a1 0 sp
                call quicksort 

# deallocate space
                lw ra 12 sp
                addi sp sp 16

                done_quicksort:
                ret

main:
                la a0 lo
                la a1 hi
                call quicksort
