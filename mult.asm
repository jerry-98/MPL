%macro scall 4                   
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .data
msg1 db 10,"Enter 1st Number: "
msg2 db 10,"Enter 2nd Number: ",10
ans_msg db 10,"Answer: "
newline db 10
cnt db 00h
cnt2 db 00h

section .bss
choice resb 4
num1 resb 4
num2 resb 4
hnum1 resb 4
hnum2 resb 4
result resb 4

section .text
global _start
_start:

scall 1,1, msg1,19
scall 0,1,num1,3


mov rsi,num1 
call AtoH
mov [hnum1],bl
scall 1,1,msg2,19
scall 0,1,num2,3

mov rsi,num2 
call AtoH
mov [hnum2],bl


mov bl,[hnum1]
mov cl,[hnum2]
mov ax,00h
sup:
add al,bl
dec cl;
jnz sup

mov dx,ax
mov rdi,result
call HtoA

scall 1,1,ans_msg,9
scall 1,1,result,2
scall 1,1,newline,1

exit:
mov rax,60
mov rdi,00
syscall

AtoH:		
mov byte[cnt],02h
mov bl,00h
rep1:
rol bl,04
mov al,byte[rsi]
cmp al,39h
jbe l1
sub al,07h
l1:
sub al,30H
add bl,al
inc rsi
dec byte[cnt]
jnz rep1
ret

HtoA:		
mov byte[cnt2],02H
rep2:
rol dl,04
mov cl,dl
and cl,0Fh
cmp cl,09h
jbe l2
add cl,07h
l2: 
add cl, 30h
mov byte[rdi],cl
inc rdi
dec byte[cnt2]
jnz rep2
ret

