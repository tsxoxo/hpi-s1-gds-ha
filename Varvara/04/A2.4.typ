= Aufgabe 2.4: Visualisierung des Stackframes

Hier ist der Stackframe der Funktion `quicksort` zu einem Zeitpunkt, nachdem `partition` zurückgekehrt ist und bevor der rekursive Aufruf für die rechte Seite erfolgt.

Wir nehmen an, dass `sp` (Stack Pointer) am Anfang auf Adresse `0x8000` zeigte. Der Stack wächst nach unten (zu niedrigeren Adressen).

#figure(
  table(
    columns: (auto, auto, auto, 2fr),
    inset: 10pt,
    align: horizon,
    fill: (col, row) => if row == 0 { luma(220) } else { none },
    
    [*Relative Adresse*], [*Beispiel-Adresse*], [*Inhalt (Register)*], [*Beschreibung*],
    
    [sp + 16], [0x8000], [ ... ], [Stackframe des Aufrufers (Previous Frame)],
    
    [sp + 12], [0x7FFC], [*ra* (Return Address)], [Rücksprungadresse zum Aufrufer],
    
    [sp + 8], [0x7FF8], [*s0* (lo / start)], [Startadresse des aktuellen Teil-Arrays],
    
    [sp + 4], [0x7FF4], [*s1* (hi / end)], [Endadresse des aktuellen Teil-Arrays],
    
    [sp + 0], [0x7FF0], [*s2* (p / pivot)], [Adresse des Pivot-Elements (von partition)],
    
    [ --- ], [0x7FE0], [ ... ], [Freier Speicher / Nächster Frame]
  ),
  caption: [Stackframe-Layout für Quicksort (16 Bytes groß)]
)
