PUBLIC print_msg, input_num, output_num, new_line

SC2 SEGMENT para public 'CODE'
	assume CS:SC2

print_msg proc far
	xor ax, ax
	mov ah, 9
	int 21h
	ret
print_msg endp


input_num proc far
	xor ax, ax
	mov ah, 1
	int 21h 
	sub al, 30h
	ret
input_num endp

output_num proc far
	add dl, 30h
	xor ax, ax
	mov ah, 2
	int 21h 
	ret
output_num endp

new_line proc far
	xor ax, ax
	mov ah, 2
	xor dx, dx
	mov dl, 13
	int 21h
	mov dl, 10
	int 21h	
	ret
new_line endp

SC2 ENDS
END
