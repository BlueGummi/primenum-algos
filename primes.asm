section .bss
digit resb 1

section .data
new_line db 10,13

section .text
global _start
_start:
   print_string "N = "
   call read_number
   mov ecx,eax
   mov eax,1
main_loop:
   inc eax
   cmp eax,ecx
   jnl exit
   mov ebx,2
is_prime:
   cmp eax,ebx ; haltura
   je print_prime
   push eax
   xor edx,edx
   div ebx
   pop eax
   test edx,edx
   jz not_prime
   inc ebx
   jmp is_prime
not_prime:
   jmp main_loop
print_prime:
   push eax
   call print_number
   print_string " "
   jmp main_loop
exit:
   mov eax,4
   mov ebx,1
   mov ecx,new_line
   mov edx,2
   int 80h
   
   syscall_exit 0

read_number:
   xor eax,eax
   mov ebx,10
   mov [digit],byte 0x30

.read_digit:
   mul ebx
   add eax,[digit]
   sub eax,0x30
   call read_digit
   cmp [digit],byte 0xA
   jne .read_digit
   ret

read_digit:
   pusha

   mov eax,3
   mov ebx,0
   mov ecx,digit
   mov edx,1
   int 80h

   popa
   ret

print_number:
   mov eax,[esp + 4]
   pusha
   mov ebx,10
   xor ecx,ecx

.push_digit:
   xor edx,edx
   div ebx
   push dx
   inc ecx
   test eax,eax
   jnz .push_digit

.print_digit:
   pop ax
   call print_digit
   loop .print_digit
   popa
   ret

print_digit:
   pusha
   mov [digit],al
   add [digit],byte 0x30

   mov eax,4
   mov ebx,1
   mov ecx,digit
   mov edx,1
   int 80h

   popa
   ret
