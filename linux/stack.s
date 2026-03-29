//
// Linux ARM64: Demonstrate stack operations
// Pushes/pops values and verifies correctness.
//
// Demonstrates STP/LDP, stack frames, register preservation.
// Syscall numbers: write = 64, exit = 93
//

.global _start

.text
_start:
    stp     x29, x30, [sp, #-16]!
    mov     x29, sp

    // Push values onto the stack
    mov     x0, #10
    mov     x1, #20
    stp     x0, x1, [sp, #-16]!

    mov     x0, #30
    mov     x1, #40
    stp     x0, x1, [sp, #-16]!

    // Pop pairs
    ldp     x2, x3, [sp], #16       // x2=30, x3=40
    ldp     x4, x5, [sp], #16       // x4=10, x5=20

    // Verify
    add     x6, x2, x4              // 40
    add     x7, x3, x5              // 60

    cmp     x6, #40
    b.ne    fail
    cmp     x7, #60
    b.ne    fail

    // Print "OK"
    adr     x1, msg_ok
    mov     x0, #1
    mov     x2, #3
    mov     x8, #64
    svc     #0
    b       done

fail:
    adr     x1, msg_fail
    mov     x0, #1
    mov     x2, #5
    mov     x8, #64
    svc     #0

done:
    ldp     x29, x30, [sp], #16
    mov     x0, #0
    mov     x8, #93
    svc     #0

msg_ok:     .ascii "OK\n"
msg_fail:   .ascii "FAIL\n"
