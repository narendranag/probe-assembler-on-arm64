# probe-assembler-on-arm64
Assembler on Apple Silicon

Tutorials etc

   1.	HelloSilicon: This GitHub repository offers an introduction to ARM64 assembly on Apple Silicon Macs. It provides code examples and explanations tailored to Apple’s ARM64 architecture. (GitHub)
	2.	Apple Developer Documentation: Apple’s official documentation includes a section on writing ARM64 code for Apple platforms, detailing the architecture and best practices for assembly programming. (Apple Developer)
	3.	A Gentle Introduction to Assembly Language Programming: This textbook provides a gentle introduction to assembly language programming, with chapters specifically addressing Apple Silicon assembly language programming. It includes macros that make programming a bit easier and discusses calling conventions used in Apple Silicon. (GitHub)
	4.	Apple-Silicon-ASM-Examples: This GitHub repository contains several simple programs written in assembly for Apple’s M1 processor (Apple Silicon). Each program demonstrates basic assembly instructions or programming concepts, such as loops and switches. They are self-contained and can be compiled on an Apple Silicon machine using the included makefile. (GitHub)
	5.	Programming with 64-Bit ARM Assembly Language: This book offers a comprehensive guide to ARM64 assembly programming, with adjustments for Apple’s ARM64 line of computers. It covers topics from getting started with computers and numbers to advanced assembly language concepts. (GitHub)



## Exit_Code
### Instructions to Assemble, Link, and Run the Program
To assemble the assembly code (`exit_code.s`) into an object file (`exit_code.o`), run:
   ```bash
   as -arch arm64 -o exit_code.o exit_code.s
   ld -o exit_code.x exit_code.o -lSystem -syslibroot /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk -e _start
   ./exit_code
   echo $?

