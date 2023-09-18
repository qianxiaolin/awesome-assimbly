assume cs:code,ds:data
data segment
    err db 'overflow!'
data ends

code segment
    int0:
        jmp short clear
        
        clear:
        mov bx,0B800h
        mov es,bx
        mov bx,0
        mov cx,2000;2000个字符
        s:
        ;清屏，设置背景色为绿色
        mov byte ptr es:[bx],32 ;将空字符数据送入显存
        inc bx
        mov byte ptr es:[bx],00100010b
        inc bx
        loop s

        mov bx,0B800h
        mov es,bx
        mov bx,1992
        mov di,0
        mov cx,8;2000个字符
        s1:
        ;显示overflow
        mov ax,data
        mov ds,ax
        mov al,err[di]
        mov ah,00001111b
        mov word ptr es:[bx],ax ;将空字符数据送入显存
        add bx,2
        inc di
        loop s1
        mov ax,4c00h
        int 21h
        ;显示overflow

  
    int0end: nop ;空指令

    start:
    ;利用(es:di)=(ds:si)，将int0指令拷贝到0000:0200到0000:02FF的空间
    mov ax,cs
    mov ds,ax
    mov si,offset int0 ;(ds:si)=(cs:offset int0)
    mov ax,0
    mov es,ax
    mov di,200h ;(es:di)=(0000:0200)
    mov ax,offset int0end
    mov bx,offset int0
    sbb ax,bx
    mov cx,ax;len(int0)=offset(intoend)-offset(into)
    cld
    rep movsb
    
    ;设置中断向量表
    mov ax,0000
    mov es,ax
    mov word ptr es:[0],0200h
    mov word ptr es:[2],0


    mov ax,8
    mov bh,0
    div bh

    mov ax,4c00h
    int 21h
    ;中断处理程序,在0000:0200到0000:02FF的空间存放指令
    
  
    

    
code ends

end start