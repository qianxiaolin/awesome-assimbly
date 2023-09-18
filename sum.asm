assume cs:codeseg

codeseg segment
    start:
    ;循环初始化
    mov ax,10
    mov cx,ax;循环12次
    mov bx,0;记录地址

    ;设置ds初始地址
    mov ax,0ffffh;不能以符号开头
    mov ds,ax

    sum:
    mov al,ds:[bx]
    mov ah,0;防止溢出
    add dx,ax
    inc bx;自加1
    loop sum

codeseg ends
end

