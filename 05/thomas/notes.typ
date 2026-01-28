## meeting mit vara

- aufgabe 2.2.a: 2.index: cache-block groesser?
  - wieso brauchst du mehr index bits bei asso 2
- a2.3.c: wieso 8-bytes blockgroesse?
- write-back vs. through -- passiert das bei load oder store oder beiden?
- addressing. 14.65: i am lost here

== a2.3.c: wieso ist 0xD0 ein Hit?
Hypothese, s. 14.37 "Bloecke und Alignment": "Adresse wird auf Vielfaches der Blockgröße abgerundet; dient als Startadresse
Beispiel: Block zu 16 Bytes, Zugriff auf Byte an Adresse 39 → Block enthält Adressen 32, ..., 47"

- wie berechnet man Blockgroesse aus den Daten in 2.3?
- ich verstehe das ganze abrunden-zweierpotenzen-letzten bits auf 0 setzen nicht
- 14.43: "Blauer Block ist Block mit Nummer 27, braucht 6 Bits, also Blocknummer 0b 01 1011" -- not 5 bits? what am i missing? Weil insgesamt 64 Bloecke?
- unklar: Verhaeltnis zwischen Bloecke -- Byte-Adressierter Speicher -- Alignment

== side quests
- how would i know the needed breadth of address bus given size of memory and addressing mode (per byte, word, etc.)
