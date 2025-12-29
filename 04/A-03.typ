// NOTE: Seems like the slides alone don't provide enough info to answer these (e.g. 3.4)
// Looking at Patterson, Hennessy -- Computer Organization RISC-V (`PH20`)

= 3. Interrupts

== 1. Welche Arten von Interrupts gibt es? Wodurch werden diese ausgelöst?

// This seems irrelevant
// - Trap, synchrone Ausnahme -- wird durch Auslösung einer konkreten Programminstruktion ausgelöst (s. 11.12)
//   - Arithmetische Fehler
//   - Transiente Ausfälle -- vergehen von selbst // relevant here?
//   - Verletzung von Schutzrechten

// Definition
// Interrupt, Unterbrechung, externe Ausnahme -- hat nichts mit dem Programmablauf zu tun (s. 11.17)

// TODO: Arten von Interrupts?
// Synchrone und Asynchrone?

// NOTE: Komisch, laut PH20 bezeichnet RISC-V lediglich "I/O device requests" als interrupts -- bezieht sich die Frage 3.1 doch eher auf Ausnahmen?

Ausgelöst durch:
- Eingaben wie Maus und Tastatur
- IO Prozesse wie Rückmeldung eines Speicherträgers über erfolgreichen Schreibprozess
- Timer

== 2. Wie bzw. wann wird auf das Eintreten eines Interrupts reagiert? Wie unterscheiden sich die Arten hier? Auf welcher Betrachtungsebene (Mikroinstruktionen, Instruktionen, Programme, . . . ) erfolgt dies?

Control detektiert Ausnahme und leitet Behandlung ein (11.22). Startet ein spezielles Unterprogramm -- eine Ausnahmeroutine (Interrupt Service Routine, _ISR_)-- über Mikroinstruktion (11.24). Für jeden Ausnahmetypen gibt es eine separate Routine, zu der per Unterbrechungstabelle gesprungen wird.

Der ISR Aufruf erfolgt entweder über einen direkten Sprung --  basierend auf dem Ausnahmetypen und der entsprechenden Adresse in der Interrupt-Tabelle (vectored interrupt); oder es wird ein spezielles Register gesetzt und anhand dessen, verzweigt (RISC-V: supervisor exception cause register).

== 3. Was ergibt sich daraus für die Verantwortlichkeiten im Falle eines Interrupts? Gehen Sie zudem auf die Sinnhaftigkeit von Rückgabewerten ein.

Behandlung einer Ausnahme sollte transparent erfolgen -- State bleibt gleich (IPC, Reg, Stack). Zeit zwischen Instruktionen vergeht.
Aufgaben des Aufrufers: PC in Register setzen, Stack aufräumen, usw. -- werden von Control übernommen. 

Interrupt-Routinen haben nie einen Rückgabewert. Das hat damit zu tun, dass der Aufruf einer ISR in einem besonderen Kontext geschieht (z.b. während ein Programm läuft), in dem es unklar ist, wie man mit einem Rückgabewert vorgehen würde: wo würde man ihn abspeichern? Wer würde ihn verarbeiten? usw. (s. 11.29)

== 4. Es gibt zudem die Möglichkeit, Interrupts zu sperren oder zu priorisieren, sodass die Behandlung nicht umgehend erfolgen muss. Welchen Nutzen könnte dies haben?

== 5. Gehen Sie von Interruptbehandlung anhand einer Sprungtabelle aus, von welcher in die richtige Interrupt Service Routine gesprungen wird.

=== a) Angenommen, die Sprungtabelle befände sich ohne Schreibschutz im Hauptspeicher. Welches Sicherheitsrisiko ergibt sich daraus? Welche Differenzierung wird nötig?

// intuitive  
Da eine ISR im Kernel-Modus ausgeführt wird, hat sie Zugriff
auf systemkritische Funktionen (swap, ...). Diese Routinen sollten 
dementsprechend besonders vor Manipulation geschützt werden. 

// TODO: Differenzierung?

=== b) Stellen Sie den Prozess der Ausnahmebehandlung auf eine Ihres Erachtens geeignete Weise dar; schematisch, textuell, . . .

s. 11.28

+ Ausnahme passiert
+ Control detektiert Ausnahme durch Mikroinstruktion. PC wird gesichert. Passende ISR wird herausgesucht.
+ Spring zur ISR. Frame wird erzeugt, Register werden gesichert, es wird Platz auf dem Stack geschafft.
+ IST beendet. Frame wird vernichtet. Kein Rückgabewert.
+ Rücksprung zum gespeicherten PC-Wert.

=== c) Wie endet die Behandlung einer Ausnahme? Was muss der Prozessor hier leisten?
