EXTRN get_num: near

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
	NUM db 0
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, DS:DSEG, SS:STK
main:
	mov ax, DSEG
	mov ds, ax

	call get_num	

	mov ah, 2
	mov dl, al
	int 21h

	mov ax, 4c00h
	int 21h
CSEG ENDS

PUBLIC NUM

END main
