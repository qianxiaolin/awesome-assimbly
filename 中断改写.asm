assume cs:code,ss:stack
stack segment
    db 128 dup(0)
stack ends

code segment
    start:
    mov ax,stack
    mov ss,ax
    mov sp,128
    push cs
    pop ds

    mov ax,0
    mov es,ax
    
    ;拷贝cs,ip到(0:200)
    push es:[9*4]
    pop es:[200h]
    push es:[9*4+2]
    pop es:[202h]

    ;拷贝指令(0:204)(es:di)=(ds:si)
    mov si,offset int9
    mov di,204h
    mov cx,offset intend - offset int9
    cld
    rep movsb

    ;修改中断表的cs:ip
    cli;禁止进入中断
    mov word ptr es:[9*4],204h
    mov word ptr es:[9*4+2],0
    sti;允许进入中断


    int9:
    push ax
    push bx
    push cx
    push es

    in al,60h
    pushf
    mov ax,0
    mov es,ax
    ;调用旧中断,处理其他按键
    call dword ptr es:[200h]
    ;处理F1
    cmp al,3bh;F1的码为
    jne int9ret
     ;改变背景颜色
    mov ax,0B800h
    mov es,ax
    mov bx,1;基数控制颜色
    mov cx,2000
    s:
    inc byte ptr es:[bx]
    add bx,2

    int9ret:
    pop es
    pop cx
    pop bx
    pop ax
    intend:nop

code ends

end start
