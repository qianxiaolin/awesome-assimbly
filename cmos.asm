assume cs:code

code segment
    start:
    out 70h,al
    in al,71h;0101 1010

    mov ah,al;0101 1010
    mov cl,4
    shr ah,cl;0000 0101 --得到高四位0101
    ;al 0101 1010
    and al,00001111b ;--得到低四位1010

    add ah,30h ;数字与对应ASCII相差30h
    add al,30h

    mov bx,0b800h
    mov es,bx

    mov bx,0B800h
    mov es,bx
    mov bx,0
    mov cx,2000;2000个字符

   


    mov byte ptr es:[160*12+40*2],ah
    mov byte ptr es:[160*12+40*2+1],00001010b
    mov byte ptr es:[160*12+40*2+2],al
    mov byte ptr es:[160*12+40*2+3],00001010b


    mov ax,4c00h
    int 21h
code ends

end start