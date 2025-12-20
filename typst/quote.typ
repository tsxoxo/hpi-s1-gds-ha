= Quoting

== doc
- https://typst.app/docs/reference/model/quote/

== Basic recipe

// NB: Attributions are only displayed for block quotes by default
#set quote(block: true)

#quote(attribution: link("https://docs.riscv.org/reference/isa/unpriv/rv32.html#ldst")[RISC-V Unprivileged ISA Spec])[Loads and stores whose effective address is not naturally aligned to the referenced datatype... 
]
