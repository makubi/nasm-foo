section .bss
	len: resb 1

section .text
	global _start

_start:
	pop rcx
	sub rcx, 1
	
	mov rax, [rsp+8h]
	;mov rax, [rsp+10h]
	mov rdx, 0
_l2:
	add rax, rdx
	inc rdx

	mov bl, [rax]
	cmp bl, 0
	jne _l2

	add rdx, 47
	mov [len], rdx

	mov rax, 1
	mov rdi, 1
	mov rsi, len
	mov rdx, 1
	syscall

	mov rax, 60
	mov rdi, 0
	syscall
	
;_l1:
	
;	loop _l1
