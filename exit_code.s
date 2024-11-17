
.global _start

.section __TEXT,__text
_start:
    mov x0, #42            // Load the exit code (42) into register x0
    mov x16, #1            // Syscall number for exit is 1 (on ARM64 for macOS)
    svc #0                 // Trigger syscall (exit)