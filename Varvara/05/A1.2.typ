== Aufgabe 1.2: Energie und Kostenvergleich

Um die Effizienz auf unterschiedlicher Hardware zu bewerten, haben wir das Programm zusätzlich auf einem älteren Laptop ausgeführt und die Ergebnisse verglichen.

=== 1. Geräteparameter und Messung

*Gerät A (Referenz):*
- *Modell:* Apple MacBook (Apple Silicon).
- *Leistungsaufnahme ($P_A$):* ca. $20$ Watt.
- *Gemessene Zeit ($t_A$):* $0.910$ s (Variante `v4_int128`).

*Gerät B (Vergleichsgerät):*
- *Modell:* Acer Aspire 3 (A315).
- *Prozessor:* Intel Core i3-6006U (2.0 GHz, Dual Core).
- *Leistungsaufnahme ($P_B$):* ca. $30$ Watt.
- *Gemessene Zeit ($t_B$):* $2.942$ s.

*Beobachtung:* Das ältere Gerät benötigt für die gleiche Aufgabe mehr als die dreifache Zeit ($3.2$x). 

=== 2. Energieverbrauch ($E = P dot t$)

*Gerät A (Mac):*
$ E_A = 20 text("W") dot 0.910 text("s") approx 18.2 text("Joule") $

*Gerät B (Acer):*
$ E_B = 30 text("W") dot 2.942 text("s") approx 88.3 text("Joule") $

*Fazit:* Der Acer Aspire 3 verbraucht für die gleiche Rechenoperation fast *5-mal mehr Energie* ($88.3 text("J")$ vs $18.2 text("J")$) als das moderne System.

=== 3. Stromkosten
Wir berechnen die Kosten basierend auf dem aktuellen Börsenstrompreis (EPEX SPOT Day-Ahead, DE-LU, ca. $110$ €/MWh).
Preis pro kWh: $0.11$ €.

*Kosten Gerät A:*
$ K_A = frac(18.2, 3.6 dot 10^6) text("kWh") dot 0.11 (text("€")/text("kWh")) approx 5.56 dot 10^(-7) text("€") $

*Kosten Gerät B:*
$ K_B = frac(88.3, 3.6 dot 10^6) text("kWh") dot 0.11 (text("€")/text("kWh")) approx 2.70 dot 10^(-6) text("€") $

*Fazit:* Das ältere System ist deutlich ineffizienter und verbraucht fast 5-mal mehr Energie für dieselbe Berechnung.

=== 4. Begründung
Die drastischen Unterschiede lassen sich durch die Speicherhierarchie erklären:

- *CPU Stalls durch Latenz:* Das Programm ist speicherlastig (Memory Bound). Das ältere System hat eine langsamere Anbindung an den Hauptspeicher. Die CPU muss häufiger und länger auf Daten warten ("Stall"), bevor sie weiterrechnen kann. Während dieser Wartezeit wird Energie verbraucht, ohne dass Arbeit verrichtet wird.
- *Räumliche Lokalität:* Die Verwendung von `int128` halbiert die Anzahl der Elemente, die in einen Cache-Block passen. Das erzwingt häufigeres Nachladen aus dem langsamen Hauptspeicher, was das ältere Speichersystem stärker belastet als das moderne.

=== 5. Verfälschende Faktoren
Warum weicht die Theorie von der Praxis ab?

- *Verdrängung im Cache:* Auf dem Laptop laufen nebenher andere Programme (Betriebssystem, Browser etc.). Diese greifen ebenfalls auf den Speicher zu und verdrängen Teile meiner Daten aus dem Cache. Beim nächsten Zugriff müssen diese Daten wieder zeitaufwendig aus dem RAM geholt werden.
- *Cache-Status (Cold vs. Warm):* Die erste Ausführung des Programms ist immer langsamer, da der Cache zunächst leer ("kalt") ist und die Daten erst aus dem Hauptspeicher geladen werden müssen.