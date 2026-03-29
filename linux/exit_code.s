//
// Linux ARM64: Exit with code 42
//
// Linux ARM64 syscall convention:
//   x8  = syscall number
//   x0  = first argument
//   svc #0 to invoke
//
// Syscall numbers: exit = 93
//

.global _start

.text
_start:
    mov     x0, #42             // exit code
    mov     x8, #93             // syscall: exit
    svc     #0
