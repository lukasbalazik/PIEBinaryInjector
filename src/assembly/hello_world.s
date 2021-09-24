BITS 64

SECTION .text
global main

section .text

main:
  xor eax,eax
  xor ebx,ebx
  xor edx,edx
  
  mov rax,1 ; sys_write
  mov rdi,1 ; stdout
  lea rsi,[rel $+hello-$] ; hello
  mov rdx,[rel $+len-$] ; len
  syscall

  call exit
exit:    
  mov rax,60   
  syscall

hello: db "hello world",33,10
len : dd 13
