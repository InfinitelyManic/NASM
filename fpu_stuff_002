; david
; Last Revision 12/10/2013
; The product of three consecutive integers plus one:    x( x + 1)(x + 2) + 1
; This is bad code - just use the good parts for priming pump and burn the rest
section .bss
X resq 1
section .data
MIN dq 2
MAX dq 0xffffffff
fmt dd `%d(%d+1)(%d+2)+1 ~ qualifies!\n`

section .text
extern printf
global main
main:
        mov ecx, dword[MIN]
        loop:
                mov dword[X], ecx       ; store into memory
                ; do something --------------
                finit                   ; initialize FPU

                fild qword[X]           ; X
                fld1                    ; 1,X
                fld1                    ; 1,1,X
                faddp st1               ; 1+1,X
                faddp st1               ; 2+X

                fild qword[X]           ; X,2+X
                fld1                    ; 1,X,2+X
                faddp st1               ; 1+X,2+X

                fild qword[X]           ; X,1+X,2+X

                fmulp   st1             ; X*(1+X),2+X
                fmulp   st1             ; X*(1+X)*(2+X)
                fld1                    ; 1,X*(1+X)*(2+X)
                fxch                    ; swap
                fadd                    ; 1+(X*(1+X)*(2+X))
                fld st0                 ; make extra copy of fX

                fsqrt                   ; sqrt(fX)
                frndint                 ; round(sqrt(fX))
                fld st0                 ; round(sqrt(fX))), round(sqrt(fX))
                fmulp                   ; round(sqrt(fX)^2)
                frndint                 ; int(round(sqrt()^2))

                fucomi                  ; compare st0 and st1 on stack
                jz print
        cont:

                ; done something ------------
        inc ecx
        cmp ecx, dword[MAX]
        jnz loop


exit:
        mov eax, 1
        mov ebx, 0
        int 0x80


print:
        call write
        jmp cont

write:
        push ebp
        mov ebp, esp
        push eax
        push ebx
        push ecx
        push edx
        push esi
        push edi
        ;----------
        ; fmt dd `%d(%d+1)(%d+2)+1==d^2\n`
        ;push dword[sqrt]
        push dword[X]
        push dword[X]
        push dword[X]
        push fmt
        call printf
        add esp, 16
        ;----------
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        pop eax
        mov esp, ebp
        pop ebp
        ret
