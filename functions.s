//
// Assembler program to demonstrate function calls.
// Calls a function to add two numbers and prints the result.
//
// Demonstrates:
//   - BL (branch with link) and RET instructions
//   - Saving/restoring the link register (x30)
//   - Passing parameters via registers (x0, x1)
//   - Returning values via x0
//

.global _start
.align 4

_start:
    // Save link register and frame pointer
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Call add_numbers(3, 4)
    mov     x0, #3              // first argument
    mov     x1, #4              // second argument
    bl      add_numbers         // call function, result in x0

    // Convert single-digit result to ASCII and print
    add     x0, x0, #0x30      // Convert to ASCII digit
    strb    w0, [sp, #-16]!    // Store on stack
    mov     w1, #10             // newline
    strb    w1, [sp, #1]

    mov     x0, #1              // stdout
    mov     x1, sp              // pointer to digit
    mov     x2, #2              // length
    mov     x16, #4             // syscall: write
    svc     #0x80
    add     sp, sp, #16         // restore stack

    // Call add_numbers(5, 3)
    mov     x0, #5
    mov     x1, #3
    bl      add_numbers

    // Convert and print second result
    add     x0, x0, #0x30
    strb    w0, [sp, #-16]!
    mov     w1, #10
    strb    w1, [sp, #1]

    mov     x0, #1
    mov     x1, sp
    mov     x2, #2
    mov     x16, #4
    svc     #0x80
    add     sp, sp, #16

    // Restore and exit
    ldp     x29, x30, [sp], #16
    mov     x0, #0
    mov     x16, #1
    svc     #0x80

// Function: add_numbers
// Adds x0 and x1, returns result in x0
add_numbers:
    add     x0, x0, x1         // x0 = x0 + x1
    ret                         // return to caller
