== 4. Cache Kohaerenz

// Assumption: Multi-Processor Architektur wo jeder Kern seinen Cache hat, s. 15.14; evtl. Mischform, 15.17
// QUESTION:
// - ist das Modell hier 'Replikation mit write update' oder 'Replikation mit write invalidate?'
// - unklar: "Beim Schreiben und Aktualisieren wird dabei immer der aktuellere Wert übernommen"
// - welche sequentiellen Kohaerenz-Regeln genau?
// ANTWORT? (15.25)
// 1. read own writes
// 2. read other writes
// 3. write serialization
//
// OPTIONEN FUER STRATEGIEN (15.29, mark 's')
// f. Umsetzung von sequentieller kohaerenz
// 1. Migration
// 2. Replikation
//    - write invalidate
//    - write update

// OPTIONEN FUER MECHANISMEN (15.33)
// - Snooping Bus
// - Invalidierung an alle Caches schicken
// - Explizites Verzeichnis fuehren: in welchem Cache liegt welche Adresse?

=== Analyse: Hält dieses Prozessor-/Cache-Modell die sequenziellen Kohärenz-Regeln?
// Propagation happens asynchronously with instruction execution.
// -> reads/writes can happen while propagation is in-flight
// -> propagation is non-atomic!

// s. 15.30, mark 'd'
==== Read own writes

Nein. Gegenbeispiel:

`t`: core 3 writes value 'a' to address 1234 
`t+1`: core 0 writes value 'b' to address 1234 
`t+2`: core 0 gets propagated value 'a' from 3's write at t 
`t+3`: core 0 reads value 'a' at 1234 

The rule says: If no other write to X occurred after processor A’s write, A must read its own value.

Here, from core 0’s perspective:

- core 3’s write did occur before core 0’s write
- but it arrives after due to propagation delay

// Sequential coherence is about logical order, not arrival order.

The model allows an older write to overwrite a newer one at the same core. Thus, it violates the 'read own writes' part of the contract.

==== Read other writes
we define 'sufficient time' as a full propagation cycle. then this requirement could be fulfilled. 

==== Write serialization
. possibly, my previous thoughts have been invalidated now, i am not sure. another question: if there's two propagations happening at the same time, do they both happen at the same rate? can we assume they do? is this mundane to this problem? the way i see it: we have to assume that propagations happen and finish in order, otherwise this all turns to mush. i dont see the problem in your scenario immediately, but i see this: - t: core 0 sets x=0 - t+1: core 2 sets x=1 - t+2: core 2 reads x=1 - t+3: x=0 propagates to core 2 - t+4: core 2 reads x=0 so this is violated as well.
