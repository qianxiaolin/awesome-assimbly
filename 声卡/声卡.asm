assume cs:code

code segment
start:
mov al,0b6h;8253芯片初始化
out 45h,al
mov dx,12h
mov ax,34dch
div word ptr [si]
out 42h,al
mov al,ah
out 42h,al

in al,61h
mov ah,al
or al,3
out 61h,al


code ends
end start