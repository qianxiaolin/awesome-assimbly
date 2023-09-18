assume cs:code,ss:stack,ds:data
stack segment
    db 128 dup(0)
stack ends

data segment
    dw 0,0
data ends


code segment
    
    start:
    ;栈段设置
    mov ss,ax
    mov sp,128;栈底为高地址
    mov ax,data
    mov ds,ax


    mov ax,0B800h
    mov es,ax
    mov ah,'a'
    s:
    mov es:[160*12+40*2],ah
    call sleep
    inc ah
    cmp ah,'z'
    jna s

    ;cpu 执行语句，消耗时间
    sleep:
        
        push dx
        mov dx,100h
       
        s1:
        sbb dx,0
        cmp ax,0
        jne s1
        
        pop dx
    
    ret

    ;保存原有的int9的cs:ip
    mov ax,0
    mov es,ax
    push es:[9*4]
    pop ds:[0]
    push es:[9*4+2]
    pop ds:[2]
    ;在中断表中覆盖9h中断
    mov word ptr es:[9*4],offset escint
    mov es:[9*4+2],cs
    ;自定义的9号中断
    escint:
        ;内部调用原来的9h中断
        push ax
        push bx
        push es


        pushf;标志寄存器入栈
        pop ax;出栈获取值给ax
        and ah,11111100b
        push ax
        popf
        
        in al,60h;读入扫描码
        call dword ptr ds:[0] ;dw取出双字
        cmp al,1
        jne int9ret
        ;改变颜色
        mov ax,0B800h
        mov es,ax
        inc byte ptr es:[160*12+40*2+1]

    int9ret:
        pop es
        pop bx
        pop ax
        iret

    mov ax,4c00h
    int 21h
code ends
end start