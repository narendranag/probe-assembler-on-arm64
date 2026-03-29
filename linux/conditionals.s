//
// Linux ARM64: Compare two numbers and print which is larger
//
// Demonstrates conditional branching with Linux syscall convention.
// Syscall numbers: write = 64, exit = 93
//

.global _start

.text
_start:
    mov     x0, #42
    mov     x1, #17

    cmp     x0, x1
    b.gt    first_greater
    b.lt    second_greater
    b       equal

first_greater:
    adr     x1, msg_first
    mov     x2, #18
    b       print

second_greater:
    adr     x1, msg_second
    mov     x2, #19
    b       print

equal:
    adr     x1, msg_equal
    mov     x2, #16
    b       print

print:
    mov     x0, #1              // stdout
    mov     x8, #64             // syscall: write
    svc     #0

    mov     x0, #0
    mov     x8, #93             // syscall: exit
    svc     #0

msg_first:   .ascii "First is greater!\n"
msg_second:  .ascii "Second is greater!\n"
msg_equal:   .ascii "Both are equal!\n"
