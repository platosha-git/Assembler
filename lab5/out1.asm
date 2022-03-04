PUBLIC ouput_unsign_form

EXTERN new_line: far
EXTERN num: word

SC4 SEGMENT para public 'CODE'
	assume CS:SC4

ouput_unsign_form proc far
	call new_line
	mov bx, num
    	mov ah, 2               
	mov cx, 4
quart:
	push cx
	mov cx, 4
calc:                        	
    	shl bx, 1               ;сдвиг bl влево через флаг переноса
    	mov dl, '0'             
    	adc dl, 0               ;прибавление флага переноса
    	int 21h                 
    	loop calc
	mov dl, 32		;пробел
	int 21h
	pop cx
	loop quart

	ret
ouput_unsign_form endp

SC4 ENDS
END
