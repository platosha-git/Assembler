PUBLIC ouput_sign_form

EXTERN new_line: far
EXTERN num: word

SC5 SEGMENT para public 'CODE'
	assume CS:SC5

ouput_sign_form proc far
	call new_line
	mov bx, num

	shl bx, 1
	mov al, 0
	adc al, 0
	cmp al, 1
	jne pos
	mov dl, '-'
	mov ah, 2
	int 21h

	mov bx, num
	neg bx
	jmp bin_to_hec
	
pos:
	mov bx, num
bin_to_hec:
	xor di, di
	mov cx, 4
cyc1:
	push cx
	mov cx, 4
	xor ax, ax
	xor si, si
	mov dl, 16
cyc2:                        	
    	shl bx, 1               

	mov al, dl		;
	mov dl, 2		; Деление номера разряда на 2
	div dl			;
	mov dl, al		;
	
	mov al, 0
	adc al, 0

	mul dl	
	add si, ax
	
   	loop cyc2
	pop cx
	cmp si, 10
	jl print
	add si, 7

print:
	mov dx, si
	cmp dx, 0
	jne no0
	cmp di, 0
	je continue
no0:
	mov di, 1	
	add dx, '0'
	mov ah, 2
	int 21h 
continue:
	loop cyc1
   
	ret

ouput_sign_form endp

SC5 ENDS
END
