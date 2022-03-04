.686
.MODEL FLAT, C
.STACK

.CODE

strCopy PROC
	push ebp
	mov ebp, esp
	pushf
	push edi
	push esi
	push ecx

	mov edi, [ebp + 8]	
	mov esi, [ebp + 12]	
	mov ecx, [ebp + 16]	
	cmp esi, edi
	jbe chgDirection
	jmp copy

chgDirection:
	std
	add edi, ecx
	dec edi
	add esi, ecx
	dec esi

copy:
	rep movsb

	pop ecx
	pop esi
	pop edi
	popf
	pop ebp

	ret
strCopy ENDP
END