mess macro msg
mov ah, 09h
LEA dx, msg
int 21h
endm

.model small

.data

msg1 db 0Ah,0dh, "Enter a string : $"		;storing string in data segment
msg2 db 0Ah,0dh, "Length of string is : $"
str1 db 30,?,30 dup (?)

.code

mov ax,@data
mov ds,ax

mess msg1

mov ah,0ah	;accepting a string
lea dx,str1
int 21h

mess msg2	;printing length of the string

lea si,str1
inc si
mov bl,[si]

ror bl,04h
call disp

ror bl,04h
call disp

mov ah,4ch
int 21h

disp proc near

mov cl,bl						;moving bl to cl
and cl,0fh						;to get the units place
cmp cl,0ah						;comparing eith 0ah to determine no. or alpha
jc down3
add cl,07h						;if alpha add 07h
down3 : add cl,30h				;else/then add 30h to get hexa ascii
        mov dl,cl				;moving cl to dl: prerequisite for diaplay

mov ah,02h						;instruction to print content of dl
int 21h

ret
endp

end
