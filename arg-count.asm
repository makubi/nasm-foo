section .data
	new_line db 10
	too_many_args db "Too many arguments passed",10

section .bss
	; limited to 99 arguments
	digits: resb 2
	c: resb 1

section .text
	global _start

_start:
	; argc
	pop rax

	; the first arg is the name
	cmp rax, 101
	jge _too_many_args_exit

	call _count_argc
	
	mov rax, 60
	mov rdi, 0
	syscall

; rax = argc
_count_argc:
	push rbp

	mov rcx, -1

_count_argc_loop:
	inc rcx
	dec rax
	jnz _count_argc_loop

	mov rax, rcx		; rax = count
	mov rcx, 0
	mov rbx, 10

_extract_digits_loop:	
	; must reset rdx
	mov rdx, 0
	div rbx
	; rax = ratio
	; rdx = remainder

	mov [digits+rcx], rdx
	inc rcx

	test rax, rax
	jnz _extract_digits_loop

_print_argc:
	dec rcx
	mov rax, [digits+rcx]
	add rax, 48
	mov [c], rax

	push rcx
	mov rax, 1
	mov rdi, 1
	mov rsi, c
	mov rdx, 1
	syscall
	pop rcx

	test rcx, rcx
	jnz _print_argc

	mov rax, 1
	mov rdi, 1
	mov rsi, new_line
	mov rdx, 1
	syscall

	pop rbp

	ret

_too_many_args_exit:
	mov rax, 1
	mov rdi, 1
	mov rsi, too_many_args
	mov rdx, 26
	syscall

	mov rax, 60
	mov rdi, 1
	syscall
