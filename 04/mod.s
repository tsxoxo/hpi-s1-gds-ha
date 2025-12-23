
.data
arg0: .word 0x0c
arg1: .word 0x05

.text
j main

# Calculate `a modulo b`
# IN
# a0 = a
# a1 = b
#
# OUT
# a0 = a % b
mod:
dec:
blt a0, a1, done
sub a0 a0 a1
j dec

done:
ret

main:
lw a0, arg0
lw a1, arg1
call mod
