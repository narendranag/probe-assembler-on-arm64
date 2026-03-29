//
// Assembler program to demonstrate loops.
// Prints digits 0-9, each on a new line.
//
// Demonstrates:
//   - Loop with counter register
//   - Branch instructions (b, b.lt)
//   - Preserving registers across syscalls
//

.global _start
.align 4

_start:
    mov     x19, #0             // x19 = loop counter (callee-saved)
    mov     x20, #10            // x20 = loop limit

loop:
    // Convert counter to ASCII digit: '0' = 0x30
    add     x21, x19, #0x30    // x21 = ASCII digit
    strb    w21, [sp, #-16]!   // Store digit byte on stack

    // Store newline after digit
    mov     x21, #10            // newline character
    strb    w21, [sp, #1]       // Store newline at sp+1

    // Write digit + newline to stdout
    mov     x0, #1              // stdout
    mov     x1, sp              // pointer to digit on stack
    mov     x2, #2              // length = 2 (digit + newline)
    mov     x16, #4             // syscall: write
    svc     #0x80

    add     sp, sp, #16         // Restore stack pointer

    // Increment and check loop condition
    add     x19, x19, #1       // counter++
    cmp     x19, x20            // compare counter to limit
    b.lt    loop                // if counter < 10, loop again

    // Exit
    mov     x0, #0
    mov     x16, #1
    svc     #0x80
