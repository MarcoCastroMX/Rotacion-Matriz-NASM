;     nasm -felf64 Matriz.asm && gcc -no-pie Matriz.o && ./a.out

		extern printf
		extern scanf
		global main

		section .text

main:
		push 	RBX
		mov 	RAX,0
		mov 	[Contador],RAX

		mov 	RDI,Pregunta
		call 	printf

		mov 	RDI,FormatoScanf
		mov 	RSI,Eje
		call 	scanf

		mov 	RBP,[Eje]

		mov 	RDI,Pregunta2
		call 	printf

		mov 	RDI,FormatoFloatScanf
		mov 	RSI,Angulo
		call 	scanf

		cmp 	RBP,1
		je 	 	X
		cmp 	RBP,2
		je 		Y
		cmp 	RBP,3
		je 		Z
	
	X:
			unpcklps	xmm0, xmm0 
			cvtps2pd	xmm0, xmm0

			movsd 		qword[rel Angulo],xmm0

			fld 	qword[rel Angulo]
			fcos 	
			fld 	qword[rel Vector2+8]
			fmul
			fstp 	qword[rel Vector2+8]

			fld 	qword[rel Angulo]
			fcos 	
			fld 	qword[rel Vector3+16]
			fmul
			fstp 	qword[rel Vector3+16]

			fld 	qword[rel Angulo]
			fsin 	
			fld 	qword[rel Vector3+8]
			fmul
			fstp 	qword[rel Vector3+8]

			fld 	qword[rel Angulo]
			fsin 	
			fld 	qword[rel Vector2+16]
			fmul
			fld 	qword[rel Negativo]
			fmul
			fstp 	qword[rel Vector2+16]

			mov 	RBX,[Contador]
			jmp 	loop1
	
	Y:
			unpcklps	xmm0, xmm0 
			cvtps2pd	xmm0, xmm0

			movsd 		qword[rel Angulo],xmm0

			fld 	qword[rel Angulo]
			fcos 	
			fld 	qword[rel Vector1]
			fmul
			fstp 	qword[rel Vector1]

			fld 	qword[rel Angulo]
			fcos 	
			fld 	qword[rel Vector3+16]
			fmul
			fstp 	qword[rel Vector3+16]

			fld 	qword[rel Angulo]
			fsin 	
			fld 	qword[rel Vector1+16]
			fmul
			fstp 	qword[rel Vector1+16]

			fld 	qword[rel Angulo]
			fsin 	
			fld 	qword[rel Vector3]
			fmul
			fld 	qword[rel Negativo]
			fmul
			fstp 	qword[rel Vector3]

			mov 	RBX,[Contador]
			jmp 	loop1


	Z:
			unpcklps	xmm0, xmm0 
			cvtps2pd	xmm0, xmm0

			movsd 		qword[rel Angulo],xmm0

			fld 	qword[rel Angulo]
			fcos 	
			fld 	qword[rel Vector1]
			fmul
			fstp 	qword[rel Vector1]

			fld 	qword[rel Angulo]
			fcos 	
			fld 	qword[rel Vector2+8]
			fmul
			fstp 	qword[rel Vector2+8]

			fld 	qword[rel Angulo]
			fsin 	
			fld 	qword[rel Vector2]
			fmul
			fstp 	qword[rel Vector2]

			fld 	qword[rel Angulo]
			fsin 	
			fld 	qword[rel Vector1+8]
			fmul
			fld 	qword[rel Negativo]
			fmul
			fstp 	qword[rel Vector1+8]

			mov 	RBX,[Contador]
			jmp 	loop1

	loop1:					
				mov 	RAX,1
				mov 	RDI,NumeroSalto
				movsd 	xmm0,qword[rel Vector1+RBX]
				call 	printf
				
				cmp 	RBX,16
				je 		loop2
				add 	RBX,8
				jmp 	loop1

			loop2:
					mov 	RAX,1
					mov 	RDI,NumeroSalto
					movsd 	xmm0,qword[rel Vector2+RBX]
					call 	printf
					
					cmp 	RBX,0
					je 		loop3
					sub 	RBX,8
					jmp 	loop2

				loop3:
						mov 	RAX,1
						mov 	RDI,NumeroSalto
						movsd 	xmm0,qword[rel Vector3+RBX]
						call 	printf
						
						cmp 	RBX,16
						je 		Fin
						add 	RBX,8
						jmp 	loop3

					Fin:
						pop     RBX                     
		    			ret

	section .data
Cadena:
		db "Ingrese un Numero: ", 0
Pregunta:
		db "A que eje quiere realizar la rotacion X(1), Y(2) y Z(3): ",0
Pregunta2:
		db "Ingrese el angulo de rotacion (En RADIANES): ",0
FormatoScanf:
		db  "%d", 0
FormatoFloatScanf:
		db  "%f", 0
NumeroSalto:
		db 	"%2.2f",10,0
Negativo:
		dq -1.0

Vector1: dq 1.1,2.2,3.3
Vector2: dq 1.11,2.22,3.33
Vector3: dq 5.55,6.66,7.77

	section .bss
Numero:
		resq 1
Eje:
		resw 1
Angulo:
		resq 1
Contador:
		resw 1
