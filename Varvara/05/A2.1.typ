== Aufgabe 2.1: Block- und Cache-Größe

Gegeben ist ein 8-Bit Adressbus und die Information, dass an jeder Adresse ein *Halfword (2 Bytes)* gespeichert ist.
Die Adressaufteilung ist: Tag (3 Bits), Index (3 Bits), Block Offset (2 Bits).

*1. Wie groß ist ein Block?*
Der Block Offset besteht aus 2 Bits. Das bedeutet, ein Block enthält $2^2 = 4$ adressierbare Einheiten ("Wörter").
Da eine Adresse aber auf 2 Bytes verweist, müssen wir dies multiplizieren:

$ text("Anzahl Wörter pro Block") = 2^2 = 4 $
$ text("Blockgröße") = 4 text("Wörter") times 2 text("Bytes/Wort") = 8 text("Bytes") $

*2. Wie groß kann der Cache maximal sein?*
Der Index besteht aus 3 Bits. Das bestimmt die Anzahl der Cache-Zeilen (Lines), die wir adressieren können.

$ text("Anzahl Lines") = 2^3 = 8 text("Lines") $

Die Gesamtgröße ist die Anzahl der Lines mal der Größe eines Blocks:

$ text("Cache-Größe") = 8 text("Lines") times 8 text("Bytes/Line") = 64 text("Bytes") $

In KiBiBytes:
$ 64 / 1024 = 0.0625 text("KiB") $