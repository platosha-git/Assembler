PUBLIC get_num
extern NUM: byte

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG
get_num proc near
	;mov ax, seg NUM
	;mov es, ax
	
	mov ah, 8  ;считать символ в AL	
	int 21h 

	;mov num, al

	ret
get_num endp
CSEG ENDS
END
