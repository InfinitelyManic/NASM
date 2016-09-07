; bit_squatting.asm
; David @InfinitelyManic
; creating domain names derived from a single domain name by reversing 1 bit
; inspired by http://dinaburg.org/bitsquatting.html
;
; COMPILED: nasm -felf64 -g -F stabs bit_squattting.asm && gcc bit_squattting.o -o bit_squattting
; nasm -v NASM version 2.09.10 compiled on Oct 17 2011
; *** THIS CODE IS VERY SLOPPY BUT SEEMS TO WORK - JUST SAYING ***
;
; macros used from mylib.mac - remove comments (;) for macros & comment out ->  %include "mylib.mac" ; this is my personal sloppy macro library

; %macro fentry 0
;        push rbp
;        mov rbp, rsp
;%endmacro

;%macro fexit 0
;        leave
;        ret
;%endmacro

;%macro fpushregs 0
;        push rbx
;        push rcx
;        push rdx
;        push rsi
;        push rdi
;        push r8
;        push r9
;        push r10
;        push r11
;        push r12
;        push r13
;        push r14
;        push r15
;%endmacro

;%macro fpopregs 0
;        pop r15
;        pop r14
;        pop r13
;        pop r12
;        pop r11
;        pop r10
;        pop r9
;        pop r8
;        pop rdi
;        pop rsi
;        pop rdx
;%endmacro

section .bss
section .data
        fmt: db `%s charPos: %d bit: %d\n`,0
        domain1: db "nasm.com",0                        ; whatever
        domain0: db "nasm.com",0                        ; whatever copy
        d_len equ $-domain0
        approved_char db "0123456789abcdefghiklmnopqrstuvwxyz",0        ; only print results with these chars
        a_len equ $-approved_char

section .text
        %include "mylib.mac"                    ; this is my personal sloppy macro library
        extern printf
        global main
main:
        ; rsi: array
        ; rcx: character position; derived from length of array - subject to offset due to removal of dot(.) com characters
        ; rdx: holds a single array element - a byte
        ; rbx: bit position & loop counter  - assumes we are looking at a byte character
        mov rsi, domain0                        ; array 0
        mov rdi, domain1                        ; array 1
        mov rcx, d_len                          ; length of array
        dec rcx                                 ; don't count terminator '0'
        sub rcx, 5                              ; character loop - back out dot(.) and top level domain -- FIX THIS, IT'S ARBITRARY
        .loop0:
                ; -----------
                mov rbx, 7                      ; s/u bits to check for loop -- FIX THIS, IT'S ARBITRARY
                .loop1:
                        mov rdx, [rsi+rcx]      ; get character element from the array
                        xor rax, rax            ; clear rax for use in bit swaps
                        mov al, dl              ; copy the lower bits to al
                        ; ---------------------- flipping bits one at a time ------------
                        bt ax, bx               ; bit test; check carry flag ("CF")
                        jnc .dobts              ; jump if CF not set or bit is 0
                .dobtr: btr ax, bx              ; bit test and reset to 0 if 1
                        jmp .skip0              ; unconditional jump to skip over command
                .dobts: bts ax, bx              ; bit test and set to 1 if 0
                        ;----------------------------------------------------------------
                .skip0:
                        push rcx
                        push rdi
                        ; ------scan for approved characters------------------
                                mov rcx, a_len
                                lea rdi, [approved_char]
                                repne scasb
                        ; -----------------------------------------------------
                        pop rdi
                        pop rcx
                        pop rcx
                        jnz .next0

                        mov dl, al              ; copy lower bits
                        mov [rsi+rcx],rdx       ; update array for printing purposes
                        ;----------------------------------------------------------------
                        call write              ; print that puppy
                        call redo               ; reset array to original domain
        .next0:
                dec rbx
                cmp rbx, 0
                jnl .loop1
                ; ------------
        dec rcx
        cmp rcx, 0
        jnl .loop0

exit:
        mov rax, 60
        xor rdi, rdi
        syscall

redo:
        fentry
        mov rdx, [rdi+rcx]                      ; get original character element from the array
        mov [rsi+rcx],rdx                       ; update array
        fexit

write:
        fentry
        fpushregs
        ; ----------
        lea rdi, [fmt]
        mov rsi, rsi                            ; squat domain - array
        mov rdx, rcx
        mov rcx, rbx
        ; -----------
        xor rax, rax
        call printf
        xor rax, rax
        fpopregs
        fexit
; -------------------- sample output

david@ubuntuserver002:~/nasm$ ./bit_squattting
nase.com charPos: 3 bit: 3
nasi.com charPos: 3 bit: 2
naso.com charPos: 3 bit: 1
nasl.com charPos: 3 bit: 0
na3m.com charPos: 2 bit: 6
nacm.com charPos: 2 bit: 4
nawm.com charPos: 2 bit: 2
naqm.com charPos: 2 bit: 1
narm.com charPos: 2 bit: 0
nqsm.com charPos: 1 bit: 4
nism.com charPos: 1 bit: 3
nesm.com charPos: 1 bit: 2
ncsm.com charPos: 1 bit: 1
fasm.com charPos: 0 bit: 3
lasm.com charPos: 0 bit: 1
oasm.com charPos: 0 bit: 0
