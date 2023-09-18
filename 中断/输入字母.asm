;输入的同时显示字符串，回车字符串输入结束
;esc删除
assume cs:code,ds:data
data segment
    stack dw 60 dup(0)
    top db 0
data ends;数据段作为栈段

code segment
start:
    mov ax,data
    mov ds,ax
    mov si,0
    mov dh,12
    mov dl,20
    call getstr

    return:
    mov ax,4c00h
    int 21h
    getstr:
        push ax
    getstrs:
        mov ah,0
        int 16h
        cmp al,20h;小于20h为非字符
        jb nochar
        ;入栈(人为)
        mov bl,top
        mov ah,1
        mov ds:[bx],ax
        add top,2
        ;显示字符
        call showstr
        ;显示字符
        jmp getstrs

    nochar:
        cmp ah,0eh;backspace的扫描码
        je backspace
        cmp ah,1ch;enter键的扫描码
        je enter
        backspace:
        ;出栈操作
        cmp top,0
        je sret
        dec top
        jmp getstrs
        enter:
        nop


    sret:
    pop ax
    ret

    showstr:
    push bx
    push es
    push ax
    mov bx,0

    s1:
    cmp bx,top
    ja showret
    mov ax,0B800h
    mov es,ax
    mov word ptr ax,stack[bx]
    
    mov es:[160*12+80+bx],ax
    pop ax
    add bx,2
    jmp s1

  
    pop es
    pop bx

    showret:
    ret

code ends
end start