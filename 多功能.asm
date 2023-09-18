assume cs:code
code segment
    start:
    
    call choice ;根据ah选择调用的子程序

    choice:
        jmp short set
        table dw sub1,sub2,sub3,sub4 ;危险指令，直接跳转
        set:
        push bx
        cmp 3
        ja sret
        mov bl,ah
        mov bh,0
        add bx,bx
        call word ptr table[bx]

    sret:
        pop bx
        ret;end set
    ret
    ;功能1
    sub1:
    push bx
    push cx
    push es

    mov bx,0B800h
    mov es,bx
    mov bx,0
    mov cx,2000;2000个字符

    clear:
    mov byte ptr es:[bx],32 ;将空字符数据送入显存
    add bx,2
    loop clear

    pop es
    pop cx
    pop bx
    ret
    ;设置前景色
    sub2:
    push bx
    push cx
    push es
    mov bx,0B800h
    mov es,bx
    mov bx,1
    mov cx,2000
    front
    and byte ptr es:[bx],11111000b ;数据保持不变使用and 
    or es:[bx],al ;al 控制前景色 1010为绿色
    add bx,2
    pop es
    pop cx
    pop bx
    loop front
    ret 

    ;设置背景色
    sub3:
    push bx
    push cx
    push es
    mov bx,0B800h
    mov es,bx
    mov bx,1
    mov cx,2000
    backgrd
    and byte ptr es:[bx],10001000b ;数据保持不变使用and 
    or es:[bx],al ;al 控制前景色 1010为绿色
    add bx,2
    pop es
    pop cx
    pop bx
    loop backgrd
    ret 

    ;向上滚动一行--将第n+1行的内容复制到第n行，最后行为空字符
    sub4:
    push cx
    push si
    push di
    push es
    push ds
    ;准备
    mov si,0B800h
    mov es,si;使用DF自增配合串传输进行拷贝操作，(es:di)=(ds,si)
    mov ds,si
    mov di,0 ;第n行0-159
    mov si,160 ;第n+1行
    cld
    mov cx,24 
    sub4:
     push cx
     mov cx,160;一行有160个字节
     rep movsb ;执行过程中ds不断后移
     pop cx
     loop sub4
     
     ;清空最后一行
     mov si,0
     mov cx,80
     endline
     mov byte ptr es:[si+3840],32;160*24=3840，为最后一行的起始位置
     add si,2
     loop endline

     pop ds
     pop es
     pop di
     pop di
     pop cx

     ret
code ends

end start