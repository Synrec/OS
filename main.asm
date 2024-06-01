org 0x7c00
bits 16

string:
    times 10 db 0
    

mov bx, string

loop:
    mov ah, 0
    int 0x16
    mov ah, 0x0e
    int 0x10
    mov [bx], al
    inc bx
    mov al, [bx]
    cmp al, 0
    je loop
    mov ah, 0x0e
    jmp toEnd

end:
    db " [COMPLETE]", 0

toEnd:
    mov bx, end
    jmp print

print:
    mov al, [bx]
    cmp al, 0
    je exit
    int 0x10
    inc bx
    cmp al, 0
    je exit
    jmp print

exit:
    jmp $
times 510-($-$$) db 0
db 0x55, 0xaa