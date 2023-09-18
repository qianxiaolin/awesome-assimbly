assume cs:code
;输入r/g/b，背景颜色为red,green,black
code segment
start:
s0:
mov ah,0
int 16h;调用中断，等待输入
mov ah,1;设为蓝色
cmp al,'r'
je red
cmp al,'g'
je green
cmp al,'b'
je  blue
jmp s0

red:
shl ah,1;红色执行完还会执行green
green:
shl ah,1
blue:
mov bx,0B800h
mov es,bx
mov bx,1
mov cx,2000
s:
    and byte ptr es:[bx],AH
    or es:[bx],ah
    add bx,2
    loop s
jmp s0

code ends
end start