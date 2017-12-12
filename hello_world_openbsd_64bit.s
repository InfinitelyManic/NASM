; stuff.s
;
; nasm -f elf64 -g -F stabs stuff.s -o stuff.o && ld -nopie stuff.o -o stuff

; man elf

;     .note      This section holds information in the note section format
;                described below.  This section is of type SHT_NOTE.  No
;                attribute types are used.  OpenBSD native executables usually
;                contain a .note.openbsd.ident section to identify themselves,
;                for the kernel to bypass any compatibility ELF binary
;                emulation tests when loading the file.

;     The note section is used to hold vendor-specific information that may be
;     used to help identify a binary's ABI.  It should start with an Elf_Note
;     struct, followed by the section name and the section description.  The
;     actual note contents follow thereafter.

;          typedef struct {
;          Elf32_Word namesz;
;          Elf32_Word descsz;
;          Elf32_Word type;
;          } Elf32_Note;

;         typedef struct {
;         Elf64_Half namesz;
;         Elf64_Half descsz;
;         Elf64_Half type;
;         } Elf64_Note;

;     namesz    Length of the note name, rounded up to a 4-byte boundary.

;     descsz    Length of the note description, rounded up to a 4-byte
;               boundary.

;     type      A vendor-specific note type.

;     The name and description strings follow the note structure.  Each string
;     is aligned on a 4-byte boundary.
section .bss
section  .note.openbsd.ident
        align 2
        dd 8,4,1                ; namesz, descsz, type
        db 'OpenBSD',0          ; name
        dd 0                    ; decription string
        align 2

section .data
        fmt:    db      `Hello World!\n`
        len:    equ     $-fmt

section .text
        global _start
_start:
        nop

        mov rax, 0xff
        call _write

_exit:
        xor rax, rax
        add al, 1
        xor rdi, rdi
        syscall

_write:
        push rbp
        mov rbp, rsp
        mov rax, 4
        mov rdi, 1
        lea rsi, [fmt]
        mov rdx, len
        syscall
        leave
        ret
