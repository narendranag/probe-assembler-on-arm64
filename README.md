# probe-assembler-on-arm64

Learning ARM64 assembly on Apple Silicon and Linux.

## Programs

| Program | Description | Concepts |
|---------|-------------|----------|
| `exit_code.s` | Exits with code 42 | Registers, syscalls |
| `hello_world.s` | Prints "Hello World!" | Write syscall, data sections |
| `loops.s` | Prints digits 0-9 | Loop counters, branch instructions |
| `conditionals.s` | Compares two numbers | CMP, conditional branching |
| `functions.s` | Adds numbers via function calls | BL/RET, link register, parameters |
| `stack.s` | Push/pop with verification | STP/LDP, stack frames |

Each program has a **macOS** version (root directory) and a **Linux** version (`linux/` directory).

### Key Differences: macOS vs Linux ARM64

| | macOS | Linux |
|---|-------|-------|
| Syscall register | `x16` | `x8` |
| Syscall invoke | `svc #0x80` | `svc #0` |
| Write syscall # | 4 | 64 |
| Exit syscall # | 1 | 93 |
| Entry point | `_start` | `_start` |
| Sections | `__TEXT,__text` | `.text` |

## Building

A `Makefile` is provided to automate assembly and linking.

```bash
# Build all programs for the detected platform (macOS or Linux)
make

# Build only macOS programs
make macos

# Build only Linux programs
make linux

# Clean all compiled files
make clean

# Show available targets
make help
```

### Manual Build (macOS)

```bash
# Assemble
as -arch arm64 -o exit_code.o exit_code.s

# Link
ld -o exit_code.x exit_code.o -lSystem -syslibroot $(xcrun --show-sdk-path) -e _start -arch arm64

# Run
./exit_code.x
echo $?    # prints 42
```

### Manual Build (Linux ARM64)

```bash
# Assemble
as -o linux/hello_world.o linux/hello_world.s

# Link
ld -o linux/hello_world.x linux/hello_world.o

# Run
./linux/hello_world.x
```

## CI

GitHub Actions CI runs on an ARM64 Linux runner (`ubuntu-24.04-arm`). It assembles, links, and tests all Linux programs on every push and PR to `main`.

## Tutorials & References

1. [HelloSilicon](https://github.com/below/HelloSilicon) - ARM64 assembly on Apple Silicon
2. [Apple Developer Documentation](https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms) - Writing ARM64 code for Apple platforms
3. [A Gentle Introduction to Assembly Language Programming](https://github.com/pkivolowitz/asm_book) - Textbook with Apple Silicon chapters
4. [Apple-Silicon-ASM-Examples](https://github.com/vhaudiern/Apple-Silicon-ASM-Examples) - Simple M1 assembly programs with makefile
5. [Programming with 64-Bit ARM Assembly Language](https://github.com/Apress/programming-with-64-bit-ARM-assembly-language) - Comprehensive ARM64 guide
