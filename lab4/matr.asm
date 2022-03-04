PUBLIC n, m, array

EXTERN print_msg: far
EXTERN input_num: far
EXTERN output_num: far
EXTERN new_line: far

EXTERN input_matr: far
EXTERN output_matr: far
EXTERN output_rem_matr: far

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

SD1 SEGMENT PARA PUBLIC 'DATA'
	n db ?
	m db ?  
	del db 3
	msg_n db 'lines num = ', '$'
	msg_m db 'columns num = ', '$'

	array db 9 dup (9 dup (?))
SD1 ends
 
SC1 SEGMENT PARA PUBLIC 'CODE'
        assume CS:SC1, DS:SD1, SS:STK

main:        
        mov ax, SD1
        mov ds, ax
        
	lea dx, [msg_n]
	call print_msg
	call input_num		;ввод кол-ва строк
	mov n, al
	call new_line

	lea dx, [msg_m]
	call print_msg
	call input_num		;ввод кол-ва столбцов
	mov m, al
	call new_line


;Ввод матрицы
	call input_matr

;Вычисление суммы столбца
	lea bx, array	
	mov cl,	m		;цикл по столбцам
	mov di,	0
calc1:
	push cx	        
	mov si, di       	;номер столбца
      	mov al, 0        	;сумма
       	mov cl, n        	;цикл по строкам
calc2:
       	add al, [bx][si]
	mov dl,	m
       	add si, dx
        loop calc2
	
	mov ah, 0		
	div byte ptr del
	
	cmp ah, 0
	je remove

	inc di
	pop cx
	loop calc1
	jmp output


;Удаление столбца
remove:	
	lea bx, array	
	mov cl,	m		;цикл по столбцам
	sub cx,	di
	cmp cx, 1
	je output_rem
	dec cx
rem1:
	push cx	        
	mov si, di     	        ;номер столбца для удаления
       	mov cl, n	        ;цикл по строкам
	xor ax,	ax
rem2:               		
	inc si		
       	mov ah, [bx][si]
	dec si
	mov [bx][si], ah
	mov dl, m       	
	add  si, dx
        loop rem2

	inc di
	pop cx
	loop rem1
output_rem:
	dec m
	call output_rem_matr
	jmp exit

output:
	call output_matr
exit:
        mov ax, 4c00h
        int 21h
SC1 ends
END main
