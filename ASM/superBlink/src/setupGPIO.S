# Assembler directives
# Commands to the assembler rather than code to be translated by it.
.section .text                    # Enter text section
.align 2                          # Align following code to 2^2 bytes
.globl setupGPIO                  # Declare global symbol "setupGPIO"

.include "memory_map.inc"
.include "gpio.inc"

setupGPIO:
    addi sp, sp, -16              # From the RISC-V Reader book, allocate the stack frame
    sw ra, 12(sp)                 # Save the return address onto the stack

    li t0, GPIO_CTRL_ADDR         # Load the base GPIO address
    li t1, GPIO_RGB_PINS          # Get the RGB pins offset
    sw t1, GPIO_OUTPUT_EN(t0)     # Writes the value in t0 into OUTPUT_ENABLE (Like pin_mode in arduino)
    sw t1, GPIO_OUTPUT_XOR(t0)    # Set the XOR so the RGB pins are active high (ON when 1)
    sw x0, GPIO_OUTPUT_VAL(t0)    # Set all the writable pins to 0 (off)

    lw ra, 12(sp)                 # Restore the return address
    addi sp, sp, 16               # Deallocating the stack frame
    ret