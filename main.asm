org 0x7c00
mov [diskNum], dl

mov bx, 0x7e00

mov ah, 2
mov al, 1
mov ch, 0
mov dh, 0
mov cl, 2
mov dl, [diskNum]
int 0x13
jc startErrorPrint1
jnc startErrorPrint2
startErrorPrint1:
    mov bx, errorMsg1
    jmp error1
startErrorPrint2:
    mov bx, errorMsg2
    jmp error2
continue:
    mov ah, 0x0e
    mov al, [0x7e00]
    int 0x10
    mov al, [0x7e01]
    int 0x10
    mov al, [0x7e02]
    int 0x10
    mov al, [0x7e03]
    int 0x10
    mov al, [0x7e04]
    int 0x10
    mov al, [0x7e05]
    int 0x10
    mov al, [0x7e06]
    int 0x10
    jmp exit
error1:
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    inc bx
    cmp al, 0
    je continue
    jmp error1
error2:
    mov ah, 0x0e
    mov al, [bx]
    int 0x10
    inc bx
    cmp al, 0
    je continue
    jmp error1

exit:
    jmp $
diskNum: db 0
errorMsg1: db "Carry FLag: 1", 0
errorMsg2: db "Carry Flag: 0", 0
times 510-($-$$) db 0
db 0x55, 0xaa

db "Sector2", 0
times 520-($-$$) db 0