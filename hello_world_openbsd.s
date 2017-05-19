; David @InfinitelyManic 
;
; uname -a
; OpenBSD 6.1 GENERIC.MP#2 i386
; nasm -v
; NASM version 2.11.08 compiled on Apr  2 2017
;
; gcc -v
; Reading specs from /usr/lib/gcc-lib/i386-unknown-openbsd6.1/4.2.1/specs
; Target: i386-unknown-openbsd6.1
; Configured with: OpenBSD/i386 system compiler
; Thread model: posix
; gcc version 4.2.1 20070719

;nasm -f elf32 hello_world.s -o hello_world.o && gcc hello_world.o -o hello_world
;/usr/bin/ld: warning: creating a DT_TEXTREL in a shared object.

; file *
; hello_world:   ELF 32-bit LSB shared object, Intel 80386, version 1
; hello_world.o: ELF 32-bit LSB relocatable, Intel 80386, version 1
; hello_world.s: ASCII Pascal program text

; man elf
; .note This section holds information in the note section format
;                described below.  This section is of type SHT_NOTE.  No
;                attribute types are used.  OpenBSD native executables usually
;                contain a .note.openbsd.ident section to identify themselves,
;                for the kernel to bypass any compatibility ELF binary
;                emulation tests when loading the file.
section ".note.openbsd.ident"

section .data
        msg:    db      `Hello World!\n`
        len     equ     $-msg

section .text
        global main
main:
        call _write

;_exit:
        push dword 0
        mov eax, 1
        call _syscall
        
        
;struct sys_write_args {
;        syscallarg(int) fd;
;        syscallarg(const void *) buf;
;        syscallarg(size_t) nbyte;
_write:
        push ebp
        mov ebp, esp
        mov eax, 0x4            ; syscall #

        push dword len          ; size
        push dword msg          ; buffer
        push dword 1            ; fd
        call _syscall
        add esp, 16             ; clean up stack
        ret

; ********************************************************************
; FreeBSD has the more "usual" calling convention, where the syscall number is in eax, and the parameters are on the stack (the first argument is pushed last). A system call should be done performed through a function call to a function containing int 0x80 and ret, not just int 0x80 itself (kernel expects to find extra 4 bytes on the stack before int 0x80 is issued). The caller must clean up the stack after the call is complete. The result is returned as usual in eax.
; http://asm.sourceforge.net/intro/hello.html
_syscall:
        int 0x80
        ret
