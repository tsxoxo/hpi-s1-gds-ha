.data
arg0: .word 0x0c
arg1: .word 0x05

.text
j main

# Calculate `a // b` (integer division)
# IN
# a0 = a
# a1 = b
#
# OUT
# a0 = a // b
mod:
# t0 = counter
add t0 x0 x0

dec:
blt a0, a1, done
sub a0 a0 a1
addi t0 t0 1
j dec

done:
mv a0 t0
ret

main:
lw a0, arg0
lw a1, arg1
call mod
