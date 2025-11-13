// SETTINGS
#set text(size: 16pt)

#show heading.where(level: 1): set text(size: 24pt)

#show table.cell.where(y: 0): strong

#set math.equation(block: true, numbering: none)
#show math.equation: set block(above: 2em, below: 2em)

#show enum: it => block(above: 1.4em, below: 2em, it)
#set enum(indent: .5em)

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

#let solution(content) = block[
  *Lösung:*\
  #pad(left: HSPACE, content)
  #v(VSPACE)
]

// MAIN

#title([Thomas Szwaja], 5, [Poker-Chip])
#v(2em)

#exercise[WWT][
]

#solution[

#table(
  columns: 6,
  stroke: 0.5pt + rgb("666675"),
  table.header[*$E_t$*][*$P_(t-1)$*][*$Q_(t-1)$*][*$P_t$*][*$Q_t$*][*Kommentar*],
    [0],[0],[0],[0],[0],[],
    [0],[0],[1],[0],[1],[],
    [0],[1],[0],[1],[0],[],
    [0],[1],[1],[1],[1],[],
    [1],[0],[0],[1],[0],[Achtung, $P_(t-1) != Q_(t-1)$],
    [1],[0],[1],[1],[0],[],
    [1],[1],[0],[0],[1],[],
    [1],[1],[1],[0],[1],[Achtung, $P_(t-1) != Q_(t-1)$],
)
]

#v(2em)

#exercise[Schaltnetz][
]

#solution[
  // Überlegung: Ein möglicher Ansatz: Zu jeder Taktvorderflanke wird S zu NOT S und R zu NOT R am RS-Flipflop. 

  Wir erinnern uns an die WWT für einen RS-Flipflop.


#table(
  columns: 6,
  stroke: 0.5pt + rgb("666675"),
  table.header[*$S_t$*][*$R_t$*][*$P_(t-1)$*][*$Q_(t-1)$*][*$P_t$*][*$Q_t$*],
    [0],[0],[$a$],[$not a$],[$a$],[$not a$],
    [0],[1],[$a$],[$not a$],[1],[0], // what happens here?
    [1],[0],[$a$],[$not a$],[0],[1],
)

Wir nehmen an, wir brauchen eine Funktion in der Form $f: (E_t, Q_t) -> (S_t, R_t)$ so, dass die Eingaben $(S_t, R_t)$ den entsprechenden Ausgang $Q_(t+1)$ des RS-Flip-Flops verursachen. Wir fassen in einer Tabelle zusammen.

#table(
  columns: 4,
  stroke: 0.5pt + rgb("666675"),
  table.header[*$E_t$*][*$Q_t$*][*Gewünschtes $Q_(t+1)$*][*Erforderliche $S, R$*],
    [0],[0],[0],[$(0,0)$],
    [0],[1],[1],[$(0,0)$],
    [1],[0],[1],[$(1, 0)$],
    [1],[1],[0],[$(0, 1)$],
)

  Wir sehen daran, dass $S = E_t and not Q_t$ und $R = E_t and Q_t$. 
  Wir sind bereit, den Schaltkreis zu entwerfen.

  #image("A-01-02.png")
]

#v(2em)


#exercise[Eingangsflipflop][
]

#solution[
Eingabeflipflop = Input Flip-Flop
A flip-flop designed to accept and store external input in a larger sequential system.
Think: keyboard input, sensor data, user button press - anything coming from outside your circuit into your state machine.
What Makes a Good One?
The question is asking you to think about desirable properties for this role:

Deterministic behavior - predictable state transitions
No forbidden states - can't brick your system with bad inputs
Ease of control - simple input interface
Flexibility - can handle different input patterns (set, reset, toggle, hold)

  ANSWER:
the jk flip flop is based on the rs flip flop and what seems to be a significant difference, is that we can set state independently from previous state. we can say store a 1 and it does it no matter what. the toggle can only switch states. 

another issue might be that the toggle could be harder to control because you really have to get things done in 1 clock sycle. if you fail to switch off E (the input) in the next clock cycle, you've toggled yourself back to your initial state. i'm not sure this exact problem exists, although it seems to be the case with the 1, 1 state in the jk flip-flop. 

so the toggle ff seems to tick a lot of boxes: deterministic, non-brickable, simple interface. but it' works the best with toggling and holding, the other functions would require adjustments at least.]

#v(2em)
