//
// Linux ARM64: Print digits 0-9 using a loop
//
// Demonstrates loops with Linux syscall convention.
// Syscall numbers: write = 64, exit = 93
//

.global _start

.text
_start:
    mov     x19, #0             // loop counter (callee-saved)
    mov     x20, #10            // loop limit

loop:
    // Convert counter to ASCII digit
    add     x21, x19, #0x30
    strb    w21, [sp, #-16]!    // Store digit on stack
    mov     x21, #10            // newline
    strb    w21, [sp, #1]

    // Write digit + newline
    mov     x0, #1              // stdout
    mov     x1, sp              // pointer to digit
    mov     x2, #2              // length
    mov     x8, #64             // syscall: write
    svc     #0

    add     sp, sp, #16         // restore stack

    // Increment and loop
    add     x19, x19, #1
    cmp     x19, x20
    b.lt    loop

    // Exit
    mov     x0, #0
    mov     x8, #93
    svc     #0
