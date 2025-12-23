.data
arg0: .word 0x0c
arg1: .word 0x05

.text
j main

# Calculate `[a] modulo [b]`
# IN
# a0 = a
# a1 = b
#
# OUT
# a0 = [a] % [b]
mod:
lw a0 0 a0
lw a1 0 a1

# Same as mod.s
dec:
blt a0, a1, done
sub a0 a0 a1
j dec

done:
ret

main:
# Load address instead of value
la a0, arg0
la a1, arg1
call mod
