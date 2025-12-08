=== slides 08

- what is data memory (20)?

=== 1

==== Instruktionen

==== Pseudoinstruktionen
Typische Kombinationen oder Varianten v. Instruktionen

Beispiele aus (56)
`nop` für `addi x0, x0, 0`
`mov rd, rs` für `addi rd, rs, 0`

==== Segmente

==== Assembler
lh:     load half word
srli:   shift right
li:     load immediate
add:
addi:
bne: 

t0
middle:

==== litte/big endian

== 2

=== Load-store-Arch
also called reg-reg arch; emphasizes ALU-reg connection

- arithm/log ops nur zwischen regs
- r/w to ram only via regs (except immediate ops)

that means
- r/w ops have only two args: reg, addr

all other ops dont have addr as param.


--- 

1001 << 0010 == * 2
1001 >> 0100 == / 2

BASE 10
0001 << 0010 == 1 * 10
0010 >> 0001 == 10 / 10
