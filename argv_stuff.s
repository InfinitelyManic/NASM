; David @InfinitelyManic
; nasm -g -f elf64 -F dwarf argv_stuff.s -o argv_stuff.o && gcc argv_stuff.o -o argv_stuff

section .bss
section .data
        fmt:    db      "%s", 10, 0

section .text
        global main
        extern printf

main:
        nop
        push rbp
        mov rbp, rsp
        sub rsp, (16 * 1)
        ; *********************
        mov rcx, rsi            ; get argv pointer
        lea rdi, [rcx]          ; get argv 1
.loop:
        mov [rsp], rcx          ; save argv

        call _write

        mov rcx, [rsp]          ; save argv

        add rcx, 8              ; inc to next pointer
        mov rsi, [rcx]          ; get next string
        cmp rsi, 0              ; is null
        jnz .loop               ; else repeat
        ; *********************
        xor eax, eax
        leave
        ret

_exit:
        mov rax, 60
        xor rdi, rdi
        syscall
_write:; rdi rsi rdx rcx r8 r9
        push rbp
        mov rbp, rsp
        lea rdi, [fmt]
        xor rax, rax
        call printf
        xor rax, rax
        leave
        ret
