//
// Assembler program to demonstrate conditionals.
// Compares two numbers and prints which is larger.
//
// Demonstrates:
//   - CMP instruction and condition flags
//   - Conditional branching (b.gt, b.lt, b.eq)
//   - Multiple code paths
//

.global _start
.align 4

_start:
    mov     x0, #42             // First number
    mov     x1, #17             // Second number

    cmp     x0, x1              // Compare the two numbers
    b.gt    first_greater       // Branch if x0 > x1
    b.lt    second_greater      // Branch if x0 < x1
    b       equal               // Otherwise they're equal

first_greater:
    adr     x1, msg_first
    mov     x2, #22             // length of "First is greater!\n"
    b       print

second_greater:
    adr     x1, msg_second
    mov     x2, #23             // length of "Second is greater!\n"
    b       print

equal:
    adr     x1, msg_equal
    mov     x2, #21             // length of "Both are equal!\n"
    b       print

print:
    mov     x0, #1              // stdout
    mov     x16, #4             // syscall: write
    svc     #0x80

    // Exit
    mov     x0, #0
    mov     x16, #1
    svc     #0x80

msg_first:   .ascii "First is greater!\n"
.align 4
msg_second:  .ascii "Second is greater!\n"
.align 4
msg_equal:   .ascii "Both are equal!\n"
