USE sucos_vendas;

SELECT * FROM itens_notas_fiscais;
SELECT * FROM itens_notas_fiscais WHERE quantidade > 60 AND preco <= 3;
 
# Quantos clientes possuem o último sobrenome Mattos?
 
SELECT * FROM tabela_de_clientes WHERE nome LIKE ('%Mattos%');

# Comando distinct - retorna dados distintos, dados que não se repetem
SELECT DISTINCT embalagem, tamanho FROM tabela_de_produtos WHERE sabor = 'Laranja';

# Quais são os bairros da cidade do Rio de Janeiro que possuem clientes?

SELECT DISTINCT bairro FROM tabela_de_clientes WHERE cidade = 'rio de janeiro';

# COMANDO LIMIT - limita a quantidade de dados a ser exibido.
# Queremos obter as 10 primeiras vendas do dia 01/01/2017. Qual seria o comando SQL para obter este resultado?

SELECT * FROM notas_fiscais;
SELECT * FROM notas_fiscais WHERE data_venda = '2017-01-01' LIMIT 10;
SELECT * FROM notas_fiscais WHERE data_venda = '2017-01-01' LIMIT 2,5; #'2,5 - 2 = QUAL LINHA COMEÇA A CONTAR, 5 = QUANTIDADE DE LINHA A SER RETORNADA A PARTIR DO 2"

# COMANDO ORDERBY - ORDENA OS DADOS 
# ASC - ASCENDENTE (MENOR P/ MAIOR), DESC - DESCENTENTE (MAIOR P/ MENOR)
# Qual (ou quais) foi (foram) a(s) maior(es) venda(s) do produto “Linha Refrescante - 1 Litro - Morango/Limão”, em quantidade? (Obtenha este resultado usando 2 SQLs).

SELECT * FROM itens_notas_fiscais;

SELECT * FROM tabela_de_produtos WHERE nome_do_produto = 'Linha refrescante - 1 Litro - Morango/Limão'; #1101035

SELECT * FROM itens_notas_fiscais WHERE codigo_do_produto = '1101035' ORDER BY quantidade DESC;

# Aproveitando o exercício do vídeo anterior quantos itens de venda existem com a maior quantidade do produto '1101035'?

SELECT MAX(`QUANTIDADE`) as 'MAIOR QUANTIDADE' FROM itens_notas_fiscais WHERE `CODIGO_DO_PRODUTO` = '1101035' ;

SELECT COUNT(*) FROM itens_notas_fiscais WHERE codigo_do_produto = '1101035' AND QUANTIDADE = 99;

# COMANDO GROUP BY - AGRUPANDO RESULTADOS
SELECT estado, limite_de_credito FROM tabela_de_clientes;
SELECT estado, SUM(limite_de_credito) AS LIMITE_TOTAL FROM tabela_de_clientes GROUP BY ESTADO;

# QUAL É O PRODUTO MAIS CARO PET E QUAL É O PRODUTO MAIS CARO LATA, vendo por produto?
SELECT nome_do_produto, embalagem, preco_de_lista FROM tabela_de_produtos;
SELECT nome_do_produto, embalagem, MAX(PRECO_DE_LISTA) AS PRECO FROM tabela_de_produtos WHERE embalagem = 'pet' GROUP BY nome_do_produto ORDER BY preco_de_lista DESC; 
SELECT nome_do_produto, embalagem, MAX(PRECO_DE_LISTA) AS PRECO FROM tabela_de_produtos WHERE embalagem = 'lata' GROUP BY nome_do_produto ORDER BY preco_de_lista DESC;

# vendo de forma geral por embalagem
SELECT embalagem, MAX(PRECO_DE_LISTA) AS MAIOR_PRECO FROM  tabela_de_produtos GROUP BY embalagem; 

# QUANTOS PRODUTOS HA POR EMBALAGEM?
SELECT embalagem, COUNT(*) AS QUANTIDADE_PRODUTO FROM tabela_de_produtos GROUP BY embalagem;

# COMANDO HAVING (filtro) que vai apos o group by 
# tabela de clientes, consultando a soma dos limites de crédito agrupados por estado:
SELECT estado, SUM(limite_de_credito) AS CRED_EST FROM tabela_de_clientes GROUP BY estado HAVING SUM(LIMITE_DE_CREDITO) >900000;

# Quais foram os clientes que fizeram mais de 2000 compras em 2016?

SELECT cpf, COUNT(*) AS Compras FROM notas_fiscais WHERE YEAR (data_venda)=2016 GROUP BY cpf HAVING COUNT(NUMERO) >2000;

# OPERAÇÕES COM SQL
SELECT * FROM tabela_de_produtos;

SELECT embalagem, COUNT(sabor) FROM tabela_de_produtos GROUP BY embalagem;

SELECT embalagem, AVG(preco_de_lista) AS media_preco FROM tabela_de_produtos GROUP BY embalagem;

SELECT sabor, COUNT(preco_de_lista) as contagem FROM tabela_de_produtos WHERE embalagem = 'lata' GROUP BY sabor;

# QUAL O MAIOR E O MENOR VALOR POR EMBALAGEM CUJO O PREÇO DE LISTA MENOR IGUAL A 80
SELECT embalagem, MAX(preco_de_lista) AS Maior_preco, MIN(preco_de_lista) AS Menor_preco FROM tabela_de_produtos GROUP BY embalagem
HAVING SUM(PRECO_DE_LISTA) <= 80;

USE sucos_vendas;

# COMANDO CASE
# CLASSIFICANDO PRODUTO PELO PREÇO
SELECT nome_do_produto, sabor, preco_de_lista, 
CASE
	WHEN preco_de_lista >=12 THEN 'PRODUTO CARO'
    WHEN preco_de_lista >=7 and preco_de_lista <= 11 THEN 'PRODUTO EM CONTA' 
	ELSE 'PRODUTO BARATO'
END AS CLASSIFICACAO_PRODUTO
FROM tabela_de_produtos;
 
# CALCULANDO O PREÇO MEDIO E CLASSIFICANDO POR EMBALAGEM DO PRODUTO MANGA 
SELECT EMBALAGEM,
CASE 
    WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
    ELSE 'PRODUTO BARATO' 
END AS STATUS_PRECO, AVG(PRECO_DE_LISTA) AS PRECO_MEDIO
FROM tabela_de_produtos
WHERE sabor = 'Manga'
GROUP BY EMBALAGEM, 
CASE 
    WHEN PRECO_DE_LISTA >= 12 THEN 'PRODUTO CARO'
    WHEN PRECO_DE_LISTA >= 7 AND PRECO_DE_LISTA < 12 THEN 'PRODUTO EM CONTA'
    ELSE 'PRODUTO BARATO' 
END 
ORDER BY EMBALAGEM;

# EXERCICIOS
# Veja o ano de nascimento dos clientes e classifique-os como: Nascidos antes de 1990 são velhos,
#nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças. Liste o nome do cliente e esta classificação.

SELECT nome, idade, sexo, cidade,
CASE
	WHEN YEAR (data_de_nascimento) <= 1989 THEN 'VELHOS'
    WHEN YEAR (data_de_nascimento) >= 1990 AND YEAR (data_de_nascimento) <= 1995 THEN 'JOVENS'
    ELSE 'CRIANCAS'
END AS STATUS_VIDA
FROM tabela_de_clientes;