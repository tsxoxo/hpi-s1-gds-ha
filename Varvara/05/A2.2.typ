== Aufgabe 2.2: Veränderte Konfiguration

Hier untersuchen wir die Auswirkungen einer veränderten Blockgröße (1 Word = 4 Bytes) bei gleichbleibender Cache-Gesamtgröße (64 Bytes).

=== A. Direkt abbildender Cache (Direct Mapped)
Die Blockgröße beträgt nun 4 Bytes. Da eine Adresse weiterhin auf ein Halfword (2 Bytes) verweist, beinhaltet ein Block genau 2 Adressen.

1. *Block Offset:*
   $ log_2(4 text("Bytes") / 2 text("Bytes/Adresse")) = 1 text("Bit") $
2. *Index:*
   Die Anzahl der Cache-Lines erhöht sich, da die Blöcke kleiner geworden sind:
   $ text("Anzahl Lines") = 64 text("Bytes") / 4 text("Bytes/Block") = 16 text("Lines") $
   $ text("Index-Bits") = log_2(16) = 4 text("Bits") $
3. *Tag:*
   $ 8 text("Gesamt") - 4 text("Index") - 1 text("Offset") = 3 text("Bits") $

*Neue Aufteilung:* Tag: 3 Bits | Index: 4 Bits | Offset: 1 Bit.

=== B. 2-fach Assoziativer Cache
Bei gleicher Blockgröße (1 Word) werden die 16 Lines nun in Sets zu je 2 Lines ("Ways") organisiert.

1. *Block Offset:* Bleibt gleich (1 Bit).
2. *Index (Set-Index):*
   $ text("Anzahl Sets") = text("Anzahl Lines") / text("Assoziativität") = 16 / 2 = 8 text("Sets") $
   $ text("Index-Bits") = log_2(8) = 3 text("Bits") $
3. *Tag:*
   $ 8 text("Gesamt") - 3 text("Index") - 1 text("Offset") = 4 text("Bits") $

*Neue Aufteilung:* Tag: 4 Bits | Index: 3 Bits | Offset: 1 Bit.

=== C. Adressierbarer Speicher
*Frage:* Kann man so mehr Speicherblöcke adressieren?
*Antwort:* *Nein.*
Die Breite des Adressbusses bleibt unverändert bei 8 Bit. Damit ist der maximal adressierbare Speicherraum physikalisch auf $2^8 = 256$ Adressen (bzw. 512 Bytes) begrenzt. Die interne Organisation des Caches ändert nur, *wie* diese Daten im schnellen Zwischenspeicher abgelegt werden, nicht aber, *wieviel* Hauptspeicher adressiert werden kann.