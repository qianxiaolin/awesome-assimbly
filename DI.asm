assume cs:codeseg,ds:dataseg
dataseg segment
        dw 'welcome'
        dw '-------'
dataseg ends

codeseg segment
        mov ax,dataseg
        mov ds,ax

        mov si,0
        mov di,7
        mov cx,8

        s:
            mov ax,ds:[si]
            mov ds:[di],ax
            add si,2
            add di,2
            loop s

            mov ax,4c00h
            int 21h
codeseg ends
end start