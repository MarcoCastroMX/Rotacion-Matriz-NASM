;calcular el area de una circunferencia de radio r con punto plotante X87
; seic otoño 2019
BITS 64
;macros para alinear la pila
%define ALINEAPILA  push rbp
%define SALIDA	pop rbp

section .bss

RAD:	resq 1
AREA:   resq 1

section .data

mensj:	db "calcular area de circunf... entra el radio",10,0
longmsj: equ $-mensj		;longitud de cadena
radio:	dq 2.1			;radio fijo 2.1 de ejemplo
formato:	db "El area es %3.3f",10,0
forment:	db "%f",0

section .text
extern printf
extern scanf

global main


main:	           ALINEAPILA          ;alinear la pila (rsp-16)
		mov rdi,mensj
		xor rax,rax
		call printf WRT ..plt  ;uso de printf  rax=0  rdi la dirección del mensaje

		mov rax,1
		mov rdi,forment
		call scanf WRT ..plt
		
		unpcklps	xmm0, xmm0   ;descomprime el numero real sp
	    cvtps2pd	xmm0, xmm0   ;conviertelo a real de doble precs.
		movsd qword [rel RAD], xmm0		;ahora si...listo
		
		

                ;fld qword [rel RAD]   ;carga el radio entrado por consola
		fld qword [rel RAD]	;carga st0 con el radio 2.1
		fmul st0		;al cuadrado st0*st0
		fldpi			;carga 3.1416 en st0
		fmul			;st0*st1
		fstp qword [rel AREA]	;guarda st0...el area pues
		mov rdi,formato
		movsd xmm0, qword [rel AREA]
		mov rax,1
		call printf WRT ..plt
		
		SALIDA			;destrabar la pila
		mov rax,60
		mov rdi,0
		syscall			;sys_exit ...terminamos
		
		
