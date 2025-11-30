.global exit, exit0, strlen, endl, printstr, printint, readstr, readint
.option norelax

.equ SYS_READ, 63
.equ SYS_WRITE, 64
.equ SYS_EXIT, 93
.equ STDIN, 0
.equ STDOUT, 1
.equ LINEFEED, 10

.data
endl_str: .byte LINEFEED, 0

.text
exit:
	li		a7, SYS_EXIT	# load immediate codigo da syscall no a7
	ecall					# syscall
exit0:
	li		a0, 0			# a0 - argumento para syscall
	j		exit

#strlen - recebe endereco da string no a0, retorna tamanho da string
strlen:
	mv      t0, a0          # move endereço da string para o registrador temporario t0 para percorrer
	li      t1, 0           # zera valor do t1, para ser usado como contador

strlen_loop:
	lb      t2, 0(t0)       # load byte - carrega 1 byte da memória no endereço (t0 + 0) para t2
	beqz    t2, strlen_end  # branch if equal zero - se o byte lido (t2) for 0 (final) , pula para o fim

	addi    t0, t0, 1       # incremento ponteiro com add immediate
	addi    t1, t1, 1		# incrementa contador
	j       strlen_loop

strlen_end:
	mv      a0, t1          # move t1 para a0 (retorno)
	ret

# endl
endl:
	la      a0, endl_str    # load address o endereço da string de nova linha
	j       printstr

# printstr(end. da string)
printstr:
	addi    sp, sp, -16     # "aloca" 16 bytes na pilha
	sd      ra, 0(sp)       # empilha RA pois chamaremos strlen (caller saved)
	sd      s0, 8(sp)       # empilha valor do s0, pois é callee saved

	mv      s0, a0          # salva no s0 o end. da string

	call    strlen          # retorna o tamanho no a0

	# sys_write(onde escrever, o que escrever, tamanho)
	li      a7, SYS_WRITE
	mv      a2, a0
	mv      a1, s0
	li      a0, STDOUT
	ecall

	ld      ra, 0(sp)
	ld      s0, 8(sp)
	addi    sp, sp, 16
	ret

# readstr(end. a armazenar, tamanho maximo), retorna tamanho
readstr:
	addi	sp, sp, -16
	sd		s0, 0(sp)
	mv		s0, a0			# salvar o endereco
	# sys_read(de onde ler, onde armazenar, quanto ler)
	li		a7, SYS_READ
	mv      a2, a1
	mv      a1, a0 
	li		a0, STDIN
	ecall                   # retorna qtd de bytes lidos no a0
	blez    a0, readstr_erro # se nada for digitado
	

	# remover o \n do final
	# a0 - número de bytes lidos. \n é o ultimo
	addi    t0, a0, -1      # decrementa o tamanho
	add     t1, s0, t0      # end. do último char (endereco + tamanho)

	lb		t2, 0(t1)
	li		t3, LINEFEED
	bne		t2, t3, readstr_ret

	sb      zero, 0(t1)
	mv		a0, t0
readstr_ret:
	ld      s0, 0(sp)       
    addi    sp, sp, 16
	ret
readstr_erro:
	li		a0, 0
	j		readstr_ret
    

