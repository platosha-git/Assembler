EXTERN print_msg: far
EXTERN input_num: far
EXTERN output_num: far
EXTERN new_line: far

EXTERN input_dec_num: far
EXTERN ouput_unsign_form: far
EXTERN ouput_sign_form: far

PUBLIC num

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

SD1 SEGMENT PARA PUBLIC 'DATA'
	choose dw ?
	msg_menu db 'Menu:', '$'
	msg_m0 db '    Exit.............................0', '$'
	msg_m1 db '    Input num........................1', '$'
	msg_m2 db '    Output unsigned-bin form.........2', '$'
	msg_m3 db '    Output signed-hex form...........3', '$'

	num dw 0

	funcs dd input_dec_num, ouput_unsign_form, ouput_sign_form
SD1 ends
 
SC1 SEGMENT PARA PUBLIC 'CODE'
        assume CS:SC1, DS:SD1, SS:STK

main:        
        mov ax, SD1
        mov ds, ax

out_menu:  
	call new_line	
	xor dx, dx      
	lea dx, [msg_menu]
	call print_msg
	call new_line

	xor dx, dx
	lea dx, [msg_m0]
	call print_msg
	call new_line

	xor dx, dx
	lea dx, [msg_m1]
	call print_msg
	call new_line

	xor dx, dx
	lea dx, [msg_m2]
	call print_msg
	call new_line

	xor dx, dx
	lea dx, [msg_m3]
	call print_msg
	call new_line
	
	call input_num
	mov ah, 0

	dec al
	mov bl, 4
	mul bl
	mov bx, ax

	cmp bx, 0
	je input

	cmp bx, 4
	je out_unsign

	cmp bx, 8
	je out_sign

	jmp exit

input:
	call funcs[bx]
	mov num, bx
	jmp out_menu

out_unsign:
	call funcs[bx]
	jmp out_menu	

out_sign:
	call funcs[bx]
	jmp out_menu	

exit:
        mov ax, 4c00h
        int 21h
SC1 ends
END main
