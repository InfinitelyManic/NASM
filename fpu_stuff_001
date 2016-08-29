; david
; find_smallest_int_x_y.asm
; Find smallest integers(x,y) so that 2013*x is square, 2014*x a cube, and 2013*y is a cube, 2014*y a square
; Last Revision 12/20/2013 09:01

section .bss
y resd 1
oldcw resw 1
newcw resw 1

section .data
fmt dd `%u\n`
START dd 0xffffffff
MIN dd 1
MAX dd 1
y1 dd 2013
y2 dd 2014
p dd 3
x dd 1

section .text
%macro setTruncate 0
        fstcw word[oldcw]       ; store old control word
        mov si, word[oldcw]     ; copy oldcw to si
        or si, 0x0C00           ; or rounding bits to 11 to truncate;i.e., get int()
        mov word[newcw], si     ; mov si to mem newcw
        fldcw word[newcw]       ; load newcw into FPU
%endmacro

extern printf
global main
main:
        mov ecx, dword[START]
loop1:
        mov dword[x], ecx               ; copy ecx into mem

        f2013xisSquare:
                finit
                fild dword[y1]          ; 2013
                fild dword[x]           ; x,2013
                fmulp st1               ; x*2013
                fld st0                 ; x*2013,x*2013
                fsqrt                   ; sqrt(x*2013),x*2013
                setTruncate             ; adjust rounding for next command - need int of float
                frndint                 ; int(sqrt(x*2013)),x*2013
                fld st0                 ; int(sqrt(x*2013)),int(sqrt(x*2013)),x*2013
                fmulp st1               ; int(sqrt(x*2013))*int(sqrt(x*2013)),x*2013
                fucomip                 ; compare
                                ;jnz cont


        f2014xisCube:
                finit
                fild dword[y2]          ; 2013
                fild dword[x]           ; x,2013
                fmulp st1               ; x*2013
                fld1                    ; 1,x*2013
                fild dword[p]           ; p,1,x*2013
                fdivp st1               ; 1/p,x*2013
                fxch                    ; x*2013,1/p
                fyl2x                   ; 1/p*log_2 x*2013
                fld st0                 ; 1/p*log_2 x*2013,1/p*log_2 x*2013
                setTruncate             ; adjust rounding for next command - need int of float
                frndint                 ; int(1/p*log_2 x*2013),1/p*log_2 x*2013
                fxch                    ; 1/p*log_2 x*2013, int(1/p*log_2 x*2013)
                fsub st1                ; 1/p*log_2 x*2013-int(1/p*log_2 x*2013),int(1/p*log_2 x*2013)
                fabs
                f2xm1                   ; 2^(1/p*log_2 x*2013-int(1/p*log_2 x*2013))-1,int(1/p*log_2 x*2013)
                fld1                    ; 1,2^(1/p*log_2 x*2013-int(1/p*log_2 x*2013))-1,int(1/p*log_2 x*2013)
                faddp                   ; 1+2^(1/p*log_2 x*2013-int(1/p*log_2 x*2013))-1,int(1/p*log_2 x*2013)
                fscale                  ; cuberoot(2013*x)
                frndint                 ; int(cuberoot(2013*x))
                fld st0                 ; int(cuberoot),int(cuberoot)
                fmul st1                ; int(cuberoot)^2,int(cuberoot)
                fmulp st1               ; int(cuberoot)^3
                fild dword[y2]          ; 2013,int(cuberoot)^3
                fild dword[x]           ; x,2013,int(cuberoot)^3
                fmulp st1               ; x*2013,int(cuberoot)^3
                fucomip                 ; compare st0 to st1 and set EFLAGs
                jnz cont


                call write
                ;---------- did something----
        cont:
        inc ecx
        cmp ecx, dword[MIN]
        jne loop1

exit:
        mov eax, 1
        mov ebx, 0
        int 0x80

write:
        push ebp
        mov ebp, esp
        push ebx
        push ecx
        push edx
        push esi
        push edi
        ;--------
        push ecx
        push fmt
        call printf
        add esp, 8
        ;---------
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        mov esp, ebp
        pop ebp
        ret

