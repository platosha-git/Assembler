PUBLIC input_dec_num

EXTERN print_msg: far
EXTERN new_line: far
EXTERN output_num: far

EXTERN num: word

SD3 SEGMENT para 'DATA'
	msg_input db 'Input num:', '$'
SD3 ENDS

SC3 SEGMENT para public 'CODE'
	assume CS:SC3, DS:SD3

input_dec_num proc far
	mov ax, SD3
	mov ds, ax
	
	call new_line	
	lea dx, [msg_input]
	call print_msg
	call new_line

	mov ax, seg num
	mov ds, ax
	
	xor bx, bx
	mov di, 0

nextnum:
    	mov ah, 1	;вводим новый символ
	int 21h

    	cmp al, 0Dh  	; если нажали enter то это конец числа 
    	je outp
    	
	cmp al, '-'  	
    	jnz pos
	mov di, 1
	jmp nextnum

pos:   
    	sub al, 30h  	;
    	xor ah, ah	;
    	xchg ax, bx	;Умножение цифры на 10
    	mov dx, 0Ah  	;и сложение с результатом
    	mul dx		;
    	add bx, ax	;
    	jmp nextnum

outp:
   	cmp di, 0
	je ex
	neg bx
ex:	  	
	ret
input_dec_num endp

SC3 ENDS
END
