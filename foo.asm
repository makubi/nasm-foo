section .data
	true db "Numbers equal",10
	false db "Numbers not equal"
	wrongArgc db "Did not pass two args",10

section .bss
	input1: resb 2
	input2: resb 2

section .text
	global _start

_start:
	pop rax
	cmp rax, 3
	jne _exit_error

	pop rax
	
	pop rax
	mov rcx, [rax]
	pop rax
	mov rbx, [rax]

	cmp rcx, rbx
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
	
nequals:
	push rbx
	push rcx
	
	mov rax, 1
	mov rdi, 1
	mov rsi, false
	mov rdx, 17
	syscall
	
	pop rsi
	add rsi, 48
	mov rdx, 1
	syscall
	
	pop rsi
	add rsi, 48
	mov rdx, 1
	syscall
	
	mov rsi, 10
	mov rdx, 1
	syscall

	push 1
	jmp exit

_exit_error:
	mov rax, 1
	mov rdi, 1
	mov rsi, wrongArgc
	mov rdx, 22
	syscall
	
	push 2
	jmp exit

exit:
	mov rax, 60
	pop rdi
	syscall
