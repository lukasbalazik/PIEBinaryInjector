# 64-bit PIE Binary Injector

## Workflow

Injected payload is constructed from base opcodes for bypassing PIE and forking, and from our compiled assembly code

Forking part of our base opcodes is very simple, just syscall fork and check if we are child or parent, if parent return to original entry point, if child execute our assembly code:

```assembly
mov rax,57
syscall
cmp eax, 0
jz child
```

For bypassing PIE relative addresses we have to calculate the offset between original entry point and our code at point where we can get relative address. We get relative address from:

```assembly
call parent
parent:
pop rax
```

now we have relative address of our code in rax, so we just sub our calculated offset from it:

```assembly
sub rax, 0xOUR_CALCULATED_OFFSET
```

and then just push it to the stack and ret:

```assembly
push rax
ret
```

This way we can get relative address of original entry point and jump to it

Then we connect our payload to our base payload and insert it into the binary as separate section.

## Usage

```bash
$ sudo apt install libelf-dev
$ make
$ nasm -f bin -o payload.bin src/assembly/hello_world.s
$ sudo cp /bin/ls .
$ sudo ./injector ls payload.bin
$ ./ls
hello world!
injector  ls  Makefile	payload.bin  src
```

## Sources

Binary injection based on Dennis Andriesse book
https://practicalbinaryanalysis.com/  

## Disclaimer

For Educational Purposes Only
