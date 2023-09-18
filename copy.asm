;将内存ffff:0~ffff:b中的数据拷贝到0:200~0:20b中，0200
assume cs:code
code segment
    start:
    ;ds定位到ffff:0
    mov ax,0ffffh
    mov ds,ax
    ;es定位到0:200中
    mov ax,0020h
    mov es,ax
    ;循环12次
    mov cx,12
    mov bx,0
    s:
    mov al,ds:[bx]
    mov es:[bx],al
    inc bx
    loop s

    mov ax,4c00h
    int 21h

code ends

end