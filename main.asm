org 0x7c00

mov bp, 0x8000
mov sp, bp
mov bh, '~'
push bx

jmp decimalNum

decimalNum:
    mov ah, 0
    int 0x16
    mov bh, al
    push bx
    cmp al, '/'
    je printSpace

continueFromSpace:
    cmp al, '/'
    je printOut
    mov ah, 0x0e
    int 0x10
    jmp decimalNum

printSpace:
    mov ah, 0x0e
    mov al, 32;
    int 0x10
    mov al, '/'
    jmp continueFromSpace

printOut:
    mov ah, 0x0e
    mov al, bh
    cmp al, '/'
    jne output
    jmp continue

continue:
    cmp al, '~'
    je exit
    pop bx
    jmp printOut

output:
    cmp al, '~'
    je continue
    int 0x10
    jmp continue

exit:
    jmp $
times 510-($-$$) db 0
db 0x55, 0xaa