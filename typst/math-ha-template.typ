// MACROS
#let zero = math.underline([0])

// SETTINGS
#set text(size: 16pt)
#set page(fill: rgb("#c6c69d"))
#set text(fill: rgb("#2d2924"))

#show heading.where(level: 1): set text(size: 24pt)

#set math.equation(block: true, numbering: none)
#show math.equation: set block(above: 2em, below: 2em)

#show enum: it => block(above: 1.4em, below: 2em, it)
#set enum(indent: .5em)
#set enum(numbering: "(1)")

#set list(indent: .5em)

#set par(
  // first-line-indent: 1em,
  // spacing: 0.65em,
  justify: true,
)

#show link: text.with(fill: blue)

// FUNCTIONS
#let VSPACE = 1em
#let HSPACE = 1em

#let title(names, sheet_number, group) = align(center, rect(inset: 1em)[
  #names #h(1fr) Mathematik 1 
  = Hausaufgabe Woche #sheet_number
  #v(1em)
  Tutorium: #group #h(1fr) Wintersemester 2025/26
])

#let exercise_counter = counter("exercise")

#let exercise(title, content) = block[
  #exercise_counter.step()
  #text(size: 1.2em)[*Aufgabe #context exercise_counter.display("1")*] (#title):\
  #box(inset: (left: HSPACE, top: 0em), width: 1fr, content)
  #v(VSPACE)
]

#let solution(content) = block(breakable: true)[
  *Lösung:*\
  #pad(left: HSPACE, content)
  #v(VSPACE)
]

// MAIN

#title([Thomas Szwaja], 10, [Poker-Chip])
#v(2em)

#exercise[Der Kern][
Sei $phi: RR^n -> RR^m$ eine lineare Abbildung.

Zeige, dass $"Kern"(phi) = {v in RR^n | phi(v) = underline(0)}$.
Zeige dass dies ein Untervektorraum von $RR^n$ ist.

]

#solution[
]

#v(2em)

#exercise[Rechenregeln Lineare Abbildungen][
  Es seien $n, m in NN$ und $phi: RR^n -> RR^m$ linear. \
  Zeige, für alle $u, v in RR^n$ und alle $x in RR$, dass

  + $phi(u + v) = phi(u) + phi(v)$\
  + $phi(#zero) = #zero$\
  + $phi(x v) = x phi(v)$
]

#solution[
]
