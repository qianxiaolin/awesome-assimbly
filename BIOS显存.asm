assume cs:code

code segment
    start:
    mov ah,2 ;设置BIOS的10h中断的2号程序，设置光标位置
    mov bh,0 ;第0页
    mov dh,5;第5行
    mov dl,12;第12列

    mov ah,9 ;显示字符功能
    mov al,'a'
    mov bl,11001010b;字符属性
    mov bh,0;第0页
    mov cx,3;字符重复字数


    int 10h 

    mov ax,4c00h
    int 21h
code ends
end start

