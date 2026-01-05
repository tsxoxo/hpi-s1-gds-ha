.data
my_var: .word 10        # Wert 10

.text
.globl main

main:
    # ---------------------------------------------------------
    # TEIL 1: Call-by-Value 
    # Wir übergeben den Wert (10) direkt im Register.
    # ---------------------------------------------------------
    
    li  s0, 5           # s0 <- Wert 5
    
    mv  a0, s0          # Kopiere den WERT von s0 nach a0
    jal ra, func_by_value
    
    # Hier ist s0 immer noch 5. 
    # Die Änderung in der Funktion hatte keinen Effekt auf s0.

    # ---------------------------------------------------------
    # TEIL 2: Call-by-Reference
    # Wir übergeben die ADRESSE der Variable in a0.
    # ---------------------------------------------------------
    
    la  a0, my_var      # Lade die ADRESSE von my_var nach a0
                        # (Pointer auf den Speicher)
    
    jal ra, func_by_reference
    
    # Jetzt hat sich der Wert im Speicher bei 'my_var' geändert!
    # Wenn wir ihn laden würden, wäre er jetzt 11.

    # Programmende (Endless loop or exit)
    li a7, 10
    ecall

# ---------------------------------------------------------
# Funktion: Call-by-Value
# Eingabe: a0 (Wert)
# Tut: Addiert 1 zu a0, aber speichert es nirgendwo dauerhaft.
# ---------------------------------------------------------
func_by_value:
    addi a0, a0, 1      # a0 = a0 + 1. 
    ret                 # Kehrt zurück. s0 im main bleibt unverändert.

# ---------------------------------------------------------
# Funktion: Call-by-Reference
# Eingabe: a0 (Adresse / Pointer)
# Tut: Lädt Wert von Adresse, addiert 1, speichert zurück.
# ---------------------------------------------------------
func_by_reference:
    lw   t0, 0(a0)      # 1. Dereferenzieren: Lade Wert von Adresse (Read)
    addi t0, t0, 1      # 2. Modifizieren: Wert + 1
    sw   t0, 0(a0)      # 3. Speichern: Schreibe zurück an Adresse (Write)
    ret