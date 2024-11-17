# probe-assembler-on-arm64
Assembler on Apple Silicon

Found this
https://github.com/below/HelloSilicon


## Exit_Code
### Instructions to Assemble, Link, and Run the Program
To assemble the assembly code (`exit_code.s`) into an object file (`exit_code.o`), run:
   ```bash
   as -arch arm64 -o exit_code.o exit_code.s
   ld -o exit_code exit_code.o -lSystem -syslibroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -e _start
   ./exit_code
   echo $?

