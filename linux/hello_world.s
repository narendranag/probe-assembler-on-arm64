//
// Linux ARM64: Print "Hello World!" to stdout
//
// Linux ARM64 syscall convention:
//   x8  = syscall number
//   x0-x5 = arguments
//   svc #0 to invoke
//
// Syscall numbers: write = 64, exit = 93
//

.global _start

.text
_start:
    // Write "Hello World!\n" to stdout
    mov     x0, #1              // fd = stdout
    adr     x1, helloworld      // pointer to string
    mov     x2, #13             // length
    mov     x8, #64             // syscall: write
    svc     #0

    // Exit with code 0
    mov     x0, #0
    mov     x8, #93             // syscall: exit
    svc     #0

.data
helloworld: .ascii "Hello World!\n"
