;-------------------------------------------;
;                                           ;
;-------------------------------------------;

SSeg Segment para Stack 'Stack'

     db 64 Dup ('SegStack ')
     
SSeg EndS

SData Segment para 'Data'
	PSP dw ?
	;; si se va a desencriptar el modo es 1
	modo db 0
	wipe db 0
	terminar db 0  ;;; si esta en uno no sigue encriptando
	vacio db 8 dup (0) ;;; Tiene solo ceros para guardar en el wipe

	input db 64 dup(0)
	output db 'generado', 0
	
	archivo1 dw ?
	archivo2 dw ?

	;;; Guarda la cantidad de bytes que se deben grabar para el wipe
	veces db 0
	
	;;; String para guardar y recibir la clave
	MF db 8 dup(0)
	
	;;; La clave sin expandir
	clave db 8 dup(0)
	
	;;; Variables para la llave, se pone la llave en 2 palabras para que pueda ser manejada por el programa
	K db 64 dup(0)
	
	;;; Variables para el mensaje. Viene partido en 2 palabras igual que la llave
	M db 64 dup(0)
	
	
	
	;;; Variables para las medias subllaves
	C0 db 28 dup(0)
	D0 db 28 dup(0)
	C1 db 28 dup(0)
	D1 db 28 dup(0)
	C2 db 28 dup(0)
	D2 db 28 dup(0)
	C3 db 28 dup(0)
	D3 db 28 dup(0)
	C4 db 28 dup(0)
	D4 db 28 dup(0)
	C5 db 28 dup(0)
	D5 db 28 dup(0)
	C6 db 28 dup(0)
	D6 db 28 dup(0)
	C7 db 28 dup(0)
	D7 db 28 dup(0)
	C8 db 28 dup(0)
	D8 db 28 dup(0)
	C9 db 28 dup(0)
	D9 db 28 dup(0)
	C10 db 28 dup(0)
	D10 db 28 dup(0)
	C11 db 28 dup(0)
	D11 db 28 dup(0)
	C12 db 28 dup(0)
	D12 db 28 dup(0)
	C13 db 28 dup(0)
	D13 db 28 dup(0)
	C14 db 28 dup(0)
	D14 db 28 dup(0)
	C15 db 28 dup(0)
	D15 db 28 dup(0)
	C16 db 28 dup(0)
	D16 db 28 dup(0)
	
	;;; Variables para las llaves finales
	K1 db 48 dup(0)
	K2 db 48 dup(0)
	K3 db 48 dup(0)
	K4 db 48 dup(0)
	K5 db 48 dup(0)
	K6 db 48 dup(0)
	K7 db 48 dup(0)
	K8 db 48 dup(0)
	K9 db 48 dup(0)
	K10 db 48 dup(0)
	K11 db 48 dup(0)
	K12 db 48 dup(0)
	K13 db 48 dup(0)
	K14 db 48 dup(0)
	K15 db 48 dup(0)
	K16 db 48 dup(0)
	
	;;; Variables para el mensaje
	L0 db 32 dup(0)
	R0 db 32 dup(0)
	L1 db 32 dup(0)
	R1 db 32 dup(0)
	L2 db 32 dup(0)
	R2 db 32 dup(0)
	L3 db 32 dup(0)
	R3 db 32 dup(0)
	L4 db 32 dup(0)
	R4 db 32 dup(0)
	L5 db 32 dup(0)
	R5 db 32 dup(0)
	L6 db 32 dup(0)
	R6 db 32 dup(0)
	L7 db 32 dup(0)
	R7 db 32 dup(0)
	L8 db 32 dup(0)
	R8 db 32 dup(0)
	L9 db 32 dup(0)
	R9 db 32 dup(0)
	L10 db 32 dup(0)
	R10 db 32 dup(0)
	L11 db 32 dup(0)
	R11 db 32 dup(0)
	L12 db 32 dup(0)
	R12 db 32 dup(0)
	L13 db 32 dup(0)
	R13 db 32 dup(0)
	L14 db 32 dup(0)
	R14 db 32 dup(0)
	L15 db 32 dup(0)
	R15 db 32 dup(0)
	R16 db 32 dup(0)
	L16 db 32 dup(0)
	
	;;; Variable para la llave expandida
	
	ER db 48 dup(0)
	
	;;; Variables de las que se sacan los indices de las cajas
	B1 db 6 dup(0)
	B2 db 6 dup(0)
	B3 db 6 dup(0)
	B4 db 6 dup(0)
	B5 db 6 dup(0)
	B6 db 6 dup(0)
	B7 db 6 dup(0)
	B8 db 6 dup(0)
	
	;;; Variables para guardar el resultado despues de pasar por las cajas
	
	SB1 db 4 dup(0)	
	SB2 db 4 dup(0)	
	SB3 db 4 dup(0)	
	SB4 db 4 dup(0)	
	SB5 db 4 dup(0)	
	SB6 db 4 dup(0)	
	SB7 db 4 dup(0)	
	SB8 db 4 dup(0)
	
	;;; Variable para el resultado de las cajas + la permutacion P
	F db 32 dup(0)
	
	;;; Para guardar el mensaje final
	Mens1 db 32 dup(0)
	Mens2 db 32 dup(0)
	

	;; PC1 para la primera permutacion de la clave:
	PC1 db 57, 49, 41, 33, 25, 17, 9
		db  1, 58, 50, 42, 34, 26, 18
		db 10,  2, 59, 51, 43, 35, 27
		db 19, 11,  3, 60, 52, 44, 36
        db 63, 55, 47, 39, 31, 23, 15
        db  7, 62, 54, 46, 38, 30, 22
        db 14,  6, 61, 53, 45, 37, 29
        db 21, 13,  5, 28, 20, 12,  4
	
	;; PC2 para la segunda permutacion de la clave:
	PC2 db 14, 17, 11, 24,  1,  5
        db  3, 28, 15,  6, 21, 10
        db 23, 19, 12,  4, 26,  8
        db 16,  7, 27, 20, 13,  2
        db 41, 52, 31, 37, 47, 55
        db 30, 40, 51, 45, 33, 48
        db 44, 49, 39, 56, 34, 53
        db 46, 42, 50, 36, 29, 32
		
	;; IP para la primera permutacion del mensaje:
	IP  db 58, 50, 42, 34, 26, 18, 10, 2
        db 60, 52, 44, 36, 28, 20, 12, 4
        db 62, 54, 46, 38, 30, 22, 14, 6
        db 64, 56, 48, 40, 32, 24, 16, 8
        db 57, 49, 41, 33, 25, 17,  9, 1
        db 59, 51, 43, 35, 27, 19, 11, 3
        db 61, 53, 45, 37, 29, 21, 13, 5
        db 63, 55, 47, 39, 31, 23, 15, 7
	   
	;; F para la segunda permutacion del mensaje (expandir R):
	E   db 32,  1,  2,  3,  4,  5
        db  4,  5,  6,  7,  8,  9
        db  8,  9, 10, 11, 12, 13
        db 12, 13, 14, 15, 16, 17
        db 16, 17, 18, 19, 20, 21
        db 20, 21, 22, 23, 24, 25
        db 24, 25, 26, 27, 28, 29
        db 28, 29, 30, 31, 32,  1
	
	
	;; Las tablas S1-S8	:
	S1  db 14,  4, 13, 1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9, 0,  7
		db  0, 15,  7, 4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5, 3,  8
		db  4,  1, 14, 8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10, 5,  0
		db 15, 12,  8, 2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0, 6, 13
		
	S2	db 15,  1,  8, 14,  6, 11,  3,  4,  9, 7,  2, 13, 12, 0,  5, 10
		db  3, 13,  4,  7, 15,  2,  8, 14, 12, 0,  1, 10,  6, 9, 11,  5
		db  0, 14,  7, 11, 10,  4, 13,  1,  5, 8, 12,  6,  9, 3,  2, 15
		db 13,  8, 10,  1,  3, 15,  4,  2, 11, 6,  7, 12,  0, 5, 14,  9
		
	S3  db 10,  0,  9, 14, 6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8
		db 13,  7,  0,  9, 3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1
		db 13,  6,  4,  9, 8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7
		db  1, 10, 13,  0, 6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12

	S4  db  7, 13, 14, 3,  0,  6,  9, 10,  1, 2, 8,  5, 11, 12,  4, 15
		db 13,  8, 11, 5,  6, 15,  0,  3,  4, 7, 2, 12,  1, 10, 14,  9
		db 10,  6,  9, 0, 12, 11,  7, 13, 15, 1, 3, 14,  5,  2,  8,  4
		db  3, 15,  0, 6, 10,  1, 13,  8,  9, 4, 5, 11, 12,  7,  2, 14

	S5  db  2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13, 0, 14,  9
		db 14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3, 9,  8,  6
		db  4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6, 3,  0, 14
		db 11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10, 4,  5,  3

	S6  db 12,  1, 10, 15, 9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11
		db 10, 15,  4,  2, 7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8
		db  9, 14, 15,  5, 2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6
		db  4,  3,  2, 12, 9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13

	S7  db  4, 11,  2, 14, 15, 0,  8, 13,  3, 12, 9,  7,  5, 10, 6,  1
		db 13,  0, 11,  7,  4, 9,  1, 10, 14,  3, 5, 12,  2, 15, 8,  6
		db  1,  4, 11, 13, 12, 3,  7, 14, 10, 15, 6,  8,  0,  5, 9,  2
		db  6, 11, 13,  8,  1, 4, 10,  7,  9,  5, 0, 15, 14,  2, 3, 12

	S8  db 13,  2,  8, 4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7
		db  1, 15, 13, 8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2
		db  7, 11,  4, 1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8
		db  2,  1, 14, 7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6, 11
		
		
	;; Tabla P para permutar el mensaje:
	P  	db 16,  7, 20, 21
        db 29, 12, 28, 17
        db  1, 15, 23, 26
        db  5, 18, 31, 10
        db  2,  8, 24, 14
        db 32, 27,  3,  9
        db 19, 13, 30,  6
        db 22, 11,  4, 25


	;; Tabla IP^-1 para la ultima permutacion:
    IP1 db 40, 8, 48, 16, 56, 24, 64, 32
        db 39, 7, 47, 15, 55, 23, 63, 31
        db 38, 6, 46, 14, 54, 22, 62, 30
        db 37, 5, 45, 13, 53, 21, 61, 29
        db 36, 4, 44, 12, 52, 20, 60, 28
        db 35, 3, 43, 11, 51, 19, 59, 27
        db 34, 2, 42, 10, 50, 18, 58, 26
        db 33, 1, 41,  9, 49, 17, 57, 25

     
SData EndS




;;;;;;;;; MACROS ;;;;;;;;;;;;;;

;;; Permutar
;;; Alista los registros para el proc de permutar
permutar Macro arreglo, tamano, tabla, destino
	xor ax, ax
	xor di, di
	lea bx, tabla
	lea si, arreglo
	lea bp, destino
	mov dx, tamano
	call perm
endM

;;; Shift
;;; Alista los registros para hacer el shift
shift Macro arreglo, destino
	lea si, arreglo
	lea di, destino
	xor bx, bx
	call ShiftI
endM

;;; XorM
;;; Para que el proc xorP sea mas facil de usar
xorM Macro op1, op2, destino, longitud
	lea si, op1
	lea di, op2
	lea cx, destino
	mov dx, longitud
	xor bx, bx
	call xorP
endM

;;; CajasM
cajasM Macro bxx, origen, destino
	lea si, bxx
	call UnirP
	mov ah, origen[bx]
	shl ax, 4
	shld cx, ax, 1
	shl ax, 1
	mov destino[0], cl
	xor cx, cx
    shld cx, ax, 1
	shl ax, 1
	mov destino[1], cl
	xor cx, cx
	shld cx, ax, 1
	shl ax, 1
	mov destino[2], cl
	xor cx, cx
	shld cx, ax, 1
	shl ax, 1
	mov destino[3], cl
	xor cx, cx
	inc di
endM

;;; Mover
mover Macro origen, destino
	lea si, origen
	lea di, destino
	call moverP
EndM

;;; Funion
funcion Macro PL, SL, PR, SR, KN
	;; Obtiene L1
	mover PR, SL
	;; Expande R
	permutar PR, 48, E, ER
	;; Un XOR de E(R) con K1
	xorM ER, KN, B1, 48
	;; La funcion de las cajas
	call cajas
	;; Permuta el resultado
	permutar SB1, 32, P, F
	;; XOR con el lado izquierdo
	xorM PL, F, SR, 32
EndM


;;; ExpandirM

expandirM Macro origen, destino
	xor bx, bx
	xor bp, bp
	lea si, origen
	lea di, destino
	call expandir
endM


CSeg Segment para public 'Code'	;Define el segmento de código para tasm.
 
 Begin:
      Assume CS:CSeg, SS:SSeg, ds:SDAta	;Asignación de los segmentos a los registro de segmentos del CPU.
	  .386
	push	ds
    xor   	ax,ax
    mov    	ax,SData  
    mov    	ES,ax
	pop		PSP
	mov		ds, PSP
	lea		bx, ds:[81h]
	lea		di, input
	
	dec bx
	buscar:				;;; Quita los espacios que haya al inicio
	inc bx
	mov al, [bx]
	cmp al, ' '
	je buscar
	cmp al, 13
	je cerrar
	dec bx
	
	archivo:
	inc bx
	mov al, [bx]
	cmp al, ' '
	je continuar
	cmp al, 13
	je cerrar
	stosb
	jmp archivo
	
	continuar:
	mov	byte ptr es:[di], 0
	
	lea di, output
        archivo0:
	inc bx
	mov al, [bx]
	cmp al, ' '
	je continuar2
	cmp al, 13
	je cerrar
	stosb
        jmp archivo0
	
	continuar2:
	mov	byte ptr es:[di], 0
	
	lea di, clave
	mov cx, 8
	buscar2:
	inc bx
	mov al, [bx]
	cmp al, 13
	je parametros
	stosb
	loop buscar2
	

	parametros:
	inc bx
	mov al, [bx]
	cmp al, 13
	je menu
	cmp al, 'w'
	je paramW
	cmp al, 'd'
	je paramD
	cmp al, ' '
	je parametros
	paramW:
	mov es:wipe, 1
	jmp parametros
	paramD:
	mov es:modo, 1
	jmp parametros
	



;;;; Programa principal ;;;;;

menu proc
	mov ax, es
	mov ds, ax
	
	;;; Abre el archivo
	lea dx, input
	mov ah, 03Dh
	mov al, 2
	int 21h
	jc cerrar
	mov archivo1, ax
	
	;;;; Crea un archivo
	mov ah, 3Ch
	lea dx, output
	xor cx, cx
	int 21h
	jc cerrar
	mov archivo2, ax

	
	
	cicloprincipal:
	inc veces
	xor si, si
	lectura:
	cmp si, 8
	je expansion
	mov ah, 3Fh
	mov bx, archivo1
	mov cx, 1
	lea dx, MF[si]
	int 21h
	cmp ax, cx
	jne EOF
	inc si
	jmp lectura
	
	EOF:
	cmp si, 0
	je findearch
	mov terminar, 1
	ceros:
	cmp si, 8
	je expansion
	mov MF[si], 0
	inc si
	jmp ceros
	
	
	

	expansion:
	expandirM MF, M
	expandirM clave, K
	
	call principal

	
	
	;;;; Guarda los datos
	mov bx, archivo2
	mov ah, 40h
	mov cx, 8
	lea dx, MF
	int 21h
	
	cmp terminar,0
	je cicloprincipal
	
	findearch:
	cmp wipe, 0
	je cerrarArchivos
	
	
	mov ah, 42h
	mov al, 0
	mov bx, archivo1
	xor cx,cx
	xor dx,dx
	int 21h
	
	
	;;;; Guarda los ceros para hacer el wipe
	xor cx, cx
	mov cl, [veces]
	guardarWipe:
	push cx
	mov bx, archivo1
	mov cx, 8
	mov ah, 40h
	lea dx, vacio
	int 21h
	pop cx
	loop guardarWipe
	
	
	cerrarArchivos:
	;;;; Cierra el archivo 1
	mov ah, 3Eh
	mov bx, archivo1
	int 21h
	
	;;; Cierra el archivo 2
	mov ah, 3Eh
	mov bx, archivo2
	int 21h
	

	
	jmp cerrar
menu EndP


   
cerrar proc
    xor ax,ax		;Limpia el al y prepara el ah para la salida.
    mov ax,4c00h 	;Servicio AH=4c int 21h para salir del programa.
    int 21h	        ;Llamada al DOS. Termine el programa.
cerrar EndP   

	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; PERM ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Permuta
;;; Valores iniciales:
;;; DX: donde viene la longitud del arreglo
;;; CX: guarda temporalmente el valor que se va a mover
;;; AX: guarda la posicion del bit con el que se esta trabajando
;;; BX: la tabla de permutaciones
;;; DI: el contador de posiciones
;;; SI: lo que se quiera permutar
;;; BP: el destino de la permutacion
perm proc
	 cmp dx, di			;;; Compara que las iteraciones no se salgan
	 je fin
	 mov al, bx[di]		;;; Pone el elemento de la tabla en AX	
	 push bx				;;; Guarda BX en la pila mientras no se necesita
	 dec al				;;; Decrementa la posicion porque en la tabla aparecen con base en 1
	 mov bx, ax
	 mov cl, [si][bx]	;;; Saca el elemento en la posicion dada
	 mov ds:bp[di], cl	;;; Pone el elemento en el destino
	 pop bx
	 inc di				;;; Para iterar
  	 jmp perm
fin: ret
	 EndP
		
	
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; SHIFT ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BX: debe empezar en 0, funciona como contador
;;; SI: arreglo de fuente
;;; DI: arreglo de destino
shiftI proc
	cmp bx, 27				
	je RI
	mov al, 1[bx][si]
	mov [di][bx], al
	inc bx
	jmp shiftI
RI: mov al, [si]
	mov [di][bx], al
	ret
	EndP

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; UNIRP ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; si = origen
;;; En Al se calculan las filas
;;; En Bl se calculan las columnas
;;; El indice queda en al
unirP proc
	;; Acomoda los bits en la posicion que les corresponde
	shl byte ptr [si],1
	shl byte ptr 1[si], 3
	shl byte ptr 2[si], 2
	shl byte ptr 3[si], 1
	
	;; Calcula la fila
	mov al, [si]
	add al, 5[si]
	
	;; Calcula la columna
	mov bl, 1[si]
	add bl, 2[si]
	add bl, 3[si]
	add bl, 4[si]
	
	;; Convierte los indices en un solo indice para vector
	mov dl, 16
	mul dl
	add bl, al
	
	ret
EndP

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; XORP ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; si: El arreglo de origen
;;; di: el arreglo de destino
;;; bx: un contador
;;; dx: la longitud
;;; cx: destino
xorP proc
	cmp dx, bx
	je xf
	mov al, [bx][si]
	xor al, [bx][di]
	push di
	mov di, cx
	mov [bx][di], al
	pop di
	inc bx
	jmp xorP
xf:	ret
EndP

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; CAJAS ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
cajas proc
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor di, di
	xor si, si
	
	cajasM B1, S1, SB1
	cajasM B2, S2, SB2
	cajasM B3, S3, SB3
	cajasM B4, S4, SB4
	cajasM B5, S5, SB5
	cajasM B6, S6, SB6
	cajasM B7, S7, SB7
	cajasM B8, S8, SB8
	
	ret
EndP


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;; MOVER ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
moverP proc
	mov cx, 32
	xor bx, bx
	ciclo:
	mov ax, si[bx]
	mov di[bx], ax
	inc bx
	loop ciclo
	ret
EndP

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; EXPANDIR ;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Toma los bits de una variable y los expande a un arreglo a un bit por elemento
expandir proc
	xor al, al
	mov al, ds:[bp][si]
	mov cx, 8
	cm1:
	rol al, 1
	mov [bx][di], al
	and byte ptr [bx][di], 1
	inc bx
	loop cm1
	inc bp
	cmp bp, 8
	je termina
	jmp expandir
	termina:
	ret
EndP

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;; ENCRIPTAR ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Realiza las funciones segun el orden para encriptar
encriptar proc
	;; Las iteraciones que generan el mensaje encriptado
	funcion L0, L1, R0, R1, K1
	funcion L1, L2, R1, R2, K2
	funcion L2, L3, R2, R3, K3
	funcion L3, L4, R3, R4, K4
	funcion L4, L5, R4, R5, K5
	funcion L5, L6, R5, R6, K6
	funcion L6, L7, R6, R7, K7
	funcion L7, L8, R7, R8, K8
	funcion L8, L9, R8, R9, K9
	funcion L9, L10, R9, R10, K10
	funcion L10, L11, R10, R11, K11
	funcion L11, L12, R11, R12, K12
	funcion L12, L13, R12, R13, K13
	funcion L13, L14, R13, R14, K14
	funcion L14, L15, R14, R15, K15
	funcion L15, L16, R15, R16, K16
	ret
EndP

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; DESENCRIPTAR ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Realiza las funciones segun el orden para desencriptar
desencriptar proc
 	;; Las iteraciones que generan el mensaje desencriptado
	funcion L0, L1, R0, R1, K16
	funcion L1, L2, R1, R2, K15
	funcion L2, L3, R2, R3, K14
	funcion L3, L4, R3, R4, K13
	funcion L4, L5, R4, R5, K12
	funcion L5, L6, R5, R6, K11
	funcion L6, L7, R6, R7, K10
	funcion L7, L8, R7, R8, K9
	funcion L8, L9, R8, R9, K8
	funcion L9, L10, R9, R10, K7
	funcion L10, L11, R10, R11, K6
	funcion L11, L12, R11, R12, K5
	funcion L12, L13, R12, R13, K4
	funcion L13, L14, R13, R14, K3
	funcion L14, L15, R14, R15, K2
	funcion L15, L16, R15, R16, K1
	ret
EndP 

principal proc
	;;;;;;;;;;;;;;;;;;;;;;;
	;;; Alista la clave ;;;
	;;;;;;;;;;;;;;;;;;;;;;;
	;; Primera permutacion de la clave
	permutar K, 56, PC1, C0
	
	;; Shifts
	;; 1
	shift C0, C1
	shift D0, D1
	;; 2
	shift C1, C2
	shift D1, D2
	;; 3
	shift C2, C0
	shift D2, D0
	shift C0, C3
	shift D0, D3
	;; 4
	shift C3, C0
	shift D3, D0
	shift C0, C4
	shift D0, D4
	;; 5
	shift C4, C0
	shift D4, D0
	shift C0, C5
	shift D0, D5
	;; 6
	shift C5, C0
	shift D5, D0
	shift C0, C6
	shift D0, D6
	;; 7
	shift C6, C0
	shift D6, D0
	shift C0, C7
	shift D0, D7
	;; 8
	shift C7, C0
	shift D7, D0
	shift C0, C8
	shift D0, D8
	;; 9
	shift C8, C9
	shift D8, D9
	;; 10
	shift C9, C0
	shift D9, D0
	shift C0, C10
	shift D0, D10
	;; 11
	shift C10, C0
	shift D10, D0
	shift C0, C11
	shift D0, D11
	;; 12
	shift C11, C0
	shift D11, D0
	shift C0, C12
	shift D0, D12
	;; 13
	shift C12, C0
	shift D12, D0
	shift C0, C13
	shift D0, D13
	;; 14
	shift C13, C0
	shift D13, D0
	shift C0, C14
	shift D0, D14
	;; 15
	shift C14, C0
	shift D14, D0
	shift C0, C15
	shift D0, D15
	;; 16
	shift C15, C16
	shift D15, D16
	
	;; Segunda permutacion
	;; 1
	permutar C1, 48, PC2, K1
	;; 2
	permutar C2, 48, PC2, K2
	;; 3
	permutar C3, 48, PC2, K3
	;; 4
	permutar C4, 48, PC2, K4
	;; 5
	permutar C5, 48, PC2, K5
	;; 6
	permutar C6, 48, PC2, K6
	;; 7
	permutar C7, 48, PC2, K7
	;; 8
	permutar C8, 48, PC2, K8
	;; 9
	permutar C9, 48, PC2, K9
	;; 10
	permutar C10, 48, PC2, K10
	;; 11
	permutar C11, 48, PC2, K11
	;; 12
	permutar C12, 48, PC2, K12
	;; 13
	permutar C13, 48, PC2, K13
	;; 14
	permutar C14, 48, PC2, K14
	;; 15
	permutar C15, 48, PC2, K15
	;; 16
	permutar C16, 48, PC2, K16
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;; Encripta el Mensaje ;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;; Primera permutacion
	permutar M, 64, IP, L0
	
	cmp modo, 1
	je desen
	call encriptar
	jmp enc
	desen:
	call desencriptar
	enc:
	
	;; Permutacion final
	permutar R16, 64, IP1, Mens1
	
	;; Convierte el arreglo de bits a una sola variable
	xor di, di
	xor bx, bx
	cic2:
	mov cx, 7
	mov MF[di], 0
	cic1:
	xor al, al
	mov al, Mens1[bx]
	shl al, cl
	add MF[di], al
	inc bx
	cmp cx, 0
	je fc1
	dec cx
	jmp cic1
	fc1:
	inc di
	cmp di, 8
	jne cic2
	
	ret
EndP
  
CSeg EndS 			;Fin del segmento de código.
     End Begin			;Fin del programa la etiqueta al final dice en que punto debe comenzar el programa.
