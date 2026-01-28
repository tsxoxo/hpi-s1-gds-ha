.data
arg0: .word 0x0c
arg1: .word 0x05

.text
j main

# Calculate `a // b` (integer division)
# Algo: count how many times we can substract a - b
# while result > 0
# IN
# a0 = a
# a1 = b
#
# OUT
# a0 = a // b
my_div:
# t0 = subtraction counter and result
add t0 x0 x0

dec_loop:
blt a0, a1, done
sub a0 a0 a1
addi t0 t0 1
j dec_loop

done:
mv a0 t0
ret

main:
lw a0, arg0
lw a1, arg1
call my_div
