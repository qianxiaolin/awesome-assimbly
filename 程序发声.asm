assume cs:code

code segment
start:
    mov al,0Bh
    out 42h,al
    out 42h,al
    in al,61h
    mov ah,al
    or al,3;al控制音频
    out 61h,al
    mov cx,60000


code ends