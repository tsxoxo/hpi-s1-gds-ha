= 3. Interrupts

== 1. Welche Arten von Interrupts gibt es? Wodurch werden diese ausgelöst?

Interrupts sind externe, asynchrone Ausnahmen, die nicht direkt mit dem aktuellen Programmablauf (im Sinne der momentanen Instruktion) zu tun haben (s. 11.17).

Grob gesehen, können wir unterscheiden zwischen IO und Timer Interrupts.

Beispiele für IO:
- Eingaben wie Maus und Tastatur
- IO Prozesse wie Rückmeldung eines Speicherträgers über erfolgreichen Schreibprozess

== 2. Wie bzw. wann wird auf das Eintreten eines Interrupts reagiert? Wie unterscheiden sich die Arten hier? Auf welcher Betrachtungsebene (Mikroinstruktionen, Instruktionen, Programme, . . . ) erfolgt dies?

Control detektiert Ausnahme und leitet Behandlung ein (11.22). Es wird je nach Ausnahme die Ausführung einer Ausnahmeroutine (Interrupt Service Routine, _ISR_) eingeleitet. 

Die Arten von Interrupt (IO, Timer) können sich durch Signalart unterscheiden (z.B. sporadische IO Rückmeldung vs. periodischer Timer). Das Schema der Behandlung bleibt aber gleich.

Die Behandlung eines Interrupts erfolgt transparent und ist für das Programm nicht sichtbar -- es vergeht lediglich Zeit zwischen zwei Instruktionen. Die ISR wird von Control durch Mikroinstruktionen angestoßen.

== 3. Was ergibt sich daraus für die Verantwortlichkeiten im Falle eines Interrupts? Gehen Sie zudem auf die Sinnhaftigkeit von Rückgabewerten ein.

Bei einem Aufruf einer _ISR_ gibt es keinen "Aufrufenden" im klassischen Sinne, da der Aufruf nicht aus einem Programmablauf sondern von der Hardware selbst verursacht wird. Dementsprechend werden die Aufgaben des Aufrufers auf Control sowie die ISR selbst verteilt. Control stellt sicher, dass nach der Behandlung des Interrupts das Programm an der selben Stelle fortsetzen kann. Die _ISR_ gewährleistet, dass der übrige State erhalten bleibt (Stack, Register).

Dementsprechend haben Interrupt-Routinen keinen Rückgabewert. Es gab keinen Aufrufenden im klassischen Sinne, also auch niemanden der einen Rückgabewert erwarten würde. Das Ziel ist es, das Programm nach dem Interrupt weiter laufen zu lassen, 'als wäre nichts gewesen'.

== 4. Es gibt zudem die Möglichkeit, Interrupts zu sperren oder zu priorisieren, sodass die Behandlung nicht umgehend erfolgen muss. Welchen Nutzen könnte dies haben?

// START_HERE:
Priorisierung und Sperrung von Interrupts könnte vielfältige Anwendung haben:

- Interrupts Sperren während der Behandlung eines bestehenden Interrupts um Komplexität zu vermeiden.
- Nach Interrupt-Quellen unterscheiden und so reagieren, dass ein möglichst effizienter Programmablauf erreicht wird.
- Bei knappen Ressourcen dafür sorgen, dass laufende Programme weiter laufen.

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
