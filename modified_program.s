	.file	"program.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	print
	.type	print, @function
print:
	test	edi, edi
	jle	.L6
	lea	eax, -1[rdi]
	push	r12
	lea	r12, 1[rsi+rax] # записываем указатель на последний символ str.
	push	rbp
	mov	rbp, rdx
	push	rbx
	mov	rbx, rsi
	.p2align 4,,10
	.p2align 3
.L3:
	movsx	edi, BYTE PTR [rbx]
	mov	rsi, rbp
	add	rbx, 1
	call	fputc@PLT
	cmp	rbx, r12
	jne	.L3
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L6:
	ret
	.size	print, .-print
	.p2align 4
	.globl	solve_task
	.type	solve_task, @function
solve_task:
	test	ecx, ecx
	jle	.L21
	push	r15
	lea	eax, -1[rcx]
	push	r14
	lea	r15, 1[rdx+rax] # в регистре r15 находится указатель на последний символ str.
	lea	r14, digits[rip] # в регистре r14 находится digits[str[i] - '0']
	push	r13
	mov	r13, rdi # в регистре r13 находится result
	push	r12
	mov	r12, rdx # в регистре r12 находится str
	push	rbp
	mov	rbp, rsi
	push	rbx
	sub	rsp, 8
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L12:
	movsx	rax, DWORD PTR 0[rbp]
	mov	BYTE PTR 0[r13+rax], bl
	add	DWORD PTR 0[rbp], 1
.L14:
	add	r12, 1 # переход к i+1 символу строки str
	cmp	r15, r12
	je	.L25
.L17:
	movsx	ebx, BYTE PTR [r12]
	lea	eax, -49[rbx]
	cmp	al, 8
	ja	.L12
	lea	eax, -48[rbx]
	movsx	rax, al
	mov	rdi, QWORD PTR [r14+rax*8]
	call	strlen@PLT
	test	eax, eax
	jle	.L14
	lea	esi, -1[rax]
	mov	ecx, DWORD PTR 0[rbp]
	xor	eax, eax
	jmp	.L16
	.p2align 4,,10
	.p2align 3
.L26:
	movsx	ebx, BYTE PTR [r12]
	mov	rax, rdx
.L16:
	sub	ebx, 48
	movsx	rcx, ecx
	movsx	rbx, ebx
	mov	rdx, QWORD PTR [r14+rbx*8]
	movzx	edx, BYTE PTR [rdx+rax]
	mov	BYTE PTR 0[r13+rcx], dl
	mov	edi, DWORD PTR 0[rbp]
	lea	rdx, 1[rax]
	lea	ecx, 1[rdi]
	mov	DWORD PTR 0[rbp], ecx
	cmp	rax, rsi
	jne	.L26
	add	r12, 1 # переход к i+1 символу строки str
	cmp	r15, r12
	jne	.L17
.L25:
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L21:
	ret
	.size	solve_task, .-solve_task
	.p2align 4
	.globl	parse_str
	.type	parse_str, @function
parse_str:
	push	rbx
	mov	rcx, rdx
	mov	rbx, rsi
	mov	edx, 1000000
	mov	esi, 1
	call	fread@PLT
	mov	DWORD PTR [rbx], eax
	pop	rbx
	ret
	.size	parse_str, .-parse_str
	.p2align 4
	.globl	generate
	.type	generate, @function
generate:
	mov	eax, DWORD PTR [rsi]
	push	r12
	push	rbp
	mov	rbp, rdi
	push	rbx
	mov	rbx, rsi
	cmp	eax, -1
	je	.L37
.L30:
	xor	r12d, r12d
	test	eax, eax
	jle	.L29
	.p2align 4,,10
	.p2align 3
.L31:
	call	rand@PLT
	cdq
	shr	edx, 25
	add	eax, edx
	and	eax, 127
	sub	eax, edx
	mov	BYTE PTR 0[rbp+r12], al
	add	r12, 1
	cmp	DWORD PTR [rbx], r12d
	jg	.L31
.L29:
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L37:
	call	rand@PLT
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1374389535
	sar	ecx, 31
	sar	rdx, 37
	sub	edx, ecx
	imul	edx, edx, 100
	sub	eax, edx
	add	eax, 1
	mov	DWORD PTR [rbx], eax
	jmp	.L30
	.size	generate, .-generate
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"\320\244\320\276\321\200\320\274\320\260\321\202 \320\262\320\262\320\276\320\264\320\260 \320\270\320\267 \320\272\320\276\320\274\320\260\320\275\320\264\320\275\320\276\320\271 \321\201\321\202\321\200\320\276\320\272\320\270 \320\264\320\276\320\273\320\266\320\265\320\275 \320\261\321\213\321\202\321\214 \320\233\320\230\320\221\320\236: program_file -d input_file output_file"
	.align 8
.LC1:
	.string	"\320\233\320\230\320\221\320\236: \nprogram_file -g size_of_str output_file\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"-d"
.LC3:
	.string	"r"
	.section	.rodata.str1.8
	.align 8
.LC4:
	.string	"\320\222\320\270\320\264\320\270\320\274\320\276, \321\202\320\260\320\272\320\276\320\263\320\276 \321\204\320\260\320\271\320\273\320\260 \320\275\320\265 \321\201\321\203\321\211\320\265\321\201\321\202\320\262\321\203\320\265\321\202\n"
	.section	.rodata.str1.1
.LC5:
	.string	"w"
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"\320\230\321\201\321\205\320\276\320\264\320\275\320\260\321\217 \321\201\321\202\321\200\320\276\320\272\320\260:\n"
	.align 8
.LC7:
	.string	"\n\n\320\237\320\276\321\201\320\273\320\265 \320\277\321\200\320\265\320\276\320\261\321\200\320\260\320\267\320\276\320\262\320\260\320\275\320\270\321\217:\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	lea	r11, -1998848[rsp]
.LPSRL0:
	sub	rsp, 4096
	or	DWORD PTR [rsp], 0
	cmp	rsp, r11
	jne	.LPSRL0
	sub	rsp, 1184
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 2000024[rsp], rax
	xor	eax, eax
	cmp	edi, 4
	jne	.L43
	mov	r12, QWORD PTR 8[rsi]
	mov	rbp, rsi
	cmp	BYTE PTR [r12], 45
	je	.L57
.L49:
	lea	r13, .LC2[rip]
	mov	rdi, r12
	mov	rsi, r13
	call	strcmp@PLT
	test	eax, eax
	jne	.L43
.L42:
	mov	rsi, r13
	mov	rdi, r12
	mov	DWORD PTR 8[rsp], 0
	call	strcmp@PLT
	test	eax, eax
	jne	.L44
	mov	rdi, QWORD PTR 16[rbp]
	lea	rsi, .LC3[rip]
	mov	r14, QWORD PTR 24[rbp]
	call	fopen@PLT
	mov	rbp, rax # в регистре rbp находится ссылка на входной файл
	test	rax, rax
	je	.L47
	lea	r12, 16[rsp] # в регистре r12 находится строка str
	lea	rsi, 8[rsp]
	mov	rdx, rax
	mov	rdi, r12
	call	parse_str
	mov	rdi, rbp
	call	fclose@PLT
.L46:
	mov	r15d, DWORD PTR 8[rsp]
	lea	r13, 1000016[rsp] # в регистре r13 находится result
	lea	rsi, 12[rsp]
	mov	rdx, r12
	mov	rdi, r13
	mov	DWORD PTR 12[rsp], 0
	mov	ecx, r15d
	call	solve_task
	lea	rsi, .LC5[rip]
	mov	rdi, r14
	call	fopen@PLT
	mov	rbp, rax
	test	rax, rax
	je	.L47
	mov	rcx, rax
	mov	edx, 31
	mov	esi, 1
	lea	rdi, .LC6[rip]
	call	fwrite@PLT
	mov	rdx, rbp
	mov	rsi, r12
	mov	edi, r15d
	call	print
	mov	rcx, rbp
	mov	edx, 43
	mov	esi, 1
	lea	rdi, .LC7[rip]
	call	fwrite@PLT
	mov	edi, DWORD PTR 12[rsp] # в регистре edi находится n
	mov	rdx, rbp
	mov	rsi, r13
	call	print
	mov	rdi, rbp
	call	fclose@PLT
.L40:
	mov	rax, QWORD PTR 2000024[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L58
	add	rsp, 2000032
	xor	eax, eax
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.L57:
	cmp	BYTE PTR 1[r12], 103
	jne	.L49
	cmp	BYTE PTR 2[r12], 0
	lea	r13, .LC2[rip]
	je	.L42
	jmp	.L49
.L43:
	lea	rdi, .LC0[rip]
	call	puts@PLT
	lea	rdi, .LC1[rip]
	call	puts@PLT
	jmp	.L40
.L44:
	mov	rdi, QWORD PTR 16[rbp]
	xor	esi, esi
	mov	edx, 10
	lea	r12, 16[rsp] # в регистр r12 записываем строку str.
	call	strtol@PLT
	lea	rsi, 8[rsp]
	mov	rdi, r12
	mov	r14, QWORD PTR 24[rbp]
	mov	DWORD PTR 8[rsp], eax
	call	generate
	jmp	.L46
.L58:
	call	__stack_chk_fail@PLT
.L47:
	lea	rdi, .LC4[rip]
	call	puts@PLT
	jmp	.L40
	.size	main, .-main
	.globl	digits
	.section	.rodata.str1.1
.LC8:
	.string	"0"
.LC9:
	.string	"I"
.LC10:
	.string	"II"
.LC11:
	.string	"III"
.LC12:
	.string	"IV"
.LC13:
	.string	"V"
.LC14:
	.string	"VI"
.LC15:
	.string	"VII"
.LC16:
	.string	"VIII"
.LC17:
	.string	"IX"
	.section	.data.rel.local,"aw"
	.align 32
	.type	digits, @object
	.size	digits, 80
digits:
	.quad	.LC8
	.quad	.LC9
	.quad	.LC10
	.quad	.LC11
	.quad	.LC12
	.quad	.LC13
	.quad	.LC14
	.quad	.LC15
	.quad	.LC16
	.quad	.LC17
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
