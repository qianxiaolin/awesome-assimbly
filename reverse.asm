assume cs:codeseg

codeseg segment
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h;8个字,存放在cs：0~cs:F
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;16个字作为栈的空间
    start:
    mov ax,cs
    mov ss,ax
    mov sp,30h

    mov cx,8
    mov bx,0

    ;入栈
    s:
    push cs:[bx]
    add bx,2
    loop s
    ;出栈
    mov bx,0
    mov cx,8
    s0:
    pop cs:[bx]
    add bx,2
    loop s0

    mov ax,4c00h
    int 21h

codeseg ends
end start