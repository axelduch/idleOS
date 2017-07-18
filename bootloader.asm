[BITS 16]     ; set to 16 bit code (real mode)

start:
	mov ax, 07C0h	; Set 'ax' equal to the location of this bootloader divided by 16
	add ax, 20h	; Skip over the size of the bootloader divided by 16
	mov ss, ax	; Set 'ss' to this location (the beginning of our stack region)
	mov sp, 4096	; Set 'ss:sp' to the top of our 4K stack

	mov ax, 07C0h	; Set 'ax' equal to the location of this bootloader divided by 16
	mov ds, ax	; Set 'ds' to this location

	mov si, message ; Put the message in si, which will be used by lodsb later
	call print	; Call our string-printing routine
	call setvideomode

	xor ax, ax	; Set 'ax' to 0 which is black code color for the VGA palette
	;mov cx, 320*200	; Set 'cx' to hold the resolution of screen for graphics mode 13h
	;call draw


	mov ax, 0xF
	mov cx, 320
	mov dx, 200
	call drawat

	cli		; Clear the Interrupt Flag (disable external interrupts)
	hlt		; Halt the CPU (until the next external interrupt)

data:
	message db 'My first bootloader!', 0

print:
	mov ah, 0Eh	; Specify 'int 10h' teletype output' function
	 	   	; [AL = Character, BH = Page Number, BL = Color (in graphics mode)]
.printchar:
	lodsb 		; Load byte at address SI into AL, and increment SI
	cmp al, 0
	je .done
	int 10h
	jmp .printchar
.done:
	ret

setvideomode:
	mov ax, 13h	; VGA mode
	int 10h
	ret

drawat:			; color in ax, x position in cx, y position in dx
	xor di, di	; We want to start from zero for x and y position computation
	push 0A000h	; Video memory address
	pop es
	add di, cx	; Add x offset to es
	imul dx, 320	; Add y * 320
	add di, dx
	sub di, 321	; Substract because we want x and y to be values of range [1, 320] and [1,200]
	mov [es:di], ax
	ret


times 510 - ($-$$) db 0 ; Fill the rest of sector with 0
dw 0xAA55               ; Add boot signature at the end of bootloader
