PUBLIC input_matr, output_matr, output_rem_matr

EXTERN n: byte
EXTERN m: byte
EXTERN array: byte

EXTERN input_num: far
EXTERN output_num: far
EXTERN new_line: far

SC3 SEGMENT para public 'CODE'
	assume CS:SC3

;Ввод матрицы
input_matr proc far
	mov ax, 4c00h
        int 21h

	lea bx, array
	mov cl, n		;цикл по строкам
in1:	
   	push cx
	mov cl, m		;цикл по столбцам
	mov si, 0
in2:	
	call input_num
	mov [bx][si], al
	inc si
	loop in2
 
	call new_line	
 
	add bl, m
	pop cx
	loop in1
	ret
input_matr endp


;Вывод матрицы
output_matr proc far
	lea bx, array
	mov cl, n	
out1:	
   	push cx
	mov cl, m
	mov si, 0
	
	call new_line
 
out2:
	xor ax,ax
	mov dl, [bx][si]

	call output_num 	

	inc si
	loop out2

	add bl, m
	pop cx
	loop out1
	ret
output_matr endp

output_rem_matr proc far
	lea bx, array
	mov cl, n	
out_rem1:	
   	push cx
	mov cl, m
	mov si, 0
	
	call new_line
 
out_rem2:
	xor ax,ax
	mov dl, [bx][si]

	call output_num 	

	inc si
	loop out_rem2

	add bl, m
	inc bl
	pop cx
	loop out_rem1
	ret
output_rem_matr endp

SC3 ENDS
END
