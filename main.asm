org 0x7c00

mov [diskNum], dl

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start

cli
lgdt[GDT_Descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode

[bits 32]
start_protected_mode:
    mov al, 'A'
    mov ah, 0xaf
    mov [0xb8000], ax
    jmp $

GDT_Start:
    null_descriptor:
        dd 0
        dd 0
    code_descriptor:
        dw 0xffff
        dw 0
        db 0
        db 0b10011010
        db 0b11001111
        db 0
    data_descriptor:
        dw 0xffff
        dw 0
        db 0
        db 0b10010010
        db 0b11001111
        db 0
GDT_Descriptor:
    dw GDT_End - GDT_Start - 1
    dd GDT_Start
GDT_End:

exit:
    jmp $

diskNum: db 0
times 510-($-$$) db 0
db 0x55, 0xaa