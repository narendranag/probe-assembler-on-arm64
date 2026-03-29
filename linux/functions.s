//
// Linux ARM64: Demonstrate function calls
// Calls add_numbers function and prints results.
//
// Demonstrates BL/RET, parameter passing, link register.
// Syscall numbers: write = 64, exit = 93
//

.global _start

.text
_start:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Call add_numbers(3, 4) -> 7
    mov     x0, #3
    mov     x1, #4
    bl      add_numbers

    // Print result
    add     x0, x0, #0x30
    strb    w0, [sp, #-16]!
    mov     w1, #10
    strb    w1, [sp, #1]

    mov     x0, #1
    mov     x1, sp
    mov     x2, #2
    mov     x8, #64
    svc     #0
    add     sp, sp, #16

    // Call add_numbers(5, 3) -> 8
    mov     x0, #5
    mov     x1, #3
    bl      add_numbers

    add     x0, x0, #0x30
    strb    w0, [sp, #-16]!
    mov     w1, #10
    strb    w1, [sp, #1]

    mov     x0, #1
    mov     x1, sp
    mov     x2, #2
    mov     x8, #64
    svc     #0
    add     sp, sp, #16

    ldp     x29, x30, [sp], #16
    mov     x0, #0
    mov     x8, #93
    svc     #0

add_numbers:
    add     x0, x0, x1
    ret
