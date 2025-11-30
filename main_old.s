# Lê 2 strings, imprime ambas e guarda a diferença de tamanho em s3.

.global _start
.option norelax     # desativa otimizacao de global pointer, que causava bug

.data
    .align 4
    buffer1: .space 64      # Espaço para a primeira string
    buffer2: .space 64      # Espaço para a segunda string
    prompt1: .string "Digite a primeira string: "
    prompt2: .string "Digite a segunda string: "
.text
_start:
    # Ler a Primeira String
    la      a0, prompt1
    call    printstr
    la      a0, buffer1     # Carrega o endereço do buffer1 em a0
    li      a1, 64          # Define o tamanho máximo de leitura
    call    readstr         # Chama a função de leitura
    mv      s1, a0          # Salva o tamanho da string 1 em s1

    # Ler a Segunda String
    la      a0, prompt2
    call    printstr
    la      a0, buffer2     # Carrega o endereço do buffer2
    li      a1, 64          # Tamanho máximo
    call    readstr
    mv      s2, a0          # Salva o tamanho da string 2 em s2

    # Printar a Primeira String
    la      a0, buffer1     # Passa o endereço da string 1
    call    printstr        # Imprime
    call    endl

    # Printar a Segunda String
    la      a0, buffer2     # Passa o endereço da string 2
    call    printstr        # Imprime
    call    endl 

    # Calcular a diferença e armazenar no s3 
    sub     s3, s1, s2      # s3 = s1 - s2 

    call    exit0
