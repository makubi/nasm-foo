section .data
	true db "Numbers equal",10
	false db "Numbers not equal",10
	number1 db 10
	number2 db 20

section .text
	global _start

_start:
	mov eax, number1
	mov ecx, number2
	cmp eax, ecx
	je equals
	jne nequals

equals:
	mov rax, 1
	mov rdi, 1
	mov rsi, true
	mov rdx, 14
	syscall

	push 0
	jmp exit
	
;	mov rax, 60
;	mov rdi, 0
;	syscall

nequals:
	mov rax, 1
	mov rdi, 1
	mov rsi, false
	mov rdx, 18
	syscall

	push 1
	jmp exit

exit:
	mov rax, 60
	pop rdi
	syscall
