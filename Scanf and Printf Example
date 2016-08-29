; david @InfinitelyManic                                                                                                                                         
; New Assembly Programming Challenge - prompt use to enter a number between 0 & 9 and tell user that # is odd or even ...                                           
; executable: challenge_64                                                                                                                                          
; The executable was written for NASM 64-bit assembly; compiled and tested as indicated below.;                                                                                                                                                                   
; nasm -f elf64 -g -F stabs challenge_64.asm && linked with gcc challenge_64.o -o challenge_64                                                                      
;                                                                                                                                                                   
                                                                                                                                                                     
section .bss                                                                                                                                                        
s_int resb 1                                                                                                                                                        
                                                                                                                                                                     
section .data                                                                                                                                                       
p_fmt: db `Hello, please enter a number between 0 and 9.\n`,0                                                                                                       
s_fmt: db '%d',0                                                                                                                                                    
w_fmt_even: db `You entered %d\; which is even\.\n`,0                                                                                                               
w_fmt_odd: db `You entered %d\; which is odd\.\n`,0                                                                                                                 

section .text                                                                                                                                                       
extern scanf, printf                                                                                                                                                
global main                                                                                                                                                         
main:                                                                                                                                                       
  call prompt                                                                                                                                         
  call getdata                                                                                                                                        
; --- this does not trap things like ascii characters (e.g., letters);therefore, it will do strange stuff if entered ...                            
cmp byte [s_int],0      ; test for values <= 0                                                                                                      
jle main                                                                                                                                            
cmp byte [s_int],10     ; test for values >= 10                                                                                                     
jge main                                                                                                                                            
                                                                                                                                                                     
bt dword [s_int], 0x0   ; bit test against first bit                                                                                                
jc write_odd                                                                                                                                        
jnc write_even                                                                                                                                      
                                                                                                                                                                     
exit:                                                                                                                                                       
mov eax, 1                                                                                                                                          
mov ebx, 0                                                                                                                                          
int 0x80                                                                                                                                            
; ---------------functions ---------------------------------------------                                                                                    
prompt:                                                                                                                                                     
push rbp                                                                                                                                            
mov rbp, rsp                                                                                                                                        
mov rdi, p_fmt                                                                                                                                      
xor eax, eax                                                                                                                                        
call printf                                                                                                                                         
leave                                                                                                                                               
ret                                                                                                                                                 
                                                                                                                                                                    
getdata:                                                                                                                                                    
push rbp                                                                                                                                            
mov rbp, rsp                                                                                                                                        
mov rdi, s_fmt                                                                                                                                      
mov rsi, s_int                                                                                                                                      
xor eax, eax                                                                                                                                        
call scanf                                                                                                                                          
xor eax, eax                                                                                                                                        
leave                                                                                                                                               
ret                                                                                                                                                 
                                                                                                                                                                 
; ------------- I could write a single write function that selects the correct fmt label                                                                    
write_even:                                                                                                                                                 
push rbp                                                                                                                                            
mov rbp, rsp                                                                                                                                        
mov rdi, w_fmt_even                                                                                                                                 
mov rsi, [s_int]                                                                                                                                    
xor eax, eax                                                                                                                                        
call printf                                                                                                                                         
xor eax, eax                                                                                                                                        
leave                                                                                                                                               
ret                                                                                                                                                 

write_odd:                                                                                                                                                  
push rbp                                                                                                                                            
mov rbp, rsp                                                                                                                                        
mov rdi, w_fmt_odd                                                                                                                                  
mov rsi, [s_int]                                                                                                                                    
xor eax, eax                                                                                                                                        
call printf                                                                                                                                         
xor eax, eax                                                                                                                                        
leave                                                                                                                                               
ret      
