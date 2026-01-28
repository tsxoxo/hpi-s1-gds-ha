= A1
// NOTE: 16^8 - 1e9+7 approx 3 billion

== Varianten
1. wie gegeben
2. wie gegeben
3. gzb: 64 - mod: 1e9 - copt: -O3 -- (var 1 mit copt -O3)
4. gzb: 128 - mod: 16^8 - copt: -O0 -- (var 2 mit copt -O0)
5. gzb: 64 - mod: 16^8 - copt: -O0 -- (var 1 mit grossem mod)
6. gzb: 128 - mod: 1e9 - copt: -O0 -- (var 2 mit kleinem mod)

== Erwartungen Parameter
Wir erwarten, dass die 3 Parameter gzb, mod und copt die Laufzeit wie folgt beeinflussen:

*gzb*: die größere Variante wird langsamer laufen. bei x86-64 passt 64-bit in ein Register, aber 128-bit muessen auf zwei Register oder ueber einen Stack Spill gehandhabt werden. Dies wuerde erheblich mehr Lese-Operationen mit sich bringen. Jede Addition, jeder `% MODULUS`, jeder cache store werden langsamer sein.

*mod*: 16^8 wird schneller laufen weil es eine Zweierpotenz ist. Der Compiler kann dies durch eine Bitmaske ersetzen. 

*copt*: Die hoeher-optimierte Variante wird schneller laufen, durch die Dutzenden von Optimierungstechniken, die der Compiler bei -O3 benutzt  (z.B. loop unrolling, function inlining)

== Erwartungen Varianten
Dementsprechend erwarten wir von den Varianten:

1. base case
2. schwer abzuschaetzen: *gzb* verlangsamt, die beiden anderen beschleunigen
3. schneller als 1
4. schneller als 1
5. schneller als 1
6. langsamer als 1




