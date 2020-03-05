%macro scall 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
m1 db "Factorial :: "   ;length::13
newline db 10

section .bss
fact resb 8

section .text
global _start
_start:

pop rcx
pop rax
pop rsi
call ascii
mov rax,1
call fact_proc
p1:
call conv_ascii
scall 01,01,newline,1
jmp exit
;scall 01,01,m1,27

ascii:
mov ax,[rsi]
mov rbx,0
mov cl,2
l4:
rol bl,04
mov dl,al
cmp dl,39h
jbe l5
sub dl,7h
l5:
sub dl,30h
add bl,dl
rol ax,08
dec cl
jnz l4
mov rcx,0
mov cx,bx
ret


fact_proc:
cmp rcx,01
jz l
push rcx
dec cl
call fact_proc
pop rbx
mul ebx
l:
ret

conv_ascii:
mov rdi,fact
mov cl,08
l1:
rol eax,04
mov dl,al
and dl,0Fh
cmp dl,09
jbe l2
add dl,07h
l2:
add dl,30h
mov [rdi],dl
inc rdi
dec cl
jnz l1
scall 01,01,m1,13
scall 01,01,fact,08
ret

exit:
mov rax,60
mov rdi,00
syscall
