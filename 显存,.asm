assume cs:codeseg,ds:dataseg
dataseg segment
    db 'Hello,World!'
dataseg ends

codeseg segment
    start:  
            mov     ax,dataseg
            mov     ds,ax
            mov     ax,0B800h
            mov     es,ax ;显存的基地址
            mov     bx,0
            mov     di,1994 ;160*12+80-6,初始地址为中间位置
            mov     cx,12
               
            s:      
            mov     ax,ds:[bx] ;数据段内容
            mov     es:[di],ax
            inc     di
            mov     al,02 ;一个字节
            mov     es:[di],al
            inc     di
            inc     bx
            loop    s
            
            mov     ax,4100h
            int     21h


codeseg ends
end start