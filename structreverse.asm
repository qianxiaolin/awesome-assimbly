assume cs:codeseg,ds:data,ss:stack
data segment
    dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h;
data ends

stack segment
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;16个字作为栈的空间
stack ends

codeseg segment
    start:
    ;初始化寄存器
    mov ax,stack;初始化栈段寄存器
    mov ss,ax
    mov sp,20h

    mov ax,data;初始化数据段寄存器
    mov ds,ax

    mov cx,8
    mov bx,0
   
    ;入栈
    s:
    push ds:[bx]
    add bx,2
    loop s
    ;出栈
    mov bx,0
    mov cx,8
    s0:
    pop ds:[bx]
    add bx,2
    loop s0

    mov ax,4c00h
    int 21h

codeseg ends
end start