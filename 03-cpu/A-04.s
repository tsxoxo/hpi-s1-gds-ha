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

.text
start:
        lw s0, initialBrightness
        lw s1, pulseLength
        add s2, s0, x0                                          # set ON counter to initial brightness
        lw s3, inputSpeed
        
tick:
        addi s1, s1, -1
        beqz s1, drawPixel                                      # start new period

        addi s2, s2, -1                                         # when ON ends -> set to OFF
        beqz s2, removePixel

        addi s3, s3, -1                                         # handle input periodically
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
# if current_brightness > 0: j decreaseBrightness
       bgtz s0, decreaseBrightness
# else 
       j tick

decreaseBrightness:
        addi s0, s0, -1
        j tick

# start period
drawPixel:
                lw s1, pulseLength                              # reset tick counter
                add s2, s0, x0                                  # reset ON counter

                beqz s2, removePixel                            # if brightness==0 set to OFF

                lw s4, white                                    # set color for painting
                j paintCanvas
    
removePixel:
    lw s4, black
    j paintCanvas

paintCanvas:    
    li t1, LED_MATRIX_0_BASE
    sw s4, 0(t1) 
    j tick

