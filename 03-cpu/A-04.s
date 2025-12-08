.data
white: .word 0x00ffffff
black: .word 0x0

pulseLength: .word 100
inputSpeed: .word 20
initialBrightness: .word 40

# --- REGISTERS ---
# s0: current brightness
# s1: ticks left in current period
# s2: ticks before OFF
# s3: ticks before input
# s4: color

# --- FUNCTIONS ---
#start:
#tick:
#+-checkInput:
#increaseBrightness:
#increaseBrightnessTestBounds:
#decreaseBrightness:
#decreaseBrightnessTestBounds:
#+drawPixel
#+removePixel
#+paintCanvas

.text
start:
        lw s0, pulseLength
        lw t0, initialBrightness
        sub s0, s0, t0
        lw s1, pulseLength
        lw s3, inputSpeed
        
tick:
        addi s1, s1, -1
        beqz s1, drawPixel # start new period
        beq s1, s0, removePixel

        # process input
        addi s3, s3, -1
        beqz s3, checkInput

        j tick

checkInput:
                lw s3, inputSpeed                               # reset input counter

                li t0, D_PAD_0_UP                               # if DPAD UP
                lb t1, 0(t0)
                bnez t1, increaseBrightnessTestBounds

                li t0, D_PAD_0_DOWN                             # if DPAD DOWN
                lb t1, 0(t0)
                bnez t1, decreaseBrightnessTestBounds

                j tick                                          # else

# v 0.0
    # li t0, LED_MATRIX_0_SIZE
    # li t2, 0xFF
    # sw t2, 0(t0)
    # j tick

increaseBrightnessTestBounds:
# if current_brightness < pulselength-1: j increaseBrightness
       lw t0, pulseLength
       addi t0, t0, -1
       blt s0, t0, increaseBrightness
# else 
       j tick

increaseBrightness:
        addi s0, s0, 1
        j tick


decreaseBrightnessTestBounds:
# if current_brightness < pulselength-1: j decreaseBrightness
       bgtz s0, decreaseBrightness
# else 
       j tick

decreaseBrightness:
        addi s0, s0, -1
        j tick

drawPixel:
    lw s4, white
    lw s1, pulseLength
    # add s2, x0, x0 TODO: 
    j paintCanvas
    
removePixel:
    lw s4, black
    j paintCanvas

paintCanvas:    
    li t1, LED_MATRIX_0_BASE
    sw s4, 0(t1) 
    j tick

