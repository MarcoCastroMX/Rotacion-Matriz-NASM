;     nasm -felf64 Prueba.asm && gcc -no-pie Prueba.o && ./a.out

extern printf
global main

section .text

main:
	push rbp
	push rbx

	mov rax,0
	mov rdi,fmr
	lea rsi,[rel mensj1]
	call printf WRT ..plt

	mov rbx,sal	;dirección de salida de resp.

	movq mm0,[rel vec1]	;vector 1
	movq mm1,[rel vec2] ; vector 2
	paddsw mm0,mm1	; suma vectorizada

	movq qword [rbx],mm0

	pop rbx
	pop rbp
	
salida:	 
	mov rax,60
	mov rdi,0
	syscall			;sys_exit ...terminamos                   

	section .data
mensj1:     db "Suma mmx ",10,0 
fmr:	db "%s",0

frdec:	db "= %d:",0

vec1:	dw 23,47,85,60
vec2:	dw 17,3,15,10

	section .bss
data:	resq	1
sal:	resw    4            

