//
// Assembler program to demonstrate stack operations.
// Pushes values onto the stack, modifies them, and pops them back.
// Prints "OK\n" if stack operations work correctly.
//
// Demonstrates:
//   - STP/LDP (store/load pair) for push/pop
//   - Stack pointer manipulation
//   - Register preservation across function calls
//   - Stack frame setup (frame pointer)
//

.global _start
.align 4

_start:
    // Set up stack frame
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Push values onto the stack
    mov     x0, #10
    mov     x1, #20
    stp     x0, x1, [sp, #-16]!     // Push 10 and 20

    mov     x0, #30
    mov     x1, #40
    stp     x0, x1, [sp, #-16]!     // Push 30 and 40

    // Pop the top pair (should be 30 and 40)
    ldp     x2, x3, [sp], #16       // Pop into x2=30, x3=40

    // Pop the next pair (should be 10 and 20)
    ldp     x4, x5, [sp], #16       // Pop into x4=10, x5=20

    // Verify: x2 + x4 should be 40, x3 + x5 should be 60
    add     x6, x2, x4              // x6 = 30 + 10 = 40
    add     x7, x3, x5              // x7 = 40 + 20 = 60

    // Check results
    cmp     x6, #40
    b.ne    fail
    cmp     x7, #60
    b.ne    fail

    // Print "OK" - stack operations verified
    adr     x1, msg_ok
    mov     x0, #1
    mov     x2, #3
    mov     x16, #4
    svc     #0x80
    b       done

fail:
    // Print "FAIL"
    adr     x1, msg_fail
    mov     x0, #1
    mov     x2, #5
    mov     x16, #4
    svc     #0x80

done:
    // Restore frame and exit
    ldp     x29, x30, [sp], #16
    mov     x0, #0
    mov     x16, #1
    svc     #0x80

msg_ok:     .ascii "OK\n"
.align 4
msg_fail:   .ascii "FAIL\n"
