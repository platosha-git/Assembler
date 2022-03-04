CSEG SEGMENT para public 'CODE'
	assume CS:CSEG
        ORG 100h                     

MAIN:  
	jmp INSTALL                  
        OLDHANDLER dd  0             ; Адрес старого обработчика 
	INSTALLED dw 1
        DATA db ' 00:00:00/00.00.0000 ', 0 

FILLBUF  proc                       
	mov ah, al                  
        and al, 00001111b           
		                    
	push cx			    
	mov cl, 4		    
	shr ah, cl		    
	pop cx			    
        add ax, 3030h
	mov DATA[bx + 1], ah        
        mov DATA[bx + 2], al        
	add bx, 3    
        ret                             
FILLBUF  endp                            

DATA_HANDLER proc                        
        pushf                            
        call cs:OLDHANDLER               ; Вызов старого обработчика
        
	push ds                          
        push es

	push ax
	push bx
	push cx
        push dx
	push di
        push cs
        pop ds
	
        mov ah, 2                 	; функция BIOS для получения текущего времени
        int 1Ah 
	jc exit				; Если прерывание не сработало (CF = 1) 
	                    

        xor bx, bx                  
        mov al, ch                  
        call FILLBUF  			; Секунды
                
        mov al, cl                  
        call FILLBUF     		; Минуты
             
        mov al, dh                  
        call FILLBUF                 	; Часы

        mov ah, 4                  	; функция BIOS для получения текущей даты
        int 1Ah
	jc exit                    

        mov al, dl                  
        call FILLBUF                 	; День

        mov al, dh                  
        call FILLBUF                 	; Месяц

        mov al, ch                 
        call FILLBUF                 	; Год
	dec bx
        mov al, cl                  
        call FILLBUF                 

        mov ax, 0B807h              ; настройка видеопамяти
        mov es, ax                  
        xor di, di                  
        xor bx, bx                  
        mov ah, 3Bh                 

output:    
	mov al, DATA[bx]            ; Запись шаблона в видеопамять
        stosw                       
	inc bx                      
        cmp DATA[bx], 0            
        jnz output                  

exit:  
	pop di                      ; Восстановление регистров
        pop dx
	pop cx
        pop bx
        pop ax

        pop es
        pop ds

        IRET                             
DATA_HANDLER ENDP                        

INSTALL:   
	mov ax, 351Ch               	 ; Получение вектора старого обработчика
        int 21h                     	 

	cmp es:INSTALLED, 1
	je UNINSTALL

        mov word ptr OLDHANDLER, bx        	
        mov word ptr OLDHANDLER + 2, es    	

        mov ax, 251Ch                     	; Загрузка текущего обработчика
        mov dx, OFFSET DATA_HANDLER            	
        int 21h                            	

        mov ax, 3100h               		
        mov dx, OFFSET INSTALL   		
                                                
        int 21h 

UNINSTALL:
    	push es
	push ds

    	mov dx, word ptr es:OLDHANDLER
    	mov ds, word ptr es:OLDHANDLER + 2
    	mov ax, 251Ch				
    	int 21h

    	pop ds
    	pop es

    	mov ah, 49h		;Освобождение блока памяти		
    	int 21h

    	mov ax, 4C00h
    	int 21h

CSEG ENDS                             
END main                    
